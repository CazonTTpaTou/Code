use SSIS_DB

/* ------------------------------------------------------------------- */
/* DONNEES : Insertion des parametres de l'application                 */
/* ------------------------------------------------------------------- */
DELETE FROM TP_DONNEES WHERE CodeDonnee LIKE 'PURGE_%';
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_BLUE_EYE', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_BSPI_P1', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_BSPI_P2', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_FSPI_N1', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_DESPATCH_SORTIE', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_DESPATCH_HISTO', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_SCHILLER', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_FSCC', 30)
INSERT INTO TP_Donnees (CodeDonnee, ValeurDonnee) VALUES ('PURGE_ICOS_BSCC', 30)

/* ------------------------------------------------------------- */
/* VUE : VP_Donnees_Purge_PROD                                   */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VP_Donnees_Purge_PROD]'))
DROP VIEW [dbo].[VP_Donnees_Purge_PROD]
GO

CREATE VIEW [dbo].[VP_Donnees_Purge_PROD]
AS
	SELECT 	CodeDonnee, 
			CAST(DATEadd(day, cast(case when ValeurDonnee < 30 THEN 30 ELSE ValeurDonnee END as INT) * -1, GETDATE()) AS DATETIME) as DateLimite
	FROM 	TP_Donnees     
	WHERE 	CodeDonnee LIKE 'PURGE_%'
GO


/* ------------------------------------------------------------- */
/* FONCTION : GetNomParametrePurge                               */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNomParametrePurge]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetNomParametrePurge]
GO

CREATE FUNCTION [GetNomParametrePurge] (@IdEquipement int)
RETURNS @retNomParametre TABLE 
(
	Libelle 			VARCHAR(50) 			NOT NULL
)
AS   
BEGIN
	-- Déclaration de la variable de la description
	DECLARE @NOMPARAMETRE AS VARCHAR(50)

	-- Initialisation des variables
	SET @NOMPARAMETRE 		= NULL

	-- Equipement : ICOS BLUE EYE (VOIE 1 & 2)
	if @IdEquipement = 14 OR @IdEquipement = 15
		SET @NOMPARAMETRE = 'PURGE_ICOS_BLUE_EYE'
	-- Equipement : ICOS BSPI P1 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 18 OR @IdEquipement = 19
		SET @NOMPARAMETRE = 'PURGE_ICOS_BSPI_P1'
	-- Equipement : ICOS BSPI P2 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 21 OR @IdEquipement = 22 
		SET @NOMPARAMETRE = 'PURGE_ICOS_BSPI_P2'
	-- Equipement : ICOS FSPI N1 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 24 OR @IdEquipement = 25 
		SET @NOMPARAMETRE = 'PURGE_ICOS_FSPI_N1'
	-- Equipement : ICOS FSCC (VOIE 1 & 2)
	ELSE IF @IdEquipement = 30 OR @IdEquipement = 31
		SET @NOMPARAMETRE = 'PURGE_ICOS_FSCC'
	-- Equipement : ICOS BSCC (VOIE 1 & 2)
	ELSE IF @IdEquipement = 32 OR @IdEquipement = 33 
		SET @NOMPARAMETRE = 'PURGE_ICOS_BSCC'
	-- Equipement : DESPATCH Firing (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 26 OR @IdEquipement = 37 
		SET @NOMPARAMETRE = 'PURGE_DESPATCH_SORTIE'
	-- Equipement : Tapis d'entree SCHILLER (ROUGE)
	ELSE IF @IdEquipement = 38 OR @IdEquipement = 39 
		SET @NOMPARAMETRE = 'PURGE_DESPATCH_HISTO'
	-- Equipement : SCHILLER (VOIE 1 & 2)
	ELSE IF @IdEquipement = 28 OR @IdEquipement = 29
		SET @NOMPARAMETRE = 'PURGE_SCHILLER'
	
	-- Restitue l'information
	INSERT @retNomParametre
	SELECT @NOMPARAMETRE
	RETURN
	
END;
GO 

/* ------------------------------------------------------------- */
/* FONCTION : GetNomColonneDatePROD                              */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNomColonneDatePROD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetNomColonneDatePROD]
GO

