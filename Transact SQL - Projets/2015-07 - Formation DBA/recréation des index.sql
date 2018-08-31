WITH  
idc AS (SELECT ic.object_id, index_id,  
               ROW_NUMBER() OVER(PARTITION BY ic.object_id, index_id, is_included_column
                                 ORDER BY index_column_id) AS index_column_id,
               is_included_column,  
               c.name, CASE WHEN is_descending_key = 1 THEN 'DESC' ELSE 'ASC' END AS ord
        FROM   sys.index_columns AS ic
               INNER JOIN sys.columns AS c
                     ON ic.object_id = c.object_id
                        AND ic.column_id = c.column_id),
idk AS (SELECT object_id, index_id,  index_column_id, 1 AS cols,
               CAST('[' + name + '] ' + ord AS NVARCHAR(MAX)) AS KEY_DEF
        FROM   idc        
        WHERE  is_included_column = 0
          AND  index_column_id = 1
        UNION ALL
        SELECT idc.object_id, idc.index_id, idc.index_column_id, cols + 1,
               KEY_DEF + ', ' + '[' + idc.name + '] ' + ord
        FROM   idc
               INNER JOIN idk
                     ON idc.object_id = idk.object_id AND
                     idc.index_id = idk.index_id AND
                     idc.index_column_id = idk.index_column_id + 1
        WHERE  idc.is_included_column = 0),
idi AS (SELECT object_id, index_id,  index_column_id, 1 AS coli,
               CAST('[' + name + '] ' AS NVARCHAR(MAX)) AS COL_DEF
        FROM   idc        
        WHERE  is_included_column = 1
          AND  index_column_id = 1
        UNION ALL
        SELECT idc.object_id, idc.index_id, idc.index_column_id, coli + 1,
               COL_DEF + ', ' + '[' +  idc.name + '] '
        FROM   idc
               INNER JOIN idi
                     ON idc.object_id = idi.object_id AND
                     idc.index_id = idi.index_id AND
                     idc.index_column_id = idi.index_column_id + 1
        WHERE  idc.is_included_column = 1),
dfi AS (SELECT idk.*, COL_DEF,  
               ROW_NUMBER() OVER(PARTITION BY idk.object_id, idk.index_id  
                                 ORDER BY cols DESC) AS N
        FROM   idk
               LEFT OUTER JOIN idi
                    ON idk.object_id = idi.object_id
                       AND idk.index_id = idi.index_id)
SELECT 'CREATE '
       + CASE WHEN is_unique = 1 THEN ' UNIQUE ' ELSE '' END
       + CASE WHEN i.index_id = 1 THEN ' CLUSTERED ' ELSE '' END +
       ' INDEX [' + i.name + '] ON [' + s.name +'].[' + o.name
       +'] (' + KEY_DEF +')'  
       + COALESCE(' INCLUDE (' + COL_DEF + ')', '')
       + COALESCE(' WHERE (' + i.filter_definition + ')', '') 
	   + ' WITH (DROP_EXISTING = ON) '
	   + CASE WHEN i.index_id IN (0, 1) THEN ' ON FG_DATA' ELSE ' ON FG_INDX' END
	   + ';' AS LOGICAL_DEFINITION,
       is_unique, CASE WHEN i.index_id = 1 THEN 1 ELSE 0 END AS is_clustered
FROM   dfi
       INNER JOIN sys.indexes AS i
             ON dfi.object_id = i.object_id
                AND dfi.index_id = i.index_id
       INNER JOIN sys.objects AS o
             ON i.object_id = o.object_id
       INNER JOIN sys.schemas AS s
             ON o.schema_id = s.schema_id
WHERE  o."type" = 'U' AND N = 1;