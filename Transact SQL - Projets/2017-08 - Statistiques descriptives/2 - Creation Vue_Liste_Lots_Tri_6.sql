USE [SQC_DB]
GO

/****** Object:  View [dbo].[VUE_LISTE_LOTS_TRI_6]    Script Date: 31/08/2017 12:15:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VUE_LISTE_LOTS_TRI_6]
AS 
	Select Lot,idLot 
	FROM T_Lot 
	Where idMachineTri = 95;
GO


