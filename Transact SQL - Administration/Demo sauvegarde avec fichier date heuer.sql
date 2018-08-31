--> tache agent tous les jours à 0h
DECLARE @SQL NVARCHAR(max);
SET @SQL = 'BACKUP DATABASE [' + DB_NAME() + '] TO DISK = ''C:\SAVE\' 
         + DB_NAME() + '_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19), getdate(), 121),'-', ''),' ', '_'),':', '')
		 + '.BAK'' WITH COMPRESSION';
EXEC (@SQL);

--> tache agent toutes les 10 minutes
DECLARE @SQL NVARCHAR(max);
SET @SQL = 'BACKUP LOG [' + DB_NAME() + '] TO DISK = ''C:\SAVE\' 
         + DB_NAME() + '_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19), getdate(), 121),'-', ''),' ', '_'),':', '')
		 + '.TRN'' WITH COMPRESSION';
EXEC (@SQL);