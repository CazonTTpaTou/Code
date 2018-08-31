/* ------------------------------------------------------------- */
/* CREATION DES FONCTIONS ET PROCEDURES STOCKEES                             */
/* ------------------------------------------------------------- */

/* Utilisation de la base SSIS_DB */
USE [SSIS_DB]
GO

/* ------------------------------------------------------------- */
/* FONCTION : GetTraitementIdMax                          		 */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTraitementIdMax]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [dbo].[GetTraitementIdMax]
GO

CREATE FUNCTION [dbo].[GetTraitementIdMax] (@IdEquipement int) 
RETURNS @retIdMax TABLE 
(
     IdMax 		INT NOT NULL
)
AS   
BEGIN
	-- Déclaration de la variable de la description
	DECLARE @IDMAX 	INT
	-- Initialisation de la variable
	SET @IDMAX 		= 0

	-- Equipement : ICOS BLUE EYE
	if @IdEquipement = 14 OR @IdEquipement = 15
		-- Vue : VT_ICOS_BLUE_EYE
		SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_BLUE_EYE WHERE IdEquipement = @IdEquipement
	-- Equipement : ICOS BSPI P1
	ELSe IF @IdEquipement = 18 OR @IdEquipement = 19
		-- Vue : VT_ICOS_BSPI_P1
		SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_BSPI_P1  WHERE IdEquipement = @IdEquipement
	-- Equipement : ICOS BSPI P2
	ELSe IF @IdEquipement = 21 OR @IdEquipement = 22
		-- Vue : VT_ICOS_BSPI_P2
		SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_BSPI_P2  WHERE IdEquipement = @IdEquipement
	-- Equipement : ICOS FSPI N1
	ELSe IF @IdEquipement = 24 OR @IdEquipement = 25
		-- Vue : VT_ICOS_FSPI_N1
		SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_FSPI_N1 WHERE IdEquipement = @IdEquipement
	-- Equipement : ICOS FSCC
	ELSe IF @IdEquipement = 30 OR @IdEquipement = 31
		-- Vue : VT_ICOS_FSCC
		SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_FSCC WHERE IdEquipement = @IdEquipement
	/* ===	DEBUT DESACTIVATION - 19/09/2016 - Suite confirmation avec JMTaborda : les pc ne servent plus === */
	-- Equipement : ICOS BSCC
	--ELSE IF @IdEquipement = 32 OR @IdEquipement = 33
	--	-- Vue : VT_ICOS_BSCC
	--	SELECT @IDMAX = ISNULL(MAX(Id),0) FROM VT_ICOS_BSCC WHERE IdEquipement = @IdEquipement
	/* ===	FIN DESACTIVATION === */
	-- Equipement : DESPATCH FIRING
	ELSe IF @IdEquipement = 26 OR @IdEquipement = 37
		-- Vue : VT_DESPATCH_FIRING
		SELECT @IDMAX = ISNULL(MAX(Uid),0) FROM VT_DESPATCH_FIRING WHERE IdEquipement = @IdEquipement
	-- Equipement : DESPATCH WAFER
	ELSe IF @IdEquipement = 38 OR @IdEquipement = 39
		-- Vue : VT_DESPATCH_WAFER
		SELECT @IDMAX = ISNULL(MAX(Uid),0) FROM VT_DESPATCH_WAFER WHERE IdEquipement = @IdEquipement
	-- Equipement : WAVELABS (RESULTS)
	ELSe IF @IdEquipement = 52 OR @IdEquipement = 53
		-- Vue : VT_WAVELABS_RESULTS
		SELECT @IDMAX = ISNULL(MAX(id),0) FROM VT_WAVELABS_RESULTS WHERE IdEquipement = @IdEquipement
	-- Equipement : WAVELABS (RECIPE)
	ELSE IF @IdEquipement = 54 OR @IdEquipement = 55
		-- Vue : VT_WAVELABS_RECIPESETTINGS
		SELECT @IDMAX = ISNULL(MAX(id),0) FROM VT_WAVELABS_RECIPESETTINGS WHERE IdEquipement = @IdEquipement
	-- Equipement : ELOGIA (CLASSIFICATION)
	ELSE IF @IdEquipement = 59
		-- Vue : VT_ELOGIA_CLASSIFICATION
		SELECT @IDMAX = ISNULL(MAX(Cel_ID),0) FROM VT_ELOGIA_CLASSIFICATION WHERE IdEquipement = @IdEquipement
	-- Equipement : ELOGIA (CLOTURE DES LOTS)
	ELSE IF @IdEquipement = 60
		-- Vue : VT_ELOGIA_CLOTURE_LOTS
		SELECT @IDMAX = ISNULL(MAX(Lot_Id),0) FROM VT_ELOGIA_CLOTURE_LOTS WHERE IdEquipement = @IdEquipement

	-- Restitue l'information
	INSERT @retIdMax
	SELECT @IDMAX
	RETURN
