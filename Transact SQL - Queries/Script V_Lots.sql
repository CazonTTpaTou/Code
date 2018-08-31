USE [SQC_DB]
GO

/****** Object:  View [dbo].[V_LOTS]    Script Date: 10/03/2014 17:41:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[V_LOTS]
AS

SELECT TOP (100) PERCENT

       CASE WHEN T_LOT_1.IdAtelierFinal = 1 
			THEN 'EDF ENR PWT' 
			ELSE 'PV Alliance' 
				END AS Societe
     , T_LOT_1.Lot
     , CASE WHEN T_LOT_1.Groupable = - 1 
			THEN 'oui' 
			ELSE 'non' 
				END AS Groupable
     , CASE WHEN dbo.V_LOT_GROUPE_COUNT.GroupLot IS NOT NULL 
			THEN 'oui' 
			ELSE 'non' 
				END AS Groupe
     , CASE WHEN T_LOT.Lot IS NULL 
			THEN T_LOT_1.Lot 
			ELSE T_LOT.Lot 
				END AS [Lot Serig]
     , dbo.V_LOT_GROUPE_COUNT.NbLots AS [Nb Lots]
     , T_Statut_7.Statut
     , dbo.T_Format.Format_ AS Format
	 , dbo.T_Forme.Forme
	 , dbo.T_Materiau.Materiau
	 , dbo.T_TypeSi.Polarite
	 , dbo.T_GradeSi.Grade
	 , dbo.T_Fournisseur.Fournisseur
	 , Ass.[Assemblage 1]
	 , Ass.[Assemblage 2+]
	 , Lin.[Lingot 1]
	 , Lin.[Lingot 2+]
	 , ISNULL('Mep: ' + T_LOT_1.ObservMeP,'') 
					  + ISNULL('Textu: ' + T_LOT_1.ObservTextu, '') 
					  + ISNULL('Diff: ' + T_LOT_1.ObservDiffu, '') 
					  + ISNULL('Desox: ' + T_LOT_1.ObservDesox, '') 
                                          + ISNULL('Pecvd: ' + T_LOT_1.ObservPecvd, '') 
					  + ISNULL('Seri: ' + T_LOT_1.ObservSerig, '') 
					  + ISNULL('Tri: ' + T_LOT_1.ObservTri, '') 
							AS Observations
	,1 AS Compte
	, T_LOT_1.OF1
	, T_LOT_1.OF2
	, CASE WHEN T_LOT_1.ManuMeg IS NULL 
            THEN '' 
					WHEN T_LOT_1.ManuMeg = 1 
					THEN 'saisie' 
					ELSE 'log machine' 
							END AS [Meg Mode]
	, T_LOT_1.PosteMeG AS [Meg Poste]
	, T_LOT_1.DateDebPosteMeG AS [Meg Date Poste]
	, T_LOT_1.EquipeMeG AS [Meg Equipe]
	, T_Operateur_8.Matricule AS [Meg Matricule]
	, T_LOT_1.ObservMeG AS [Meg Obs]
	, T_LOT_1.DateHeureGodet AS [Meg Date Heure]
	, dbo.T_Machine.Machine AS [Meg Equipement]
	, CASE WHEN T_LOT_1.ManuMeP = 1 
					THEN 'saisie' 
					ELSE 'log machine' 
							END AS [Mep Mode]
	, T_LOT_1.PosteMeP AS [Mep Poste]
	, T_LOT_1.DateDebPosteSortMeP AS [Mep Date Poste], T_LOT_1.EquipeMeP AS [Mep Equipe]
	, T_Operateur_7.Matricule AS [Mep Matricule]
	, T_LOT_1.ObservMeP AS [Mep Obs]
	, T_LOT_1.DateHeureEntrMeP AS [Mep Date Heure Entr]
	, Null AS [Mep Date Heure Deb] 
	, Null AS [Mep Date Heure Fin]
	, T_LOT_1.DateHeureSortMeP AS [Mep Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortMeP AS float) AS int) AS datetime) AS [Mep Date Sort]
	, T_LOT_1.QteEntrMeP AS [Mep Qte Entr]
	, T_LOT_1.QteSortMeP AS [Mep Qte Sort]
	, T_LOT_1.QteEntrMeP - T_LOT_1.QteSortMeP AS [Mep Rej Total]
	, T_LOT_1.QteManqMeP AS [Mep Qte Manq]
	, T_LOT_1.RejOperEbrechMeP AS [Mep Rej Op Ebr]
	, T_LOT_1.RejOperAspectMeP AS [Mep Rej Op Asp]
	, T_LOT_1.RejOperCasseMeP AS [Mep Rej Op Casse]
	, T_LOT_1.RejEquipEbrechMeP AS [Mep Rej Eq Ebr]
	, T_LOT_1.RejEquipEpaisMeP AS [Mep Rej Eq Epais]
	, T_LOT_1.RejEquipDimMeP AS [Mep Rej Eq Dim]
	, T_Machine_7.Machine AS [Mep Equipement]
	, T_LOT_1.LotMatiereMeP AS [Mep Lot Matiere]
	, CASE WHEN T_LOT_1.ManuTextu = 1 
		   THEN 'saisie' 
		   ELSE 'log machine' 
				END AS [Textu Mode]
	, T_LOT_1.PosteTextu AS [Textu Poste]
	, T_LOT_1.DateDebPosteSortTextu AS [Textu Date Poste]
	, T_LOT_1.EquipeTextu AS [Textu Equipe]
	, T_Operateur_1.Matricule AS [Textu Matricule]
	, T_LOT_1.ObservTextu AS [Textu Obs]
	, T_LOT_1.DateHeureEntrTextu AS [Textu Date Heure Entr] 
	, Null AS [Textu Date Heure Deb]
	, Null AS [Textu Date Heure Fin] 
    , T_LOT_1.DateHeureSortTextu AS [Textu Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortTextu AS float) AS int) AS datetime) AS [Textu Date Sort]
	, T_LOT_1.QteEntrTextu AS [Textu Qte Entr]
	, T_LOT_1.QteSortTextu AS [Textu Qte Sort]
	, T_LOT_1.QteEntrTextu - T_LOT_1.QteSortTextu - ISNULL(T_LOT_1.QteVenteTextu, 0) AS [Textu Rej Total]
	, T_LOT_1.QteManqTextu AS [Textu Qte Manq]
	, T_LOT_1.PoidsDecape AS [Textu Pds Decap g]
	, T_LOT_1.RejOperEbrechTextu AS [Textu Rej Op Ebr]
	, T_LOT_1.RejOperAspectTextu AS [Textu Rej Op Asp]
	, T_LOT_1.RejOperCasseTextu AS [Textu Rej Op Casse]
	, T_LOT_1.RejEquipCasseTextu AS [Textu Rej Eq Casse]
	, T_Machine_1.Machine AS [Textu Equipement]
	, CASE WHEN T_LOT_1.ManuDiffu = 1 
		   THEN 'saisie' 
		   ELSE 'log machine' 
				END AS [Diff Mode]
	, T_LOT_1.PosteDiffu AS [Diff Poste]
	, T_LOT_1.DateDebPosteSortDiffu AS [Diff Date Poste]
	, T_LOT_1.EquipeDiffu AS [Diff Equipe]
	, T_Operateur_2.Matricule AS [Diff Matricule]
	, T_LOT_1.ObservDiffu AS [Diff Obs]
	, T_LOT_1.DateHeureEntrDiffu AS [Diff Date Heure Entr]
	, Null AS [Diff Date Heure Deb]
	, Null AS [Diff Date Heure Fin]
	, T_LOT_1.DateHeureSortDiffu AS [Diff Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortDiffu AS float) AS int) AS datetime) AS [Diff Date Sort]
	, T_LOT_1.QteEntrDiffu AS [Diff Qte Entr]
	, T_LOT_1.QteSortDiffu AS [Diff Qte Sort]
	, T_LOT_1.QteEntrDiffu 
			- T_LOT_1.QteSortDiffu 
			- ISNULL(T_LOT_1.QteVenteDiffu, 0) 
					AS [Diff Rej Total]
	, T_LOT_1.QteManqDiffu AS [Diff Qte Manq]
	, T_LOT_1.RejOperEbrechDiffu AS [Diff Rej Op Ebr]
	, T_LOT_1.RejOperAspectDiffu AS [Diff Rej Op Asp]
	, T_LOT_1.RejOperCasseDiffu AS [Diff Rej Op Casse]
	, T_LOT_1.RejEquipCasseDiffu AS [Diff Rej Eq Casse]
	, T_Machine_2.Machine AS [Diff Equipement]
	, dbo.T_Tube.Tube AS [Diff Tube]
	, dbo.T_Recette.Recette AS [Diff Recette]
	, T_Nacelle_1.Nacelle AS [Diff Nacelle]
	, T_LOT_1.CptNacelleDiffu AS [Diff Nacelle Cpt]
	, T_LOT_1.R2 AS [Diff R2]
	, CASE WHEN T_LOT_1.ManuDesox <> 1 
		   THEN 'saisie' 
		   ELSE 'log machine' 
				END AS [Desox Mode]
	, T_LOT_1.PosteDesox AS [Desox Poste]
	, T_LOT_1.DateDebPosteSortDesox AS [Desox Date Poste]
	, T_LOT_1.EquipeDesox AS [Desox Equipe]
	, T_Operateur_3.Matricule AS [Desox Matricule]
	, T_LOT_1.ObservDesox AS [Desox Obs]
	, T_LOT_1.DateHeureEntrDesox AS [Desox Date Heure Entr]
	, Null AS [Desox Date Heure Deb]
	, Null AS [Desox Date Heure Fin] 
    , T_LOT_1.DateHeureSortDesox AS [Desox Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortDesox AS float) AS int) AS datetime) AS [Desox Date Sort]
	, T_LOT_1.QteEntrDesox AS [Desox Qte Entr]
	, T_LOT_1.QteSortDesox AS [Desox Qte Sort]
	, T_LOT_1.QteEntrDesox - T_LOT_1.QteSortDesox - ISNULL(T_LOT_1.QteVenteDesox, 0) AS [Desox Rej Total]
	, T_LOT_1.QteManqDesox AS [Desox Qte Manq]
	, T_LOT_1.RejOperEbrechDesox AS [Desox Rej Op Ebr]
	, T_LOT_1.RejOperAspectDesox AS [Desox Rej Op Asp]
	, T_LOT_1.RejOperCasseDesox AS [Desox Rej Op Casse]
	, T_LOT_1.RejEquipCasseDesox AS [Desox Rej Eq Casse]
	, T_Machine_3.Machine AS [Desox Equipement]
	, T_LOT_1.BacDesox AS [Desox Bac]
	, T_LOT_1.RejEquipCasseChgtDesox AS [Desox Rej Eq Casse Chgt]
	, T_LOT_1.RejEquipAspectChgtDesox AS [Desox Rej Eq Asp Chgt]
	, T_LOT_1.RejEquipCasseDechgtDesox AS [Desox Rej Eq Casse Dechgt]
	, T_LOT_1.RejEquipAspectDechgtDesox AS [Desox Rej Eq Asp Dechgt]
	, T_LOT_1.RShunt AS [Desox RShunt]
	, CASE WHEN T_LOT_1.ManuPecvd = 1 
		   THEN 'saisie' 
		   ELSE 'log machine' 
				END AS [Pecvd Mode]
	, T_LOT_1.PostePecvd AS [Pecvd Poste]
	, T_LOT_1.DateDebPosteSortPecvd AS [Pecvd Date Poste]
	, T_LOT_1.EquipePecvd AS [Pecvd Equipe]
	, T_Operateur_4.Matricule AS [Pecvd Matricule]
	, T_LOT_1.ObservPecvd AS [Pecvd Obs]
	, T_LOT_1.DateHeureEntrPecvd AS [Pecvd Date Heure Entr]
	, Null AS [Pecvd Date Heure Deb]
	, Null AS [Pecvd Date Heure Fin] 
    , T_LOT_1.DateHeureSortPecvd AS [Pecvd Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortPecvd AS float) AS int) AS datetime) AS [Pecvd Date Sort]
	, T_LOT_1.QteEntrPecvd AS [Pecvd Qte Entr]
	, T_LOT_1.QteSortPecvd AS [Pecvd Qte Sort]
	, T_LOT_1.QteEntrPecvd - T_LOT_1.QteSortPecvd - ISNULL(T_LOT_1.QteVentePecvd, 0) AS [Pecvd Rej Total]
	, T_LOT_1.QteManqPecvd AS [Pecvd Qte Manq], T_LOT_1.RejOperEbrechPecvd AS [Pecvd Rej Op Ebr]
	, T_LOT_1.RejOperAspectPecvd AS [Pecvd Rej Op Asp]
	, T_LOT_1.RejOperCassePecvd AS [Pecvd Rej Op Casse]
	, T_LOT_1.[RejEquipCoulB+] AS [Pecvd Rej Eq B+]
	, T_LOT_1.RejEquipCoulB AS [Pecvd Rej Eq B]
	, T_LOT_1.RejEquipCoulC AS [Pecvd Rej Eq C]
	, T_LOT_1.RejEquipCassePecvd AS [Pecvd Rej Eq Casse]
	, T_Machine_4.Machine AS [Pecvd Equipement]
	, T_Tube_1.Tube AS [Pecvd Tube]
	, T_Recette_1.Recette AS [Pecvd Cth Recette]
	, dbo.T_Nacelle.Nacelle AS [Pecvd Nacelle]
	, T_LOT_1.CptNacellePecvd AS [Pecvd Nacelle Cpt]
	, T_Recette_2.Recette AS [Pecvd Vision Recette]
	, CASE WHEN T_LOT_1.ManuSerig = 1 
		   THEN 'saisie' 
		   ELSE 'log machine' 
				END AS [Seri Mode]
	, T_LOT_1.PosteSerig AS [Seri Poste]
	, T_LOT_1.DateDebPosteSortSerig AS [Seri Date Poste]
	, T_LOT_1.EquipeSerig AS [Seri Equipe]
	, T_Operateur_5.Matricule AS [Seri Matricule]
	, T_LOT_1.ObservSerig AS [Seri Obs]
	, T_LOT_1.DateHeureEntrSerig AS [Seri Date Heure Entr]
	, Null AS [Seri Date Heure Deb]
	, Null AS [Seri Date Heure Fin] 
    , T_LOT_1.DateHeureSortSerig AS [Seri Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortSerig AS float) AS int) AS datetime) AS [Seri Date Sort]
	, T_LOT_1.QteEntrSerig AS [Seri Qte Entr]
	, T_LOT_1.QteSortSerig AS [Seri Qte Sort]
	, T_LOT_1.QteEntrSerig 
			- T_LOT_1.QteSortSerig 
			- ISNULL(T_LOT_1.QteVenteSerig, 0) 
					AS [Seri Rej Total], T_LOT_1.QteManqSerig AS [Serig Qte Manq]
	, T_LOT_1.RejOperEbrechSerig AS [Seri Rej Op Ebr]
	, T_LOT_1.RejOperAspectSerig AS [Seri Rej Op Asp]
	, T_LOT_1.RejOperCasseSerig AS [Seri Rej Op Casse]
	, T_LOT_1.RejOperGradeBSerig AS [Seri Rej Op GradeB]
	, T_LOT_1.RejEquipEbrechChgt AS [Seri Rej Chgt Ebr]
	, T_LOT_1.RejEquipAspectChgt AS [Seri Rej Chgt Asp]
	, T_LOT_1.RejEquipCasseChgt AS [Seri Rej Chgt Casse]
	, T_LOT_1.RejEquipEbrechSt1 AS [Seri Rej Station 1 Ebr]
	, T_LOT_1.RejEquipAspectSt1 AS [Seri Rej Station 1 Asp]
	, T_LOT_1.RejEquipCasseSt1 AS [Seri Rej Station 1 Casse]
	, T_LOT_1.RejEquipVision1 AS [Seri Rej Eq Vision1]
	, T_LOT_1.RejEquipManqSt1 AS [Seri Rej Eq Manq1]
	, T_LOT_1.RejEquipEbrechSt2 AS [Seri Rej Station 2 Ebr]
	, T_LOT_1.RejEquipAspectSt2 AS [Seri Rej Station 2 Asp]
	, T_LOT_1.RejEquipCasseSt2 AS [Seri Rej Station 2 Casse]
	, T_LOT_1.RejEquipVision2 AS [Seri Rej Eq Vision2]
	, T_LOT_1.RejEquipManqSt2 AS [Seri Rej Eq Manq2]
	, T_LOT_1.RejEquipEbrechSt3 AS [Seri Rej Station 3 Ebr]
	, T_LOT_1.RejEquipAspectSt3 AS [Seri Rej Station 3 Asp]
	, T_LOT_1.RejEquipCasseSt3 AS [Seri Rej Station 3 Casse]
	, T_LOT_1.RejEquipVision3 AS [Seri Rej Eq Vision3]
	, T_LOT_1.RejEquipManqSt3 AS [Seri Rej Eq Manq3]
	, T_LOT_1.RejEquipEbrechSt4 AS [Seri Rej Station 4 Ebr]
	, T_LOT_1.RejEquipAspectSt4 AS [Seri Rej Station 4 Asp]
	, T_LOT_1.RejEquipCasseSt4 AS [Seri Rej Station 4 Casse]
	, T_LOT_1.RejEquipEbrechDechgt AS [Seri Rej Dechgt Ebr]
	, T_LOT_1.RejEquipAspectDechgt AS [Seri Rej Dechgt Asp]
	, T_LOT_1.RejEquipCasseDechgt AS [Seri Rej Dechgt Casse]
	, T_Machine_5.Machine AS [Seri Equipement]
	, dbo.T_ProfilCuisson.ProfilCuisson AS [Seri Profil Cuisson]
	, Null AS [Seri Num Lot Encre]
	, Null AS [Seri P1 Pds Encre mg]
	, Null AS [Seri P1 Ecran]
	, Null AS [Seri P1 Num Ecran]
	, Null AS [Seri P1 Cause Chg Ecran]
	, Null AS [Seri P2 Pds Encre mg]
	, Null AS [Seri P2 Ecran]
	, Null AS [Seri P2 Num Ecran]
	, Null AS [Seri P2 Cause Chg Ecran]
	, Null AS [Seri N1 Pds Encre mg]
	, Null AS [Seri N1 Ecran]
	, Null AS [Seri N1 Num Ecran]
	, Null AS [Seri N1 Cause Chg Ecran]
	, Null AS [Seri N2 Pds Encre mg]
	, Null AS [Seri N2 Ecran]
	, Null AS [Seri N2 Num Ecran]
	, Null AS [Seri N2 Cause Chg Ecran]
	, CASE WHEN T_LOT_1.ManuTri = 1 
			THEN 'saisie' 
			ELSE 'log machine' 
			END AS [Tri Mode]
	, T_LOT_1.PosteTri AS [Tri Poste]
	, T_LOT_1.DateDebPosteSortTri AS [Tri Date Poste]
	, T_LOT_1.EquipeTri AS [Tri Equipe]
	, T_Operateur_6.Matricule AS [Tri Matricule]
	, T_LOT_1.ObservTri AS [Tri Obs]
	, T_LOT_1.DateHeureEntrTri AS [Tri Date Heure Entr]
	, Null AS [Tri Date Heure Deb]
	, Null AS [Tri Date Heure Fin] 
    , T_LOT_1.DateHeureSortTri AS [Tri Date Heure Sort]
	, CAST(CAST(CAST(T_LOT_1.DateHeureSortTri AS float) AS int) AS datetime) AS [Tri Date Sort]
	, T_LOT_1.QteEntrTri AS [Tri Qte Entr]
	, T_LOT_1.QteSortTri AS [Tri Qte Sort]
	, T_LOT_1.QteEntrTri 
			- T_LOT_1.QteSortTri AS [Tri Rej Total]
	, T_LOT_1.QteManqTri AS [Tri Qte Manq]
	, T_LOT_1.QteNonRetri AS [Tri Qte Non Retri]
	, T_LOT_1.RejOperEbrechTri AS [Tri Rej Op Ebr]
	, T_LOT_1.RejOperAspectTri AS [Tri Rej Op Asp]
	, T_LOT_1.RejOperCasseTri AS [Tri Rej Op Casse]
	, T_LOT_1.RejOperGradeBTri AS [Tri Rej Op GradeB]
	, T_LOT_1.RejEquipCasseTri AS [Tri Rej Ep Casse]
	, ISNULL(T_LOT_1.QteManqTri, 0) AS [Tri Qte Ecart]
	, T_Machine_6.Machine AS [Tri Equipement]
	, ISNULL(dbo.TC_LOT_CLASSE.[22_0], 0) AS [Tri Qte 22_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[21_8], 0) AS [Tri Qte 21_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[21_6], 0) AS [Tri Qte 21_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[21_4], 0) AS [Tri Qte 21_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[21_2], 0) AS [Tri Qte 21_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[21_0], 0) AS [Tri Qte 21_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[20_8], 0) AS [Tri Qte 20_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[20_6], 0) AS [Tri Qte 20_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[20_4], 0) AS [Tri Qte 20_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[20_2], 0) AS [Tri Qte 20_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[20_0], 0) AS [Tri Qte 20_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[19_8], 0) AS [Tri Qte 19_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[19_6], 0) AS [Tri Qte 19_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[19_4], 0) AS [Tri Qte 19_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[19_2], 0) AS [Tri Qte 19_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[19_0], 0) AS [Tri Qte 19_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[18_8], 0) AS [Tri Qte 18_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[18_6], 0) AS [Tri Qte 18_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[18_4], 0) AS [Tri Qte 18_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[18_2], 0) AS [Tri Qte 18_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[18_0], 0) AS [Tri Qte 18_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[17_8], 0) AS [Tri Qte 17_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[17_6], 0) AS [Tri Qte 17_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[17_4], 0) AS [Tri Qte 17_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[17_2], 0) AS [Tri Qte 17_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[17_0], 0) AS [Tri Qte 17_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[16_8], 0) AS [Tri Qte 16_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[16_6], 0) AS [Tri Qte 16_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[16_4], 0) AS [Tri Qte 16_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[16_2], 0) AS [Tri Qte 16_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[16_0], 0) AS [Tri Qte 16_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[15_8], 0) AS [Tri Qte 15_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[15_6], 0) AS [Tri Qte 15_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[15_4], 0) AS [Tri Qte 15_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[15_2], 0) AS [Tri Qte 15_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[15_0], 0) AS [Tri Qte 15_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[14_8], 0) AS [Tri Qte 14_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[14_6], 0) AS [Tri Qte 14_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[14_4], 0) AS [Tri Qte 14_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[14_2], 0) AS [Tri Qte 14_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[14_0], 0) AS [Tri Qte 14_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[13_8], 0) AS [Tri Qte 13_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[13_6], 0) AS [Tri Qte 13_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[13_4], 0) AS [Tri Qte 13_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[13_2], 0) AS [Tri Qte 13_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[13_0], 0) AS [Tri Qte 13_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[12_8], 0) AS [Tri Qte 12_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[12_6], 0) AS [Tri Qte 12_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[12_4], 0) AS [Tri Qte 12_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[12_2], 0) AS [Tri Qte 12_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[12_0], 0) AS [Tri Qte 12_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-18_0], 0) AS [Tri Qte L-18_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-17_0], 0) AS [Tri Qte L-17_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-16_0], 0) AS [Tri Qte L-16_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-15_6], 0) AS [Tri Qte L-15_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-14_0], 0) AS [Tri Qte L-14_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-13_6], 0) AS [Tri Qte L-13_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-12_0], 0) AS [Tri Qte L-12_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-11_6], 0) AS [Tri Qte L-11_6]
	, ISNULL(dbo.TC_LOT_CLASSE.Al, 0) AS [Tri Qte Al]
	, ISNULL(dbo.TC_LOT_CLASSE.Ak, 0) AS [Tri Qte Ak]
	, ISNULL(dbo.TC_LOT_CLASSE.Ai, 0) AS [Tri Qte Ai]
	, ISNULL(dbo.TC_LOT_CLASSE.Aj, 0) AS [Tri Qte Aj]
	, ISNULL(dbo.TC_LOT_CLASSE.Ah, 0) AS [Tri Qte Ah]
	, ISNULL(dbo.TC_LOT_CLASSE.Ag, 0) AS [Tri Qte Ag]
	, ISNULL(dbo.TC_LOT_CLASSE.Af, 0) AS [Tri Qte Af]
	, ISNULL(dbo.TC_LOT_CLASSE.Ae, 0) AS [Tri Qte Ae]
	, ISNULL(dbo.TC_LOT_CLASSE.Ad, 0) AS [Tri Qte Ad]
	, ISNULL(dbo.TC_LOT_CLASSE.Ac, 0) AS [Tri Qte Ac]
	, ISNULL(dbo.TC_LOT_CLASSE.Ab, 0) AS [Tri Qte Ab]
	, ISNULL(dbo.TC_LOT_CLASSE.Aa, 0) AS [Tri Qte Aa]
	, ISNULL(dbo.TC_LOT_CLASSE.A0, 0) AS [Tri Qte A0]
	, ISNULL(dbo.TC_LOT_CLASSE.A1, 0) AS [Tri Qte A1]
	, ISNULL(dbo.TC_LOT_CLASSE.A2, 0) AS [Tri Qte A2]
	, ISNULL(dbo.TC_LOT_CLASSE.A3, 0) AS [Tri Qte A3]
	, ISNULL(dbo.TC_LOT_CLASSE.B, 0) AS [Tri Qte B]
	, ISNULL(dbo.TC_LOT_CLASSE.C, 0) AS [Tri Qte C]
	, ISNULL(dbo.TC_LOT_CLASSE.D, 0) AS [Tri Qte D]
	, ISNULL(dbo.TC_LOT_CLASSE.E, 0) AS [Tri Qte E]
	, ISNULL(dbo.TC_LOT_CLASSE.F, 0) AS [Tri Qte F]
	, ISNULL(dbo.TC_LOT_CLASSE.G, 0) AS [Tri Qte G]
	, ISNULL(dbo.TC_LOT_CLASSE.H, 0) AS [Tri Qte H]
	, ISNULL(dbo.TC_LOT_CLASSE.I, 0) AS [Tri Qte I]
	, ISNULL(dbo.TC_LOT_CLASSE.J, 0) AS [Tri Qte J]
	, ISNULL(dbo.TC_LOT_CLASSE.K, 0) AS [Tri Qte K]
	, ISNULL(dbo.TC_LOT_CLASSE.L, 0) AS [Tri Qte L]
	, ISNULL(dbo.TC_LOT_CLASSE.A1L, 0) AS [Tri Qte A1L]
	, ISNULL(dbo.TC_LOT_CLASSE.M, 0) AS [Tri Qte M]
	, ISNULL(dbo.TC_LOT_CLASSE.EMe, 0) AS [Tri Qte Eme]
	, ISNULL(dbo.TC_LOT_CLASSE.Rsh, 0) AS [Tri Qte Rsh]
	, ISNULL(dbo.TC_LOT_CLASSE.P_22_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_21_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_21_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_21_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_21_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_21_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_20_8, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_20_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_20_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_20_2, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_20_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_19_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_19_6, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_19_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_19_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_19_0, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_18_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_18_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_18_4, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_18_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_18_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_17_8, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_17_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_17_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_17_2, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_17_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_16_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_16_6, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_16_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_16_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_16_0, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_15_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_15_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_15_4, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_15_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_15_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_14_8, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_14_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_14_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_14_2, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_14_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_13_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_13_6, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_13_4, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_13_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_13_0, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_12_8, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_12_6, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_12_4, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_12_2, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_12_0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_0], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_6], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_0], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-11_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ak, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Aj, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_Ai, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ah, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ag, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_Af, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ae, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ad, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_Ac, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Ab, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Aa, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_A0, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_A1, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_A2, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_A3, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_B, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_C, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_D, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_E, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_F, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_G, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_H, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_I, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_J, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_K, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_L, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_A1L, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_M, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_EMe, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.P_Rsh, 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Idk, 0)
					  + ISNULL(dbo.TC_LOT_CLASSE.P_Div, 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_2], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_6], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_8], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_2], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_8], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_2], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_8], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_2], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_4], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_8], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_2], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_4], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_8], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_2], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_8], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_2], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_6], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_8], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_2], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_4], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_6], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_8], 0) 
                      + ISNULL(dbo.TC_LOT_CLASSE.[P_L-20_0], 0) 
					  + ISNULL(dbo.TC_LOT_CLASSE.[P_L-20_2], 0) 
							AS [Tri Puiss W]
	, ISNULL(dbo.TC_LOT_CLASSE.P_22_0, 0) AS [Tri Puiss 22_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_21_8, 0) AS [Tri Puiss 21_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_21_6, 0) AS [Tri Puiss 21_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_21_4, 0) AS [Tri Puiss 21_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_21_2, 0) AS [Tri Puiss 21_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_21_0, 0) AS [Tri Puiss 21_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_20_8, 0) AS [Tri Puiss 20_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_20_6, 0) AS [Tri Puiss 20_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_20_4, 0) AS [Tri Puiss 20_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_20_2, 0) AS [Tri Puiss 20_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_20_0, 0) AS [Tri Puiss 20_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_19_8, 0) AS [Tri Puiss 19_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_19_6, 0) AS [Tri Puiss 19_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_19_4, 0) AS [Tri Puiss 19_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_19_2, 0) AS [Tri Puiss 19_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_19_0, 0) AS [Tri Puiss 19_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_18_8, 0) AS [Tri Puiss 18_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_18_6, 0) AS [Tri Puiss 18_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_18_4, 0) AS [Tri Puiss 18_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_18_2, 0) AS [Tri Puiss 18_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_18_0, 0) AS [Tri Puiss 18_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_17_8, 0) AS [Tri Puiss 17_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_17_6, 0) AS [Tri Puiss 17_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_17_4, 0) AS [Tri Puiss 17_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_17_2, 0) AS [Tri Puiss 17_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_17_0, 0) AS [Tri Puiss 17_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_16_8, 0) AS [Tri Puiss 16_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_16_6, 0) AS [Tri Puiss 16_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_16_4, 0) AS [Tri Puiss 16_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_16_2, 0) AS [Tri Puiss 16_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_16_0, 0) AS [Tri Puiss 16_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_15_8, 0) AS [Tri Puiss 15_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_15_6, 0) AS [Tri Puiss 15_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_15_4, 0) AS [Tri Puiss 15_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_15_2, 0) AS [Tri Puiss 15_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_15_0, 0) AS [Tri Puiss 15_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_14_8, 0) AS [Tri Puiss 14_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_14_6, 0) AS [Tri Puiss 14_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_14_4, 0) AS [Tri Puiss 14_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_14_2, 0) AS [Tri Puiss 14_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_14_0, 0) AS [Tri Puiss 14_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_13_8, 0) AS [Tri Puiss 13_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_13_6, 0) AS [Tri Puiss 13_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_13_4, 0) AS [Tri Puiss 13_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_13_2, 0) AS [Tri Puiss 13_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_13_0, 0) AS [Tri Puiss 13_0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_12_8, 0) AS [Tri Puiss 12_8]
	, ISNULL(dbo.TC_LOT_CLASSE.P_12_6, 0) AS [Tri Puiss 12_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_12_4, 0) AS [Tri Puiss 12_4]
	, ISNULL(dbo.TC_LOT_CLASSE.P_12_2, 0) AS [Tri Puiss 12_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_12_0, 0) AS [Tri Puiss 12_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_0], 0) AS [Tri Puiss L-18_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_0], 0) AS [Tri Puiss L-17_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_0], 0) AS [Tri Puiss L-16_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_6], 0) AS [Tri Puiss L-15_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_0], 0) AS [Tri Puiss L-14_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_6], 0) AS [Tri Puiss L-13_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_0], 0) AS [Tri Puiss L-12_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-11_6], 0) AS [Tri Puiss L-11_6]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Al, 0) AS [Tri Puiss Al]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ak, 0) AS [Tri Puiss Ak]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Aj, 0) AS [Tri Puiss Aj]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ai, 0) AS [Tri Puiss Ai]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ah, 0) AS [Tri Puiss Ah]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ag, 0) AS [Tri Puiss Ag]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Af, 0) AS [Tri Puiss Af]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ae, 0) AS [Tri Puiss Ae]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ad, 0) AS [Tri Puiss Ad]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ac, 0) AS [Tri Puiss Ac]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Ab, 0) AS [Tri Puiss Ab]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Aa, 0) AS [Tri Puiss Aa]
	, ISNULL(dbo.TC_LOT_CLASSE.P_A0, 0) AS [Tri Puiss A0]
	, ISNULL(dbo.TC_LOT_CLASSE.P_A1, 0) AS [Tri Puiss A1]
	, ISNULL(dbo.TC_LOT_CLASSE.P_A2, 0) AS [Tri Puiss A2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_A3, 0) AS [Tri Puiss A3]
	, ISNULL(dbo.TC_LOT_CLASSE.P_B, 0) AS [Tri Puiss B]
	, ISNULL(dbo.TC_LOT_CLASSE.P_C, 0)  AS [Tri Puiss C]
	, ISNULL(dbo.TC_LOT_CLASSE.P_D, 0) AS [Tri Puiss D]
	, ISNULL(dbo.TC_LOT_CLASSE.P_E, 0) AS [Tri Puiss E]
	, ISNULL(dbo.TC_LOT_CLASSE.P_F, 0) AS [Tri Puiss F]
	, ISNULL(dbo.TC_LOT_CLASSE.P_G, 0) AS [Tri Puiss G]
	, ISNULL(dbo.TC_LOT_CLASSE.P_H, 0)  AS [Tri Puiss H]
	, ISNULL(dbo.TC_LOT_CLASSE.P_I, 0) AS [Tri Puiss I]
	, ISNULL(dbo.TC_LOT_CLASSE.P_J, 0) AS [Tri Puiss J]
	, ISNULL(dbo.TC_LOT_CLASSE.P_K, 0) AS [Tri Puiss K]
	, ISNULL(dbo.TC_LOT_CLASSE.P_L, 0) AS [Tri Puiss L]
	, ISNULL(dbo.TC_LOT_CLASSE.P_A1L, 0) AS [Tri Puiss A1L]
	, ISNULL(dbo.TC_LOT_CLASSE.P_M, 0) AS [Tri Puiss M]
	, ISNULL(dbo.TC_LOT_CLASSE.P_EMe, 0) AS [Tri Puiss Eme]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Rsh, 0) AS [Tri Puiss Rsh]
	, dbo.VL_TRI_STAT.NomFic AS [Tri Fichier]
	, dbo.VL_TRI_STAT.DateFic AS [Tri Date Heure Fichier]
	, dbo.VL_TRI_STAT.DateCreat AS [Tri Date Heure Import]
	, dbo.VL_TRI_STAT.DateHeure_min AS [Tri Date Heure Mes Min]
	, dbo.VL_TRI_STAT.DateHeure_max AS [Tri Date Heure Mes Max]
	, dbo.VL_TRI_STAT.Run_ AS [Tri Run]
	, dbo.VL_TRI_STAT.Wafer AS [Tri Wafer Desc]
	, dbo.VL_TRI_STAT.Retri AS [Tri Retri]
	, dbo.VL_TRI_STAT.Voc_med AS [Tri Voc Med]
	, dbo.VL_TRI_STAT.Voc_moy AS [Tri Voc Moy]
	, dbo.VL_TRI_STAT.Voc_ect AS [Tri Voc Ect]
	, dbo.VL_TRI_STAT.Voc_ectr AS [Tri Voc Ectr]
	, dbo.VL_TRI_STAT.Voc_min AS [Tri Voc Min]
	, dbo.VL_TRI_STAT.Voc_max AS [Tri Voc Max]
	, dbo.VL_TRI_STAT.Voc_ampl AS [Tri Voc Ampl]
	, dbo.VL_TRI_STAT.Isc_med AS [Tri Isc Med]
	, dbo.VL_TRI_STAT.Isc_moy AS [Tri Isc Moy]
	, dbo.VL_TRI_STAT.Isc_ect AS [Tri Isc Ect]
	, dbo.VL_TRI_STAT.Isc_ectr AS [Tri Isc Ectr]
	, dbo.VL_TRI_STAT.Isc_min AS [Tri Isc Min]
	, dbo.VL_TRI_STAT.Isc_max AS [Tri Isc Max]
	, dbo.VL_TRI_STAT.Isc_ampl AS [Tri Isc Ampl]
	, dbo.VL_TRI_STAT.Vmax_med AS [Tri Vmax Med]
	, dbo.VL_TRI_STAT.Vmax_moy AS [Tri Vmax Moy]
	, dbo.VL_TRI_STAT.Vmax_ect AS [Tri Vmax Ect]
	, dbo.VL_TRI_STAT.Vmax_ectr AS [Tri Vmax Ectr]
	, dbo.VL_TRI_STAT.Vmax_min AS [Tri Vmax Min]
	, dbo.VL_TRI_STAT.Vmax_max AS [Tri Vmax Max]
	, dbo.VL_TRI_STAT.Vmax_ampl AS [Tri Vmax Ampl]
	, dbo.VL_TRI_STAT.Imax_med AS [Tri Imax Med]
	, dbo.VL_TRI_STAT.Imax_moy AS [Tri Imax Moy]
	, dbo.VL_TRI_STAT.Imax_ect AS [Tri Imax Ect]
	, dbo.VL_TRI_STAT.Imax_ectr AS [Tri Imax Ectr]
	, dbo.VL_TRI_STAT.Imax_min AS [Tri Imax Min]
	, dbo.VL_TRI_STAT.Imax_max AS [Tri Imax Max]
	, dbo.VL_TRI_STAT.Imax_ampl AS [Tri Imax Ampl]
	, dbo.VL_TRI_STAT.Pmax_med AS [Tri Pmax Med]
	, dbo.VL_TRI_STAT.Pmax_moy AS [Tri Pmax Moy]
	, dbo.VL_TRI_STAT.Pmax_ect AS [Tri Pmax Ect]
	, dbo.VL_TRI_STAT.Pmax_ectr AS [Tri Pmax Ectr]
	, dbo.VL_TRI_STAT.Pmax_min AS [Tri Pmax Min]
	, dbo.VL_TRI_STAT.Pmax_max AS [Tri Pmax Max]
	, dbo.VL_TRI_STAT.Pmax_ampl AS [Tri Pmax Ampl]
	, dbo.VL_TRI_STAT.FF_med AS [Tri FF Med]
	, dbo.VL_TRI_STAT.FF_moy AS [Tri FF Moy]
	, dbo.VL_TRI_STAT.FF_ect AS [Tri FF Ect]
	, dbo.VL_TRI_STAT.FF_ectr AS [Tri FF Ectr]
	, dbo.VL_TRI_STAT.FF_min AS [Tri FF Min]
	, dbo.VL_TRI_STAT.FF_max AS [Tri FF Max]
	, dbo.VL_TRI_STAT.FF_ampl AS [Tri FF Ampl]
	, dbo.VL_TRI_STAT.Rend_med AS [Tri Rend Med]
	, dbo.VL_TRI_STAT.Rend_moy AS [Tri Rend Moy]
	, dbo.VL_TRI_STAT.Rend_ect AS [Tri Rend Ect]
	, dbo.VL_TRI_STAT.Rend_ectr AS [Tri Rend Ectr]
	, dbo.VL_TRI_STAT.Rend_min AS [Tri Rend Min]
	, dbo.VL_TRI_STAT.Rend_max AS [Tri Rend Max]
	, dbo.VL_TRI_STAT.Rend_ampl AS [Tri Rend Ampl]
	, dbo.VL_TRI_STAT.Rs_med AS [Tri Rs Med]
	, dbo.VL_TRI_STAT.Rs_moy AS [Tri Rs Moy]
	, dbo.VL_TRI_STAT.Rs_ect AS [Tri Rs Ect]
	, dbo.VL_TRI_STAT.Rs_ectr AS [Tri Rs Ectr]
	, dbo.VL_TRI_STAT.Rs_min AS [Tri Rs Min]
	, dbo.VL_TRI_STAT.Rs_max AS [Tri Rs Max]
	, dbo.VL_TRI_STAT.Rs_ampl AS [Tri Rs Ampl]
	, dbo.VL_TRI_STAT.Rsh_med AS [Tri Rsh Med]
	, dbo.VL_TRI_STAT.Rsh_moy AS [Tri Rsh Moy]
	, dbo.VL_TRI_STAT.Rsh_ect AS [Tri Rsh Ect]
	, dbo.VL_TRI_STAT.Rsh_ectr AS [Tri Rsh Ectr]
	, dbo.VL_TRI_STAT.Rsh_min AS [Tri Rsh Min]
	, dbo.VL_TRI_STAT.Rsh_max AS [Tri Rsh Max]
	, dbo.VL_TRI_STAT.Rsh_ampl AS [Tri Rsh Ampl]
	, dbo.VL_TRI_STAT.I@Vref_med AS [Tri I@Vref Med]
	, dbo.VL_TRI_STAT.I@Vref_moy AS [Tri I@Vref Moy]
	, dbo.VL_TRI_STAT.I@Vref_ect AS [Tri I@Vref Ect]
	, dbo.VL_TRI_STAT.I@Vref_ectr AS [Tri I@Vref Ectr]
	, dbo.VL_TRI_STAT.I@Vref_min AS [Tri I@Vref Min]
	, dbo.VL_TRI_STAT.I@Vref_max AS [Tri I@Vref Max]
	, dbo.VL_TRI_STAT.I@Vref_ampl AS [Tri I@Vref Ampl]
	, dbo.VL_TRI_STAT.Irrad_med AS [Tri Irrad Med]
	, dbo.VL_TRI_STAT.Irrad_moy AS [Tri Irrad Moy]
	, dbo.VL_TRI_STAT.Irrad_ect AS [Tri Irrad Ect]
	, dbo.VL_TRI_STAT.Irrad_ectr AS [Tri Irrad Ectr]
	, dbo.VL_TRI_STAT.Irrad_min AS [Tri Irrad Min]
	, dbo.VL_TRI_STAT.Irrad_max AS [Tri Irrad Max]
	, dbo.VL_TRI_STAT.Irrad_ampl AS [Tri Irrad Ampl]
	, dbo.VL_TRI_STAT.IrrDev_med AS [Tri IrrDev Med]
	, dbo.VL_TRI_STAT.IrrDev_moy AS [Tri IrrDev Moy]
	, dbo.VL_TRI_STAT.IrrDev_ect AS [Tri IrrDev Ect]
	, dbo.VL_TRI_STAT.IrrDev_ectr AS [Tri IrrDev Ectr]
	, dbo.VL_TRI_STAT.IrrDev_min AS [Tri IrrDev Min]
	, dbo.VL_TRI_STAT.IrrDev_max AS [Tri IrrDev Max]
	, dbo.VL_TRI_STAT.IrrDev_ampl AS [Tri IrrDev Ampl]
	, dbo.VL_TRI_STAT.[T°mon_med] AS [Tri T°mon Med]
	, dbo.VL_TRI_STAT.[T°mon_moy] AS [Tri T°mon Moy]
	, dbo.VL_TRI_STAT.[T°mon_ect] AS [Tri T°mon Ect]
	, dbo.VL_TRI_STAT.[T°mon_ectr] AS [Tri T°mon Ectr]
	, dbo.VL_TRI_STAT.[T°mon_min] AS [Tri T°mon Min]
	, dbo.VL_TRI_STAT.[T°mon_max] AS [Tri T°mon Max]
	, dbo.VL_TRI_STAT.[T°mon_ampl] AS [Tri T°mon Ampl]
	, dbo.VL_TRI_STAT.[T°cell_med] AS [Tri T°cell Med]
	, dbo.VL_TRI_STAT.[T°cell_moy] AS [Tri T°cell Moy]
	, dbo.VL_TRI_STAT.[T°cell_ect] AS [Tri T°cell Ect]
	, dbo.VL_TRI_STAT.[T°cell_ectr] AS [Tri T°cell Ectr]
	, dbo.VL_TRI_STAT.[T°cell_min] AS [Tri T°cell Min]
	, dbo.VL_TRI_STAT.[T°cell_max] AS [Tri T°cell Max]
	, dbo.VL_TRI_STAT.[T°cell_ampl] AS [Tri T°cell Ampl]
	, dbo.VL_TRI_STAT.CoeffI_med AS [Tri CoeffI Med]
	, dbo.VL_TRI_STAT.CoeffI_moy AS [Tri CoeffI Moy]
	, dbo.VL_TRI_STAT.CoeffI_ect AS [Tri CoeffI Ect]
	, dbo.VL_TRI_STAT.CoeffI_ectr AS [Tri CoeffI Ectr]
	, dbo.VL_TRI_STAT.CoeffI_min AS [Tri CoeffI Min]
	, dbo.VL_TRI_STAT.CoeffI_max AS [Tri CoeffI Max]
	, dbo.VL_TRI_STAT.CoeffI_ampl AS [Tri CoeffI Ampl]
	, dbo.VL_TRI_STAT.CoeffV_med AS [Tri CoeffV Med]
	, dbo.VL_TRI_STAT.CoeffV_moy AS [Tri CoeffV Moy]
	, dbo.VL_TRI_STAT.CoeffV_ect AS [Tri CoeffV Ect]
	, dbo.VL_TRI_STAT.CoeffV_ectr AS [Tri CoeffV Ectr]
	, dbo.VL_TRI_STAT.CoeffV_min AS [Tri CoeffV Min]
	, dbo.VL_TRI_STAT.CoeffV_max AS [Tri CoeffV Max]
	, dbo.VL_TRI_STAT.CoeffV_ampl AS [Tri CoeffV Ampl]
	, dbo.VL_TRI_STAT.CoeffP_med AS [Tri CoeffP Med]
	, dbo.VL_TRI_STAT.CoeffP_moy AS [Tri CoeffP Moy]
	, dbo.VL_TRI_STAT.CoeffP_ect AS [Tri CoeffP Ect]
	, dbo.VL_TRI_STAT.CoeffP_ectr AS [Tri CoeffP Ectr]
	, dbo.VL_TRI_STAT.CoeffP_min AS [Tri CoeffP Min]
	, dbo.VL_TRI_STAT.CoeffP_max AS [Tri CoeffP Max]
	, dbo.VL_TRI_STAT.CoeffP_ampl AS [Tri CoeffP Ampl]
    -- V2.5.0 - Début AJOUT
	, dbo.VL_TRI_STAT.IDK_med AS [Tri IDK Med]
	, dbo.VL_TRI_STAT.IDK_moy AS [Tri IDK Moy]
	, dbo.VL_TRI_STAT.IDK_ect AS [Tri IDK Ect]
	, dbo.VL_TRI_STAT.IDK_ectr AS [Tri IDK Ectr]
	, dbo.VL_TRI_STAT.IDK_min AS [Tri IDK Min]
	, dbo.VL_TRI_STAT.IDK_max AS [Tri IDK Max]
	, dbo.VL_TRI_STAT.IDK_ampl AS [Tri IDK Ampl]
    -- V2.5.0 - Fin AJOUT
	, T_LOT_1.RejEquipCasseChgtTextu AS [Textu Rej Eq Casse Chgt]
	, T_LOT_1.RejEquipCasseDechgtTextu AS [Textu Rej Eq Casse Dechgt]
	, GETDATE() AS [Exe Date Heure]
	, T_LOT_1.NomRejParamMeP AS [MeP Rej Param Nom]
	, T_LOT_1.RejParamMeP AS [MeP Rej Param Qte]
	, T_LOT_1.NomRejParamTextu AS [Textu Rej Param Nom]
	, T_LOT_1.RejParamTextu AS [Textu Rej Param Qte]
	, T_LOT_1.ObsVenteTextu AS [Textu Vente Observ]
	, ISNULL(T_LOT_1.QteVenteTextu, 0) AS [Textu Vente Qte]
	, T_LOT_1.NomRejParamDiffu AS [Diff Rej Param Nom]
	, T_LOT_1.RejParamDiffu AS [Diff Rej Param Qte]
	, T_LOT_1.ObsVenteDiffu AS [Diff Vente Observ]
	, ISNULL(T_LOT_1.QteVenteDiffu, 0) AS [Diff Vente Qte]
	, T_LOT_1.NomRejParamDesox AS [Desox Rej Param Nom]
	, T_LOT_1.RejParamDesox AS [Desox Rej Param Qte]
	, T_LOT_1.ObsVenteDesox AS [Desox Vente Observ]
	, ISNULL(T_LOT_1.QteVenteDesox, 0)  AS [Desox Vente Qte]
	, T_LOT_1.NomRejParamPecvd AS [Pecvd Rej Param Nom]
	, T_LOT_1.RejParamPecvd AS [Pecvd Rej Param Qte]
	, T_LOT_1.ObsVentePecvd AS [Pecvd Vente Observ]
	, ISNULL(T_LOT_1.QteVentePecvd, 0) AS [Pecvd Vente Qte]
	, T_LOT_1.NomRejParamSerig AS [Seri Rej Param Nom]
	, T_LOT_1.RejParamSerig AS [Seri Rej Param Qte]
	, T_LOT_1.ObsVenteSerig AS [Seri Vente Observ]
	, ISNULL(T_LOT_1.QteVenteSerig, 0) AS [Seri Vente Qte]
	, T_LOT_1.NomRejParamTri AS [Tri Rej Param Nom]
	, T_LOT_1.RejParamTri AS [Tri Rej Param Qte]
	, T_LOT_1.RejEquipMecaMCTri AS [Tri Rej Eq Meca MC]
	, T_LOT_1.RejEquipMecaGeomTri AS [Tri Rej Eq Meca Geom]
	, T_LOT_1.RejEquipMecaDivTri AS [Tri Rej Eq Meca Div]
	, ISNULL(dbo.TC_LOT_CLASSE.Idk, 0) AS [Tri Qte Idk]
	, ISNULL(dbo.TC_LOT_CLASSE.Div, 0) AS [Tri Qte Div]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-12_2], 0) AS [Tri Qte L-12_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-12_4], 0) AS [Tri Qte L-12_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-12_6], 0) AS [Tri Qte L-12_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-12_8], 0) AS [Tri Qte L-12_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-13_0], 0) AS [Tri Qte L-13_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-13_2], 0) AS [Tri Qte L-13_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-13_4], 0) AS [Tri Qte L-13_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-13_8], 0) AS [Tri Qte L-13_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-14_2], 0) AS [Tri Qte L-14_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-14_4], 0) AS [Tri Qte L-14_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-14_6], 0) AS [Tri Qte L-14_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-14_8], 0) AS [Tri Qte L-14_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-15_0], 0) AS [Tri Qte L-15_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-15_2], 0) AS [Tri Qte L-15_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-15_4], 0) AS [Tri Qte L-15_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-15_8], 0) AS [Tri Qte L-15_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-16_2], 0) AS [Tri Qte L-16_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-16_4], 0) AS [Tri Qte L-16_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-16_6], 0) AS [Tri Qte L-16_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-16_8], 0) AS [Tri Qte L-16_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-17_2], 0) AS [Tri Qte L-17_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-17_4], 0) AS [Tri Qte L-17_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-17_6], 0) AS [Tri Qte L-17_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-17_8], 0) AS [Tri Qte L-17_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-18_2], 0) AS [Tri Qte L-18_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-18_4], 0) AS [Tri Qte L-18_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-18_6], 0) AS [Tri Qte L-18_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-18_8], 0) AS [Tri Qte L-18_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-19_0], 0) AS [Tri Qte L-19_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-19_2], 0) AS [Tri Qte L-19_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-19_4], 0) AS [Tri Qte L-19_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-19_6], 0) AS [Tri Qte L-19_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-19_8], 0) AS [Tri Qte L-19_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-20_0], 0) AS [Tri Qte L-20_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[L-20_2], 0) AS [Tri Qte L-20_2]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Idk, 0) AS [Tri Puiss Idk]
	, ISNULL(dbo.TC_LOT_CLASSE.P_Div, 0) AS [Tri Puiss Div]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_2], 0) AS [Tri Puiss L-12_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_4], 0) AS [Tri Puiss L-12_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_6], 0) AS [Tri Puiss L-12_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-12_8], 0) AS [Tri Puiss L-12_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_0], 0) AS [Tri Puiss L-13_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_2], 0) AS [Tri Puiss L-13_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_4], 0) AS [Tri Puiss L-13_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-13_8], 0) AS [Tri Puiss L-13_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_2], 0) AS [Tri Puiss L-14_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_4], 0) AS [Tri Puiss L-14_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_6], 0) AS [Tri Puiss L-14_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-14_8], 0) AS [Tri Puiss L-14_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_0], 0) AS [Tri Puiss L-15_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_2], 0) AS [Tri Puiss L-15_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_4], 0) AS [Tri Puiss L-15_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-15_8], 0) AS [Tri Puiss L-15_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_2], 0) AS [Tri Puiss L-16_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_4], 0) AS [Tri Puiss L-16_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_6], 0) AS [Tri Puiss L-16_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-16_8], 0) AS [Tri Puiss L-16_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_2], 0) AS [Tri Puiss L-17_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_4], 0) AS [Tri Puiss L-17_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_6], 0) AS [Tri Puiss L-17_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-17_8], 0) AS [Tri Puiss L-17_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_2], 0) AS [Tri Puiss L-18_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_4], 0) AS [Tri Puiss L-18_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_6], 0) AS [Tri Puiss L-18_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-18_8], 0) AS [Tri Puiss L-18_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_0], 0) AS [Tri Puiss L-19_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_2], 0) AS [Tri Puiss L-19_2]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_4], 0) AS [Tri Puiss L-19_4]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_6], 0) AS [Tri Puiss L-19_6]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-19_8], 0) AS [Tri Puiss L-19_8]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-20_0], 0) AS [Tri Puiss L-20_0]
	, ISNULL(dbo.TC_LOT_CLASSE.[P_L-20_2], 0) AS [Tri Puiss L-20_2]
	, T_LOT_1.RejEquipDoublTextu	AS [Textu Rej Eq Doubl]
    , T_LOT_1.RejEquipEpaisTextu    AS [Textu Rej Eq Epais]
    
    -------------------------------------------------------------------------------------
    -- Champs atelier initial et final pour projet transitique --------------------------
    -------------------------------------------------------------------------------------
    
    ,T_LOT_1.IdAtelierInitial AS [IdAtelierInitial]
    ,T_LOT_1.IdAtelierFinal AS [IdAtelierFinal]
    
    ,CASE WHEN T_LOT_1.IdAtelierInitial = 1 
			THEN 'EDF ENR PWT' 
			ELSE 'PV Alliance' 
				END AS Atelier_Initial
				
    ,CASE WHEN T_LOT_1.IdAtelierFinal = 1 
			THEN 'EDF ENR PWT' 
			ELSE 'PV Alliance' 
				END AS Atelier_Final
		
	-------------------------------------------------------------------------------------
	-- Nouveaux champs V_Lots In Cell Line pour reporting SAS - 04/04/2014 --------------
	-------------------------------------------------------------------------------------	
	
	,0 AS [PECVD_OnOffLine]
	,dbo.T_LOT_CELL_INLINE.[PECVD_DateHeureDebutCycle] AS [PECVD_DateHeureDebutCycle]
	,dbo.T_LOT_CELL_INLINE.[PECVD_DateHeureFinCycle] AS [PECVD_DateHeureFinCycle]
	,dbo.T_LOT_CELL_INLINE.[PECVD_QuantiteEntree] AS [PECVD_QuantiteEntreeMach]
	,dbo.T_LOT_CELL_INLINE.[PECVD_QuantiteSortie] AS [PECVD_QuantiteSortieMach]
	,dbo.T_LOT_CELL_INLINE.[PECVD_QuantiteRejets] AS [PECVD_QuantiteRejetMach]
		
	,0 AS [SERIG_OnOffLine]
	,dbo.T_LOT_CELL_INLINE.[SERIG_DateHeureDebutCycle] AS [SERIG_DateHeureDebutCycle]
	,dbo.T_LOT_CELL_INLINE.[SERIG_DateHeureFinCycle] AS [SERIG_DateHeureFinCycle]
	,dbo.T_LOT_CELL_INLINE.[SERIG_QuantiteEntree] AS [SERIG_QuantiteEntreeMach]
	,dbo.T_LOT_CELL_INLINE.[SERIG_QuantiteSortie] AS [SERIG_QuantiteSortieMach]
	,dbo.T_LOT_CELL_INLINE.[SERIG_QuantiteRejets] AS [SERIG_QuantiteRejetMach]
	
	,0 AS [TRI_OnOffLine]
	,dbo.T_LOT_CELL_INLINE.[TRI_DateHeureDebutCycle] AS [TRI_DateHeureDebutCycle]
	,dbo.T_LOT_CELL_INLINE.[TRI_DateHeureFinCycle] AS [TRI_DateHeureFinCycle]
	,dbo.T_LOT_CELL_INLINE.[TRI_QuantiteEntree] AS [TRI_QuantiteEntreeMach]
	,dbo.T_LOT_CELL_INLINE.[TRI_QuantiteSortie] AS [TRI_QuantiteSortieMach]
	,dbo.T_LOT_CELL_INLINE.[TRI_QuantiteRejets] AS [TRI_QuantiteRejetMach]
	
		--------------------------------------------------------------------------------------
		-- Nouveaux champs V_Lots pour reporting SAS restant à implémenter -------------------
		--------------------------------------------------------------------------------------
		,0 AS [PECVD_QuantiteManqMach]
		,0 AS [PECVD_QuantiteRejetOper]
		,0 AS [SERIG_QuantiteManqMach]
		,0 AS [SERIG_QuantiteRejetOper]
		,0 AS [TRI_QuantiteManqMach]
		,0 AS [TRI_QuantiteRejetOper]
		--------------------------------------------------------------------------------------
		
	--------------------------------------------------------------------------------------------
	-- Champs dimensionnels pour Alexandre Rivier pour faciliter la gestion des dates dans les TCD 
	--------------------------------------------------------------------------------------------
		,DatePart(YEAR,T_LOT_1.DateDebPosteSortTri) AS [Tri Date Poste Annee]

		,Case DatePart(QUARTER,T_LOT_1.DateDebPosteSortTri) 
			WHEN 1 THEN '1 - Trimestre n° 1'
			WHEN 2 THEN '2 - Trimestre n° 2'
			WHEN 3 THEN '3 - Trimestre n° 3'
			WHEN 4 THEN '4 - Trimestre n° 4'
			END AS [Tri Date Poste Trimestre]
		
		,Case DatePart(month,T_LOT_1.DateDebPosteSortTri)
			WHEN 1 THEN '01 - Janvier'
			WHEN 2 THEN '02 - Février'
			WHEN 3 THEN '03 - Mars'
			WHEN 4 THEN '04 - Avril'
			WHEN 5 THEN '05 - Mai'
			WHEN 6 THEN '06 - Juin'
			WHEN 7 THEN '07 - Juillet'
			WHEN 8 THEN '08 - Août'
			WHEN 9 THEN '09 - Septembre'
			WHEN 10 THEN '10 - Octobre' 
			WHEN 11 THEN '11 - Novembre'
			WHEN 12 THEN '12 - Décembre'
			END AS [Tri Date Poste Mois]
		
		,Convert(Varchar(15),
					'Semaine n° ' 
					+ Convert(Varchar(2),Case Len(DatePart(WEEK,T_LOT_1.DateDebPosteSortTri)) WHEN 1 THEN '0' ELSE '' END)
					+ Convert(Varchar(2),DatePart(WEEK,T_LOT_1.DateDebPosteSortTri))) AS [Tri Date Poste Semaine]
 
		,Case DatePart(WEEKDAY,T_LOT_1.DateDebPosteSortTri)
			WHEN 1 THEN '01 - Lundi'
			WHEN 2 THEN '02 - Mardi'
			WHEN 3 THEN '03 - Mercredi'
			WHEN 4 THEN '04 - Jeudi'
			WHEN 5 THEN '05 - Vendredi'
			WHEN 6 THEN '06 - Samedi'
			WHEN 7 THEN '07 - Dimanche'
			END AS [Tri Date Poste Jour semaine]
		
		,DatePart(DAY,T_LOT_1.DateDebPosteSortTri) AS [Tri Date Poste Jour]
		
	--------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------	
				
FROM         

					  dbo.T_Statut AS T_Statut_2 
					  RIGHT OUTER JOIN dbo.T_Statut AS T_Statut_6 
					  RIGHT OUTER JOIN dbo.T_Machine 
					  RIGHT OUTER JOIN dbo.T_Statut 
					  RIGHT OUTER JOIN dbo.T_LOT AS T_LOT_1 
							ON dbo.T_Statut.Id = T_LOT_1.IdStatutMeG 
							ON dbo.T_Machine.Id = T_LOT_1.IdMachineMeG 
					  LEFT OUTER JOIN dbo.T_LOT 
					  INNER JOIN dbo.T_LOT_GROUPE 
							ON dbo.T_LOT.IdLot = dbo.T_LOT_GROUPE.IdGroupLot 
							ON T_LOT_1.IdLot = dbo.T_LOT_GROUPE.IdSousLot 
					  LEFT OUTER JOIN dbo.VL_TRI_STAT 
							ON T_LOT_1.IdLot = dbo.VL_TRI_STAT.IdLot 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_8 
							ON T_LOT_1.IdOperMeG = T_Operateur_8.Id 
					  LEFT OUTER JOIN dbo.T_ProfilCuisson 
							ON T_LOT_1.IdProfilCuissonSerig = dbo.T_ProfilCuisson.Id 
					  LEFT OUTER JOIN dbo.V_LOT_GROUPE_COUNT 
							ON T_LOT_1.IdLot = dbo.V_LOT_GROUPE_COUNT.GroupLot 
					  LEFT OUTER JOIN dbo.T_Nacelle 
							ON T_LOT_1.IdNacellePecvd = dbo.T_Nacelle.Id 
					  LEFT OUTER JOIN dbo.T_TypeSi 
							ON T_LOT_1.IdTypeSi = dbo.T_TypeSi.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_7 
							ON T_LOT_1.IdStatut = T_Statut_7.Id 
					  LEFT OUTER JOIN dbo.T_Recette AS T_Recette_2 
							ON T_LOT_1.IdRecetteVision = T_Recette_2.Id 
					  LEFT OUTER JOIN dbo.T_Recette AS T_Recette_1 
							ON T_LOT_1.IdRecetteCTH = T_Recette_1.Id 
					  LEFT OUTER JOIN dbo.T_Tube AS T_Tube_1 
							ON T_LOT_1.IdTubePecvd = T_Tube_1.Id 
					  LEFT OUTER JOIN dbo.T_Recette 
							ON T_LOT_1.IdRecetteDiffu = dbo.T_Recette.Id 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_6 
							ON T_LOT_1.IdMachineTri = T_Machine_6.Id 
							ON T_Statut_6.Id = T_LOT_1.IdStatutTri 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_5 
							ON T_LOT_1.IdMachineSerig = T_Machine_5.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_5 
							ON T_LOT_1.IdStatutSerig = T_Statut_5.Id 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_4 
							ON T_LOT_1.IdMachinePecvd = T_Machine_4.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_4 
							ON T_LOT_1.IdStatutPecvd = T_Statut_4.Id 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_3 
							ON T_LOT_1.IdMachineDesox = T_Machine_3.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_3 
							ON T_LOT_1.IdStatutDesox = T_Statut_3.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_1 
							ON T_LOT_1.IdOperTextu = T_Operateur_1.Id 
							ON T_Statut_2.Id = T_LOT_1.IdStatutDiffu 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_1 
							ON T_LOT_1.IdMachineTextu = T_Machine_1.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_1 
							ON T_LOT_1.IdStatutTextu = T_Statut_1.Id 
					  LEFT OUTER JOIN dbo.T_Format 
							ON T_LOT_1.IdFormat = dbo.T_Format.Id 
					  LEFT OUTER JOIN dbo.T_Fournisseur 
							ON T_LOT_1.IdFourn = dbo.T_Fournisseur.Id 
					  LEFT OUTER JOIN dbo.T_Statut AS T_Statut_8 
							ON T_LOT_1.IdStatutMeP = T_Statut_8.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_7 
							ON T_LOT_1.IdOperMeP = T_Operateur_7.Id 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_7 
							ON T_LOT_1.IdMachineMeP = T_Machine_7.Id 
					  LEFT OUTER JOIN dbo.T_GradeSi 
							ON T_LOT_1.IdGradeSi = dbo.T_GradeSi.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_2 
							ON T_LOT_1.IdOperDiffu = T_Operateur_2.Id 
					  LEFT OUTER JOIN dbo.T_Materiau 
							ON T_LOT_1.IdMateriau = dbo.T_Materiau.Id 
					  LEFT OUTER JOIN dbo.T_Machine AS T_Machine_2 
							ON T_LOT_1.IdMachineDiffu = T_Machine_2.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_3 
							ON T_LOT_1.IdOperDesox = T_Operateur_3.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_4 
							ON T_LOT_1.IdOperPecvd = T_Operateur_4.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_5 
							ON T_LOT_1.IdOperSerig = T_Operateur_5.Id 
					  LEFT OUTER JOIN
							dbo.T_Forme ON T_LOT_1.IdForme = dbo.T_Forme.Id 
					  LEFT OUTER JOIN dbo.T_Operateur AS T_Operateur_6 
							ON T_LOT_1.IdOperTri = T_Operateur_6.Id 
					  LEFT OUTER JOIN dbo.T_Tube 
							ON T_LOT_1.IdTubeDiffu = dbo.T_Tube.Id 
					  LEFT OUTER JOIN dbo.T_Nacelle AS T_Nacelle_1 
							ON T_LOT_1.IdNacelleDiffu = T_Nacelle_1.Id 
					  LEFT OUTER JOIN dbo.TC_LOT_CLASSE 
							ON T_LOT_1.IdLot = dbo.TC_LOT_CLASSE.IdLot 
					  LEFT OUTER JOIN dbo.T_LOT_CELL_INLINE 
							ON T_LOT_1.idLot = dbo.T_LOT_CELL_INLINE.idLot
					  	CROSS APPLY dbo.GetAssemblages (T_LOT_1.IdLot) AS Ass
					  	CROSS APPLY dbo.GetLingots (T_LOT_1.IdLot) AS Lin
					  	
ORDER BY [Mep Date Heure Entr] DESC



GO

