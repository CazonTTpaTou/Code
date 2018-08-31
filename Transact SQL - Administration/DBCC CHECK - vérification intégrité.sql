DECLARE @SQL NVARCHAR(max);
SET @SQL = N'';

SELECT @SQL = @SQL + N'USE ' + name + N';PRINT ''' + name + N'''; DBCC CHECKDB WITH NO_INFOMSGS;'
FROM   sys.databases
WHERE  name NOT IN ('tempdb', 'model');

EXEC (@SQL);

