-- r�les

-- cr�ez un r�le de server de nom ROL_IMPEX dot� des privil�ges suivants :
-- ADMINISTER BULK OPERATIONS, EXTERNAL ACCESS ASSEMBLY, UNSAFE ASSEMBLY

-- cr�ez un role de server de nom ROL_SECUR dot� des privil�ges :
-- SHUTDOWN, ALTER ANY LOGIN, ALTER ANY LOGIN, ALTER ANY CREDENTIAL, 
-- ALTER ANY CONNECTION, ALTER TRACE, AUTHENTICATE SERVER, ALTER ANY SERVER AUDIT
-- CREATE SERVER ROLE, ALTER ANY SERVER ROLE

-- dans la base DB_GRAND_HOTEL,

-- cr�ez un r�le de base de donn�es de nom ROL_ADMIN dot� des privil�ges suivants :
-- SELECT sur la base enti�re, sauf sur les tables du schema S_ADM
-- CREATE VIEW, BACKUP DATABASE, BACKUP LOG au niveau base

-- cr�ez un r�le de base de donn�es de nom ROL_ECRIVAIN dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE sur la base enti�re, sauf mise � jour des tables du schema S_ADM
-- EXECUTE sur les schemas S_CEE, S_CHB et S_PRS

-- cr�ez un r�le de base de donn�es de nom ROL_ADMIN dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES et CREATE VIEW sur la base enti�re

-- cr�ez un r�le de base de donn�es de nom ROL_DEV dot� des privil�ges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES,
-- CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE FUNCTION, CREATE TYPE,
-- CREATE ASSEMBLY sur la base enti�re



