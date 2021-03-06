USE [GMAO_DB]
GO

/****** Object:  View [dbo].[SAS_Dimension_Dependance_DO]    Script Date: 29/03/2017 10:17:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[SAS_Dimension_Dependance_DO]
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
		--		+ ' (n� ' 
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
),

-------------------------------------------------------------------------------------------
Dimension_Triee 
AS(
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
	Ordre_Equipement,
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

	Case(LG.Actif) WHEN -1 THEN 'Actif' ELSE 'Inactif' END AS Actif,

	--convert(Varchar(10),dbo.Tri_Texte(UAP_T.UAP_Tri)) + ' - ' + LG.Unite AS Unite_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(Secteur_T.Secteur_Tri)) + ' - ' + LG.Secteur AS Secteur_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(Procede_T.Procede_Tri)) + ' - ' + LG.Procede AS Procede_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Equipement)) + ' - ' + LG.Equipement AS Equipement_Trie,
	--convert(Varchar(10),dbo.Tri_Texte(LG.Ordre_Sous_Equipement)) + ' - ' + LG.Sous_Equipement AS Sous_Equipement_Trie,
	
	UAP_T.PourcentageDependance/100.00 AS [Dep_UAP],
	Secteur_T.PourcentageDependance/100.00 AS [Dep_Secteur],
	Procede_T.PourcentageDependance/100.00 AS [Dep_Procede],
	Equipement.PourcentageDependance/100.00 AS [Dep_Equipement],
	coalesce(SousEnsemble.PourcentageDependance,0)/100.00 AS [Dep_Sous_Equipement]

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
	 ON LG.ID5 = SousEnsemble.idSousEnsemble)

SELECT 

	Code_Emplacement,

	SDE.Actif,
	SDE.[Unite],
	SDE.Secteur,
	SDE.[Procede],	
	SDE.Equipement,
	coalesce(SDE.Sous_Equipement,
	         convert(varchar(4),
								dbo.Tri_Texte(SDE.Ordre_Equipement)) 
								+ ' - Racine')
																	AS Sous_Equipement,

	SDE.[Dep_UAP],
	SDE.[Dep_Secteur],
	SDE.[Dep_Procede],
	SDE.[Dep_Equipement],
	SDE.[Dep_Sous_Equipement]
																		
	FROM Dimension_Triee AS SDE 


GO