CREATE FUNCTION [GetNomColonneDatePROD] (@IdEquipement int)
RETURNS @retNomColonne TABLE 
(
	Libelle 			VARCHAR(50) 			NOT NULL
)
AS   
BEGIN
	-- Déclaration de la variable de la description
	DECLARE @NOMCOLONNE AS VARCHAR(50)

	-- Initialisation des variables
	SET @NOMCOLONNE 		= NULL

	-- Equipement : ICOS BLUE EYE (VOIE 1 & 2)
	if @IdEquipement = 14 OR @IdEquipement = 15
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : ICOS BSPI P1 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 18 OR @IdEquipement = 19
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : ICOS BSPI P2 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 21 OR @IdEquipement = 22 
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : ICOS FSPI N1 (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 24 OR @IdEquipement = 25 
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : ICOS FSCC (VOIE 1 & 2)
	ELSE IF @IdEquipement = 30 OR @IdEquipement = 31
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : ICOS BSCC (VOIE 1 & 2)
	ELSE IF @IdEquipement = 32 OR @IdEquipement = 33 
		SET @NOMCOLONNE = 'TIMESTAMP'
	-- Equipement : DESPATCH Firing (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 26 OR @IdEquipement = 37 
		SET @NOMCOLONNE = 'TS'
	-- Equipement : Tapis d'entree SCHILLER (ROUGE)
	ELSE IF @IdEquipement = 38 OR @IdEquipement = 39 
		SET @NOMCOLONNE = 'TS'
	-- Equipement : SCHILLER (VOIE 1 & 2)
	ELSE IF @IdEquipement = 28 OR @IdEquipement = 29
		SET @NOMCOLONNE = 'DATE'
	
	-- Restitue l'information
	INSERT @retNomColonne
	SELECT @NOMCOLONNE
	RETURN
	
END;
GO 

/* ------------------------------------------------------------- */
/* FONCTION : GetNomTableEquipementPROD                          */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNomTableEquipementPROD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetNomTableEquipementPROD]
GO

CREATE FUNCTION [GetNomTableEquipementPROD] (@IdEquipement int)
RETURNS @retNomTable TABLE 
(
	Libelle 			VARCHAR(50) 			NOT NULL
)
AS   
BEGIN
	-- Déclaration de la variable de la description
	DECLARE @NOMTABLE AS VARCHAR(50)

	-- Initialisation des variables
	SET @NOMTABLE 		= NULL

	-- Equipement : ICOS BLUE EYE (VOIE 1)
	if @IdEquipement = 14 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BLUE EYE (VOIE 2)
	ELSE IF @IdEquipement = 15
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSPI P1 (ROUGE)
	ELSE IF @IdEquipement = 18
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSPI P1 (BLEUE)
	ELSE IF @IdEquipement = 19
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSPI P2 (ROUGE)
	ELSE IF @IdEquipement = 21 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSPI P2 (BLEUE)
	ELSE IF @IdEquipement = 22 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS FSPI N1 (ROUGE)
	ELSE IF @IdEquipement = 24 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS FSPI N1 (BLEUE)
	ELSE IF @IdEquipement = 25 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS FSCC (VOIE 1)
	ELSE IF @IdEquipement = 30
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS FSCC (VOIE 2)
	ELSE IF @IdEquipement = 31
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSCC (VOIE 1)
	ELSE IF @IdEquipement = 32 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : ICOS BSCC (VOIE 2)
	ELSE IF @IdEquipement = 33 
		SET @NOMTABLE = 'dbo.Part_1'
	-- Equipement : DESPATCH Firing (ROUGE)
	ELSE IF @IdEquipement = 26 
		SET @NOMTABLE = 'dbo.WAFERPV'
	-- Equipement : DESPATCH Firing (BLEUE)
	ELSE IF @IdEquipement = 37 
		SET @NOMTABLE = 'dbo.WAFERPV'
	-- Equipement : Tapis d'entree SCHILLER (ROUGE)
	ELSE IF @IdEquipement = 38 
		SET @NOMTABLE = 'dbo.WAFERSTAT'
	-- Equipement : Tapis d'entree SCHILLER (BLEUE)
	ELSE IF @IdEquipement = 39 
		SET @NOMTABLE = 'dbo.WAFERSTAT'
	-- Equipement : SCHILLER (VOIE 1)
	ELSE IF @IdEquipement = 28 
		SET @NOMTABLE = 'dbo.RESULTS1'
	-- Equipement : SCHILLER (VOIE 2)
	ELSE IF @IdEquipement = 29 
		SET @NOMTABLE = 'dbo.RESULTS2'
	
	-- Restitue l'information
	INSERT @retNomTable
	SELECT @NOMTABLE
	RETURN
	
END;
GO 

/* ------------------------------------------------------------- */
/* PROCEDURE : PROD_PURGE_TABLES                                 */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PROD_PURGE_TABLES]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PROD_PURGE_TABLES]
GO

