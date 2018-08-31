SELECT * FROM sys.dm_exec_requests;
SELECT * FROM sys.dm_exec_query_stats CROSS APPLY sys.dm_exec_sql_text(sql_handle)
ORDER BY total_worker_time DESC;

(@1 varchar(8000),@2 smallint)UPDATE [dbo].[INTERVENTION] set [DateCreation] = @1  WHERE [idIntervention]=@2