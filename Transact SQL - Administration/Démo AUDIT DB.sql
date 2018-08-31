/******************************************************************************
* PREPARATION
******************************************************************************/
USE master;
GO

IF EXISTS(SELECT * FROM sys.configurations WHERE name = 'xp_cmdshell' AND value_in_use = 0)
BEGIN
   IF EXISTS(SELECT * FROM sys.configurations WHERE name = 'show advanced options' AND value_in_use = 0)
   BEGIN
      EXEC ('EXEC sp_configure ''show advanced options'', 1');
      EXEC ('RECONFIGURE');
   END
   EXEC ('EXEC sp_configure ''xp_cmdshell'', 1');
   EXEC ('RECONFIGURE');
END;
GO   

EXEC xp_cmdshell 'MKDIR "C:\!\SQL Server Database AUDIT\"';
EXEC xp_cmdshell 'MKDIR "C:\!\SQL Server BACKUP\"';


IF EXISTS(SELECT * FROM sys.databases WHERE name = 'DB_TEST_AUDIT')
BEGIN
   EXEC ('USE DB_TEST_AUDIT;ALTER DATABASE DB_TEST_AUDIT SET SINGLE_USER WITH ROLLBACK IMMEDIATE;')
   EXEC ('USE master;DROP DATABASE DB_TEST_AUDIT');
END   
GO   

IF EXISTS(SELECT * FROM sys.server_principals WHERE name = 'CNX_LECTEUR')
   EXEC ('DROP LOGIN CNX_LECTEUR');
GO

IF EXISTS(SELECT * FROM sys.server_principals WHERE name = 'CNX_ECRIVAIN')
   EXEC ('DROP LOGIN CNX_ECRIVAIN');
GO

IF EXISTS(SELECT * FROM sys.server_audits  WHERE name = 'SVA_FRED')
BEGIN
   EXEC ('USE master;ALTER SERVER AUDIT SVA_FRED WITH (STATE = OFF);')
   EXEC ('USE master;DROP SERVER AUDIT SVA_FRED');
END   
GO

IF EXISTS(SELECT * FROM sys.server_audit_specifications  WHERE name = 'SAS_BACKUP_RESTORE_SRV')
BEGIN
   EXEC ('USE master;ALTER SERVER AUDIT SPECIFICATION SAS_BACKUP_RESTORE_SRV WITH (STATE = OFF);')
   EXEC ('USE master;DROP SERVER AUDIT SPECIFICATION SAS_BACKUP_RESTORE_SRV');
END   
GO

IF EXISTS(SELECT * FROM sys.server_triggers WHERE name = 'E_LOGON')
   EXEC ('DROP TRIGGER E_LOGON ON ALL SERVER');
GO

EXEC xp_cmdshell 'DEL /Q "C:\!\SQL Server BACKUP\*.*"';
EXEC xp_cmdshell 'DEL /Q "C:\!\SQL Server Database AUDIT\*.*"';
GO

/******************************************************************************
* CRÉATION DE LA BASE DE TEST ET MISE EN PLACE D'OBJETS
******************************************************************************/

USE master;
GO

CREATE DATABASE DB_TEST_AUDIT;
GO

CREATE LOGIN CNX_LECTEUR 
   WITH PASSWORD = 'Maux 2 p@stAga',
        DEFAULT_DATABASE = DB_TEST_AUDIT,
        DEFAULT_LANGUAGE = French;
GO
        
CREATE LOGIN CNX_ECRIVAIN 
   WITH PASSWORD = 'Maux 2 p@stAga',
        DEFAULT_DATABASE = DB_TEST_AUDIT,
        DEFAULT_LANGUAGE = French;        
GO

USE DB_TEST_AUDIT;
GO

CREATE USER USR_LECTEUR FROM LOGIN CNX_LECTEUR;
GO

CREATE USER USR_ECRIVAIN FROM LOGIN CNX_ECRIVAIN;
GO

CREATE SCHEMA S_BOUQUIN
GO

CREATE TABLE S_BOUQUIN.T_LIVRE_LVR
(LVR_ID     INT IDENTITY PRIMARY KEY,
 LVR_TITRE  VARCHAR(256))
GO

CREATE TABLE dbo.acces
(id      INT IDENTITY PRIMARY KEY,
 nom     sysname DEFAULT USER,
 moment  DATETIME2(3) DEFAULT GETDATE())
GO

GRANT SELECT ON DATABASE::DB_TEST_AUDIT TO USR_LECTEUR;
GO

GRANT INSERT ON dbo.acces TO USR_LECTEUR;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::S_BOUQUIN TO USR_ECRIVAIN;
GO

GRANT INSERT ON dbo.acces TO USR_ECRIVAIN;
GO

CREATE TRIGGER E_LOGON
ON ALL SERVER
FOR LOGON
AS
   IF EXISTS(SELECT * 
             FROM   sys.server_principals 
             WHERE  name = USER 
               AND  default_database_name = 'DB_TEST_AUDIT')
   INSERT INTO DB_TEST_AUDIT.dbo.acces 
   DEFAULT VALUES;
