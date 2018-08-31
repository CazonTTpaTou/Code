/* ################################################################------------ */
/* INSERTION DU PARAMETRAGE DU DATA WAREHOUSE                                */
/* ################################################################------------ */

/* Utilisation de la base DWH_DB */
USE [CELL_INLINE_DB]
GO

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--											REINITIALISATION DU PARAMETRAGE DES CLASSE   		      					
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- On supprime les classes que le script va creer
IF (SELECT COUNT(*) FROM [dbo].[TD_PRODUCTION_CLASSES]) > 0
	DELETE FROM [dbo].[TD_PRODUCTION_CLASSES]
	
-- On supprime les groupes de classe que le script va creer
IF (SELECT COUNT(*) FROM [dbo].[TD_PRODUCTION_CLASSES_GROUPES]) > 0
	DELETE FROM [dbo].[TD_PRODUCTION_CLASSES_GROUPES]

-- On supprime les types de classe que le script va creer
IF (SELECT COUNT(*) FROM [dbo].[TD_PRODUCTION_CLASSES_TYPES]) > 0
	DELETE FROM [dbo].[TD_PRODUCTION_CLASSES_TYPES]

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													FOURNISSEURS
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

IF (SELECT COUNT(*) FROM [dbo].[TD_PRODUCTION_FOURNISSEURS] WHERE [IdFournisseur] = 10) = 0
BEGIN
	-- Creation des fournisseurs
	INSERT INTO [dbo].[TD_Production_Fournisseurs] ([IdFournisseur],[NomFournisseur],[FournisseurActif]) VALUES (10, 'Elogia', -1)
	-- Complement des informations
	UPDATE [dbo].[TD_Production_Fournisseurs] SET [FournisseurRang] = [IdFournisseur]
END

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													EQUIPEMENTS
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

