/* ------------------------------------------------------------- */
/* CREATION DES VUES                                             */
/* ------------------------------------------------------------- */

/* Utilisation de la base INLINE_CELL_DB */
USE [CELL_INLINE_DB]
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES                                   */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES]
AS
	SELECT	CASE 
				WHEN C.IdClasse BETWEEN 1    AND 999  THEN 'Automate'
				WHEN C.IdClasse BETWEEN 1000 AND 1999 THEN 'Vision P'
				WHEN C.IdClasse BETWEEN 2000 AND 2999 THEN 'Vision N'
				WHEN C.IdClasse BETWEEN 3000 AND 3499 THEN 'Flasheur (WaveLabs)'
				WHEN C.IdClasse BETWEEN 3500 AND 3599 THEN 'Electrolum (WaveLabs)'
				WHEN C.IdClasse BETWEEN 3600 AND 3699 THEN 'IR - Flasheur (WaveLabs)'
			END AS Machine,
			CASE 
				WHEN C.IdClasse BETWEEN 1    AND 999  THEN 3000
				WHEN C.IdClasse BETWEEN 1000 AND 1999 THEN 1000
				WHEN C.IdClasse BETWEEN 2000 AND 2999 THEN 2000
				WHEN C.IdClasse BETWEEN 3000 AND 3499 THEN 3000
				WHEN C.IdClasse BETWEEN 3500 AND 3599 THEN 3500
				WHEN C.IdClasse BETWEEN 3600 AND 3699 THEN 3600
			END AS CodeMachine,
			CASE 
				WHEN C.IdClasse BETWEEN 1    AND 99   THEN C.IdClasse
				WHEN C.IdClasse BETWEEN 1000 AND 1999 THEN C.IdClasse - 1000
				WHEN C.IdClasse BETWEEN 2000 AND 2999 THEN C.IdClasse - 2000
				WHEN C.IdClasse BETWEEN 3000 AND 3499 THEN C.IdClasse - 3000
				WHEN C.IdClasse BETWEEN 3500 AND 3599 THEN C.IdClasse - 3500
				WHEN C.IdClasse BETWEEN 3600 AND 3699 THEN C.IdClasse - 3600
			END AS CodeClasse,
			T.IdTypeClasse AS IdTypeClasse, T.Libelle AS LibTypeClasse, T.Description AS DescTypeClasse, 
			T.Rejets, G.Libelle AS LibGroupeClasse, G.Description AS DescGroupeClasse,
			C.IdClasse AS IdClasse, C.Libelle AS LibClasse, C.Description AS DescClasse
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	T.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_VALIDES                          */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_VALIDES]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_VALIDES]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_VALIDES]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, C.IdClasse, C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	C.IdClasse BETWEEN 1 AND 999
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_VISION_P					         */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_VISION_P]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_VISION_P]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_VISION_P]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, C.IdClasse - 1000 AS IdClasse, C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	C.IdClasse BETWEEN 1000 AND 1999
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_VISION_N                          */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_VISION_N]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_VISION_N]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_VISION_N]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, C.IdClasse - 2000 AS IdClasse, C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	C.IdClasse BETWEEN 2000 AND 2999
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_FLASHEUR	                         */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_FLASHEUR]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_FLASHEUR]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_FLASHEUR]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, 
			CASE WHEN C.IdClasse BETWEEN 3000 AND 3499 THEN C.IdClasse - 3000 ELSE C.IdClasse END AS IdClasse, 
			C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	(C.IdClasse BETWEEN 3000 AND 3499 OR C.IdClasse BETWEEN 1 AND 999)
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_ELECTROLUM                        */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_ELECTROLUM]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_ELECTROLUM]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_ELECTROLUM]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, C.IdClasse - 3500 AS IdClasse, C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	C.IdClasse BETWEEN 3500 AND 3599
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VD_PRODUCTION_CLASSES_INFRA_ROUGE                       */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VD_PRODUCTION_CLASSES_INFRA_ROUGE]'))
	DROP VIEW [dbo].[VD_PRODUCTION_CLASSES_INFRA_ROUGE]
GO

