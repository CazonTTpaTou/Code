USE master;
GO

CREATE PROCEDURE dbo.sp__DB_SNAP @DB NVARCHAR(128), @PATH NVARCHAR(256)
AS

IF NOT EXISTS(SELECT *
              FROM   master.sys.databases
              WHERE  name = @DB
                AND  source_database_id IS NULL
                AND  state_desc = 'ONLINE')
BEGIN
   RAISERROR('Le nom de base %s n''existe pas sur ce serveur ou n''est pas en état copiable.', 16, 1, @DB);
   RETURN;
END;

IF RIGHT(@PATH, 1) = '\'
   SET @PATH = @PATH + '\';

DECLARE @T TABLE (file_exists bit, file_is_dir bit, parent_dir_exists bit);
INSERT INTO @T
EXEC master.sys.xp_fileexist @PATH;
IF NOT EXISTS(SELECT 0
              FROM   @T
              WHERE  file_is_dir = 1)
BEGIN
   RAISERROR('Le chemin passé en arguement, n''est pas un répertoire valide.' , 16, 1);
   RETURN
END

DECLARE @SQL VARCHAR(MAX);
SET @SQL = 'CREATE DATABASE [' + @DB +'_SNAP_'  
           + REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR(23), CURRENT_TIMESTAMP, 121), '-', ''), ' ', '_'), ':', ''), '.', '_')
           + '] ON '
SELECT @SQL = @SQL + '( NAME = ' + name +', FILENAME = '''  
            + @PATH + REVERSE(SUBSTRING(REVERSE(physical_name), 1, CHARINDEX('\', REVERSE(physical_name)) - 1))
            + '''),'
from   sys.master_files
WHERE  type = 0
  AND  database_id = DB_ID(@DB)
SET @SQL = SUBSTRING(@SQL, 1, LEN(@SQL) - 1) + ' AS SNAPSHOT OF ['
           + @DB + ']'
EXEC (@SQL)

GO

EXEC sp_MS_marksystemobject 'dbo.sp__DB_SNAP';
GO