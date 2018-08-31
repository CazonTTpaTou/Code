-- r�les
USE master;

-- cr�ez un r�le de server de nom ROL_IMPEX dot� des privil�ges suivants :
-- ADMINISTER BULK OPERATIONS, EXTERNAL ACCESS ASSEMBLY, UNSAFE ASSEMBLY
CREATE SERVER ROLE ROL_IMPEX;
GRANT ADMINISTER BULK OPERATIONS, 
      EXTERNAL ACCESS ASSEMBLY, 
	  UNSAFE ASSEMBLY
   TO ROL_IMPEX;

-- cr�ez un role de server de nom ROL_SECUR dot� des privil�ges :
-- SHUTDOWN, ALTER ANY LOGIN, ALTER ANY LOGIN, ALTER ANY CREDENTIAL, 
-- ALTER ANY CONNECTION, ALTER TRACE, AUTHENTICATE SERVER, ALTER ANY SERVER AUDIT
-- CREATE SERVER ROLE, ALTER ANY SERVER ROLE
CREATE SERVER ROLE ROL_SECUR;
GRANT SHUTDOWN, 
      ALTER ANY LOGIN, 
	  ALTER ANY CREDENTIAL, 
      ALTER ANY CONNECTION, 
	  ALTER TRACE, 
	  AUTHENTICATE SERVER, 
	  ALTER ANY SERVER AUDIT,
      CREATE SERVER ROLE, 
	  ALTER ANY SERVER ROLE
   TO ROL_SECUR;

-- dans la base DB_GRAND_HOTEL,
USE DB_GRAND_HOTEL;

-- cr�ez un r�le de base de donn�es de nom ROL_ADMIN dot� des privil�ges suivants :
-- SELECT sur la base enti�re, sauf sur les tables du schema S_ADM
-- CREATE VIEW, BACKUP DATABASE, BACKUP LOG au niveau base
CREATE ROLE ROL_ADMIN;
GRANT SELECT, CREATE VIEW, BACKUP DATABASE, BACKUP LOG
      ON DATABASE
	  TO ROL_ADMIN;
DENY SELECT 
     ON SCHEMA::S_ADM 
   TO ROL_ADMIN

-- cr�ez un r�le de base de donn�es de nom ROL_ECRIVAIN dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE sur la base enti�re, sauf mise � jour des tables du schema S_ADM
-- EXECUTE sur les schemas S_CEE, S_CHB et S_PRS

-- cr�ez un r�le de base de donn�es de nom ROL_LECTEUR dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES et CREATE VIEW sur la base enti�re

-- cr�ez un r�le de base de donn�es de nom ROL_DEV dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES,
-- CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE FUNCTION, CREATE TYPE,
-- CREATE ASSEMBLY sur la base enti�re