CREATE PROCEDURE [dbo].[PROD_PURGE_TABLES] (@IdEquipement int) 
AS   
BEGIN
	-- On declare la chaine de commande à exécuter
	DECLARE @COMMANDE AS nVARCHAR(512)
	DECLARE @NOMTABLE AS VARCHAR(50)
	DECLARE @NOMCOLONNE AS VARCHAR(50)
	DECLARE @NOMPARAMETRE AS VARCHAR(50)
	DECLARE @DATELIMITE AS VARCHAR(20)
	
	-- On recupere le nom de la table associée à l'équipement	
	SELECT @NOMTABLE = Libelle
	FROM   GetNomTableEquipementProd(@IdEquipement)
		
	-- On recupere le nom de la colonne associée à l'équipement	
	SELECT @NOMCOLONNE = Libelle
	FROM   GetNomColonneDatePROD(@IdEquipement)
	
	-- On recupere le nom du parametre de purge associé à l'équipement	
	SELECT @NOMPARAMETRE = Libelle
	FROM   GetNomParametrePurge(@IdEquipement)

	-- On recupere la date limite associée à l'équipement
	SELECT @DATELIMITE = DateLimite FROM VP_Donnees_Purge_PROD WHERE CodeDonnee = ''' + @NOMPARAMETRE + '''
	
	-- On supprime les lignes antérieures à la date de 
	--SET @COMMANDE = 'DELETE FROM ' + @NOMTABLE + ' WHERE ' + @NOMCOLONNE + ' < CAST (''' + @DATELIMITE + ''' AS DATETIME)'
	SET @COMMANDE = 'DELETE FROM ' + @NOMTABLE + ' WHERE ' + @NOMCOLONNE + ' < dateadd (day,-30,getdate())'

	-- Equipement : ICOS BLUE EYE (VOIE 1)
	if @IdEquipement = 14 
		EXECUTE [192.168.23.66\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BLUE EYE (VOIE 2)
	ELSE IF @IdEquipement = 15
		EXECUTE [192.168.23.68\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSPI P1 (ROUGE)
	ELSE IF @IdEquipement = 18
		EXECUTE [192.168.23.74\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSPI P1 (BLEUE)
	ELSE IF @IdEquipement = 19
		EXECUTE [192.168.23.76\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSPI P2 (ROUGE)
	ELSE IF @IdEquipement = 21 
		EXECUTE [192.168.23.78\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSPI P2 (BLEUE)
	ELSE IF @IdEquipement = 22 
		EXECUTE [192.168.23.80\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS FSPI N1 (ROUGE)
	ELSE IF @IdEquipement = 24 
		EXECUTE [192.168.23.70\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS FSPI N1 (BLEUE)
	ELSE IF @IdEquipement = 25 
		EXECUTE [192.168.23.72\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : DESPATCH Firing (ROUGE & BLEUE)
	ELSE IF @IdEquipement = 26 OR @IdEquipement = 37 
		EXECUTE [192.168.9.64\SQLEXPRESS].[TRACABILITE].[dbo].sp_executesql @COMMANDE	
	-- Equipement : Tapis d'entree SCHILLER (ROUGE)
	ELSE IF @IdEquipement = 38 OR @IdEquipement = 39
		EXECUTE [192.168.9.64\SQLEXPRESS].[TRACABILITE].[dbo].sp_executesql @COMMANDE	
	-- Equipement : SCHILLER (VOIE 1)
	ELSE IF @IdEquipement = 28 
		EXECUTE [192.168.9.64\SQLEXPRESS].[TESTERSORTER].[dbo].sp_executesql @COMMANDE	
	-- Equipement : SCHILLER (VOIE 2)
	ELSE IF @IdEquipement = 29 
		EXECUTE [192.168.9.64\SQLEXPRESS].[TESTERSORTER].[dbo].sp_executesql @COMMANDE 	
	-- Equipement : ICOS FSCC (VOIE 1)
	ELSE IF @IdEquipement = 30
		EXECUTE [192.168.23.86\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS FSCC (VOIE 2)
	ELSE IF @IdEquipement = 31
		EXECUTE [192.168.23.88\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSCC (VOIE 1)
	ELSE IF @IdEquipement = 32 
		EXECUTE [192.168.23.82\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
	-- Equipement : ICOS BSCC (VOIE 2)
	ELSE IF @IdEquipement = 33 
		EXECUTE [192.168.23.84\SQLEXPRESS].[ICOS_DB].[dbo].sp_executesql @COMMANDE	
		
END
GO
