/* Utilisation de la base SSIS_DB */
USE [SSIS_DB]
GO

/* ------------------------------------------------------------- */
/* PROCEDURE : SQC_MAJ_QUANTITES_LOT                             */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SQC_MAJ_QUANTITES_LOT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[SQC_MAJ_QUANTITES_LOT]
GO

CREATE PROCEDURE [dbo].[SQC_MAJ_QUANTITES_LOT] (@LOTS VARCHAR(2048))
AS
BEGIN
	-- On declare les variables
	DECLARE @ERRORVAR 		AS INT
	DECLARE @MESSAGE 		AS VARCHAR(3000)
	DECLARE @COMMANDE 		AS NVARCHAR(4000)
	DECLARE @LISTE_LOTS     AS NVARCHAR(500)
	
	-- Si une erreur se produit on annule toute la transaction (Obligatoire si acces serveur lié)
	SET XACT_ABORT ON
	-- On n'affiche pas le resultats des SELECT
	SET NOCOUNT ON;

	-- Trace du debut du traitement
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', 'Debut traitement SQC_MAJ_QUANTITES_LOT'

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en entree a l'etape DIFFUSION : QteEntrDiffu
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	--	[Quantite en entree EQUIPEMENT] 								| 	[Quantite sortie en TEXTU]
	-------------------------------------------------------------------------------------------------------------------------------
	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (11)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET	QteEntrDIFFU = ISNULL(S.DIFFU_QuantiteEntree, L.QteSortTextu)' +
					' FROM   T_LOT L LEFT JOIN T_LOT_CELL_INLINE S ON (L.IdLot = S.IdLot AND S.DIFFU_DateHeureDebutCycle IS NOT NULL)' + 
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'DIFFU - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en entree a l'etape DIFFUSION : QteManqEntreeDIFFU
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite sortie en TEXTU] 										|	[Quantite sortie en TEXTU] 
	--	- [Quantite entree en DIFFU]                                    |	- [Quantite entree en DIFFU]     
	--	- [Nombre rejets Operateur au CHARGEMENT]                       |	- [Nombre rejets Operateur au CHARGEMENT] 
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (11)
	
	-- On met à jour les lots qui ne sont pas passés par le LYTOX/IMPLANTEUR (EXECUTION SUR SQC)
	SET @COMMANDE = ' UPDATE L' +
					' SET QteManqEntreeDIFFU = ISNULL(L.QteSortTextu,0)' +
										   ' - ISNULL(L.QteEntrDiffu,0)' +
										   ' - ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.Lot = R.LOT AND R.IdEtape = 11)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS + 
					' AND L.IdMachineDiffu <> 46'
	-- On trace la requete executee
	SET @MESSAGE = 'DIFFU - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT (LYDOP)', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-- On met à jour les lots qui sont passés par le LYTOX/IMPLANTEUR (ATTENTION !!! La table "WAFER_LTX" n'existe pas sur SQC) 
	SET @COMMANDE = ' UPDATE L' +
					' SET QteManqEntreeDIFFU = ISNULL(L.QteSortTextu,0) - ISNULL(Q.Quantity_In,0)' +
					' FROM T_LOT L LEFT JOIN WAFER_LTX Q ON (L.Lot = Q.LotID)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS + 
					' AND L.IdMachineDiffu = 46'
	-- On trace la requete executee
	SET @MESSAGE = 'DIFFU - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT (LYTOX)', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en sortie a l'etape DIFFUSION : QteSortDIFFU
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite en sortie EQUIPEMENT]									|	[Quantite entree en DIFFU] 
	--				                                    				|	+ [Ajout OPERATEUR en DIFFU]  
	--	 																|	- [Somme des rejets EQUIPEMENT en DIFFU]    
	--  - [Ventes en DIFFU]                         					|	- [Ventes en DIFFU]
	--	- [Somme des rejets OPERATEUR en DIFFU]							| 	- [Somme des rejets OPERATEUR en DIFFU]
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en DIFFU]*				| 	+ [Somme des rejets OPERATEUR CHARGEMENT en DIFFU]*
	--  * Pris en compte dans les manques en entree mais aussi dans le comptage des rejets operateurs
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (11)
	
	SET @COMMANDE = ' UPDATE L' +
						' SET	QteSortDIFFU = CASE WHEN S.DIFFU_QuantiteSortie IS NOT NULL' +
											  ' THEN S.DIFFU_QuantiteSortie' +
											  ' ELSE ISNULL(L.QteEntrDIFFU,0)' +
												 ' + ISNULL(L.QteAjoutDIFFU,0)' +
												 ' - (ISNULL(L.RejEquipImplanDIFFU,0) + ISNULL(L.RejEquipLytoxDIFFU,0))' +
										 ' END' +
										 ' - ISNULL(L.QteVenteDIFFU,0)' +
										 ' - (ISNULL(L.RejOperEbrechDiffu,0) + ISNULL(L.RejOperAspectDiffu,0) + ISNULL(L.RejOperCasseDiffu,0))' +
										 ' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM   T_LOT L LEFT JOIN T_LOT_CELL_INLINE S ON (L.IdLot = S.IdLot AND S.DIFFU_DateHeureFinCycle IS NOT NULL)' +
								   ' LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.IdLot = R.IdLot AND R.IdEtape = 11)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'DIFFU - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en sortie de l'etape DIFFUSION : QteManqDIFFU
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite entree en DIFFU]										|	[Quantite entree en DIFFU]	
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en DIFFU]*				| 	+ [Somme des rejets OPERATEUR CHARGEMENT en DIFFU]*
	--	- [Quantite sortie en DIFFU] 									|	- [Quantite sortie en DIFFU]   
	--  - [Ventes en DIFFU]                         					|	- [Ventes en DIFFU]
	--	- [Somme des rejets OPERATEUR en DIFFU]							| 	- [Somme des rejets OPERATEUR en DIFFU]
	--	- [Somme des rejets EQUIPEMENT en DIFFU]						| 	- [Somme des rejets EQUIPEMENT en DIFFU]
	--  * Pris en compte dans les manques en entree mais aussi dans le comptage des rejets operateurs
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (11)
	
 	SET @COMMANDE = ' UPDATE	L' +
					' SET		QteManqDIFFU = ISNULL(L.QteEntrDIFFU,0)' +
										   ' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
										   ' - ISNULL(L.QteSortDIFFU,0)' +
										   ' - ISNULL(L.QteVenteDIFFU,0)' +
										   ' - (ISNULL(L.RejOperEbrechDiffu,0) + ISNULL(L.RejOperAspectDiffu,0) + ISNULL(L.RejOperCasseDiffu,0))' +
										   ' - (ISNULL(L.RejEquipImplanDiffu,0) + ISNULL(L.RejEquipLytoxDiffu,0))' +
					' FROM		T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.IdLot = R.IdLot AND R.IdEtape = 11)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND 	L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'DIFFU - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en entree a l'etape PECVD : QteEntrPecvd
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	--	[Quantite en entree EQUIPEMENT] 								| 	[Quantite sortie en DESOX]
	-------------------------------------------------------------------------------------------------------------------------------
	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (5)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET	QteEntrPecvd = ISNULL(S.PECVD_QuantiteEntree, L.QteSortDesox)' +
					' FROM   T_LOT L LEFT JOIN T_LOT_CELL_INLINE S ON (L.IdLot = S.IdLot AND S.PECVD_DateHeureDebutCycle IS NOT NULL)' + 
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'PECVD - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en entree a l'etape PECVD : QteManqEntreePecvd
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite sortie en DESOX] 										|	[Quantite sortie en DESOX] 
	--	- [Quantite entree en PECVD]                                    |	- [Quantite entree en PECVD]     
	--	- [Nombre rejets Operateur au CHARGEMENT]                       |	- [Nombre rejets Operateur au CHARGEMENT] 
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (5)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET QteManqEntreePecvd = ISNULL(L.QteSortDesox,0)' +
										   ' - ISNULL(L.QteEntrPecvd,0)' +
										   ' - ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.Lot = R.LOT AND R.IdEtape = 5)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'PECVD - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en sortie a l'etape PECVD : QteSortPecvd
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite en sortie EQUIPEMENT]									|	[Quantite entree en PECVD] 
	--				                                    				|	+ [Ajout OPERATEUR en PECVD]  
	--	 																|	- [Somme des rejets EQUIPEMENT en PECVD]    
	--  - [Ventes en PECVD]                         					|	- [Ventes en PECVD]
	--	- [Somme des rejets OPERATEUR en PECVD]							| 	- [Somme des rejets OPERATEUR en PECVD]
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en PECVD]*				| 	+ [Somme des rejets OPERATEUR CHARGEMENT en PECVD]*
	--  * Pris en compte dans les manques en entree mais aussi dans le comptage des rejets operateurs
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (5)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET	QteSortPecvd = CASE WHEN S.PECVD_QuantiteSortie IS NOT NULL' +
											  ' THEN S.PECVD_QuantiteSortie' +
											  ' ELSE ISNULL(L.QteEntrPecvd,0)' +
												 ' + ISNULL(L.QteAjoutPecvd,0)' +
												 ' - (ISNULL(L.RejEquipCassePecvd,0) + ISNULL(L.[RejEquipCoulB+],0) + ISNULL(L.RejEquipCoulB,0) + ISNULL(L.RejEquipCoulC,0))' +
										 ' END' +
										 ' - ISNULL(L.QteVentePecvd,0)' +
										 ' - (ISNULL(L.RejOperEbrechPecvd,0) + ISNULL(L.RejOperAspectPecvd,0) + ISNULL(L.RejOperCassePecvd,0))' +
										 ' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM   T_LOT L LEFT JOIN T_LOT_CELL_INLINE S ON (L.IdLot = S.IdLot AND S.PECVD_DateHeureFinCycle IS NOT NULL)' +
								   ' LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.IdLot = R.IdLot AND R.IdEtape = 5)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'PECVD - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en sortie de l'etape PECVD : QteManqPecvd
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite entree en PECVD]										|	[Quantite entree en PECVD]	
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en PECVD]*				| 	+ [Somme des rejets OPERATEUR CHARGEMENT en PECVD]*
	--	- [Quantite sortie en PECVD] 									|	- [Quantite sortie en PECVD]   
	--  - [Ventes en PECVD]                         					|	- [Ventes en PECVD]
	--	- [Somme des rejets OPERATEUR en PECVD]							| 	- [Somme des rejets OPERATEUR en PECVD]
	--	- [Somme des rejets EQUIPEMENT en PECVD]						| 	- [Somme des rejets EQUIPEMENT en PECVD]
	--  * Pris en compte dans les manques en entree mais aussi dans le comptage des rejets operateurs
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (5)
	
 	SET @COMMANDE = ' UPDATE	L' +
					' SET		QteManqPecvd = ISNULL(L.QteEntrPecvd,0)' +
										   ' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
										   ' - ISNULL(L.QteSortPecvd,0)' +
										   ' - ISNULL(L.QteVentePecvd,0)' +
										   ' - (ISNULL(L.RejOperEbrechPecvd,0) + ISNULL(L.RejOperAspectPecvd,0) + ISNULL(L.RejOperCassePecvd,0))' +
										   ' - (ISNULL(L.RejEquipCassePecvd,0) + ISNULL(L.[RejEquipCoulB+],0) + ISNULL(L.RejEquipCoulB,0) + ISNULL(L.RejEquipCoulC,0))' +
					' FROM		T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.IdLot = R.IdLot AND R.IdEtape = 5)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND 	L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'PECVD - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en entree a l'etape SERIGRAPHIE : QteEntrSerig
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	--	[Quantite en entree EQUIPEMENT] 								| 	[Quantite sortie en PECVD]
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
	SET @COMMANDE = ' UPDATE LOT' +
					' SET QteEntrSerig = ISNULL(CELL.SERIG_QuantiteEntree, LOT.QteSortPecvd)' +
					' FROM T_LOT LOT LEFT JOIN T_LOT_CELL_INLINE CELL ON (LOT.IdLot = CELL.IdLot AND CELL.SERIG_DateHeureDebutCycle IS NOT NULL)' + 
					' WHERE LOT.Lot IN ' + @LOTS +
					' AND LOT.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'SERIGRAPHIE - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en entree a l'etape SERIGRAPHIE : QteManqEntreeSerig
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite sortie en PECVD] 										|	[Quantite sortie en PECVD] 
	--	- [Quantite entree en SERIGRAPHIE]                              |	- [Quantite entree en SERIGRAPHIE]     
	--	- [Nombre rejets Operateur au CHARGEMENT]                       |	- [Nombre rejets Operateur au CHARGEMENT] 
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET QteManqEntreeSerig = ISNULL(L.QteSortPecvd,0)' +
										   ' - ISNULL(L.QteEntrSerig,0)' +
										   ' - ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.Lot = R.LOT AND R.IdEtape = 6)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'SERIGRAPHIE - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en sortie a l'etape SERIGRAPHIE : QteSortSerig
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite en sortie EQUIPEMENT]									|	[Quantite entree en SERIGRAPHIE] 
	--				                                    				|	+ [Ajout OPERATEUR en SERIGRAPHIE]  
	--	 																|	- [Somme des rejets EQUIPEMENT en SERIGRAPHIE]    
	--  - [Ventes en SERIGRAPHIE]                         				|	- [Ventes en SERIGRAPHIE]
	--	- [Somme des rejets OPERATEUR en SERIGRAPHIE]					| 	- [Somme des rejets OPERATEUR en SERIGRAPHIE]
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en SERIGRAPHIE]		| 	+ [Somme des rejets OPERATEUR CHARGEMENT en SERIGRAPHIE]
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET	QteSortSerig = CASE WHEN S.SERIG_QuantiteSortie IS NOT NULL' +
							                  ' THEN S.SERIG_QuantiteSortie' +
							                  ' ELSE ISNULL(L.QteEntrSerig,0)' +
												 ' + ISNULL(L.QteAjoutSerig,0)' +
											     ' - (ISNULL(L.RejEquipEbrechChgt,0) + ISNULL(L.RejEquipAspectChgt,0) ' +
										          ' + ISNULL(L.RejEquipCasseChgt,0) + ISNULL(L.RejEquipEbrechSt1,0) + ISNULL(L.RejEquipAspectSt1,0)' +
										          ' + ISNULL(L.RejEquipCasseSt1,0) + ISNULL(L.RejEquipManqSt1,0) + ISNULL(L.RejEquipVision1,0)' +
										          ' + ISNULL(L.RejEquipEbrechSt2,0) + ISNULL(L.RejEquipAspectSt2,0) + ISNULL(L.RejEquipCasseSt2,0)' +
										          ' + ISNULL(L.RejEquipManqSt2,0) + ISNULL(L.RejEquipVision2,0) + ISNULL(L.RejEquipEbrechSt3,0)' +
										          ' + ISNULL(L.RejEquipAspectSt3,0) + ISNULL(L.RejEquipCasseSt3,0) + ISNULL(L.RejEquipManqSt3,0)' +
										          ' + ISNULL(L.RejEquipVision3,0) + ISNULL(L.RejEquipEbrechSt4,0) + ISNULL(L.RejEquipAspectSt4,0)' +
										          ' + ISNULL(L.RejEquipCasseSt4,0) + ISNULL(L.RejEquipEbrechDechgt,0) + ISNULL(L.RejEquipAspectDechgt,0)' +
										          ' + ISNULL(L.RejEquipCasseDechgt,0))' +
										 ' END' +
										' - ISNULL(L.QteVenteSerig,0)' +
										' - (ISNULL(L.RejOperEbrechSerig,0) + ISNULL(L.RejOperAspectSerig,0) + ISNULL(L.RejOperCasseSerig,0) + ISNULL(L.RejOperGradeBSerig,0))' +
										' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM   T_LOT L LEFT JOIN T_LOT_CELL_INLINE S ON (L.IdLot = S.IdLot AND S.SERIG_DateHeureDebutCycle IS NOT NULL)' +
								   ' LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.IdLot = R.IdLot AND R.IdEtape = 6)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'SERIGRAPHIE - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en sortie de l'etape SERIGRAPHIE : QteManqSerig
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite entree en SERIGRAPHIE]								|	[Quantite entree en SERIGRAPHIE]	
	--	+ [Somme des rejets OPERATEUR CHARGEMENT en SERIGRAPHIE]*	    | 	+ [Somme des rejets OPERATEUR CHARGEMENT en SERIGRAPHIE]*
	--	- [Quantite sortie en SERIGRAPHIE] 								|	- [Quantite sortie en SERIGRAPHIE]   
	--  - [Ventes en SERIGRAPHIE]                         				|	- [Ventes en SERIGRAPHIE]
	--	- [Somme des rejets OPERATEUR en SERIGRAPHIE]					| 	- [Somme des rejets OPERATEUR en SERIGRAPHIE]
	--	- [Somme des rejets EQUIPEMENT en SERIGRAPHIE]					| 	- [Somme des rejets EQUIPEMENT en SERIGRAPHIE]
	--  * Pris en compte dans les manques en entree mais aussi dans le comptage des rejets operateurs
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
 	SET @COMMANDE = ' UPDATE	L' +
					' SET		QteManqSerig = ISNULL(QteEntrSerig,0)' +
					                         ' + ISNULL(R.OPE_VOIE1_CHGT,0)' +
					                         ' - ISNULL(QteSortSerig,0)' +
					                         ' - ISNULL(QteVenteSerig,0)' +
										     ' - (ISNULL(RejOperEbrechSerig,0) + ISNULL(RejOperAspectSerig,0) + ISNULL(RejOperCasseSerig,0) + ISNULL(RejOperGradeBSerig,0))' +
					                         ' - (ISNULL(RejEquipEbrechChgt,0) + ISNULL(RejEquipAspectChgt,0) + ISNULL(RejEquipCasseChgt,0) + ISNULL(RejEquipEbrechSt1,0)' +
					                          ' + ISNULL(RejEquipAspectSt1,0) + ISNULL(RejEquipCasseSt1,0) + ISNULL(RejEquipManqSt1,0) + ISNULL(RejEquipVision1,0)' +
					                          ' + ISNULL(RejEquipEbrechSt2,0) + ISNULL(RejEquipAspectSt2,0) + ISNULL(RejEquipCasseSt2,0) + ISNULL(RejEquipManqSt2,0)' +
					                          ' + ISNULL(RejEquipVision2,0) + ISNULL(RejEquipEbrechSt3,0) + ISNULL(RejEquipAspectSt3,0) + ISNULL(RejEquipCasseSt3,0)' +
					                          ' + ISNULL(RejEquipManqSt3,0) + ISNULL(RejEquipVision3,0) + ISNULL(RejEquipEbrechSt4,0) + ISNULL(RejEquipAspectSt4,0)' +
					                          ' + ISNULL(RejEquipCasseSt4,0) + ISNULL(RejEquipEbrechDechgt,0) + ISNULL(RejEquipAspectDechgt,0) + ISNULL(RejEquipCasseDechgt,0))' +
					' FROM T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.Lot = R.LOT AND R.IdEtape = 6)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND 	L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'SERIGRAPHIE - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites en entree a l'etape TRI : QteEntrTri
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	--	[Quantite en entree EQUIPEMENT] 								| 	[Quantite sortie en SERIGRAPHIE]
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
	SET @COMMANDE = ' UPDATE LOT' +
					' SET	QteEntrTri = ISNULL(CELL.TRI_QuantiteEntree, LOT.QteSortSerig)' +
					' FROM   T_LOT LOT LEFT JOIN T_LOT_CELL_INLINE CELL ON (LOT.IdLot = CELL.IdLot AND CELL.TRI_DateHeureDebutCycle IS NOT NULL)' + 
					' WHERE LOT.Lot IN ' + @LOTS +
					' AND LOT.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'TRI - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 

	-------------------------------------------------------------------------------------------------------------------------------
	-- Mise a jour des quantites manquantes en entree a l'etape TRI : QteManqEntreeTri
	--  ...........................................................................................................................
	-- 	INLINE															|	OFFLINE
	--  ...........................................................................................................................
	-- 	[Quantite sortie en SERIGRAPHIE] 								|	[Quantite sortie en SERIGRAPHIE] 
	--	- [Quantite entree en TRI]                             			|	- [Quantite entree en TRI]     
	--	- [Nombre rejets Operateur au CHARGEMENT]                       |	- [Nombre rejets Operateur au CHARGEMENT] 
	-------------------------------------------------------------------------------------------------------------------------------

	SELECT @LISTE_LOTS = Liste from GetLotsEligibles (6)
	
	SET @COMMANDE = ' UPDATE L' +
					' SET QteManqEntreeTri = ISNULL(L.QteSortSerig,0)' +
										 ' - ISNULL(L.QteEntrTri,0)' +
										 ' - ISNULL(R.OPE_VOIE1_CHGT,0)' +
					' FROM T_LOT L LEFT JOIN V_LOTS_QUANTITE_REJETS_OPERATEUR R ON (L.Lot = R.LOT AND R.IdEtape = 7)' +
					' WHERE L.Lot IN ' + @LOTS +
					' AND L.Lot IN ' + @LISTE_LOTS
	-- On trace la requete executee
	SET @MESSAGE = 'TRI - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On execute la commande	
	EXECUTE @ERRORVAR = [SRV-SQL\SQC].[SQC_DB].[dbo].sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
	
VALIDER_TRANSACTION:
	-- On trace la fin du traitement
	SET @MESSAGE = 'Fin traitement SQC_MAJ_QUANTITES_LOT > OK' 
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'I', @MESSAGE
	-- On sort
	RETURN 0
	
INVALIDER_TRANSACTION:
	-- On recupere le code erreur
	IF @@ERROR <> 0 SELECT @ERRORVAR = @@ERROR
	-- On trace l'erreur
	SET @MESSAGE = 'Fin traitement SQC_MAJ_QUANTITES_LOT > ERREUR ' + CAST(@ERRORVAR AS VARCHAR)
	EXEC SSIS_INSERT_DEBUG 'SQC_MAJ_QUANTITES_LOT', 'TRSFT_DWH_SQC', 'E', @MESSAGE
	-- On retourne l'erreur
	RETURN @ERRORVAR;

END;
GO