GO  

/******************************************************************************
* PARTIE AUDIT : mise en place du suivi
******************************************************************************/

USE master;
GO

-- création de l'espace de travail pour les audits
CREATE SERVER AUDIT SVA_FRED
TO FILE ( FILEPATH = 'C:\!\SQL Server Database AUDIT\'
        , MAXSIZE = 1 GB 
        , MAX_ROLLOVER_FILES = 256 
        , RESERVE_DISK_SPACE = OFF )
WITH ( QUEUE_DELAY = 3000
     , ON_FAILURE = SHUTDOWN );
GO

-- suivie d'une action de groupe au niveau serveur :
CREATE SERVER AUDIT SPECIFICATION SAS_BACKUP_RESTORE_SRV
FOR SERVER AUDIT SVA_FRED
ADD (BACKUP_RESTORE_GROUP);
GO
-- concernant les sauvegardes et restaurations de toutes bases

USE DB_TEST_AUDIT;
GO

-- suivie d'une action de groupe au niveau base
CREATE DATABASE AUDIT SPECIFICATION SAS_SUIVI_BASE
FOR SERVER AUDIT SVA_FRED
ADD (DATABASE_OBJECT_CHANGE_GROUP)
GO
-- concernant les modification de structure des objets de la base 

-- suivi d'une action particulière au niveau objet, pour toute la base
ALTER DATABASE AUDIT SPECIFICATION SAS_SUIVI_BASE
ADD ( SELECT     
      ON DATABASE::DB_TEST_AUDIT       
      BY dbo);
-- concerne le SELECT sur tous les objets de la base DB_TEST_AUDIT  
   
-- suivie de plusieurs action spécifique au niveau objet, pour tout un schema SQL
ALTER DATABASE AUDIT SPECIFICATION SAS_SUIVI_BASE
ADD  ( INSERT, UPDATE, DELETE  
      ON SCHEMA::S_BOUQUIN 
      BY USR_ECRIVAIN);
-- concerne les mises à jour (INSERT, UPDATE, DELETE) sur tous les objets ddu schéma SQL S_BOUQUIN        
      
-- suivi de l'action INSERT sur la table dbo.acces.
ALTER DATABASE AUDIT SPECIFICATION SAS_SUIVI_BASE
ADD ( INSERT  
      ON dbo.acces 
      BY USR_ECRIVAIN, USR_LECTEUR);      
GO

-- démarrage de l'audit au niveau serveur
USE master;
GO

-- pour l'espace de stockage
ALTER SERVER AUDIT SVA_FRED
WITH (STATE = ON);
GO   

-- pour le suivi niveau serveur
ALTER SERVER AUDIT SPECIFICATION SAS_BACKUP_RESTORE_SRV
WITH (STATE = ON);
GO   

-- démarrage de l'audit au niveau base
USE DB_TEST_AUDIT;
GO

ALTER DATABASE AUDIT SPECIFICATION SAS_SUIVI_BASE
WITH (STATE = ON);
GO   


   
/******************************************************************************
* TEST divers de manipulation des données
******************************************************************************/

ALTER TABLE S_BOUQUIN.T_LIVRE_LVR
  ADD LVR_DH_INSERT DATETIME2(6) DEFAULT GETDATE();
 
--> se connecter sous le compte CNX_ECRIVAIN/Maux 2 p@stAga

INSERT INTO S_BOUQUIN.T_LIVRE_LVR (LVR_TITRE)
VALUES ('Guère épais'),
       ('Benne à or dur'),
       ('L''étroite Moustiquaire');
GO 100

UPDATE TOP (50) S_BOUQUIN.T_LIVRE_LVR 
SET    LVR_TITRE = 'Guerre et Paix'
WHERE  LVR_TITRE = 'Guère épais';
GO 
 
UPDATE TOP (10) S_BOUQUIN.T_LIVRE_LVR 
SET    LVR_TITRE = 'Les trois mousquetaires'
WHERE  LVR_TITRE = 'L''étroite Moustiquaire';
GO

DELETE FROM S_BOUQUIN.T_LIVRE_LVR 
WHERE  LVR_TITRE = 'Benne à or dur';
GO

SELECT * 
FROM   S_BOUQUIN.T_LIVRE_LVR ;
GO

--> se connecter sous le compte CNX_LECTEUR/Maux 2 p@stAga

SELECT LVR_ID, LVR_TITRE 
FROM   S_BOUQUIN.T_LIVRE_LVR 
WHERE  LVR_TITRE LIKE '% et %' ;
GO

-- > revenir en tant que sysadmin

BACKUP DATABASE DB_TEST_AUDIT
TO DISK = 'C:\!\SQL Server BACKUP\DB_TEST_AUDIT.full.bak';

 
/******************************************************************************
* PARTIE AUDIT : lecture des données auditées
******************************************************************************/
     
SELECT * 
FROM   sys.fn_get_audit_file ( 'C:\!\SQL Server Database AUDIT\*', default, default )

-- ### macrhe pas : backup et change structure ???

