/****** Script de la commande SelectTopNRows à partir de SSMS  ******/
Use GMAO_DB;
DELETE FROM [dbo].[FiltreIntervention] 
WHERE idUtilisateur = 20 and FiltreActif = 0;
GO

Update [dbo].[FiltreIntervention] SET FiltreActif = -1
Where idFiltreInter = 557;
GO

