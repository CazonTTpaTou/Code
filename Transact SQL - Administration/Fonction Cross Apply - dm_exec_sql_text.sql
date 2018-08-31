SELECT s.* FROM sys.dm_exec_query_stats as s CROSS APPLY sys.dm_exec_sql_text(sql_handle)
ORDER BY total_worker_time DESC;

SELECT q.* FROM sys.dm_exec_query_stats CROSS APPLY sys.dm_exec_sql_text(sql_handle) as q
ORDER BY total_worker_time DESC;