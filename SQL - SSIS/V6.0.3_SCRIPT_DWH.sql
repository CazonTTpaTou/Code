/* ------------------------------------------------------------- */
/* CREATION DES OBJETS DANS LE DATA WAREHOUSE                    */
/* ------------------------------------------------------------- */

/* Utilisation de la base INLINE_CELL_DB */
USE [CELL_INLINE_DB]
GO

BEGIN TRANSACTION
GO

-- =====================================================================================================================================
-- CREATION DE DEUX NOUVELLES COLONNES DANS LA TABLE 'WAFER_TRI' 
-- =====================================================================================================================================

ALTER TABLE dbo.WAFER_TRI ADD
	PosteRetrait 	INT NULL,
	PositionRetrait INT NULL
GO

ALTER TABLE dbo.WAFER_TRI SET (LOCK_ESCALATION = TABLE)
GO

COMMIT
GO