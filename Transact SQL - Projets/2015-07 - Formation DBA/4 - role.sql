-- rôles

-- créez un rôle de server de nom ROL_IMPEX doté des privilèges suivants :
-- ADMINISTER BULK OPERATIONS, EXTERNAL ACCESS ASSEMBLY, UNSAFE ASSEMBLY

-- créez un role de server de nom ROL_SECUR doté des privilèges :
-- SHUTDOWN, ALTER ANY LOGIN, ALTER ANY LOGIN, ALTER ANY CREDENTIAL, 
-- ALTER ANY CONNECTION, ALTER TRACE, AUTHENTICATE SERVER, ALTER ANY SERVER AUDIT
-- CREATE SERVER ROLE, ALTER ANY SERVER ROLE

-- dans la base DB_GRAND_HOTEL,

-- créez un rôle de base de données de nom ROL_ADMIN doté des privilèges suivants :
-- SELECT sur la base entière, sauf sur les tables du schema S_ADM
-- CREATE VIEW, BACKUP DATABASE, BACKUP LOG au niveau base

-- créez un rôle de base de données de nom ROL_ECRIVAIN doté des privilèges suivants :
-- SELECT, INSERT, UPDATE, DELETE sur la base entière, sauf mise à jour des tables du schema S_ADM
-- EXECUTE sur les schemas S_CEE, S_CHB et S_PRS

-- créez un rôle de base de données de nom ROL_ADMIN doté des privilèges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES et CREATE VIEW sur la base entière

-- créez un rôle de base de données de nom ROL_DEV doté des privilèges suivants :
-- SELECT, INSERT, UPDATE, DELETE, EXECUTE, REFERENCES,
-- CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE FUNCTION, CREATE TYPE,
-- CREATE ASSEMBLY sur la base entière



