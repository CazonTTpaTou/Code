-- SELECT * FROM sys.dm_db_missing_index_details WHERE database_id = DB_ID()
-- 15 demandes, 6 index mutualisés créés

CREATE INDEX IX_20160321_SQLpro_ModuleChargComp_IdChargComp_I_IdModule
   ON [SQM_DB].[dbo].[TR_ModuleChargComp] ([IdChargComp]) INCLUDE ([IdModule])
   WITH (FILLFACTOR = 80);
GO

CREATE INDEX IX_20160321_SQLpro_PaletteEtape_IdEtape_IdStatut_I_IdPalette_DateHeureSort
   ON [SQM_DB].[dbo].[TR_PaletteEtape] ([IdEtape], [IdStatut])
      INCLUDE ([IdPalette], [DateHeureSort])
   WITH (FILLFACTOR = 80);
GO

CREATE INDEX IX_20160321_SQLpro_TR_Module_IdGamme_I_Id_Pm_IdMilieu
   ON [SQM_DB].[dbo].[TR_Module] ([IdGamme])
      INCLUDE ([Id], [Pm], [IdMilieu])
   WITH (FILLFACTOR = 80);
GO

CREATE INDEX IX_20160321_SQLpro_TR_Module_IdPalette_I_IdDiagGlobal_IdArticle
   ON [SQM_DB].[dbo].[TR_Module] ([IdPalette])
      INCLUDE ([IdDiagGlobal], [IdArticle])
   WITH (FILLFACTOR = 80);
GO

CREATE INDEX IX_20160321_SQLpro_TR_ModuleEtape_IdEtape_IdStatut_I_Id_IdModule_DateHeureEntr_DateHeureSort
   ON [SQM_DB].[dbo].[TR_ModuleEtape] ([IdEtape], [IdStatut])
      INCLUDE ([Id], [IdModule], [DateHeureEntr], [DateHeureSort])
   WITH (FILLFACTOR = 80);
GO

CREATE INDEX IX_20160321_SQLpro_TR_ModuleEtape_IdEtape_Id_I_IdStatut
   ON [SQM_DB].[dbo].[TR_ModuleEtape] ([IdEtape], [Id])
      INCLUDE (	[IdStatut])
   WITH (FILLFACTOR = 80);
GO










