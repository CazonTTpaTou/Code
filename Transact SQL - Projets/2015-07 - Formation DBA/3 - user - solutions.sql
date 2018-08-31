-- utilisateur...

USE DB_GRAND_HOTEL;
GO

-- Dans la base DB_GRAND_HOTEL, cr�ez les utilisateurs
-- USR_LECTEUR relatif � CNX_LECTEUR schema par d�faut S_PRS
CREATE USER USR_LECTEUR 
   FROM LOGIN CNX_LECTEUR 
   WITH DEFAULT_SCHEMA = S_PRS;


-- USR_ECRIVAIN relatif � CNX_ECRIVAIN schema par d�faut S_CHB
CREATE USER USR_ECRIVAIN 
   FROM LOGIN CNX_ECRIVAIN
   WITH DEFAULT_SCHEMA = S_CHB;


-- USR_ADMIN relatif � CNX_ADMIN sch�ma par d�faut dbo
CREATE USER USR_ADMIN 
   FROM LOGIN CNX_ADMIN
   WITH DEFAULT_SCHEMA = dbo;

-- testez � nouveau les 3 entit�s en vous connectant au serveur

