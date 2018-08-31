SET LOCK_TIMEOUT 30;
-- mise à jour des index par défragmentation
DECLARE @SQL NVARCHAR(max)
SET @SQL = N''
SELECT @SQL = @SQL +
       CASE ips.index_id 
	      WHEN 0 THEN N'ALTER TABLE [' + s.name + N'].[' + o.name + N'] REBUILD;' 
		  WHEN 1 THEN N'ALTER INDEX [' +  i.name + N'] ON [' + s.name + N'].[' + o.name + '] '
		               + CASE WHEN avg_fragmentation_in_percent > 30 THEN N'REBUILD WITH (FILLFACTOR = 100);'
					          ELSE N'REORGANIZE;' END
		  ELSE N'ALTER INDEX [' +  i.name + N'] ON [' + s.name + N'].[' + o.name + '] '
		               + CASE WHEN avg_fragmentation_in_percent > 30 THEN N'REBUILD WITH (FILLFACTOR = 80);'
					          ELSE N'REORGANIZE;' END
	   END
FROM   sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS ips
       JOIN sys.objects AS o
	        ON ips.object_id = o.object_id
	   JOIN sys.schemas AS s
	        ON o.schema_id = s.schema_id
       JOIN sys.indexes AS i
	        ON ips.object_id = i.object_id
			AND ips.index_id = i.index_id
WHERE  page_count > 64;
EXEC (@SQL);
-- mise à jour des statistiques par recalcul en FULL SCAN
SET @SQL = N''
SELECT @SQL = @SQL +
       N'UPDATE STATISTICS  [' + sc.name + N'].[' + o.name + N'] [' + s.name + N']  WITH FULLSCAN;'
FROM   sys.stats AS s 
       CROSS APPLY sys.dm_db_stats_properties(s.object_id , s.stats_id) AS sp
       JOIN sys.objects AS o
	        ON s.object_id = o.object_id
	   JOIN sys.schemas AS sc
	        ON o.schema_id = sc.schema_id
WHERE  100 * modification_counter / rows >= 10;
EXEC (@SQL);




     