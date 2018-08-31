USE [CELL_INLINE_DB]
GO

/****** Object:  StoredProcedure [dbo].[DWH_EXEC_DEFRAG]    Script Date: 11/17/2014 12:21:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DWH_EXEC_DEFRAG] (@TYPE_DEFRAG VARCHAR(50)) 
AS   
BEGIN

	-- Declaration des variables
	DECLARE @CRITERES 		AS NVARCHAR(150)  
	DECLARE @CURSEUR 		AS NVARCHAR(1000)
	DECLARE @COMMANDE 		AS NVARCHAR(1000)  
	
	-- Type de defrag : REBUILD
	IF (@TYPE_DEFRAG = 'REBUILD')
		-- On constitue les criteres de la requête
		SET @CRITERES =  ' AND indexstats.avg_fragmentation_in_percent > 30' 
	-- Type de defrag : REORGANIZE
	ELSE IF (@TYPE_DEFRAG = 'REORGANIZE')
		-- On constitue les criteres de la requête
		SET @CRITERES =  ' AND indexstats.avg_fragmentation_in_percent > 5' +
						 ' AND indexstats.avg_fragmentation_in_percent <= 30'
	-- On constitue la requete
	SET @CURSEUR =  ' DECLARE CUR_Commande CURSOR FOR ' +
					' SELECT ''ALTER INDEX '' + dbindexes.[name] + '' ON [dbo].['' + dbtables.[name] + ''] ' + @TYPE_DEFRAG + '''' +
					' FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats' +
						' INNER JOIN sys.tables dbtables' +
							' ON dbtables.[object_id] = indexstats.[object_id]' +
						' INNER JOIN sys.schemas dbschemas' +
							' ON dbtables.[schema_id] = dbschemas.[schema_id]' +
						' INNER JOIN sys.indexes AS dbindexes' +
							' ON dbindexes.[object_id] = indexstats.[object_id] AND indexstats.index_id = dbindexes.index_id' +
						' WHERE	indexstats.database_id = DB_ID() AND dbindexes.[name] IS NOT NULL' + @CRITERES
	-- On cree le curseur
	EXEC (@CURSEUR) 
	-- On ouvre le curseur
	OPEN CUR_Commande  
	-- On recupere le premier tuple (correspondant à la commande à saisir)
	FETCH NEXT FROM CUR_Commande INTO @COMMANDE
	-- Tant qu'un tuple est retourné
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		-- On execute la commande de reconstruction de l'index
		EXEC (@COMMANDE) 
		-- On passe au tuple suivant
		FETCH NEXT FROM CUR_Commande INTO @COMMANDE  
	END  
	-- On ferme le curseur
	CLOSE CUR_Commande   
	-- On libere la memoire
	DEALLOCATE CUR_Commande 

END

GO


