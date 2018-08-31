-- connexion

-- cr�ez trois comptes de connexion :
-- CNX_LECTEUR 
-- CNX_ECRIVAIN 
-- CNX_ADMIN
--> tous dot�s du mot de passe 'Sql2014! avec expiration, respect de la politique 
-- et changement � la premi�re connexion

CREATE LOGIN CNX_LECTEUR
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
        DEFAULT_DATABASE = DB_GRAND_HOTEL,
		DEFAULT_LANGUAGE = Fran�ais,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

CREATE LOGIN CNX_ECRIVAIN
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
        DEFAULT_DATABASE = DB_GRAND_HOTEL,
		DEFAULT_LANGUAGE = Fran�ais,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

CREATE LOGIN CNX_ADMIN
   WITH PASSWORD = '''Sql2014!' MUST_CHANGE,
		DEFAULT_LANGUAGE = English,
		CHECK_EXPIRATION = ON,
		CHECK_POLICY = ON;
GO

-- base par d�faut  [DB_GRAND_HOTEL], langue fran�aise
--> SAUF pour CNX_ADMIN base master et langue english

--> Pouvez-vous vous connecter avec chacun ?
Oui, mais les 2 premiers se font jet�s car ils ne sont pas reconnus dan la base de destination
