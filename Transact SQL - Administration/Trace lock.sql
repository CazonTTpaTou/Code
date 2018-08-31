
SELECT * 
FROM   sys.dm_exec_requests AS r
       CROSS APPLY sys.dm_exec_sql_text(r.sql_handle)
       CROSS APPLY sys.dm_exec_query_plan(r.plan_handle)
	   JOIN sys.dm_exec_sessions AS s
	        ON r.session_id = s.session_id
	   JOIN sys.dm_exec_connections AS c
	        ON r.session_id = c.session_id

WHERE  r.session_id > 50 AND r.session_id <> @@SPID


select * from 
sys.dm_os_waiting_tasks t
inner join sys.dm_exec_connections c on c.session_id = t.blocking_session_id
cross apply sys.dm_exec_sql_text(c.most_recent_sql_handle) as h1