END
GO

/* ------------------------------------------------------------- */
/* FONCTION : GetNomTableEquipementDWH                           */
/* ------------------------------------------------------------- */
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNomTableEquipementDWH]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [dbo].[GetNomTableEquipementDWH]
GO

CREATE FUNCTION [dbo].[GetNomTableEquipementDWH] (@IdEquipement int)
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

	-- Equipement : ICOS BLUE EYE
	if @IdEquipement = 14 OR @IdEquipement = 15
		SET @NOMTABLE = 'ICOS_BLUE_EYE'
	-- Equipement : ICOS BSPI P1
	ELSE IF @IdEquipement = 18 OR @IdEquipement = 19
		SET @NOMTABLE = 'ICOS_BSPI_P1'
	-- Equipement : ICOS BSPI P2
	ELSE IF @IdEquipement = 21 OR @IdEquipement = 22
		SET @NOMTABLE = 'ICOS_BSPI_P2'
	-- Equipement : ICOS FSPI N1
	ELSE IF @IdEquipement = 24 OR @IdEquipement = 25
		SET @NOMTABLE = 'ICOS_FSPI_N1'
	-- Equipement : ICOS FSCC
	ELSE IF @IdEquipement = 30 OR @IdEquipement = 31
		SET @NOMTABLE = 'ICOS_FSCC'
	-- Equipement : ICOS BSCC
	ELSE IF @IdEquipement = 32 OR @IdEquipement = 33
		SET @NOMTABLE = 'ICOS_BSCC'
	-- Equipement : SiNa Loader
	ELSE IF @IdEquipement = 3
		SET @NOMTABLE = 'WAFER_SNL'
	-- Equipement : SiNa Unloader
	ELSE IF @IdEquipement = 13
		SET @NOMTABLE = 'WAFER_SNU'
	-- Equipement : Print Line Loader 
	ELSE IF @IdEquipement = 16
		SET @NOMTABLE = 'WAFER_PLL'
	-- Equipement : Print P1 
	ELSE IF @IdEquipement = 17 OR @IdEquipement = 34
		SET @NOMTABLE = 'WAFER_PP1'
	-- Equipement : Print P2 
	ELSE IF @IdEquipement = 20 OR @IdEquipement = 35
		SET @NOMTABLE = 'WAFER_PP2'
	-- Equipement : Print N1 
	ELSE IF @IdEquipement = 23 OR @IdEquipement = 36
		SET @NOMTABLE = 'WAFER_PN1'
	-- Equipement : DESPATCH Firing 
	ELSE IF @IdEquipement = 26 OR @IdEquipement = 37
		SET @NOMTABLE = 'DESPATCH_FIRING'
	-- Equipement : Tapis d'entree SCHILLER
	ELSE IF @IdEquipement = 38 OR @IdEquipement = 39
		SET @NOMTABLE = 'WAFER_DES_HISTO'
	-- Equipement : SCHILLER
	ELSE IF @IdEquipement = 28 OR @IdEquipement = 29
		SET @NOMTABLE = 'BERGER_RESULTS'
	-- Equipement : LYTOX
	ELSE IF @IdEquipement = 46
		SET @NOMTABLE = 'WAFER_LTX'
	-- Equipement : WAVELABS (RESULTS)
	ELSE IF @IdEquipement = 52 OR @IdEquipement = 53
		SET @NOMTABLE = 'WAFER_WAV'
	-- Equipement : WAVELABS (RECIPE)
	ELSE IF @IdEquipement = 54 OR @IdEquipement = 55
		SET @NOMTABLE = 'RECIPE_WAV'
	-- Equipement : ELOGIA (CLASSIFICATION)
	ELSE IF @IdEquipement = 59
		SET @NOMTABLE = 'WAFER_TRI'
	-- Equipement : ELOGIA (CLOTURE DES LOTS)
	ELSE IF @IdEquipement = 60
		SET @NOMTABLE = 'WAFER_TRI_LOT'
		
	-- Restitue l'information
	INSERT @retNomTable
	SELECT @NOMTABLE
	RETURN
	
