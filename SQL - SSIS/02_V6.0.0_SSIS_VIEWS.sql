-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--											CREATION DES VUES
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
USE [SSIS_DB]
GO

/* ------------------------------------------------------------- */
/* VUE : VT_WAVELABS_RESULTS                            		 */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VT_WAVELABS_RESULTS]'))
	DROP VIEW [dbo].[VT_WAVELABS_RESULTS]
GO

CREATE VIEW [dbo].[VT_WAVELABS_RESULTS]
AS
	SELECT	M.IdEquipement, E.*
	FROM    OPENQUERY("10.65.226.61\POSTGRESQL", 'select * from public.results') E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 52 	
	UNION
	SELECT	M.IdEquipement, E.*
	FROM    OPENQUERY("10.65.226.62\POSTGRESQL", 'select * from public.results') E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 53 	
GO

/* ------------------------------------------------------------- */
/* VUE : VT_WAVELABS_RECIPESETTINGS                              */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VT_WAVELABS_RECIPESETTINGS]'))
	DROP VIEW [dbo].[VT_WAVELABS_RECIPESETTINGS]
GO

CREATE VIEW [dbo].[VT_WAVELABS_RECIPESETTINGS]
AS
	SELECT	M.IdEquipement, E.*
	FROM    OPENQUERY("10.65.226.61\POSTGRESQL", 'select * from public.recipesettings') E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 54 	
	UNION
	SELECT	M.IdEquipement, E.*
	FROM    OPENQUERY("10.65.226.62\POSTGRESQL", 'select * from public.recipesettings') E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 55 	
GO

/* ------------------------------------------------------------- */
/* VUE : VT_ELOGIA_CLASSIFICATION								 */
/* ------------------------------------------------------------- */

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

/* ------------------------------------------------------------- */
/* VUE : VT_ELOGIA_CLOTURE_LOTS   								 */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VT_ELOGIA_CLOTURE_LOTS]'))
	DROP VIEW [dbo].[VT_ELOGIA_CLOTURE_LOTS]
GO

CREATE VIEW [dbo].[VT_ELOGIA_CLOTURE_LOTS]
AS
	SELECT	M.IdEquipement, E.*
	FROM    dbo.TRI_LOT E, TT_Derniere_Mesure_Equipement M
	WHERE   E.Lot_Id > M.IdDerniereMesure 
	AND     M.IdEquipement = 60 	
GO
