USE [GMAO_DB]
GO

/****** Object:  View [dbo].[Mesure_Temps_Arret_Impacte]    Script Date: 09/04/2014 14:43:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[Mesure_Temps_Arret_Impacte]
AS
WITH 

Temps_Equipement AS
(
SELECT 
	
	rea.idIntervention as REF_Arret,
	equ.idEquipement as ITV_ID,
	cast(Equ.idEquipement as varchar(10))
	+'-'+cast(0 as varchar(10)) as Code_Emplacement,
	rea.DebutArret as ITV_DEBUT,
	coalesce(rea.FinArret,getdate()) as ITV_FIN ,
	
	datediff(mi,rea.DebutArret,coalesce(rea.FinArret,getdate()))/60.00 AS EQ_T_Arret,
	(datediff(mi,rea.DebutArret,coalesce(rea.FinArret,getdate()))/60.00) 
		* (equ.PourcentageDependance)/100.00 as EQ_T_Arret_Impacte,
	--rea.TempsArretSaisie as EQ_T_Arret,
	--rea.TempsArretSaisie * (equ.PourcentageDependance)/100.00 as EQ_T_Arret_Impacte,
	
	(equ.PourcentageDependance)/100.00 AS Pourcentage,
	0 as SSE_T_Arret,
	0 as SSE_T_Arret_Impacte
	
	FROM dbo.Realisation as rea
		
	inner join dbo.Intervention as inter
	on rea.idIntervention = inter.idIntervention

	inner join Demande as dem
	on dem.idDemande = inter.idDemande

	inner join dbo.Equipement as Equ
	on dem.idEquipement = Equ.idEquipement

	where not(rea.DebutArret is null) 
	and coalesce(dem.idSousEnsemble,0) = 0),

Temps_Sous_Equipement AS
(
	SELECT
	
	rea.idIntervention as REF_Arret,
	equ.idEquipement as ITV_ID,
	cast(Equ.idEquipement as varchar(10))
	+'-'+cast(Equ.idSousEnsemble as varchar(10)) as Code_Emplacement,
	rea.DebutArret as ITV_DEBUT,
	coalesce(rea.FinArret,getdate()) as ITV_FIN ,
	  
	0 as EQ_T_Arret,
	0 as EQ_T_Arret_Impacte,
	
	(equ.PourcentageDependance)/100.00 as Pourcentage,
	
	datediff(hh,rea.DebutArret,coalesce(rea.FinArret,getdate()))/60.00 AS SSE_T_Arret,
	(datediff(hh,rea.DebutArret,coalesce(rea.FinArret,getdate()))/60.00) 
		* (equ.PourcentageDependance)/100.00 as SSE_T_Arret_Impacte
	-- rea.TempsArretSaisie as SSE_T_Arret,
	-- rea.TempsArretSaisie * (equ.PourcentageDependance)/100.00 as SSE_T_Arret_Impacte
	
	FROM dbo.Realisation as rea
	
	inner join dbo.Intervention as inter
	on rea.idIntervention = inter.idIntervention

	inner join Demande as dem
	on dem.idDemande = inter.idDemande

	inner join dbo.SousEnsemble as Equ
	on dem.idSousEnsemble = Equ.idSousEnsemble
	where not(rea.DebutArret is null) 
	and coalesce(dem.idSousEnsemble,0) <> 0)

SELECT * FROM Temps_Equipement
UNION
SELECT * FROM Temps_Sous_Equipement




GO