IF (SELECT COUNT(*) FROM [dbo].[TD_PRODUCTION_EQUIPEMENTS] WHERE [IdEquipement] BETWEEN 47 AND 60) = 0 
BEGIN
	-- Creation des equipements
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (47, NULL, 10, 7, 'TRI 6', -1, 70000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (48, 47, 10, 7, 'Vision P', -1, 71000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (49, 47, 10, 7, 'Vision N', -1, 72000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (50, 47, 10, 7, 'Flasheur', -1, 73000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (51, 47, 10, 7, 'Electrolum', -1, 74000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (52, 51, 10, 7, 'ElectrolumResults 1', -1, 74100)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (53, 51, 10, 7, 'ElectrolumResults 2', -1, 74200)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (54, 51, 10, 7, 'ElectrolumRecipes 1', -1, 74300)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (55, 51, 10, 7, 'ElectrolumRecipes 2', -1, 74400)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (56, 47, 10, 7, 'Infra-Rouge', -1, 75000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (57, 47, 10, 7, 'R-Ligne', -1, 76000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (58, 47, 10, 7, 'Automate', -1, 79000)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (59, 58, 10, 7, 'AutomateClasses', -1, 79100)
	INSERT INTO [dbo].[TD_Production_Equipements] ([IdEquipement],[IdEquipementPere],[IdFournisseur],[IdEtape],[NomEquipement],[EquipementActif],[EquipementRang]) VALUES (60, 58, 10, 7, 'AutomateClotureLots', -1, 79300)
END

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													TYPES DE CLASSE
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- Creation des types de classe
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_TYPES] ([IdTypeClasse],[Libelle],[Description],[Rejets]) VALUES (0,'Produit','Cellule OK (Equipement)',0)
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_TYPES] ([IdTypeClasse],[Libelle],[Description],[Rejets]) VALUES (1,'Puissance','Classes de rendement finales (Automate)',0)
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_TYPES] ([IdTypeClasse],[Libelle],[Description],[Rejets]) VALUES (2,'Machine','Classes générées suite à un problème machine',-1)
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_TYPES] ([IdTypeClasse],[Libelle],[Description],[Rejets]) VALUES (3,'Produit','Classes générées suite à l''identification d''un défaut du produit',-1)
-- Complement des informations
UPDATE [dbo].[TD_PRODUCTION_CLASSES_TYPES] SET [Actif] = -1, [Rang] = [IdTypeClasse]

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													CLASSES VISION P
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- -------------------------------------------------------------
-- GROUPE DE CLASSES (TABLE : TD_PRODUCTION_CLASSES_GROUPES)
-- -------------------------------------------------------------
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (1000,2,48,'ERVP','Erreur Système de Vision (Vision P)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (1001,0,48,'OK',  'Cellule OK (VISION P)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (1002,3,48,'P...','Défauts P... (Vision P)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (1003,3,48,'PCEN','Défauts PCEN (Vision P)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (1004,3,48,'PASP','Défauts PASP (Vision P)')

-- -------------------------------------------------------------
-- CLASSES (TABLE : TD_PRODUCTION_CLASSES)
-- -------------------------------------------------------------
-- Erreur générale du système
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1000,1000,'ERVP','Erreur Système de Vision P')
-- Cellule bonne
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1001,1001,'OK','Cellule bonne en vision P')
-- Défaut mécaniques qui mettent en péril l'intégrité de la cellule 
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1002,1002,'PKC.','Casse outil intra cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1003,1002,'PEBR','Ebréchure sur bord Cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1004,1002,'POTR','OverTravel - Dépassement Offset Robot')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1005,1002,'PGEO','Géométrie - Dimensionnel Bord & Angles')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1006,1002,'P90.','Orientation Bus - à 90° ou non détectés')
-- Rejets propres aux cellules
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1010,1003,'PCEN','Centrage X, Y ou Rotation')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1011,1004,'PDIS','Distance entre Encre et Bord Cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1012,1004,'PASP','Taches entre Fingers')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (1013,1004,'PREC','Recouvrement - P2/P1')

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													CLASSES VISION N
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- -------------------------------------------------------------
-- GROUPE DE CLASSES (TABLE : TD_PRODUCTION_CLASSES_GROUPES)
-- -------------------------------------------------------------
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (2000,2,49,'ERVN','Erreur Système de Vision (Vision N)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (2001,0,49,'OK',  'Cellule OK (VISION N)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (2002,3,49,'N...','Défauts N... (Vision N)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (2003,3,49,'NCEN','Défauts NCEN (Vision N)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (2004,3,49,'NASP','Défauts NASP (Vision N)')

-- -------------------------------------------------------------
-- CLASSES (TABLE : TD_PRODUCTION_CLASSES)
-- -------------------------------------------------------------
-- Erreur générale du système
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2000,2000,'ERVN','Erreur Système de Vision N')
-- Cellule bonne
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2001,2001,'OK','Cellule bonne en vision N')
-- Défaut mécaniques qui mettent en péril l'intégrité de la cellule 
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2002,2002,'NKC.','Casse outil intra cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2003,2002,'NEBR','Ebréchure sur bord Cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2004,2002,'NOTR','OverTravel - Dépassement Offset Robot')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2005,2002,'NGEO','Géométrie - Dimensionnel Bord & Angles')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2006,2002,'N90.','Orientation Bus - à 90° ou non détectés')
-- Rejets propres aux cellules
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2010,2003,'NCEN','Centrage - X, Y ou Rotation')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2011,2004,'NDIS','Distance entre Encre et Bord Cellule')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2012,2004,'NASP','Taches entre Fingers')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2013,2004,'NGAP','Coupures de lignes sur Fingers')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2014,2004,'NLAR','Lignes Larges inclut Knots et Thickenings')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2015,2004,'NFIN','Lignes Fines lignes trop fines')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (2016,2004,'NBUS','Bus Coupures, manques ou taches')

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													CLASSES FLASHEUR WAVELABS
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- -------------------------------------------------------------
-- GROUPE DE CLASSES (TABLE : TD_PRODUCTION_CLASSES_GROUPES)
-- -------------------------------------------------------------
-- Groupe de classes bonnes
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3001,1,50,'23.0','Classe finale de rendement 23.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3002,1,50,'22.8','Classe finale de rendement 22.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3003,1,50,'22.6','Classe finale de rendement 22.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3004,1,50,'22.4','Classe finale de rendement 22.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3005,1,50,'22.2','Classe finale de rendement 22.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3006,1,50,'22.0','Classe finale de rendement 22.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3007,1,50,'21.8','Classe finale de rendement 21.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3008,1,50,'21.6','Classe finale de rendement 21.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3009,1,50,'21.4','Classe finale de rendement 21.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3010,1,50,'21.2','Classe finale de rendement 21.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3011,1,50,'21.0','Classe finale de rendement 21.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3012,1,50,'20.8','Classe finale de rendement 20.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3013,1,50,'20.6','Classe finale de rendement 20.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3014,1,50,'20.4','Classe finale de rendement 20.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3015,1,50,'20.2','Classe finale de rendement 20.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3016,1,50,'20.0','Classe finale de rendement 20.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3017,1,50,'19.8','Classe finale de rendement 19.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3018,1,50,'19.6','Classe finale de rendement 19.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3019,1,50,'19.4','Classe finale de rendement 19.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3020,1,50,'19.2','Classe finale de rendement 19.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3021,1,50,'19.0','Classe finale de rendement 19.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3022,1,50,'18.8','Classe finale de rendement 18.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3023,1,50,'18.6','Classe finale de rendement 18.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3024,1,50,'18.4','Classe finale de rendement 18.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3025,1,50,'18.2','Classe finale de rendement 18.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3026,1,50,'18.0','Classe finale de rendement 18.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3027,1,50,'17.8','Classe finale de rendement 17.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3028,1,50,'17.6','Classe finale de rendement 17.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3029,1,50,'17.4','Classe finale de rendement 17.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3030,1,50,'17.2','Classe finale de rendement 17.2 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3031,1,50,'17.0','Classe finale de rendement 17.0 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3032,1,50,'16.8','Classe finale de rendement 16.8 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3033,1,50,'16.6','Classe finale de rendement 16.6 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3034,1,50,'16.4','Classe finale de rendement 16.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3098,1,50,'L-16.4','Classe finale de rendement inférieure à 16.4 définie par l''automate')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3099,1,50,'M...','Classe finale de rendement inférieure à 14 définie par l''automate')
-- Groupe de classes de rejets
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3100,2,50,'ERFL','Défauts ERFL (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3102,3,50,'ELEC','Défauts ELEC (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3103,3,50,'RSH.','Défauts RSH. (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3104,3,50,'IDK.','Défauts IDK. (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3105,3,50,'RLIF','Défauts RLIF (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3106,3,50,'RLIB','Défauts RLIB (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3107,3,50,'ISR.','Défauts ISR. (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3108,3,50,'ISR4','Défauts ISR4 (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3109,3,50,'ISR9','Défauts ISR9 (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3110,3,50,'ERIR','Défauts ERIR (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3111,3,50,'IR..','Défauts IR.. (Flasheur)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3112,2,50,'NOCL','Défauts NOCL (Flasheur)')

-- -------------------------------------------------------------
-- CLASSES (TABLE : TD_PRODUCTION_CLASSES)
-- -------------------------------------------------------------
-- Classes bonnes
DECLARE @CLASSE_MAX 		AS REAL = 23
DECLARE @CLASSE_MIN 		AS REAL = 13.9
DECLARE @CLASSE 			AS REAL = @CLASSE_MAX
DECLARE @ID_CLASSE 			AS INT = 1
DECLARE @ID_GROUPE 			AS INT = 3001
DECLARE @LIBELLE 			AS VARCHAR(10)
DECLARE @DESCRIPTION 		AS VARCHAR(255)

WHILE ROUND(@CLASSE,1) >= ROUND(@CLASSE_MIN,1)
	BEGIN
		-- On constitue le libelle de la classe
		SET @LIBELLE = CASE WHEN  ROUND(@CLASSE,1) < 14 THEN 'M...' ELSE (CASE WHEN LEN(CAST(@CLASSE AS VARCHAR)) = 2 THEN CAST(@CLASSE AS VARCHAR) + '.0' ELSE CAST(@CLASSE AS VARCHAR) END) END
		-- On constitue la description
		SET @DESCRIPTION = CASE WHEN  ROUND(@CLASSE,1) < 14 THEN 'Classe de puissance <14%' ELSE ('Classe de puissance ' + @LIBELLE) END
		-- On calcule l'id du groupe
		SELECT @ID_GROUPE = CASE 
			WHEN (16.3 < @CLASSE AND @CLASSE <= 23) THEN CASE WHEN (CAST(ROUND((@CLASSE*10),0) AS INT)%2=1) THEN @ID_GROUPE + 1 ELSE @ID_GROUPE END
			WHEN (13.9 < @CLASSE AND @CLASSE <= 16.3) THEN 3098
			WHEN (@CLASSE <= 13.9) THEN 3099
		END
		SET @ID_CLASSE = CASE @ID_GROUPE WHEN 3099 THEN 99 ELSE @ID_CLASSE END
		-- On insert dans la table
		INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse], [IdGroupeClasse], [Libelle], [Description], [Actif], [Rang]) VALUES (@ID_CLASSE, @ID_GROUPE, @LIBELLE, @DESCRIPTION, -1, @ID_CLASSE)
		-- On incremente l'identifiant 
		SET @ID_CLASSE = @ID_CLASSE + 1
		-- On decremente la puissance de la classe
		SET @CLASSE = @CLASSE - 0.1
	END 
	
-- Erreur générale du système
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3100,3100,'ERFL','Défauts de fonctionnement du Testeur')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3101,3100,'IRR.','Irradiance trop Haute (AM1.5 400-1100 : 748,74)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3102,3100,'IRR.','Irradiance trop Basse (AM1.5 400-1100 : 748,74)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3103,3100,'TEMP','Température Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3104,3100,'TEMP','Température Trop Haute')
-- Rejets propres aux cellules
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3121,3102,'FF..','Fill Factor Trop Haut')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3122,3102,'RS..','Résistance Série Trop Elevée')
--                                                                                                            
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3123,3103,'RSH.','Résistance Shunt Trop Basse')
--                                                                                                           
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3140,3104,'IDK.','Dépassement de I rev, ou Vrev atteint en saturation')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3141,3104,'ID06','I à -6V')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3142,3104,'ID10','I à -10V')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3143,3104,'ID12','I à -12V')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3144,3104,'ID13','I à -13V')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3145,3104,'IDMN','Vrev Min')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3146,3104,'IDMX','Irev Max (en cas de Courant Saturé avant d''arrivé au seuil de V)')
--                                                                                                            
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3160,3105,'RLF.','Rligne Face Avant (Rligne vers 25 Ohms ?)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3161,3105,'RLF1','Résistance Ligne Face Avant Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3162,3105,'RLF2','Résistance Ligne Face Avant Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3163,3105,'RLF3','Résistance Ligne Face Avant Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3164,3105,'RLF4','Résistance Ligne Face Avant Trop Haute')
--                                                                                                           
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3170,3106,'RLB.','Rligne Face Arrière')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3171,3106,'RLB1','Résistance Ligne Face Arrière Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3172,3106,'RLB2','Résistance Ligne Face Arrière Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3173,3106,'RLB3','Résistance Ligne Face Arrière Trop Haute')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3174,3106,'RLB4','Résistance Ligne Face Arrière Trop Haute')
--                                                                                                            
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3180,3107,'ISR.','Défaut de Courant en Réponse Spectrale')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3181,3108,'ISR4','Mesure Bleue à 400 nm Basse')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3182,3109,'ISR9','Mesure Rouge à 900 nm Basse')
--                                                                                                            
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3190,3110,'ERIR','Défaut InfraRouge (Non vérifiable à l''oeil)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3191,3111,'IRAV','Niv Gris Moyen trop Haut')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3192,3111,'IRMX','Niv Gris Max Trop Haut')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3193,3111,'IRSD','Niv Gris Ecart-type Trop Elevé')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3194,3111,'IRPT','Puissance Résultante PTOTIR')
--                                                                                                            
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3199,3112,'NOCL','Pas de Classe : Ne rentre dans aucune case')

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													CLASSES ELECTROLUM WAVELABS
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- -------------------------------------------------------------
-- GROUPE DE CLASSES (TABLE : TD_PRODUCTION_CLASSES_GROUPES)
-- -------------------------------------------------------------
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3500,3,51,'EREL','Défauts EREL (Electrolum intégrée au WAVELABS)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3501,0,51,'OK','Cellule OK (WAVELABS)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3502,3,51,'MICR','Défauts MICR (Electrolum intégrée au WAVELABS)')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES_GROUPES] ([IdGroupeClasse],[IdTypeClasse],[IdEquipement],[Libelle],[Description]) VALUES (3503,3,51,'ELUM','Défauts ELUM (Electrolum intégrée au WAVELABS)')