END;
GO

/* ------------------------------------------------------------- */
/* PROCEDURE : DWH_MAJ_DONNEES_TRI                           	 */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DWH_MAJ_DONNEES_TRI]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DWH_MAJ_DONNEES_TRI]
GO

CREATE PROCEDURE [dbo].[DWH_MAJ_DONNEES_TRI] 
AS
BEGIN
	-- On declare les variables
	DECLARE @ERRORVAR 	AS INT
	DECLARE @MESSAGE  	AS VARCHAR(MAX)
	DECLARE @COMMANDE 	AS NVARCHAR(MAX)

	-- Si une erreur se produit on annule toute la transaction (Obligatoire si acces serveur lié)
	SET XACT_ABORT ON
	-- On n'affiche pas le resultats des SELECT
	SET NOCOUNT ON;

	-----------------------------------------------------------------------
	-- Mise à jour des libelles des classes 
	-----------------------------------------------------------------------
	SET @COMMANDE = ' UPDATE W' +
					' SET ClasseVisionP	= CASE WHEN ClasseVisionP IS NULL THEN VP.LibClasse ELSE ClasseVisionP END,' +
					    ' ClasseVisionN	= CASE WHEN ClasseVisionN IS NULL THEN VN.LibClasse ELSE ClasseVisionN END,' +
					    ' ClasseFlasheur = CASE WHEN ClasseFlasheur IS NULL THEN FL.LibClasse ELSE ClasseFlasheur END,' +
					    ' ClasseElectrolum = CASE WHEN ClasseElectrolum IS NULL THEN EL.LibClasse ELSE ClasseFlasheur END' +
					' FROM WAFER_TRI W' +
					     ' LEFT JOIN VD_PRODUCTION_CLASSES_VISION_P VP   ON W.IdClasseVisionP  = VP.IdClasse' +
					     ' LEFT JOIN VD_PRODUCTION_CLASSES_VISION_N VN   ON W.IdClasseVisionN  = VN.IdClasse' +
					     ' LEFT JOIN VD_PRODUCTION_CLASSES_FLASHEUR FL   ON W.IdClasseFlasheur = FL.IdClasse' +
					     ' LEFT JOIN VD_PRODUCTION_CLASSES_ELECTROLUM EL ON W.IdClasseElectrolum = EL.IdClasse' +
					' WHERE ClasseVisionP IS NULL OR ClasseVisionN IS NULL OR ClasseFlasheur IS NULL OR ClasseElectrolum IS NULL'		  					  
	-- On trace la requete executee
	SET @MESSAGE = 'MISE A JOUR LIBELLES CLASSES - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'DWH_MAJ_DONNEES_TRI', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On exécute la commande	
	EXECUTE @ERRORVAR = dbo.sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 	

VALIDER_TRANSACTION:
	-- On sort
	RETURN 0
	
INVALIDER_TRANSACTION:
	-- On recupere le code erreur
	IF @@ERROR <> 0 SELECT @ERRORVAR = @@ERROR
	-- On retourne l'erreur
	RETURN @ERRORVAR;
		
