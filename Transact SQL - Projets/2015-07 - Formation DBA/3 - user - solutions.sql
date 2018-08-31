-- utilisateur...

USE DB_GRAND_HOTEL;
GO

-- Dans la base DB_GRAND_HOTEL, créez les utilisateurs
-- USR_LECTEUR relatif à CNX_LECTEUR schema par défaut S_PRS
CREATE USER USR_LECTEUR 
   FROM LOGIN CNX_LECTEUR 
   WITH DEFAULT_SCHEMA = S_PRS;


-- USR_ECRIVAIN relatif à CNX_ECRIVAIN schema par défaut S_CHB
CREATE USER USR_ECRIVAIN 
   FROM LOGIN CNX_ECRIVAIN
   WITH DEFAULT_SCHEMA = S_CHB;


-- USR_ADMIN relatif à CNX_ADMIN schéma par défaut dbo
CREATE USER USR_ADMIN 
   FROM LOGIN CNX_ADMIN
   WITH DEFAULT_SCHEMA = dbo;

-- testez à nouveau les 3 entités en vous connectant au serveur