-- -------------------------------------------------------------
-- CLASSES (TABLE : TD_PRODUCTION_CLASSES)
-- -------------------------------------------------------------
-- Erreur générale du système
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3500,3500,'EREL','Defaut Electrolum')
-- Cellule bonne
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3501,3501,'OK','Cellule bonne à l''electrolum (WAVELABS)')
-- Rejets propres aux cellules
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3502,3502,'ELKC','Cracks')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3503,3503,'ELFG','Fingers')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3504,3503,'ELDA','Dark Area')
INSERT INTO [dbo].[TD_PRODUCTION_CLASSES] ([IdClasse],[IdGroupeClasse],[Libelle],[Description]) VALUES (3505,3503,'ELSC','Rayures')

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													CLASSES INFRA-ROUGE WAVELABS
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- 													MISE A JOUR COMPLEMENTAIRE DES GROUPES ET DES CLASSES
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
UPDATE [dbo].[TD_PRODUCTION_CLASSES_GROUPES] SET [Actif] = -1, [Rang] = [IdGroupeClasse]
UPDATE [dbo].[TD_PRODUCTION_CLASSES] SET [Actif] = -1, [Rang] = [IdClasse]

/* ################################################################ */
/* TABLE : TP_STATUT_WAFER_WAV		                             */
/* ################################################################ */

