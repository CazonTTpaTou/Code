/* ------------------------------------------------------------------------- */
/* INSERTION DU PARAMETRAGE DES IMPORTS                                      */
/* ------------------------------------------------------------------------- */

/* Utilisation de la base SSIS_DB */
USE SSIS_DB
GO

/* ------------------------------------------------------------------------- */
/* REINITIALISATION DES INSERTION DU PARAMETRAGE                             */
/* ------------------------------------------------------------------------- */

/* Suppression de la derniere mesure integree du DATA WAREHOUSE */ 
DELETE FROM TT_SQC_Derniere_Mesure_DWH WHERE NomTable IN ('WAFER_WAV','RECIPE_WAV','WAFER_TRI','WAFER_TRI_LOT')
/* Suppression de la description des nouveaux imports */
DELETE FROM TT_Derniere_Mesure_Equipement WHERE IdEquipement IN (52,53,54,55,59,60)
/* Suppression de la description des nouveaux imports */
DELETE FROM TP_Import_Parametres WHERE IdTypeImport IN (17,18,19,20)
/* Suppression des groupes administrateurs à prevenir */
DELETE FROM TP_Contacts_Alertes WHERE IdGroupe IN (17,18,19)
/* Suppression des nouveaux types d'imports */
DELETE FROM TP_Import_Types WHERE IdTypeImport IN (17,18,19,20)
/* Suppression des groupes administrateurs à prevenir */
DELETE FROM TP_Contacts_Groupes WHERE IdGroupe IN (17,18,19)

/* ------------------------------------------------------------------------- */
/* TP_CONTACTS_GROUPES : GROUPES ADMINISTRATEURS À PRÉVENIR                  */
/* ------------------------------------------------------------------------- */

/* Import WAVELABS */
INSERT INTO TP_Contacts_Groupes	(IdGroupe, NomGroupe, DescriptionGroupe, GroupeActif, GroupeRang) VALUES (17, 'Import des données WAVELABS', 'Import des données issues du WAVELABS', -1, 1) 
/* Import TRI */
INSERT INTO TP_Contacts_Groupes	(IdGroupe, NomGroupe, DescriptionGroupe, GroupeActif, GroupeRang) VALUES (18, 'Import des données TRI', 'Import des données de classification des cellules', -1, 1) 
/* Import Cloture des lots */
INSERT INTO TP_Contacts_Groupes	(IdGroupe, NomGroupe, DescriptionGroupe, GroupeActif, GroupeRang) VALUES (19, 'Import des données sur les lots', 'Import des informations sur la clôture des lots', -1, 1) 

/* ------------------------------------------------------------------------- */
/* TP_CONTACTS_ALERTES : RATTACHEMENT ADMINISTRATEURS AUX NOUVEAUX GROUPES   */
/* ------------------------------------------------------------------------- */

/* Import WAVELABS */
INSERT INTO TP_Contacts_Alertes (IdGroupe, IdContact, Echec, Succes, AlerteActif, AlerteRang) VALUES (17, 1, -1, 0, -1, 1)
/* Import TRI */
INSERT INTO TP_Contacts_Alertes (IdGroupe, IdContact, Echec, Succes, AlerteActif, AlerteRang) VALUES (18, 1, -1, 0, -1, 1)
/* Import Cloture des lots */
INSERT INTO TP_Contacts_Alertes (IdGroupe, IdContact, Echec, Succes, AlerteActif, AlerteRang) VALUES (19, 1, -1, 0, -1, 1)

/* ------------------------------------------------------------------------- */
/* TP_IMPORT_TYPES : AJOUT DES NOUVEAUX TYPES D'IMPORTS                      */
/* ------------------------------------------------------------------------- */

/* Resultats des tests */
INSERT INTO TP_Import_Types (IdTypeImport, IdGroupe, NomType, Executable, DescriptionTypeImport, TypeImportActif, TypeImportRang)
VALUES (17, 17, 'WAVELABS Resultats', '\Maintenance Plans\Imports\CELLULES\INLINE\WAVELABS\WAV_RESULTS', 'Import des résultats issus du WAVELABS (Base POSTGRESQL)', -1, 17)

/* Configuration de la recette */
INSERT INTO TP_Import_Types (IdTypeImport, IdGroupe, NomType, Executable, DescriptionTypeImport, TypeImportActif, TypeImportRang)
VALUES (18, 17, 'WAVELABS Recette', '\Maintenance Plans\Imports\CELLULES\INLINE\WAVELABS\WAV_RECIPE', 'Import des configurations des recettes du WAVELABS (Base POSTGRESQL)', -1, 18)

