SELECT sqlserver_start_time,
       s.name AS TABLE_SCHEMA, o.name AS TABLE_NAME, i.name AS INDEX_NAME,
       st.*
FROM   sys.dm_db_index_usage_stats AS st
       JOIN sys.indexes AS i ON st.object_id = i.object_id AND st.index_id = i.index_id
	   JOIN sys.objects AS o ON st.object_id = o.object_id
	   JOIN sys.schemas AS s ON  o.schema_id = s.schema_id
	   CROSS JOIN sys.dm_os_sys_info
WHERE  database_id = DB_ID() 
  AND  o."type" IN ('U', 'V')
ORDER  BY user_seeks, user_lookups, user_scans, user_updates DESC;


