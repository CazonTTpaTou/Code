USE [GMAO_DB]
GO
/****** Object:  View [dbo].[SAS_Dimension_Demandeur]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Demandeur]
AS

SELECT 

	idUtilisateur [Code_Demandeur],
	UPPER(login) as [Nom_Demandeur],
	Actif AS [Actif_Demandeur],
	Ordre as [Ordre_Demandeur]
	
	FROM

	dbo.GD_utilisateur
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Suivi_DI_Pondere]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Suivi_DI_Pondere]
AS
SELECT 

		CONVERT(Varchar(8),ST.Code_Intervention)
		+ '-' 
		+ CONVERT(Varchar(8),
							ROW_NUMBER() 
							OVER(PARTITION BY ST.CODE_INTERVENTION ORDER BY ST.CODE_INTERVENTION)) 
												AS SurrogateKey,
		1.00/
			(COUNT(ST.Code_Intervention) 
							OVER (PARTITION BY ST.Code_Intervention))
												AS Poids_Pondere,
		ST.* 
		
	FROM dbo.SAS_Table_Faits_Suivi_Domaine as ST

	--ORDER BY SurrogateKey
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Efficacite_Prev]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Efficacite_Prev]
AS
SELECT  
		DatePart(yyyy,MEP.Date_Prev) *10000
		+DatePart(mm,MEP.Date_Prev) * 100
		+DatePart(dd,MEP.Date_Prev)*1
		as Code_Date,

	   FP.idFichePreventive as [Code_Preventif],
	   FP.idTypePlanification as [Code_Type_Preventif],
	   FP.Actif as [Code_Actif],
	   
	   CAST(FP.idEquipement as varchar(10))
			+'-'+cast(coalesce(FP.idSousEnsemble,0) as varchar(10)) as Code_Emplacement,
		
   		--MEP.DatePrevision,
   		--MEP.[date],	
		MEP.Ecart_Date_PREV_Date_PEC,
		--MEP.Ecart_Date_PREV_Date_Cloture,
		
		MEP.Frequence_Empirique,
		MEP.Frequence_Theorique,
		-- MEP.Ecart_Frequence_theorique_Reelle,
		
		-- Mesures à considérer pour le cube GMAO correspondant
		MEP.[Date_Previsionnelle],
		MEP.[Date_Creation_Intervention],
		MEP.[Date_Cloture_Intervention],
		MEP.[Ecart_Previsionnel-Reel] AS [Ecart_Constate],
		
		/* Hors_scope_20 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*20/100)   THEN 1
            ELSE 0 END) AS [Ecart >= 20%], 
          /* Hors_scope_30 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*30/100)   THEN 1
            ELSE 0 END) AS [Ecart >= 30%], 
          /* Hors_scope_40 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*40/100)   THEN 1
            ELSE 0 END) AS [Ecart >= 40%], 
          /* Hors_scope_50 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*50/100)   THEN 1
            ELSE 0 END) AS [Ecart >= 50%], 
          /* Dans_scope_20 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*20/100)   THEN 0
            ELSE 1 END) AS [Ecart < 20%], 
          /* Dans_scope_30 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*30/100)   THEN 0
            ELSE 1 END) AS [Ecart < 30%], 
          /* Dans_scope_40 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*40/100)   THEN 0
            ELSE 1 END) AS [Ecart < 40%], 
          /* Dans_scope_50 */
            (CASE WHEN MEP.[Ecart_Previsionnel-Reel] >= (MEP.[Frequence_Theorique]*50/100)   THEN 0
            ELSE 1 END) AS [Ecart < 50%],
		
	    GETDATE() as Date_Actualisation
  	   
	FROM
	
		FichePreventive  as FP
		
		inner join SAS_Mesures_Efficacite_Preventif as MEP
		on FP.idFichePreventive = MEP.Code_Preventif