/* Classification des cellules */
INSERT INTO TP_Import_Types (IdTypeImport, IdGroupe, NomType, Executable, DescriptionTypeImport, TypeImportActif, TypeImportRang)
VALUES (19, 18, 'Classification des cellules', '\Maintenance Plans\Imports\CELLULES\INLINE\ELOGIA\ELO_CLASSIFICATION', 'Import de la classification des cellules', -1, 19)

/* Cloture des lots */
INSERT INTO TP_Import_Types (IdTypeImport, IdGroupe, NomType, Executable, DescriptionTypeImport, TypeImportActif, TypeImportRang)
VALUES (20, 19, 'Clôture des lots', '\Maintenance Plans\Imports\CELLULES\INLINE\ELOGIA\ELO_CLOTURE_LOTS', 'Import des informations sur la clôture des lots', -1, 20)

/* -------------------------------------------------------------------------- */
/* TP_IMPORT_PARAMETRES : DESCRIPTION DES NOUVEAUX IMPORTS                    */
/* -------------------------------------------------------------------------- */
		
/* Resultats des tests (Voie 1) */
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (17, 52, 'Import des résultats issues du WAVELABS (Voie 1)', NULL, NULL, NULL, NULL, 0, -1, 1)

/* Resultats des tests (Voie 2) */
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (17, 53, 'Import des résultats issues du WAVELABS (Voie 2)', NULL, NULL, NULL, NULL, 0, -1, 1)

/* Configuration de la recette (Voie 1) */
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (18, 54, 'Import de la configuration de la recette WAVELABS (Voie 1)', NULL, NULL, NULL, NULL, 0, -1, 1)

/* Configuration de la recette (Voie 1) */
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (18, 55, 'Import de la configuration de la recette WAVELABS (Voie 2)', NULL, NULL, NULL, NULL, 0, -1, 1)

/* Classification des cellules (Voie 1 & 2)*/
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (19, 59, 'Import de la classification des cellules', NULL, NULL, NULL, NULL, 0, -1, 1)

/* Clôture des lots (Voie 1 & 2)*/
INSERT INTO TP_Import_Parametres (IdTypeImport, IdEquipement, DescriptionImport, RepertoireLOG, RepertoireSAV, RepertoireTMP, FormatFichier, Limite, ImportActif, ImportRang)
VALUES (20, 60, 'Import des informations sur la clôture des lots', NULL, NULL, NULL, NULL, 0, -1, 1)

/* ------------------------------------------------------------------------- */
/* TT_DERNIERE_MESURE_EQUIPEMENT : LIGNES ASSOCIÉES AUX ÉQUIPEMENT           */
/* ------------------------------------------------------------------------- */

/* Resultats des tests (Voie 1) */
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (52, 0, 0);

/* Resultats des tests (Voie 2) */
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (53, 0, 0);
	
/* Configuration de la recette (Voie 1) */
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (54, 0, 0);

/* Configuration de la recette (Voie 2) */
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (55, 0, 0);

/* Classification des cellules (Voie 1 & 2)*/
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (59, 0, 0);

/* Clôture des lots */
INSERT INTO	TT_Derniere_Mesure_Equipement (IdEquipement, IdDerniereMesure, IdLigneWafer) VALUES (60, 0, 0);
	
/* ------------------------------------------------------------------------- */
/* INITIALISATION DE LA DERNIERE MESURE DU DATA WAREHOUSE INTEGREE           */
/* ------------------------------------------------------------------------- */

/* Resultats des tests */
INSERT INTO TT_SQC_Derniere_Mesure_DWH (NomTable, IdMesureMini, IdMesureMaxi) VALUES ('WAFER_WAV',0,0)

/* Configuration de la recette */
INSERT INTO TT_SQC_Derniere_Mesure_DWH (NomTable, IdMesureMini, IdMesureMaxi) VALUES ('RECIPE_WAV',0,0)

/* Classification des cellules (Voie 1 & 2)*/
INSERT INTO TT_SQC_Derniere_Mesure_DWH (NomTable, IdMesureMini, IdMesureMaxi) VALUES ('WAFER_TRI',0,0)

/* Clôture des lots */
INSERT INTO TT_SQC_Derniere_Mesure_DWH (NomTable, IdMesureMini, IdMesureMaxi) VALUES ('WAFER_TRI_LOT',0,0)


