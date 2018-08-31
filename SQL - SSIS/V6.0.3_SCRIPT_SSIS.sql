/* ------------------------------------------------------------- */
/* CREATION DES OBJETS DANS LA BASE SSIS                    	 */
/* ------------------------------------------------------------- */

USE [SSIS_DB]
GO

-- =====================================================================================================================================
-- RECREATION DE LA VUE 'VT_ELOGIA_CLASSIFICATION' 
-- =====================================================================================================================================

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VT_ELOGIA_CLASSIFICATION]'))
	DROP VIEW [dbo].[VT_ELOGIA_CLASSIFICATION]
GO

CREATE VIEW [dbo].[VT_ELOGIA_CLASSIFICATION]
AS
	SELECT	M.IdEquipement, E.*
	FROM    dbo.TRI_CELLULE E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Cel_Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 59 	

GO

