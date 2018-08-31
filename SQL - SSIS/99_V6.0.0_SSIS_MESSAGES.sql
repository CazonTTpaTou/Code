/* ------------------------------------------------------------------------- */
/* INSERTION DES MESSAGES RETOURNES PAS LES PAQUETS SSIS                     */
/* ------------------------------------------------------------------------- */

/* Utilisation de la base SSIS_DB */
USE [SSIS_DB]
GO

/* ------------------------------------------------------------- */
/* DTSX 'WAV_RESULTS.dtsx' : 1801 >> 1899                        */
/* ------------------------------------------------------------- */
/* Suppression des messages associ�s a WAVELABS - RESULTS */
DELETE FROM TP_Messages WHERE IdMessage BETWEEN 1801 AND 1899;

/* Insertion des messages associ�s a WAVELABS - RESULTS */
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1801, 1, 'Une erreur s''est produite lors de la recherche de l''identifiant de l''�quipement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1802, 1, 'Une erreur s''est produite lors de la r�cup�ration de l''identifiant de la derni�re mesure.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1803, 1, 'Une erreur s''est produite lors du transfert des donn�es du WAVELABS vers le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1804, 1, 'Une erreur s''est produite lors de l''enregistrement du traitement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1805, 3, 'Aucune donn�e du WAVELABS � transf�rer sur le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1806, 1, 'Une erreur s''est produite lors de la r�cup�ration du compte-rendu du traitement sur le WAVELABS.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1807, 1, 'Une erreur s''est produite lors de la mise � jour compl�mentaire des enregistrements.');

/* ------------------------------------------------------------- */
/* DTSX 'WAV_RECIPE.dtsx' : 1901 >> 1999                         */
/* ------------------------------------------------------------- */
/* Suppression des messages associ�s a WAVELABS - RECIPE */
DELETE FROM TP_Messages WHERE IdMessage BETWEEN 1901 AND 1999;

/* Insertion des messages associ�s a WAVELABS - RECIPE */
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1901, 1, 'Une erreur s''est produite lors de la recherche de l''identifiant de l''�quipement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1902, 1, 'Une erreur s''est produite lors de la r�cup�ration de l''identifiant de la derni�re mesure.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1903, 1, 'Une erreur s''est produite lors du transfert des donn�es du WAVELABS vers le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1904, 1, 'Une erreur s''est produite lors de l''enregistrement du traitement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1905, 3, 'Aucune donn�e du WAVELABS � transf�rer sur le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1906, 1, 'Une erreur s''est produite lors de la r�cup�ration du compte-rendu du traitement sur le WAVELABS.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(1907, 1, 'Une erreur s''est produite lors de la mise � jour compl�mentaire des enregistrements.');

/* ------------------------------------------------------------- */
/* DTSX 'TRI_WAFER.dtsx' : 2001 >> 2099                          */
/* ------------------------------------------------------------- */
/* Suppression des messages associ�s a TRI - CELLULE */
DELETE FROM TP_Messages WHERE IdMessage BETWEEN 2001 AND 2099;

/* Insertion des messages associ�s a TRI - CELLULE */
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2001, 1, 'Une erreur s''est produite lors de la recherche de l''identifiant de l''�quipement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2002, 1, 'Une erreur s''est produite lors de la r�cup�ration de l''identifiant de la derni�re mesure.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2003, 1, 'Une erreur s''est produite lors du transfert des donn�es de classification (TRI) vers le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2004, 1, 'Une erreur s''est produite lors de l''enregistrement du traitement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2005, 3, 'Aucune donn�e de classification (ELOGIA) � transf�rer sur le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2006, 1, 'Une erreur s''est produite lors de la r�cup�ration du compte-rendu du traitement sur TRI.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2007, 1, 'Une erreur s''est produite lors de la mise � jour compl�mentaire des enregistrements.');

/* ------------------------------------------------------------- */
/* DTSX 'LOT_WAFER.dtsx' : 2101 >> 2199                          */
/* ------------------------------------------------------------- */
/* Suppression des messages associ�s a TRI - LOT */
DELETE FROM TP_Messages WHERE IdMessage BETWEEN 2101 AND 2199;

/* Insertion des messages associ�s a TRI - LOT */
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2101, 1, 'Une erreur s''est produite lors de la recherche de l''identifiant de l''�quipement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2102, 1, 'Une erreur s''est produite lors de la r�cup�ration de l''identifiant de la derni�re mesure.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2103, 1, 'Une erreur s''est produite lors du transfert des donn�es de cl�ture vers le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2104, 1, 'Une erreur s''est produite lors de l''enregistrement du traitement.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2105, 3, 'Aucune donn�e de classification (ELOGIA) � transf�rer sur le DATA WAREHOUSE.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2106, 1, 'Une erreur s''est produite lors de la r�cup�ration du compte-rendu du traitement sur cl�ture de lots.');
INSERT INTO	TP_Messages (IdMessage, IdType, LibelleMessage) 
VALUES	(2107, 1, 'Une erreur s''est produite lors de la mise � jour compl�mentaire des enregistrements.');