END

GO

/* ------------------------------------------------------------- */
/* PROCEDURE : DWH_MAJ_DONNEES_CLOTURE                       	 */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DWH_MAJ_DONNEES_CLOTURE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DWH_MAJ_DONNEES_CLOTURE]
GO

CREATE PROCEDURE [dbo].[DWH_MAJ_DONNEES_CLOTURE] 
AS
BEGIN
	-- On declare les variables
	DECLARE @ERRORVAR 	AS INT
	DECLARE @MESSAGE  	AS VARCHAR(MAX)
	DECLARE @COMMANDE 	AS NVARCHAR(MAX)

	-- Si une erreur se produit on annule toute la transaction (Obligatoire si acces serveur lié)
	SET XACT_ABORT ON
	-- On n'affiche pas le resultats des SELECT
	SET NOCOUNT ON;

	-----------------------------------------------------------------------
	-- Suppression des lignes precedemment enregistrees pour un lot
	-----------------------------------------------------------------------
	SET @COMMANDE = ' DELETE FROM L ' +
                    ' FROM WAFER_TRI_LOT L INNER JOIN (SELECT LOTId, MAX(IdRecord) AS idRecord ' +
													 ' FROM WAFER_TRI_LOT ' +
													 ' WHERE  LotId IN (SELECT lotid FROM WAFER_TRI_LOT GROUP BY lotid HAVING COUNT(idrecord) > 1)' +
													 ' GROUP BY lotid) M' +
						 ' ON (L.LotId = M.LotId AND L.idRecord < M.idRecord AND L.HorodatageCreationBoite > DATEADD (MONTH,-1, getdate()))
'		  					  
	-- On trace la requete executee
	SET @MESSAGE = 'MISE A JOUR DONNEES CLOTURE - Execution requete : ' + @COMMANDE 
	EXEC SSIS_INSERT_DEBUG 'DWH_MAJ_DONNEES_CLOTURE', 'TRSFT_DWH_SQC', 'I', @MESSAGE 
	-- On exécute la commande	
	EXECUTE @ERRORVAR = dbo.sp_executesql @COMMANDE 
	-- Si erreur on invalide la transaction
	IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 	

VALIDER_TRANSACTION:
	-- On sort
	RETURN 0
	
INVALIDER_TRANSACTION:
	-- On recupere le code erreur
	IF @@ERROR <> 0 SELECT @ERRORVAR = @@ERROR
	-- On retourne l'erreur
	RETURN @ERRORVAR;
		
END

GO

/* ------------------------------------------------------------- */
/* PROCEDURE : DWH_MAJ_POST_TRAITEMENT                           */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DWH_MAJ_POST_TRAITEMENT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DWH_MAJ_POST_TRAITEMENT]
GO

