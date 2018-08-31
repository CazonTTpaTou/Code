--> audit de volume et d'occuppation des journaux de transaction
DBCC SQLPERF(LOGSPACE)

--> verser les données d'un DBCC vers une table
-- 1) construire la table
DECLARE @T TABLE (DATABASE_NAME          sysname,
                  LOG_SIZE_MB            FLOAT,
				  LOG_SPACE_USED_PERCENT FLOAT,
				  STATUS                 BIT);
-- 2) alimenter la table avec une exécution dynamique
INSERT INTO @T
EXEC ('DBCC SQLPERF(LOGSPACE)');
-- 3) utilisation de la table
SELECT *
FROM   @T
WHERE  DATABASE_NAME NOT IN ('master', 'msdb', 'tempdb', 'model')
  AND  DATABASE_NAME NOT LIKE 'ReportServer$%';




DBCC TRACEON (3604)
--> quels sont les indicateurs de trace mis en place
DBCC TRACESTATUS

--> analyse de fragmentation des index
-- résultat sous forme texte
DBCC SHOWCONTIG;
-- résultat sous forme tabulaire
DBCC SHOWCONTIG WITH TABLERESULTS
--> remplacé par :
SELECT s.name AS TABLE_SCHEMA, o.name AS TABLE_NAME, i.name AS INDEX_NAME, ips.* 
FROM   sys.dm_db_index_physical_stats(DB_ID(), NULL,  NULL, NULL, NULL) AS ips
       JOIN sys.indexes AS i
	        ON ips.object_id = i.object_id
			AND ips.index_id = i.index_id
       JOIN sys.objects AS o
	        ON ips.object_id = o.object_id
	   JOIN sys.schemas AS s
	        ON o.schema_id = s.schema_id
ORDER  BY avg_fragmentation_in_percent DESC;

-- plus vieille transaction active
--> sous forme text
DBCC OPENTRAN
--> sous forme tabulaire
DBCC OPENTRAN WITH TABLERESULTS


-- trace des transactions durant plus de 30 minutes
SELECT at.transaction_id, at.transaction_begin_time,
       login_time, host_name, program_name, login_name, nt_domain, nt_user_name,
	   last_request_start_time, text AS SQL_COMMAND,
	   DATEDIFF(minute, at.transaction_begin_time, GETDATE()) AS DUREE_MINUTES
FROM   sys.dm_tran_active_transactions AS at
       JOIN sys.dm_tran_session_transactions AS st
	        ON at.transaction_id = st.transaction_id
	   JOIN sys.dm_exec_sessions AS s
	        ON st.session_id = s.session_id
	   JOIN sys.dm_exec_connections AS c
	        ON st.session_id = c.session_id
	   CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle)
WHERE  DATEDIFF(minute, at.transaction_begin_time, GETDATE()) > 30;











