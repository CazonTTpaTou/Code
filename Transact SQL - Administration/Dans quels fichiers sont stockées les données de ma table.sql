SELECT DISTINCT s.name AS TABLE_SCHEMA, o.name AS TABLE_NAME,
       dbf.name AS FILE_NAME, dbf.physical_name 
FROM   sys.indexes AS i
       JOIN sys.objects AS o
	        ON i.object_id = o.object_id
	   JOIN sys.schemas AS s
	        ON o.schema_id = s.schema_id
       JOIN sys.partitions AS p
	        ON i.index_id = p.index_id
			AND i.object_id = p.object_id
	   LEFT OUTER JOIN sys.allocation_units AS au
	        ON p.partition_id = au.container_id
	   LEFT OUTER JOIN sys.filegroups AS fg
	        ON au.data_space_id = fg.data_space_id
	   LEFT OUTER JOIN sys.database_files AS dbf
	        ON fg.data_space_id = dbf.data_space_id;