USE [GMAO_DB]
GO

/****** Object:  View [dbo].[SAS_Table_Faits_Capacite_Prod]    Script Date: 11/27/2014 17:55:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










ALTER VIEW [dbo].[SAS_Table_Faits_Capacite_Prod]
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
),

DO_Non_Regroupe 
AS 
(SELECT  
		
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
	   --coalesce(CTN.Duree_Impact_SSE,0) as [Impact_Sous_Equipement],
	   
	   24*60-coalesce(CTN.Duree_Impact_EQ,0) as [TBF_Equipement],
	   coalesce(CTN.Duree_Impact_EQ,0) as [Impact_Equipement],
	   
	   24*60-coalesce(CTN.Duree_Impact_Procede,0) as [TBF_Procede],
	   coalesce(CTN.Duree_Impact_Procede,0) as [Impact_Procede],
	   
	   24*60-coalesce(CTN.Duree_Impact_Secteur,0) as [TBF_Secteur],
	   coalesce(CTN.Duree_Impact_Secteur,0) as [Impact_Secteur],
	   
	   24*60-coalesce(CTN.Duree_Impact_UAP,0) as [TBF_UAP],
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
											
		getdate() AS Date_Rafraichissement																							
															  
FROM 

	(select V.DateJour,E.idEquipement
	    FROM Vue_Calendrier as V,Equipement as E
	    /*Where E.Actif =-1*/
	    ) as VE

left outer join 

		Date_Impact_Jour as CTN
			on VE.DateJour = CTN.DateJour
			and VE.idEquipement = CTN.ITV_ID

left outer join
		Vue_Filtre_Realisation AS VFR
			on CTN.REF_Arret = VFR.idIntervention)

SELECT  

	Code_Date,
	Code_Emplacement,
	1440 AS Temps_Ouverture,
	CASE WHEN SUM(Impact_Equipement)<=1440 THEN 1440-SUM(Impact_Equipement) ELSE 0 END AS TBF_Equipement,
	CASE WHEN SUM(Impact_Procede)<=1440 THEN 1440-SUM(Impact_Procede) ELSE 0 END AS TBF_Procede,
	CASE WHEN SUM(Impact_Secteur)<=1440 THEN 1440-SUM(Impact_Secteur) ELSE 0 END TBF_Secteur,
	CASE WHEN SUM(Impact_UAP)<=1440 THEN 1440-SUM(Impact_UAP) ELSE 0 END AS TBF_UAP,
	Max(Date_Rafraichissement) AS Date_Rafraichissement
	
FROM 

	DO_Non_Regroupe

GROUP BY Code_Date,
         Code_Emplacement


GO


