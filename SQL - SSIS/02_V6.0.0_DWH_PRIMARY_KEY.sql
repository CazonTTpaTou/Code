/* ------------------------------------------------------------- */
/* CREATION DES CLES PRIMAIRES                                   */
/* ------------------------------------------------------------- */

/* Utilisation de la base INLINE_CELL_DB */
USE [CELL_INLINE_DB]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES_TYPES			             	 */
/* ------------------------------------------------------------- */

/* Colonne : TD_PRODUCTION_CLASSES_TYPES.IdTypeClasse */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES_TYPES]') AND name = N'PK_TD_PRODUCTION_CLASSES_TYPES')
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_TYPES] DROP CONSTRAINT [PK_TD_PRODUCTION_CLASSES_TYPES]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_TYPES] ADD  CONSTRAINT [PK_TD_PRODUCTION_CLASSES_TYPES] PRIMARY KEY NONCLUSTERED 
(
	[IdTypeClasse] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES_GROUPES			             */
/* ------------------------------------------------------------- */

/* Colonne : TD_PRODUCTION_CLASSES_GROUPES.IdGroupe */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES_GROUPES]') AND name = N'PK_TD_PRODUCTION_CLASSES_GROUPES')
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] DROP CONSTRAINT [PK_TD_PRODUCTION_CLASSES_GROUPES]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ADD  CONSTRAINT [PK_TD_PRODUCTION_CLASSES_GROUPES] PRIMARY KEY NONCLUSTERED 
(
	[IdGroupeClasse] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES			           		     */
/* ------------------------------------------------------------- */

/* Colonne : TD_PRODUCTION_CLASSES.IdClasse */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES]') AND name = N'PK_TD_PRODUCTION_CLASSES')
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES] DROP CONSTRAINT [PK_TD_PRODUCTION_CLASSES]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES] ADD  CONSTRAINT [PK_TD_PRODUCTION_CLASSES] PRIMARY KEY NONCLUSTERED 
(
	[IdClasse] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV			                         */
/* ------------------------------------------------------------- */

/* Colonne : TP_STATUT_WAFER_WAV.IdStatutWafer */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TP_STATUT_WAFER_WAV]') AND name = N'PK_TP_STATUT_WAFER_WAV')
	ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] DROP CONSTRAINT [PK_TP_STATUT_WAFER_WAV]
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] ADD  CONSTRAINT [PK_TP_STATUT_WAFER_WAV] PRIMARY KEY NONCLUSTERED 
(
	[IdStatutWafer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV_DETAIL	                         */
/* ------------------------------------------------------------- */

/* Colonne : TP_STATUT_WAFER_WAV_DETAIL.RejetBin */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TP_STATUT_WAFER_WAV_DETAIL]') AND name = N'PK_TP_STATUT_WAFER_WAV_DETAIL')
	ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL] DROP CONSTRAINT [PK_TP_STATUT_WAFER_WAV_DETAIL]
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ADD  CONSTRAINT [PK_TP_STATUT_WAFER_WAV_DETAIL] PRIMARY KEY NONCLUSTERED 
(
	[RejetBin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : RECIPE_WAV			                                 */
/* ------------------------------------------------------------- */

/* Colonne : RECIPE_WAV.IdRecord */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RECIPE_WAV]') AND name = N'PK_RECIPE_WAV')
	ALTER TABLE [dbo].[RECIPE_WAV] DROP CONSTRAINT [PK_RECIPE_WAV]
GO

ALTER TABLE [dbo].[RECIPE_WAV] ADD  CONSTRAINT [PK_RECIPE_WAV] PRIMARY KEY NONCLUSTERED 
(
	[IdRecord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_WAV                                             */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_WAV.IdRecord */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WAFER_WAV]') AND name = N'PK_WAFER_WAV')
	ALTER TABLE [dbo].[WAFER_WAV] DROP CONSTRAINT [PK_WAFER_WAV]
GO

ALTER TABLE [dbo].[WAFER_WAV] ADD  CONSTRAINT [PK_WAFER_WAV] PRIMARY KEY NONCLUSTERED 
(
	[IdRecord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI                                             */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_TRI.IdRecord */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WAFER_TRI]') AND name = N'PK_WAFER_TRI')
	ALTER TABLE [dbo].[WAFER_TRI] DROP CONSTRAINT [PK_WAFER_TRI]
GO

ALTER TABLE [dbo].[WAFER_TRI] ADD  CONSTRAINT [PK_WAFER_TRI] PRIMARY KEY NONCLUSTERED 
(
	[IdRecord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI_LOT                                       	 */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_TRI_LOT.IdRecord */
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WAFER_TRI_LOT]') AND name = N'PK_WAFER_TRI_LOT')
	ALTER TABLE [dbo].[WAFER_TRI_LOT] DROP CONSTRAINT [PK_WAFER_TRI_LOT]
GO

ALTER TABLE [dbo].[WAFER_TRI_LOT] ADD  CONSTRAINT [PK_WAFER_TRI_LOT] PRIMARY KEY NONCLUSTERED 
(
	[IdRecord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
