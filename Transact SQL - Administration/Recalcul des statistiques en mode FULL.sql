
DECLARE @SQL NVARCHAR(max);
SET @SQL = N'';
SELECT @SQL = @SQL + N'UPDATE STATISTICS [' + s.name + N'].[' + o.name + N'] ([' +  st.name +']) WITH FULLSCAN;'
FROM   sys.stats AS st
       CROSS APPLY sys.dm_db_stats_properties(object_id, stats_id) AS sp
	   JOIN sys.objects AS o ON st.object_id = o.object_id
	   JOIN sys.schemas AS s ON   o.schema_id = s.schema_id
WHERE  modification_counter > rows * 1.3
  OR   last_updated < DATEADD(day, -3, GETDATE())
  OR   last_updated IS NULL;
EXEC (@SQL);

