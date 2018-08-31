USE [GMAO_DEV]
GO

/****** Object:  View [dbo].[Vue_Process_Liste_Intervention]    Script Date: 04/13/2014 20:20:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Vue_Process_Liste_Intervention]
AS
SELECT	

CASE WHEN idTypeDemande = 1
		THEN 'Intervention curative'
		ELSE 'Intervention préventive'
		END
			AS [Type intervention],
			
	[Date] AS [Date de début],
	
	CASE WHEN coalesce(DateCloture,0) = 0
		THEN 'Non terminé'
		ELSE convert(varchar(20),DateCloture,120) 
		END
			AS [Date de fin],
	
	Etat AS [Statut intervention],
	Datediff(day,[Date],convert(datetime,coalesce(DateCloture,GETDATE()))) AS [Durée intervention en j],
	[Unité],
	Secteur,
	Procédé,
	Equipement,
	[Description]


	FROM dbo.Vue_Edition_Liste_Intervention

	WHERE 
		
		datediff(day,coalesce(DateCloture,getdate()),GETDATE())<1
		AND idEtat <> 8
		AND idUAP = 2


GO

