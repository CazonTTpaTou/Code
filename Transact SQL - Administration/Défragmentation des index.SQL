--> voir la fragmentation des index
SELECT s.name AS TABLE_SCHEMA, o.name AS TABLE_NAME, i.name AS INDEX_NAME, partition_number,
       avg_fragmentation_in_percent, page_count
FROM   sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS ips
       JOIN sys.indexes AS i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
	   JOIN sys.objects AS o ON ips.object_id = o.object_id
	   JOIN sys.schemas AS s ON   o.schema_id = s.schema_id
WHERE  page_count > 8
ORDER BY 1, 2, 3

--> 1) Reconstruire les index fragmmentés à plus de 30%
--> 2) Réorganiser les index fragmentés à plus de 15%

DECLARE @FILL_FACTOR_TABLE TINYINT, 
        @FILL_FACTOR_INDEX TINYINT,
		@WAIT_BETWEEN_SEC  TINYINT;

SELECT @FILL_FACTOR_TABLE = 100, @FILL_FACTOR_INDEX = 90, @WAIT_BETWEEN_SEC = 10;

--> commande pour maintenance index
DECLARE @SQL NVARCHAR(max), @WAIT NVARCHAR(16), @H NVARCHAR(2), @M NVARCHAR(2), @S NVARCHAR(2);

SET @FILL_FACTOR_TABLE = COALESCE(@FILL_FACTOR_TABLE, 100);
SET @FILL_FACTOR_INDEX = COALESCE(@FILL_FACTOR_INDEX, 100);

SET @H = CAST(@WAIT_BETWEEN_SEC / 3600 AS NVARCHAR(2));
IF LEN(@H) = 1 SET @H = '0' + @H
SET @WAIT_BETWEEN_SEC = @WAIT_BETWEEN_SEC % 3600;
SET @M = CAST(@WAIT_BETWEEN_SEC / 60 AS NVARCHAR(2));
IF LEN(@M) = 1 SET @M = '0' + @M
SET @WAIT_BETWEEN_SEC = @WAIT_BETWEEN_SEC % 60;
SET @S = CAST(@WAIT_BETWEEN_SEC AS NVARCHAR(2));
SET @WAIT = @H + N':' + @M + N':' + @S;  

SET @SQL = N'';
SELECT CASE WHEN i.name IS NULL 
               THEN N'ALTER TABLE [' + s.name + N'].[' + o.name + N'] REBUILD' 
					+ N' WITH (FILLFACTOR = ' + CAST( CASE WHEN i.index_id > 1 
					                                         THEN @FILL_FACTOR_INDEX 
															 ELSE @FILL_FACTOR_TABLE 
													 END AS NVARCHAR(16)) + N');'
			   ELSE N'ALTER INDEX [' + i.name + N'] ON [' + s.name + N'].[' + o.name + N']' 
			        + CASE WHEN avg_fragmentation_in_percent > 30
					          THEN N' REBUILD WITH (FILLFACTOR = ' + CAST(@FILL_FACTOR_TABLE AS NVARCHAR(16)) + N');'
							  ELSE N' REORGANIZE;' 
					  END 
			END + N'WAITFOR DELAY ''' + @WAIT + N''';'
FROM   sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) AS ips
       JOIN sys.indexes AS i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
	   JOIN sys.objects AS o ON ips.object_id = o.object_id
	   JOIN sys.schemas AS s ON   o.schema_id = s.schema_id
WHERE  page_count > 8
  AND  avg_fragmentation_in_percent > 15;



