/* ------------------------------------------------------------- */
/* CREATION DES CLES ETRANGERES                                  */
/* ------------------------------------------------------------- */

/* Utilisation de la base DWH_DB */
USE [CELL_INLINE_DB]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES_GROUPES                         */
/* ------------------------------------------------------------- */

/* Colonne : TD_PRODUCTION_CLASSES_GROUPES.IdTypeClasse */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TD_PRODUCTION_CLASSES_GROUPES_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES_GROUPES]'))
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] DROP CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_00]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] WITH NOCHECK ADD CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_00] FOREIGN KEY([IdTypeClasse])
	REFERENCES [dbo].[TD_PRODUCTION_CLASSES_TYPES] ([IdTypeClasse])
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] CHECK CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_00]
GO

/* Colonne : TD_PRODUCTION_CLASSES_GROUPES.IdEquipement */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TD_PRODUCTION_CLASSES_GROUPES_01]') AND parent_object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES_GROUPES]'))
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] DROP CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_01]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] WITH NOCHECK ADD CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_01] FOREIGN KEY([IdEquipement])
	REFERENCES [dbo].[TD_PRODUCTION_EQUIPEMENTS] ([IdEquipement])
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] CHECK CONSTRAINT [FK_TD_PRODUCTION_CLASSES_GROUPES_01]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES                                 */
/* ------------------------------------------------------------- */

/* Colonne : TD_PRODUCTION_CLASSES.IdGroupeClasse */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TD_PRODUCTION_CLASSES_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[TD_PRODUCTION_CLASSES]'))
	ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES] DROP CONSTRAINT [FK_TD_PRODUCTION_CLASSES_00]
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES] WITH NOCHECK ADD CONSTRAINT [FK_TD_PRODUCTION_CLASSES_00] FOREIGN KEY([IdGroupeClasse])
	REFERENCES [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse])
GO

ALTER TABLE [dbo].[TD_PRODUCTION_CLASSES] CHECK CONSTRAINT [FK_TD_PRODUCTION_CLASSES_00]
GO


/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV                                   */
/* ------------------------------------------------------------- */

/* Colonne : TP_STATUT_WAFER_WAV.IdStatutOrigine */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TP_STATUT_WAFER_WAV_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[TP_STATUT_WAFER_WAV]'))
	ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] DROP CONSTRAINT [FK_TP_STATUT_WAFER_WAV_00]
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV]  WITH NOCHECK ADD  CONSTRAINT [FK_TP_STATUT_WAFER_WAV_00] FOREIGN KEY([IdStatutOrigine])
	REFERENCES [dbo].[TP_STATUT_WAFER_ORIGINE] ([IdStatutOrigine])
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] CHECK CONSTRAINT [FK_TP_STATUT_WAFER_WAV_00]
GO

/* Colonne : TP_STATUT_WAFER_WAV.IdTypeStatut */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TP_STATUT_WAFER_WAV_01]') AND parent_object_id = OBJECT_ID(N'[dbo].[TP_STATUT_WAFER_WAV]'))
	ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] DROP CONSTRAINT [FK_TP_STATUT_WAFER_WAV_01]
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV]  WITH NOCHECK ADD  CONSTRAINT [FK_TP_STATUT_WAFER_WAV_01] FOREIGN KEY([IdTypeStatut])
	REFERENCES [dbo].[TP_STATUT_WAFER_TYPE] ([IdTypeStatut])
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV] CHECK CONSTRAINT [FK_TP_STATUT_WAFER_WAV_01]
GO

/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV_DETAIL                            */
/* ------------------------------------------------------------- */

/* Colonne : TP_STATUT_WAFER_WAV_DETAIL.IdStatutWafer */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TP_STATUT_WAFER_WAV_DETAIL_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[TP_STATUT_WAFER_WAV_DETAIL]'))
	ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL] DROP CONSTRAINT [FK_TP_STATUT_WAFER_WAV_DETAIL_00]
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL]  WITH NOCHECK ADD  CONSTRAINT [FK_TP_STATUT_WAFER_WAV_DETAIL_00] FOREIGN KEY([IdStatutWafer])
	REFERENCES [dbo].[TP_STATUT_WAFER_WAV] ([IdStatutWafer])
GO

ALTER TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL] CHECK CONSTRAINT [FK_TP_STATUT_WAFER_WAV_DETAIL_00]
GO

/* ------------------------------------------------------------- */
/* TABLE : RECIPE_WAV                                             */
/* ------------------------------------------------------------- */

/* Colonne : RECIPE_WAV.IdEquipement */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RECIPE_WAV_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[RECIPE_WAV]'))
	ALTER TABLE [dbo].[RECIPE_WAV] DROP CONSTRAINT [FK_RECIPE_WAV_00]
GO

ALTER TABLE [dbo].[RECIPE_WAV] WITH NOCHECK ADD CONSTRAINT [FK_RECIPE_WAV_00] FOREIGN KEY([IdEquipement])
	REFERENCES [dbo].[TD_PRODUCTION_EQUIPEMENTS] ([IdEquipement])
GO

ALTER TABLE [dbo].[RECIPE_WAV] CHECK CONSTRAINT [FK_RECIPE_WAV_00]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_WAV                                             */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_WAV.IdEquipement */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WAFER_WAV_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[WAFER_WAV]'))
	ALTER TABLE [dbo].[WAFER_WAV] DROP CONSTRAINT [FK_WAFER_WAV_00]
GO

ALTER TABLE [dbo].[WAFER_WAV] WITH NOCHECK ADD CONSTRAINT [FK_WAFER_WAV_00] FOREIGN KEY([IdEquipement])
	REFERENCES [dbo].[TD_PRODUCTION_EQUIPEMENTS] ([IdEquipement])
GO

ALTER TABLE [dbo].[WAFER_WAV] CHECK CONSTRAINT [FK_WAFER_WAV_00]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI                                             */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_TRI.IdEquipement */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WAFER_TRI_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[WAFER_TRI]'))
	ALTER TABLE [dbo].[WAFER_TRI] DROP CONSTRAINT [FK_WAFER_TRI_00]
GO

ALTER TABLE [dbo].[WAFER_TRI] WITH NOCHECK ADD CONSTRAINT [FK_WAFER_TRI_00] FOREIGN KEY([IdEquipement])
	REFERENCES [dbo].[TD_PRODUCTION_EQUIPEMENTS] ([IdEquipement])
GO

ALTER TABLE [dbo].[WAFER_TRI] CHECK CONSTRAINT [FK_WAFER_TRI_00]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI_LOT                                         */
/* ------------------------------------------------------------- */

/* Colonne : WAFER_TRI_LOT.IdEquipement */
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_WAFER_TRI_LOT_00]') AND parent_object_id = OBJECT_ID(N'[dbo].[WAFER_TRI_LOT]'))
	ALTER TABLE [dbo].[WAFER_TRI_LOT] DROP CONSTRAINT [FK_WAFER_TRI_LOT_00]
GO

ALTER TABLE [dbo].[WAFER_TRI_LOT] WITH NOCHECK ADD CONSTRAINT [FK_WAFER_TRI_LOT_00] FOREIGN KEY([IdEquipement])
	REFERENCES [dbo].[TD_PRODUCTION_EQUIPEMENTS] ([IdEquipement])
GO

ALTER TABLE [dbo].[WAFER_TRI_LOT] CHECK CONSTRAINT [FK_WAFER_TRI_LOT_00]
GO