CREATE PROCEDURE [dbo].[DWH_MAJ_POST_TRAITEMENT] (@IdEquipement int) 
AS   
BEGIN
	-- On declare les variables
	DECLARE @ERRORVAR AS INT
	DECLARE @COMMANDE AS NVARCHAR(512)
	DECLARE @NOMTABLE AS VARCHAR(20)

	-- On debute une transaction
	BEGIN TRANSACTION T_MAJ_POST_TRAITEMENT;

	-- Si une erreur se produit on annule toute la transaction (Obligatoire si acces serveur lié)
	SET XACT_ABORT ON
	-- On n'affiche pas le resultats des SELECT
	SET NOCOUNT ON;
	
	-- Initialisation des variables 
	SET @COMMANDE = ''
	SET @NOMTABLE = ''
	
	-- On recupere le nom de la table associée à l'équipement	
	SELECT @NOMTABLE = Libelle
	FROM   GetNomTableEquipementDWH(@IdEquipement)
	
	-- Si erreur on invalide la transaction
	IF (@@ERROR <> 0 OR @NOMTABLE IS NULL) GOTO INVALIDER_TRANSACTION 
  
	-- Equipement autre que IMPLANTEUR IONIQUE et LYTOX et WAVELABS (RECETTE) ET ELOGIA (CLOTURE)
	IF @IdEquipement <> 46 AND @IdEquipement <> 54 AND @IdEquipement <> 55 AND @IdEquipement <> 60
		BEGIN
			-- Equipement SCHILLER (BERGER)
			IF (@IdEquipement = 28 OR @IdEquipement = 29)
				-- On met à jour le Lot Id a partir du LotWaferId
				SET @COMMANDE = 'UPDATE ' + @NOMTABLE + ' ' +
								'SET		LotId = SUBSTRING(WaferID,1,9), ' +
										   'WaferEqID = SUBSTRING(WaferID,10,2), ' +
										   'WaferNr	  = SUBSTRING(WaferID,12,5) ' +
								'WHERE   LotId IS NULL  ' +
								'AND     WaferID IS NOT NULL'
			-- Equipement WAVELABS (RESULTS)
			ELSE IF	(@IdEquipement = 52 OR @IdEquipement = 53)
				-- On met à jour le Lot Id a partir du WaferID_Auto
				SET @COMMANDE = 'UPDATE ' + @NOMTABLE + ' ' +
								'SET		LotId = SUBSTRING(WaferID_Auto,1,9), ' +
										   'WaferEqID = SUBSTRING(WaferID_Auto,10,2), ' +
										   'WaferNr = SUBSTRING(WaferID_Auto,12,5) ' +
								'WHERE   LotId IS NULL  ' +
								'AND     WaferID_Auto IS NOT NULL'
			-- Equipement autre que SCHILLER (BERGER) & WAVELABS (RESULTS)
			ELSE
				-- On met à jour le Lot Id a partir du LotWaferId
				SET @COMMANDE = 'UPDATE ' + @NOMTABLE + ' ' +
								'SET		LotId = SUBSTRING(LotWaferID,1,9), ' +
										   'WaferEqID = SUBSTRING(LotWaferID,10,2), ' +
										   'WaferNr = SUBSTRING(LotWaferID,12,5) ' +
								'WHERE   LotId IS NULL  ' +
								'AND     LotWaferID IS NOT NULL'
			-- On exécute la commande	
			EXECUTE @ERRORVAR = [SRV-SSIS-DWH\DWH_CELL].[CELL_INLINE_DB].[dbo].sp_executesql @COMMANDE 
			--EXECUTE @ERRORVAR = [SRV-SSIS-DEV\DWH_DEV].[CELL_INLINE_DB].[dbo].sp_executesql @COMMANDE 
			-- Si erreur on invalide la transaction
			IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
		END
		
	-- Equipement : Tapis d'entree du SCHILLER, on met à jour la table des etats courants
	IF @IdEquipement = 38 OR @IdEquipement = 39
		BEGIN
			EXECUTE @ERRORVAR = DWH_MAJ_DONNEES_DESPATCH
			IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
		END 

		-- Equipement : TRI, on met à jour les libelles des classes
	IF @IdEquipement = 59
		BEGIN
			EXECUTE @ERRORVAR = DWH_MAJ_DONNEES_TRI
			IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
		END 

	-- Equipement : TRI, on met à jour les données sur les lots clotures
	IF @IdEquipement = 60
		BEGIN
			EXECUTE @ERRORVAR = DWH_MAJ_DONNEES_CLOTURE
			IF @ERRORVAR <> 0 GOTO INVALIDER_TRANSACTION 
		END 
	
VALIDER_TRANSACTION:
	-- On valide la transaction
	COMMIT TRANSACTION T_MAJ_POST_TRAITEMENT;
	-- On sort
	RETURN 0
	
INVALIDER_TRANSACTION:
	-- On recupere le code erreur
	IF @@ERROR <> 0 SELECT @ERRORVAR = @@ERROR
	-- On invalide la transaction
	ROLLBACK TRANSACTION T_MAJ_POST_TRAITEMENT;
	-- On retourne l'erreur
	RETURN @ERRORVAR;
		
END
GO



