/*
-- voir les taux d'occupation des journaux des bases
DECLARE @SERVER sysname;
SET @SERVER = CASE @@SERVICENAME 
                 WHEN N'MSSQLSERVER' 
				    THEN N'MSSQLSERVER' 
				 ELSE N'MSSQL$' + @@SERVICENAME
			  END;
SELECT cntr_value AS OCCUPATION_JT_PERCENT
FROM   sys.dm_os_performance_counters
WHERE  object_name = @SERVER + N':Databases'
  AND  counter_name = N'Percent Log Used'
*/

--> augmenter la taille du dernier fichier créé pour le JT 
--  de 5 % pour les bases dont les JT sont pleins à plus de 67%
--  et envoe une alerte par mail

--> PARAMETRE
DECLARE @PERCENT_GROWTH FLOAT;
SET @PERCENT_GROWTH = 5;

-- trouver le taux d'occupation du journal d'une base
DECLARE @SERVER sysname, @SQL NVARCHAR(max);
SELECT @SERVER = CASE @@SERVICENAME 
                 WHEN N'MSSQLSERVER' 
				    THEN N'MSSQLSERVER' 
				 ELSE N'MSSQL$' + @@SERVICENAME
			  END,
	   @SQL = N'';
WITH T AS 
(
SELECT instance_name AS DATABASE_NAME, cntr_value AS OCCUPATION_JT_PERCENT,
       mf.name AS TRANSACTION_FILE_NAME, size * 8 AS SIZE_MB,
	   ROW_NUMBER() OVER(PARTITION BY database_id ORDER BY file_id DESC) AS N
FROM   sys.dm_os_performance_counters AS pc
       JOIN sys.master_files AS mf
	        ON pc.instance_name = DB_NAME(mf.database_id)
WHERE  object_name = @SERVER + N':Databases'
  AND  counter_name = N'Percent Log Used'
  AND  instance_name NOT IN ('master', 'msdb', 'tempdb', 'model')
  AND  cntr_value > 67
  AND  mf.type_desc = 'LOG'
)
SELECT @SQL = @SQL + N'ALTER DATABASE [' + RTRIM(DATABASE_NAME) + '] MODIFY FILE (NAME = ''' 
       + TRANSACTION_FILE_NAME + ''', SIZE = '  
       + CAST(CEILING(SIZE_MB * (1 + (@PERCENT_GROWTH / 100.0))) AS NVARCHAR(16)) + ' MB );'
FROM   T; 

IF @SQL <> N''
BEGIN
   EXEC (@SQL);
   SET @SQL = 'Les commandes SQL suivantes ont été passées suite à un taux de remplissage supérieur à 67%. ' + @SQL;
   EXEC msdb.dbo.sp_send_dbmail 
                       @profile_name = NULL, 
                       @recipients   = 'monitoring@photowatt.com',
					   @subject      = 'ALERTE : croissance fichier transactions',
					   @body         = @SQL,
					   @importance   = 'High';
END;


