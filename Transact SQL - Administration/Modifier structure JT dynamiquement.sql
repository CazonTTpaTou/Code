CREATE TABLE T1 (C CHAR(2000), D CHAR(2000))

CREATE TABLE T2 (C CHAR(2200), D CHAR(2200))

--> JT 2 Mo => VLF : 512 Ko

--> 10 Go => Combien de VLF ??? 10 Go = 10 000 Mo => 20 000 VLF

--=> bien dimensionner les JT pour chaque base de prod et pour tempdb !!!

-- 1) à la création de la base : bien dimensionner => OK

-- 2) si mal créé au départ:
--    a) créer un nouveau fichier du JT bien dimensionné
--    b) diminuer la taille du fichier JT primaire au minimum (DBCC SHRINKFILE)
--       pour l'y aider vous pouvez passer la journalisation en mode simple de manière transitoire  




USE MaBase;

DECLARE @FILENAME sysname;
SELECT @FILENAME = 

SELECT d.name, * 
FROM   sys.master_files AS mf
       JOIN sys.databases AS d
	        ON mf.database_id = d.database_id
WHERE  NOT EXISTS(SELECT 1
                  FROM   sys.master_files AS mf2
				  WHERE  type_desc = 'LOG'
				  AND    mf2.database_id = mf.database_id
				  HAVING COUNT(*) > 1)
  AND  d.name NOT IN ('master', 'tempdb', 'model', 'msdb')
  AND  d.name NOT LIKE 'ReportServer%'
  AND  type_desc = 'LOG';



ALTER DATABASE MaBase 
   SET RECOVERY SIMPLE;

CHECKPOINT; --> force l'écriture physique des pages sales (pages contenant les nouvelles données en RAM) dans les fichiers de données

ALTER DATABASE MaBase 
   ADD LOG FILE (NAME         = 'JT2',
                 FILENAME     = 'C:\tmp\tran\MaBase.ldf',
				 SIZE         = 16 GB,
				 FILEGROWTH   = 50 MB);

DBCC SHRINKFILE ('MaBase_log', 1);

ALTER DATABASE MaBase 
   MODIFY FILE (NAME          = 'MaBase_log',
                SIZE          = 2 MB);

ALTER DATABASE MaBase 
   SET RECOVERY FULL;


