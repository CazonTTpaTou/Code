SELECT * 
FROM  sys.dm_db_missing_index_details 
ORDER BY statement, COALESCE(equality_columns + ', ' + inequality_columns, equality_columns, inequality_columns)

SELECT sc.name, o.name, i.name, s.*
FROM   sys.dm_db_index_usage_stats AS s
       JOIN sys.indexes AS i
	        ON s.object_id = i.object_id AND s.index_id = i.index_id
       JOIN sys.objects AS o
	        ON s.object_id = o.object_id
       JOIN sys.schemas AS sc
	        ON o.schema_id = sc.schema_id
WHERE  database_id = DB_ID()
  AND  s.index_id > 1
ORDER BY user_seeks, user_lookups, user_scans, user_updates DESC


CREATE INDEX X_SQLPRO_20150709_1712_001
   ON [SQC_DB].[dbo].[T_Evenements_Ecran]
      ([EQU_Identifiant], [LIG_Identifiant], [EVT_Entite], [EVT_DateHeureMontage])
   INCLUDE ([EVT_Identifiant])
   WITH (FILLFACTOR = 90);

CREATE INDEX X_SQLPRO_20150709_1712_002
   ON [SQC_DB].[dbo].[T_Evenements_Ecran]
      ([EQU_Identifiant], [EVT_Entite], [EVT_DateHeureMontage])
   INCLUDE ([EVT_Identifiant], [LIG_Identifiant])
   WITH (FILLFACTOR = 90);