CREATE VIEW [dbo].[VD_PRODUCTION_CLASSES_INFRA_ROUGE]
AS
	SELECT	G.IdGroupeClasse, G.Libelle AS LibGroupeClasse, C.IdClasse - 3600 AS IdClasse, C.Libelle AS LibClasse, T.Rejets
	FROM	[dbo].[TD_Production_Classes] C 
			LEFT JOIN [dbo].[TD_Production_Classes_Groupes] G ON C.[IdGroupeClasse] = G.[IdGroupeClasse]
			LEFT JOIN [dbo].[TD_Production_Classes_Types] T ON T.[IdTypeClasse] = G.[IdTypeClasse]
	WHERE	C.IdClasse BETWEEN 3600 AND 3699
	AND		C.Actif = -1
	AND		G.Actif = -1
	AND		C.Actif = -1
GO

/* ------------------------------------------------------------- */
/* VUE : VP_STATUT_WAFER_WAV                                     */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VP_STATUT_WAFER_WAV]'))
	DROP VIEW [dbo].[VP_STATUT_WAFER_WAV]
GO

CREATE VIEW [dbo].[VP_STATUT_WAFER_WAV]
AS
	SELECT	S.IdStatutWafer as IdStatut, S.Libelle as LibStatut, S.Observations as ObsStatut, S.Actif, S.Rang,
			E.IdEtape, E.NomEtape as LibEtape, 
			O.IdStatutOrigine as IdOrigine, O.Libelle as LibOrigine,
			D.RejetBin,
			T.IdTypeStatut as IdType,  T.Libelle as LibType
	FROM	[dbo].[TP_STATUT_WAFER_WAV] S 
			INNER JOIN [dbo].[TP_STATUT_WAFER_WAV_DETAIL] D ON (S.IdStatutWafer = D.IdStatutWafer)
			INNER JOIN [dbo].[TP_STATUT_WAFER_TYPE] T ON (S.IdTypeStatut = T.IdTypeStatut)
			INNER JOIN [dbo].[TP_STATUT_WAFER_ORIGINE] O ON (S.IdStatutOrigine = O.IdStatutOrigine)
			CROSS JOIN [dbo].[TD_Production_Etapes]	E
	WHERE	E.IdEtape          = 7
GO

/* ------------------------------------------------------------- */
/* VUE : VP_STATUT_WAFER                            		 	 */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VP_STATUT_WAFER]'))
	DROP VIEW [dbo].[VP_STATUT_WAFER]
GO

CREATE VIEW [dbo].[VP_STATUT_WAFER] 
AS
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_JR] 
	UNION ALL
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_SERIG] 
	UNION ALL
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_DESPATCH] 
	UNION ALL
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_SCHILLER] 
	UNION ALL
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_LYTOX] 
	UNION ALL
	SELECT	DISTINCT IdStatut, IdEtape, IdOrigine, IdType, LibStatut, ObsStatut, Actif, Rang
	FROM	[dbo].[VP_STATUT_WAFER_WAV] 
GO

/* ------------------------------------------------------------- */
/* VUE : V_STATUT_WAFER_WAV                            		 	 */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_STATUT_WAFER_WAV]'))
	DROP VIEW [dbo].[V_STATUT_WAFER_WAV]
GO

CREATE VIEW [dbo].[V_STATUT_WAFER_WAV]
AS
	SELECT	W.IdRecord, W.IdEquipement, W.LotId, W.WaferEqID, W.WaferNr, W.TimeStamp_Flash AS DateHeure, W.WaferId_Manu AS LotWaferId, 
			W.WaferId_Auto AS PhysWaferId, 
			ISNULL(W.Bin,0) as RejetBin,
			S.IdStatut, S.LibStatut, S.IdType, S.LibType  
	FROM	WAFER_WAV W INNER JOIN VP_STATUT_WAFER_WAV S
				ON ISNULL(S.RejetBin,0) = ISNULL(W.Bin,0) 
GO


/* ------------------------------------------------------------- */
/* VUE : V_REPARTITION_LOT                            		 	 */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[V_REPARTITION_LOT]'))
	DROP VIEW [dbo].[V_REPARTITION_LOT]
GO

CREATE VIEW [dbo].[V_REPARTITION_LOT]
AS
	SELECT	W.IdRecord, W.IdEquipement, W.LotId, W.WaferEqID, W.WaferNr, W.TimeStamp_Flash AS DateHeure, W.WaferId_Manu AS LotWaferId, 
			W.WaferId_Auto AS PhysWaferId, 
			ISNULL(W.Bin,0) as RejetBin,
			S.IdStatut, S.LibStatut, S.IdType, S.LibType  
	FROM	WAFER_WAV W INNER JOIN VP_STATUT_WAFER_WAV S
				ON ISNULL(S.RejetBin,0) = ISNULL(W.Bin,0) 
GO

