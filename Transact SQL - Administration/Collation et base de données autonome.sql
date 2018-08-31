CREATE DATABASE toto COLLATE French_CI_AI;
GO

USE toto;
GO

CREATE TABLE T (C VARCHAR(32));
GO

INSERT INTO T VALUES ('DUPONT')

CREATE TABLE #T (D VARCHAR(32))

INSERT INTO #T SELECT C FROM T

SELECT *
FROM   T JOIN #T 
          ON C=D

--> RESOLUTION

--> 1) dans la jointure

SELECT *
FROM   T JOIN #T 
          ON C=D COLLATE French_100_BIN2

--> 2) � la cr�ation de la table tempporaire
DROP TABLE #T;

CREATE TABLE #T (D VARCHAR(32) COLLATE database_default);

INSERT INTO #T SELECT C FROM T

SELECT *
FROM   T JOIN #T 
          ON C=D

--> 3) en cr�ant la table avec les donn�es de l'autre table (SELECT INTO)
DROP TABLE #T;

SELECT C AS D INTO #T FROM T;

SELECT *
FROM   T JOIN #T 
          ON C=D

--> 4) en utilisant des bases de donn�es "autonomes" (Contained DATABASEs, base de donn�es � relation contenant contenu)

EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

-- autorise le serveur � cr�er des bases "autonomes"
EXEC sp_configure 'contained database authentication', 1;
GO
RECONFIGURE;
GO

-- passage de la base de donn�es en mode autonome
USE toto;

ALTER DATABASE toto
   SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

USE master;

ALTER DATABASE toto
    SET CONTAINMENT = PARTIAL;

ALTER DATABASE toto
   SET MULTI_USER

USE toto;

-- probl�me naturellement r�solu
DROP TABLE #T;

CREATE TABLE #T (D VARCHAR(32));

INSERT INTO #T SELECT C FROM T

SELECT *
FROM   T JOIN #T 
          ON C=D