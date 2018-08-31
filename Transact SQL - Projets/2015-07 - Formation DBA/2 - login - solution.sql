-- connexion

-- créez trois comptes de connexion :
-- CNX_LECTEUR 
-- CNX_ECRIVAIN 
-- CNX_ADMIN
--> tous dotés du mot de passe 'Sql2014! avec expiration, respect de la politique 
-- et changement à la première connexion

CREATE LOGIN CNX_LECTEUR
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
        DEFAULT_DATABASE = DB_GRAND_HOTEL,
		DEFAULT_LANGUAGE = Français,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

CREATE LOGIN CNX_ECRIVAIN
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
        DEFAULT_DATABASE = DB_GRAND_HOTEL,
		DEFAULT_LANGUAGE = Français,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

CREATE LOGIN CNX_ADMIN
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
		DEFAULT_LANGUAGE = English,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

-- base par défaut  [DB_GRAND_HOTEL], langue française
--> SAUF pour CNX_ADMIN base master et langue english

--> Pouvez-vous vous connecter avec chacun ?
Oui, mais les 2 premiers se font jetés car ils ne sont pas reconnus dan la base de destination