INSERT INTO [dbo].[TP_STATUT_WAFER_WAV] ([IdStatutWafer],[IdStatutOrigine],[IdTypeStatut],[Libelle],[Observations],[Actif],[Rang]) VALUES (7101,1,0,'Tri (WaveLabs) - Défaut ELECTROLUM','Défaut ELECTROLUM',-1,7101)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV] ([IdStatutWafer],[IdStatutOrigine],[IdTypeStatut],[Libelle],[Observations],[Actif],[Rang]) VALUES (7102,1,50,'Tri (WaveLabs) - Bon','Sortie bonne',-1,7102)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV] ([IdStatutWafer],[IdStatutOrigine],[IdTypeStatut],[Libelle],[Observations],[Actif],[Rang]) VALUES (7103,1,1,'Tri (WaveLabs) - Micro Cracks','Rejet micro-crack',-1,7103)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV] ([IdStatutWafer],[IdStatutOrigine],[IdTypeStatut],[Libelle],[Observations],[Actif],[Rang]) VALUES (7104,1,4,'Tri (WaveLabs) - Aspect','Rejet Aspect',-1,7104)

/* ################################################################ */
/* TABLE : TP_STATUT_WAFER_WAV_DETAIL                            */
/* ################################################################ */

INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (0,7101)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (1,7102)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (2,7103)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (3,7104)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (4,7104)
INSERT INTO [dbo].[TP_STATUT_WAFER_WAV_DETAIL] ([RejetBin],[IdStatutWafer]) VALUES (5,7104)
