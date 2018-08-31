USE [GMAO_DB]
GO

/****** Object:  View [dbo].[SAS_Table_Faits_Plan_Maintenance]    Script Date: 10/23/2014 15:53:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[SAS_Table_Faits_Plan_Maintenance]

AS

-- Table rassemblant les n° d'équipement ayant un plan de maintenance
-- Si un sous équipement a un plan de maintenance, on considère que l'équipement a un plan de maintenance

WITH FP_Equipement
AS
(Select 
		idEquipement AS id_EQ_FP,
		COUNT(idEquipement) AS Nb_Preventif
		
	FROM FichePreventive
	-- Where coalesce(idSousEnsemble,0) = 0
	Group BY idEquipement),

------------------------------------------------------
FP_Sous_Equipement 
AS 
(Select 
	idSousEnsemble AS id_EQ_FP,
	COUNT(idEquipement) AS Nb_Preventif
		FROM FichePreventive	
		Group BY idSousEnsemble),		
------------------------------------------------------
Plan_Equipement AS
(SELECT  

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
	   
	   Coalesce(FP.Nb_Preventif,0) AS [Nombre_Preventif],
	   
	   GETDATE() as Date_Rafraichissement
	   	   
	FROM
	
	Equipement as EQ 
			left outer join FP_Equipement  as FP
		             ON EQ.idEquipement = FP.id_EQ_FP),
------------------------------------------------------		             
Plan_Sous_Equipement AS

(SELECT  

		CAST(EQ.idEquipement as varchar(19))
		+'-'
		+CAST(EQ.idEquipement as varchar(19)) 
												as Code_Emplacement,

	   EQ.idSousEnsemble as [Code Equipement],
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
	   
	   Coalesce(FP.Nb_Preventif,0) AS [Nombre_Preventif],
	   
	   GETDATE() as Date_Rafraichissement
	   	   
	FROM
	
	SousEnsemble as EQ 
			left outer join FP_Equipement  as FP
		             ON EQ.idSousEnsemble = FP.id_EQ_FP)		             

	SELECT * from Plan_Equipement
	UNION
	SELECT * from Plan_Sous_Equipement

GO





