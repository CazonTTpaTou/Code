-- correction du modèle : ajout des contraintes de validation pour chronologie

ALTER TABLE [dbo].[Realisation]
   ADD CONSTRAINT CK_Realisation_CHRONOLOGIE_Arret
   CHECK ([DebutArret] <= [FinArret]);
GO

ALTER TABLE [dbo].[Realisation]
   ADD CONSTRAINT CK_Realisation_CHRONOLOGIE_Inter
   CHECK ([DebutInter] <= [FinInter]);
GO