GO
/****** Object:  View [dbo].[SAS_Dimension_Emplacement]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Emplacement]
AS
WITH
-------------------------------------------------------------------------------------------
UAP_T
AS (
	SELECT 
			
			UAP.*,
			ROW_NUMBER()
			OVER (ORDER BY Ordre) AS UAP_Tri

			FROM UAP AS UAP),
-------------------------------------------------------------------------------------------
Secteur_T
AS (
	SELECT 

			SEC.*,
			ROW_NUMBER()
			OVER (ORDER BY UAP_T.UAP_Tri,SEC.Ordre) AS Secteur_Tri

			FROM Secteur AS SEC
			INNER JOIN UAP_T 
			ON SEC.idUAP = UAP_T.idUAP),
-------------------------------------------------------------------------------------------
Procede_T
AS (
	SELECT
			
			PROCE.*,
			ROW_NUMBER()
			OVER (ORDER BY Secteur_T.Secteur_Tri,PROCE.Ordre) AS Procede_Tri

			FROM Procede AS PROCE
			INNER JOIN Secteur_T
			ON PROCE.idSecteur = Secteur_T.idSecteur),						
-------------------------------------------------------------------------------------------

Equipement_Trie AS
(SELECT 
	idEquipement AS idEquipement,
	ROW_NUMBER() 
			Over(order by coalesce(UAP.Ordre,32000) ASC,
						  coalesce(Secteur.Ordre,32000) ASC,
						  coalesce(Procede.Ordre,32000) ASC,
						  coalesce(Equipement.Ordre,32000) ASC) AS TRIE
			 
			FROM UAP
			
					inner join Secteur
					on UAP.idUAP = Secteur.idUAP
					inner join Procede
					on Secteur.idSecteur = Procede.idSecteur
					inner join Equipement
					on Procede.idProcede = Equipement.idProcede),

-------------------------------------------------------------------------------------------

Liste_Equipement as
(
SELECT  
	
		
		cast(Equipement.idEquipement as varchar(10))
		+'-0' as Code_Emplacement,
		
		UAP.libelle as [Unite],
		
		Secteur.Libelle as [Secteur],
		
		Procede.Libelle as [Procede],
		
		Equipement.Libelle as [Equipement],
		
		NULL as [Sous_Equipement],
		
		--------------------------------------------
		
		UAP.idUAP as ID1,
		Secteur.idSecteur as ID2,
		Procede.idProcede as ID3,
		Equipement.idEquipement as ID4,
		0 as ID5,
		
		---------------------------------------
			
		UAP.Ordre AS OrdreUAP,
		Secteur.Ordre AS OrdreSecteur,
		Procede.Ordre AS OrdreProcede,		
		Equipement.Ordre AS OrdreEquipement,
		
		0 AS OrdreSousEquipement,
		
		ROW_NUMBER() 
			Over(order by UAP.Ordre ASC,
						  Secteur.Ordre ASC,
						  Procede.Ordre ASC,
						  Equipement.Ordre ASC) AS ORDRE_EQUIPEMENT,
		
		NULL AS ORDRE_SOUS_EQUIPEMENT,		
			
		Equipement.Actif as Actif
				
		FROM UAP
		inner join Secteur
		on UAP.idUAP = Secteur.idUAP
		inner join Procede
		on Secteur.idSecteur = Procede.idSecteur
		inner join Equipement
		on Procede.idProcede = Equipement.idProcede

),

-------------------------------------------------------------------------------------------

Liste_Sous_Equipement 
AS (
	SELECT  
		
		
		cast(Equipement.idEquipement as varchar(10))
		+'-'+cast(SousEnsemble.idSousEnsemble as varchar(10)) as Code_Emplacement,
		
		UAP.libelle as [Unite],
		
		Secteur.Libelle as [Secteur],
		
		Procede.Libelle as [Procede],
		
		Equipement.Libelle as [Equipement],
		
		--coalesce(
				SousEnsemble.Libelle
		--		+ ' (n° ' 
		--		+ convert(varchar(200),SousEnsemble.idSousEnsemble) 
		--		+ ')' 
		--			,'-') 
								AS [Sous_Equipement],
		
		---------------------------------------------------
		
		UAP.idUAP as ID1,
		Secteur.idSecteur as ID2,
		Procede.idProcede as ID3,
		Equipement.idEquipement as ID4,
		SousEnsemble.idSousEnsemble as ID5,
		
		---------------------------------------------------
		
		ROW_NUMBER() 
			Over(order by coalesce(UAP.Ordre,UAP.idUAP)) AS OrdreUAP,
		ROW_NUMBER() 
			Over(order by coalesce(Secteur.Ordre,Secteur.idSecteur)) AS OrdreSecteur,
		ROW_NUMBER() 
			Over(order by coalesce(Procede.Ordre,Procede.idProcede)) AS OrdreProcede,		
		ROW_NUMBER() 
			Over(order by coalesce(Equipement.Ordre,Equipement.idEquipement)) AS OrdreEquipement,
		ROW_NUMBER() 
			Over(order by coalesce(SousEnsemble.Ordre,SousEnsemble.idSousEnsemble)) AS OrdreSousEquipement,
		
		Equipement_Trie.TRIE AS ORDRE_EQUIPEMENT,
		
		ROW_NUMBER() 
			Over(order by UAP.Ordre ASC,
						  Secteur.Ordre ASC,
						  Procede.Ordre ASC,
						  Equipement.Ordre ASC,
						  SousEnsemble.Ordre) AS ORDRE_SOUS_EQUIPEMENT,
		
		----------------------------------------------------------------
		
		SousEnsemble.Actif as Actif
				
		FROM UAP
		inner join Secteur
		on UAP.idUAP = Secteur.idUAP
		inner join Procede
		on Secteur.idSecteur = Procede.idSecteur
		inner join Equipement
		on Procede.idProcede = Equipement.idProcede
		inner join Equipement_Trie
		on Equipement.idEquipement = Equipement_Trie.idEquipement
		inner join SousEnsemble
		on Equipement.idEquipement = SousEnsemble.idEquipement
		
),

-------------------------------------------------------------------------------------------

Liste_GLOBALE
AS (
SELECT  TOP 100 PERCENT * FROM Liste_Equipement
		UNION
SELECT  TOP 100 PERCENT * FROM Liste_Sous_Equipement

--order by ordreUAP,OrdreSecteur,OrdreProcede,OrdreEquipement,OrdreSousEquipement
)

-------------------------------------------------------------------------------------------

SELECT

	Code_Emplacement,
	
	convert(Varchar(10),dbo.Tri_Texte(UAP_T.UAP_Tri)) + ' - ' + LG.Unite AS Unite,
	convert(Varchar(10),dbo.Tri_Texte(Secteur_T.Secteur_Tri)) + ' - ' + LG.Secteur AS Secteur,
	convert(Varchar(10),dbo.Tri_Texte(Procede_T.Procede_Tri)) + ' - ' + LG.Procede AS Procede,
	convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Equipement)) + ' - ' + LG.Equipement AS Equipement,
	convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Sous_Equipement)) + ' - ' + LG.Sous_Equipement AS Sous_Equipement,

	
	-- Unite,
	-- Secteur,
	-- Procede,
	-- Equipement,
	-- Sous_Equipement,
	
	-- OrdreUAP AS Ordre_UAP,
	-- OrdreSecteur AS Ordre_Secteur,
	-- OrdreProcede AS Ordre_Procede,
	-- Ordre_Equipement,
	-- Ordre_Sous_Equipement,
	
	ROW_NUMBER() 
				Over(order by COALESCE(ORDRE_EQUIPEMENT,32000) ASC,
							  COALESCE(ORDRE_SOUS_EQUIPEMENT,0) ASC)
							  
				AS Ordre_Flux_Production,

	ID1 AS [ID1],
	ID2 AS [ID2],
	ID3 AS [ID3],
	ID4 AS [ID4],
	ID5 AS [ID5],

	LG.Actif

	--convert(Varchar(10),dbo.Tri_Texte(UAP_T.UAP_Tri)) + ' - ' + LG.Unite AS Unite_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(Secteur_T.Secteur_Tri)) + ' - ' + LG.Secteur AS Secteur_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(Procede_T.Procede_Tri)) + ' - ' + LG.Procede AS Procede_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Equipement)) + ' - ' + LG.Equipement AS Equipement_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Sous_Equipement)) + ' - ' + LG.Sous_Equipement AS Sous_Equipement_Trie,
	
	--UAP_T.PourcentageDependance/100.00 AS [%_UAP],
	--Secteur_T.PourcentageDependance/100.00 AS [%_Secteur],
	--Procede_T.PourcentageDependance/100.00 AS [%_Procede],
	--Equipement.PourcentageDependance/100.00 AS [%_Equipement],
	--coalesce(SousEnsemble.PourcentageDependance,0)/100.00 AS [%_Sous_Equipement]

FROM Liste_GLOBALE AS LG

	 INNER JOIN UAP_T
	 ON LG.ID1 = UAP_T.idUAP
	 INNER JOIN Secteur_T
	 ON LG.ID2 = Secteur_T.idSecteur
	 INNER JOIN Procede_T
	 ON LG.ID3 = Procede_T.idProcede
	 LEFT OUTER JOIN Equipement
	 ON LG.ID4 = Equipement.idEquipement
	 LEFT OUTER JOIN SousEnsemble
	 ON LG.ID5 = SousEnsemble.idSousEnsemble
GO
/****** Object:  View [dbo].[SAS_Table_Faits_DO_Temps_Arret]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_DO_Temps_Arret]

AS
WITH 
DOE AS
		(SELECT 
			Code_Date,
			Code_Emplacement,
			Temps_Arret AS [Temps_Arret],			
			--DO_Equipement,
			--NULL as DO_Sous_Equipement,
			getDate() AS Date_Actualisation,
			Temps_Ouverture,
			Temps_Bon_Fonctionnement
						
				FROM SAS_Graphique_DO_Equipement),

DOSS AS
		(SELECT 
			Code_Date,
			Code_Emplacement,
			Temps_Arret AS [Temps_Arret],
			--NULL AS DO_Equipement,
			--DO_Sous_Equipement,
			getDate() AS Date_Rafraichissement,
			Temps_Ouverture,
			Temps_Bon_Fonctionnement
			
				FROM SAS_Graphique_DO_Sous_Equipement)
				
SELECT * FROM DOE
UNION
SELECT * FROM DOSS
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Couverture_Maint]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Couverture_Maint]
AS
SELECT  

	   -- FP.idFichePreventive as [Code_Preventif],
	   FP.idTypePlanification as [Code_Type_Preventif],
	   FP.Actif as [Code_Actif],
	   
	   CAST(FP.idEquipement as varchar(10))
			+'-'+cast(coalesce(FP.idSousEnsemble,0) as varchar(10)) as Code_Emplacement,
	   
	   GETDATE() as Date_Actualisation,	 
	   
	   MCM.*
	   	   
	FROM
	 
	FichePreventive  as FP
	inner join SAS_Mesures_Couverture_Maint as MCM
	on FP.idFichePreventive = MCM.Code_Preventif
GO
/****** Object:  View [dbo].[SAS_Dimension_Actif]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Actif]
AS

WITH
Acti AS
(select -1 as Code_Actif,'En activité' as Actif),
NonActi AS
(select 0 as Code_Actif,'Obsolète' as Actif)
--------------------------------------------------
SELECT * FROM Acti
UNION
SELECT * FROM NonActi
GO
/****** Object:  View [dbo].[SAS_Dimension_Type_Preventif]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Type_Preventif]
AS

SELECT 
	idPlanification AS [Code_Type_Planification],
	Libelle AS [Type_planification],
	Actif AS [Actif_Type_Planification],
	Ordre AS [Ordre_Type_Planification]
	
	FROM dbo.TypePlanification
GO
/****** Object:  View [dbo].[SAS_Dimension_Type_Intervention]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Type_Intervention]
AS

SELECT 
	idTypeIntervention AS [Code_Type_Intervention],
	Libelle AS [Type_Intervention],
	Actif AS [Actif_Type_Intervention],
	Ordre AS [Ordre_Type_Intervention]
	
	FROM dbo.TypeIntervention
GO
/****** Object:  View [dbo].[SAS_Dimension_Domaine]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Domaine]
AS

SELECT 

	idDomaine as [Code_Domaine],
	Libelle as [Domaine_Intervention],
	Actif AS [Actif_Domaine],
	Ordre as [Ordre_Domaine]
	
	FROM

	dbo.Domaine
GO
/****** Object:  View [dbo].[SAS_Dimension_Date]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Date]
AS
----------------------------------------------------------------------------------------
With entiers
as
(select (ent.chiffres) as i
	from 
	(select Chiffre as chiffres
		from Serie_Base_10()) as ent),
----------------------------------------------------------------------------------------		
Calendrier as
(select CAST(FLOOR(CAST(dateadd(mm,2,getdate()) AS FLOAT)) AS DATETIME) - chiffre 
as DateJour 
from 
	(select (1000*m.i+100 * c.i + 10*d.i + u.i) as chiffre
	from entiers u
	cross join entiers d
	cross join entiers c
	cross join entiers m) as Base_10

where (dateadd(mm,2,getdate()) - chiffre > dateAdd(yy,-10,getdate()))
And (datediff(day,'2013-10-01 00:00:00.0000000',dateadd(mm,2,getdate()) - chiffre)>=0))
--------------------------------------------------------------------------------------
select TOP 100 PERCENT 

		DateJour,
					DatePart(yyyy,DateJour) *10000
					+DatePart(mm,DateJour) * 100
					+DatePart(dd,DateJour)*1
					as Code_Date,
					
					CAST(DATENAME(year, DateJour) AS int) as Annee,
					 Case 
						When CAST(DATENAME(QUARTER, DateJour) AS INT)< 3 THEN 1
						Else 2
					 END as Num_Semestre
					 
					,CAST(DATENAME(QUARTER, DateJour) AS INT) as Num_Trimestre
					,DATENAME(MONTH, DateJour) as Libelle_Mois
					,CAST(DATENAME(WEEK, DateJour) AS INT) as Num_Semaine    
					,CAST(DATENAME(dayofyear, DateJour)AS INT) as Num_Jour_Annee
					,DATENAME(weekday, DateJour) as Libelle_Jour_Semaine
					,CAST(DATENAME(day, DateJour) AS INT) as Num_JourMois,
					
					DatePart(m,DateJour) as Num_Mois,
					DatePart(dw,DateJour) as Num_Jour_Semaine,
					
					CAST(DATENAME(year, DateJour) AS VARCHAR(4))
					+ ' - '  +
					Case WHEN DatePart(m,DateJour)>9 THEN CAST(DatePart(m,DateJour) AS Varchar(2))
						 ELSE '0' + CAST(DatePart(m,DateJour) AS VARCHAR(2))
						 END
					+ ' - ' + DATENAME(MONTH, DateJour)
																			AS Libelle_Date
					
					 from Calendrier

order by DateJour
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Capacite_Prod]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Capacite_Prod]
AS
WITH Date_Impact
AS
(
SELECT 
		MTAI.REF_Arret,
		MTAI.ITV_ID,
		MTAI.Code_Emplacement,
		MTAI.ITV_DEBUT,
		MTAI.ITV_FIN,
		MTAI.SSE_T_Arret,
		MTAI.EQ_T_Arret,
		
		Secteur.PourcentageDependance as [Pourc_Sect], 
		Procede.PourcentageDependance as [Pourc_Proc],
		Equipement.PourcentageDependance as [Pourc_Equ],
		coalesce(SousEnsemble.PourcentageDependance,0) [Pourc_SSE], 
		
		MTAI.SSE_T_Arret_Impacte as Impact_SSE,
		dateadd(MINUTE,
			(MTAI.SSE_T_Arret_Impacte)*60,
			 MTAI.ITV_DEBUT)
			AS
			dateFin_Impact_SSE,
		dateadd(MINUTE,
			(MTAI.EQ_T_Arret+MTAI.SSE_T_Arret_Impacte)*60,
			 MTAI.ITV_DEBUT)
			AS
			dateFin_Impact_EQ,
		dateadd(MINUTE,
			((MTAI.EQ_T_Arret+MTAI.SSE_T_Arret_Impacte)*60)*(Equipement.PourcentageDependance/100.00),
			 MTAI.ITV_DEBUT)
			AS
			dateFin_Impact_Procede,
		dateadd(MINUTE,
			(MTAI.EQ_T_Arret+MTAI.SSE_T_Arret_Impacte)*60
				*((Equipement.PourcentageDependance*Procede.PourcentageDependance)/10000.00),
			 MTAI.ITV_DEBUT)
			AS
			dateFin_Impact_Secteur,
		dateadd(MINUTE,
			(MTAI.EQ_T_Arret+MTAI.SSE_T_Arret_Impacte)*60*
			((Equipement.PourcentageDependance*Procede.PourcentageDependance
			  *Secteur.PourcentageDependance)/1000000.00),
			 MTAI.ITV_DEBUT)
			AS
			dateFin_Impact_UAP						
		
	FROM Mesure_Temps_Arret_Impacte as MTAI

		INNER JOIN Dimension_Emplacement as DE
		ON MTAI.Code_Emplacement = DE.Code_Emplacement
		INNER JOIN UAP
		ON DE.ID1 = UAP.idUAP
		INNER JOIN Secteur 
		ON DE.ID2 = Secteur.idSecteur
		INNER JOIN Procede
		ON DE.ID3 = Procede.idProcede
		INNER JOIN Equipement
		ON DE.ID4 = Equipement.idEquipement
		LEFT OUTER JOIN SousEnsemble
		ON DE.ID5 = SousEnsemble.idSousEnsemble
),
Date_Impact_Jour
AS
(
SELECT 
		J.*,
		V.*,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.ITV_Fin))) as Duree_Arret,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.dateFin_Impact_SSE))) as Duree_Impact_SSE,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.dateFin_Impact_EQ))) as Duree_Impact_EQ,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.dateFin_Impact_Procede))) as Duree_Impact_Procede,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.dateFin_Impact_Secteur))) as Duree_Impact_Secteur,
		
		DATEDIFF(n,
		dbo.MaxDate(J.DateJour,
			dbo.MinDate(
					dateAdd(day,1,J.DateJour),
					V.ITV_Debut)),
		dbo.MinDate(dateAdd(day,1,J.DateJour),
					dbo.MaxDate(
							J.DateJour,
							V.dateFin_Impact_UAP))) as Duree_Impact_UAP
							
		FROM Vue_Calendrier as J,
		
		Date_Impact  as V
                
         WHERE J.DateJour < V.ITV_Fin 
           and J.DateJour >= 
			   CAST(FLOOR(CAST(V.ITV_Debut AS FLOAT)) AS DATETIME)
)

SELECT  
		
		VE.DateJour as [Date_Du_Jour],
		
		DatePart(yyyy,VE.DateJour) *10000
					+DatePart(mm,VE.DateJour) * 100
					+DatePart(dd,VE.DateJour)*1
					as Code_Date,
			
		DatePart(hh,VE.DateJour) *10000
					+DatePart(n,VE.DateJour) * 100
					+DatePart(ss,VE.DateJour)*1
					as Code_Temps,
																
	   CTN.REF_Arret as [Code_Intervention],
	   cast(VE.idEquipement as varchar(10))
		+'-'+cast(0 as varchar(10)) as [Code_Emplacement],
		
	   24*60 as [Temps_Ouverture],
	   
	   -- 24*60-coalesce(CTN.Duree_Arret,0) as [TBF],
	   
	   --(1.00*coalesce(CTN.Duree_Arret,0)) AS [Arret],
	   
	   --24*60-coalesce(CTN.Duree_Impact_SSE,0) as [TBF_Sous_Equipement],
	   coalesce(CTN.Duree_Impact_SSE,0) as [Impact_Sous_Equipement],
	   
	   -- 24*60-coalesce(CTN.Duree_Impact_EQ,0) as [TBF_Equipement],
	   coalesce(CTN.Duree_Impact_EQ,0) as [Impact_Equipement],
	   
	   --24*60-coalesce(CTN.Duree_Impact_Procede,0) as [TBF_Procede],
	   coalesce(CTN.Duree_Impact_Procede,0) as [Impact_Procede],
	   
	   --24*60-coalesce(CTN.Duree_Impact_Secteur,0) as [TBF_Secteur],
	   coalesce(CTN.Duree_Impact_Secteur,0) as [Impact_Secteur],
	   
	   --24*60-coalesce(CTN.Duree_Impact_UAP,0) as [TBF_UAP],
	   coalesce(CTN.Duree_Impact_UAP,0) as [Impact_UAP],
	   
	    Convert(Decimal(12,6),
							(24.000000*60.000000-coalesce(CTN.Duree_Impact_SSE,0)) 
							/ 1440.000000)
											AS DO_Sous_Equipement,
		Convert(Decimal(12,6),
							(24.000000*60.000000-coalesce(CTN.Duree_Impact_EQ,0)) 
							/ 1440.000000)
											AS DO_Equipement,
		Convert(Decimal(12,6),
							(24.000000*60.000000-coalesce(CTN.Duree_Impact_Procede,0)) 
							/ 1440.000000)
											AS DO_Procede,
		Convert(Decimal(12,6),
							(24.00*60.00-coalesce(CTN.Duree_Impact_Secteur,0)) 
							/ 1440.000000)
											AS DO_Secteur,
		Convert(Decimal(12,6),
							(24.000000*60.000000-coalesce(CTN.Duree_Impact_UAP,0)) 
							/ 1440.000000)
											AS DO_UAP,
											
		VFR.[% Temps Avant Realisation] AS [Ratio_Tps_Avant_Realisation],
		VFR.[% Temps Attente Piece] AS [Ratio_Tps_Attente_Piece],
		VFR.[% Durée Intervention] AS [Ratio_Duree_Intervenant],											
											
		getdate() AS Date_Actualisation																							
															  
FROM 

	(select V.DateJour,E.idEquipement
	    FROM Vue_Calendrier as V,Equipement as E) as VE

left outer join 

		Date_Impact_Jour as CTN
			on VE.DateJour = CTN.DateJour
			and VE.idEquipement = CTN.ITV_ID

left outer join
		Vue_Filtre_Realisation AS VFR
			on CTN.REF_Arret = VFR.idIntervention
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Indicateur_Maint]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Indicateur_Maint]
AS
WITH
Indicateur_Maintenance
AS (
		SELECT 

			 [Code_Date],
			 [Code_Temps],
			 [Code_Intervention],
			 [Code_Emplacement],
			 [Temps_Ouverture],
			 [Temps_Ouverture]-[Impact_Equipement] AS [TBF Brut],
			 [Impact_Equipement] AS [Arret_Brut]

		FROM [SAS_Table_Faits_Capacite_Prod]

			WHERE [Impact_Sous_Equipement] = 0)

SELECT 

TFIM.Code_Emplacement,
DD.Libelle_Date,

SUM(Temps_Ouverture) AS Tps_Ouv,
SUM([TBF Brut]) AS TBF,
SUM([Arret_Brut])/60.000000 AS Arret_Brut,
COUNT(Distinct Code_Intervention) AS NB_Inter,
CONVERT(Decimal(14,6),
						(1.000000*SUM([TBF Brut]))
						/
						((1 + COUNT(Distinct Code_Intervention))*60.000000))
																	AS MTBF_H,
CONVERT(Decimal(14,6),
						(1.000000*SUM([TBF Brut]))
						/
						((1 + COUNT(Distinct Code_Intervention))*24.000000*60.000000))
																	AS MTBF_J,																	
CONVERT(Decimal(14,6),
						(1.000000*SUM([Arret_Brut]))
						/
						((dbo.MaxOrNull(COUNT(Distinct Code_Intervention),1))*60.000000))
																	AS MTTR_H,
CONVERT(Decimal(14,6),
						(1.000000*SUM([Arret_Brut]))
						/
						((dbo.MaxOrNull(COUNT(Distinct Code_Intervention),1))*24.000000*60.000000))
																	AS MTTR_J,
																	
GETDATE() AS Date_Actualisation																																																				
																	
 FROM 
 
		Indicateur_Maintenance AS TFIM
		INNER JOIN dbo.SAS_Dimension_Date AS DD
		ON TFIM.Code_Date = DD.Code_Date

GROUP BY Code_Emplacement,Libelle_Date
GO
/****** Object:  View [dbo].[SAS_Dimension_Compteur]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Compteur]
AS
Select 

	idCompteur as [Code_Compteur],
	Libelle as [Nom_Compteur],
	Ordre as [Ordre_Compteur],
	Actif as [Actif_Compteur],
	Unite as [Unite_Compteur]
	
	FROM dbo.Compteur
GO
/****** Object:  View [dbo].[SAS_Dimension_Temps]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Temps]
AS
----------------------------------------------------------------------------------------
With entiers
as
(select (ent.chiffres) as i
	from 
	(select Chiffre as chiffres
		from Serie_Base_10()) as ent),
----------------------------------------------------------------------------------------		
Calendrier as
(select dateAdd(ss,
	chiffre,
	CAST(FLOOR(CAST(getdate() AS FLOAT)) AS DATETIME)) 
as HeureJour 
FROM 
	(select (10000*dm.i+1000*m.i+100 * c.i + 10*d.i + u.i) as chiffre
	from entiers u
	cross join entiers d
	cross join entiers c
	cross join entiers m
	cross join entiers dm) as Base_10

where  chiffre < 86400)
--------------------------------------------------------------------------------------
select TOP 100 PERCENT 

		HeureJour,
					DatePart(hh,HeureJour) *10000
					+DatePart(mi,HeureJour) * 100
					+DatePart(ss,HeureJour)*1
					as Code_Temps,
					
					 Case 
						When CAST(DATENAME(hh, HeureJour) AS INT)>=6 AND CAST(DATENAME(hh, HeureJour) AS INT)<14 THEN 'Matin' 
						When CAST(DATENAME(hh, HeureJour) AS INT)>=14 AND CAST(DATENAME(hh, HeureJour) AS INT)< 22 THEN 'Après-midi'
						Else 'Nuit'
					 END as Poste,
					 
					CAST(DATENAME(hh, HeureJour) AS INT) as Heure
					,DATENAME(n, HeureJour) as [Minute]
					,CAST(DATENAME(ss, HeureJour) AS INT) as Seconde    
					
					 from Calendrier

order by HeureJour
GO
/****** Object:  View [dbo].[SAS_Dimension_Service]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Service]
AS

SELECT 

	idService as [Code_Service],
	Libelle as [Service],
	Actif AS [Actif_Service],
	Ordre as [Ordre_Service]
	
	FROM

	dbo.Service
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Suivi_Activite]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Suivi_Activite]
AS
SELECT     
			DatePart(yyyy,dbo.Intervention.DateCreation) *10000
					+DatePart(mm,dbo.Intervention.DateCreation) * 100
					+DatePart(dd,dbo.Intervention.DateCreation)*1
					as Code_Date,
			
			DatePart(hh,dbo.Intervention.DateCreation) *10000
					+DatePart(n,dbo.Intervention.DateCreation) * 100
					+DatePart(ss,dbo.Intervention.DateCreation)*1
					as Code_Temps,
			
			Demande.idService as [Code_Service],
			Demande.idUrgence as [Code_Urgence],
			Intervention.idEtat as [Code_Etat_Intervention],
			Intervention.idDetail as [Code_Detail_Intervention],
			Rea.idTypeIntervention as [Code_Type_Intervention],
			Demande.idDemandeur as [Code_Demandeur],
			
			cast(Demande.idEquipement as varchar(10))
			+'-'+cast(coalesce(Demande.idSousEnsemble,0) as varchar(10)) as Code_Emplacement,
			
			-- dbo.Intervention.idIntervention AS [Code_Intervention],
			
			rea.Domaine as [Dimension_domaine],
			
			CASE 
				 WHEN Demande.idUrgence =  1 and Rea.idTypeIntervention = 2 THEN Rea.idTypeIntervention *100 + 1
				 WHEN Demande.idUrgence >  1 and Rea.idTypeIntervention = 2 THEN Rea.idTypeIntervention *100 
				 ELSE Rea.idTypeIntervention *100
				 END AS [Code_Type_Inter_Urgence],
											
		    GETDATE() as Date_Actualisation,		    
				
			MSAT.*
														                      
FROM         
			dbo.Intervention INNER JOIN dbo.Demande 
			ON dbo.Intervention.idDemande = dbo.Demande.idDemande 
			
			inner join Realisation as rea 
			on Intervention.idIntervention = rea.idIntervention
			
			inner join SAS_Mesures_Suivi_Activite as MSAT 
			on Intervention.idIntervention = MSAT.Code_Intervention

WHERE Intervention.idEtat = 7
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Suivi_Actions]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Suivi_Actions]
AS
SELECT     
			DatePart(yyyy,dbo.Intervention.DateCreation) *10000
					+DatePart(mm,dbo.Intervention.DateCreation) * 100
					+DatePart(dd,dbo.Intervention.DateCreation)*1
					as Code_Date,
			
			DatePart(hh,dbo.Intervention.DateCreation) *10000
					+DatePart(n,dbo.Intervention.DateCreation) * 100
					+DatePart(ss,dbo.Intervention.DateCreation)*1
					as Code_Temps,
			
			Demande.idService as [Code_Service],
			Demande.idUrgence as [Code_Urgence],
			Intervention.idEtat as [Code_Etat_Intervention],
			Intervention.idDetail as [Code_Detail_Intervention],
			Rea.idTypeIntervention as [Code_Type_Intervention],
			Demande.idDemandeur as [Code_Demandeur],
			
			cast(Demande.idEquipement as varchar(10))
			+'-'+cast(coalesce(Demande.idSousEnsemble,0) as varchar(10)) as Code_Emplacement,
			
			-- dbo.Intervention.idIntervention AS [Code_Intervention],
			
			rea.Domaine as [Dimension_domaine],
			
			CASE 
				 WHEN Demande.idUrgence =  1 and Rea.idTypeIntervention = 2 THEN Rea.idTypeIntervention *100 + 1
				 WHEN Demande.idUrgence >  1 and Rea.idTypeIntervention = 2 THEN Rea.idTypeIntervention *100 
				 ELSE Rea.idTypeIntervention *100
				 END AS [Code_Type_Inter_Urgence],
														
		    GETDATE() as Date_Actualisation,		    
				
			MSA.*
														                      
FROM         
			dbo.Intervention INNER JOIN dbo.Demande 
			ON dbo.Intervention.idDemande = dbo.Demande.idDemande 
			
			inner join Realisation as rea 
			on Intervention.idIntervention = rea.idIntervention
			
			inner join SAS_Mesures_Suivi_Actions as MSA 
			on Intervention.idIntervention = MSA.Code_Intervention

WHERE Intervention.idEtat = 7
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Releve_Compteur]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Releve_Compteur]
AS

-- Table condensant les emplacements des compteurs à partir des fiches préventives des relevés
WITH Empl_Compteur

AS (
	SELECT CP.idCompteur as [idCompteur],Max(FP.idFichePreventive) as [FichePreventive]
		FROM Compteur as CP
		INNER JOIN ActionMaster as AM
		ON CP.idCompteur = AM.idCompteur
		INNER JOIN FichePreventive as FP
		ON FP.idFichePreventive = AM.idFichePreventive
		
		GROUP BY CP.idCompteur),

-- Table numérotant les numéros de relevé chronologique par nom de compteur		
Releve 
AS(
	SELECT *,
		ROW_NUMBER() OVER (Partition by idCompteur order by DateReleve) as numReleve
			from ReleveCompteur)		
 
--------------------------------------------------------------------------------------
SELECT     
	
			-- Champs de code pour les jonctions avec les tables de dimansion
			DatePart(yyyy,Rel.DateReleve) *10000
					+DatePart(mm,Rel.DateReleve) * 100
					+DatePart(dd,Rel.DateReleve)*1
					as Code_Date,
			
			DatePart(hh,Rel.DateReleve) *10000
					+DatePart(n,Rel.DateReleve) * 100
					+DatePart(ss,Rel.DateReleve)*1
					as Code_Temps,
			
			Rel.idCompteur as [Code_Compteur],
			CP.Actif as [Code_Actif],
			
			cast(FP.idEquipement as varchar(10))
			+'-'+cast(coalesce(FP.idSousEnsemble,0) as varchar(10)) as Code_Emplacement,			
											
		    GETDATE() as Date_Rafraichissement,		
		    
		    -- Champs de mesure et de calcul    	
			MRC.*
														                      
FROM        
			Releve AS Rel
			INNER JOIN Empl_Compteur as EC
			ON Rel.idCompteur = EC.idCompteur
			
			INNER JOIN dbo.SAS_Mesures_Releve_Compteur as MRC
			on Rel.idReleveCompteur = MRC.Code_Releve
			
			INNER JOIN Compteur as CP
			ON Rel.idCompteur = CP.idCompteur
			
			INNER JOIN FichePreventive as FP
			ON EC.FichePreventive = FP.idFichePreventive

-- On ne conserve pas les premiers relevés qui sont des relevés d'initialisation 
WHERE Rel.NumReleve > 1 
	  AND Rel.Consommation >0
GO
/****** Object:  View [dbo].[SAS_Dimension_Intervenant]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Intervenant]
AS

SELECT 

	Intervenant.idIntervenant AS [Code_Intervenant],
	Intervenant.idService AS [Code_Service],
	Service.Libelle AS [Nom_Service],
	Intervenant.Nom AS [Nom_Intervenant],
	Intervenant.Prenom AS [Prenom_Intervenant],
	Intervenant.NomCourt AS [Initiales_Intervenant],
	Intervenant.Actif as [Actif_Intervenant],
	Intervenant.Ordre as [Ordre_Intervenant]
	
FROM

	Intervenant
	INNER JOIN Service
	ON Intervenant.idService = Service.idService
GO
/****** Object:  View [dbo].[SAS_Dimension_Etat_Interv]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Etat_Interv]
AS

SELECT 

	idEtat as [Code_Etat_Intervention],
	Libelle as [Etat_Intervention],
	Actif as [Actif_Etat_Intervention],
	Ordre as [Ordre_Etat_Intervention]
	
	FROM dbo.EtatIntervention
	
-- WHERE Type = 'GMAO'
GO
/****** Object:  View [dbo].[SAS_Dimension_Urgence]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Urgence]
AS

SELECT 
	DU.idUrgence as [Code_Urgence],
	DU.Libelle as [Degre_Urgence],
	DU.Ordre as [Ordre_DegreUrgence],
	Pr.Libelle as [Priorite],
	Pr.ordre as [Ordre_Priorite]
	
	FROM

	DegreUrgence as DU
	INNER JOIN 
	Priorite as Pr
	ON DU.idPriorite = Pr.idPriorite
GO
/****** Object:  View [dbo].[SAS_Dimension_Detail_Intervention]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Detail_Intervention]
AS

SELECT 

	idEtat as [Code_Etat_Intervention],
	Libelle as [Etat_Intervention],
	Actif as [Actif_Etat_Intervention],
	Ordre as [Ordre_Etat_Intervention]
	
	FROM dbo.EtatIntervention
	
-- WHERE Type = 'Utilisateur'
GO
/****** Object:  View [dbo].[SAS_Table_Faits_Plan_Maintenance]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Table_Faits_Plan_Maintenance]

AS

-- Table rassemblant les n° d'équipement ayant un plan de maintenance
-- Si un sous équipement a un plan de maintenance, on considère que l'équipement a un plan de maintenance

WITH FP_Equipement
AS
(Select idEquipement AS id_EQ_FP
	FROM FichePreventive
	-- Where coalesce(idSousEnsemble,0) = 0
	Group BY idEquipement)
	
------------------------------------------------------
SELECT  

		CAST(EQ.idEquipement as varchar(19))
			+'-0' 
				 as Code_Emplacement,

	   EQ.idEquipement as [Code Equipement],
	   EQ.Libelle [Libelle_Equipement],
	   
	   CASE coalesce(FP.id_EQ_FP,0)
			When 0 Then 0
			Else 1
			END
			AS [Plan_Maintenance_Binaire],
			
	   CASE coalesce(FP.id_EQ_FP,0)
			When 0 Then 'Pas de plan de maintenance'
			Else 'Plan de maintenance'
			END
			AS [Plan_Maintenance],
	   
	   GETDATE() as Date_Actualisation
	   	   
	FROM
	
	Equipement as EQ 
			left outer join FP_Equipement  as FP
		             ON EQ.idEquipement = FP.id_EQ_FP
GO
/****** Object:  View [dbo].[SAS_Dimension_Type_Inter_Urgence]    Script Date: 09/26/2014 09:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAS_Dimension_Type_Inter_Urgence]
-- Dimension intégrant le type d'intervention curatif machine arrêtée + machine dégradée selon le degré d'urgence
AS
 WITH Produit_Cartesien
 AS
 (
 SELECT 
		 
		 DU.Code_Urgence *100 + DTI.Code_Type_Intervention as [Code_TI_U],
		 CASE 
		 When DU.Code_Urgence =  1 and DTI.Code_Type_Intervention = 2 THEN DTI.Code_Type_Intervention *100 + 1
		 When DU.Code_Urgence >  1 and DTI.Code_Type_Intervention = 2 THEN DTI.Code_Type_Intervention *100 
		 Else DTI.Code_Type_Intervention *100
		 END AS [Code],
		 
		 CASE 
		 When DU.Code_Urgence =  1 and DTI.Code_Type_Intervention = 2 THEN 'Curatif (machine arrêtée)'
		 When DU.Code_Urgence >  1 and DTI.Code_Type_Intervention = 2 THEN 'Curatif (marche dégradée)'
		 Else DTI.[Type d'intervention]
		 END AS [Libelle],
		 DTI.Actif_Type_Intervention as [Actif],
		 DTI.Ordre_Type_Intervention * 100   + DU.[Ordre_Priorité] as [Ordre]
 
 FROM Dimension_Urgence as DU,Dimension_Type_Intervention as DTI
 WHERE DTI.Actif_Type_Intervention = -1)
 -- ORDER BY ORDRE
 
 SELECT 
	
		PC.[Code],
		PC.[Libelle],
		-- Max(PC.[Actif]) AS [Code_Actif],
		Max(PC.[Ordre]) AS [Ordre]
		
	FROM Produit_Cartesien as PC
 
	GROUP BY PC.[Code],PC.[Libelle]
GO
