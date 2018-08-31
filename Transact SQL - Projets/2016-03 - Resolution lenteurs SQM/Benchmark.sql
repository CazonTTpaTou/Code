SET STATISTICS TIME ON
SELECT "VR"."IdModule" ,"VR"."NumModule" ,"VR"."DateHeureEntr" ,"VR"."Diagnostic" ,"VR"."DateHeureSort" ,"TR"."IdPDP" ,"TR"."IdPDPArticle"  FROM "dbo"."VR_NumModule_Liste_CtrlMod" "VR","dbo"."TR_Module" "TR" WHERE ("VR"."IdModule" = "TR"."Id" ) ORDER BY "VR"."IdModuleEtape"  DESC,"VR"."IdModule"  DESC 
SELECT 1  FROM "dbo"."TR_Module" 
SELECT [Id],[IdEtape],[IdStatut] FROM [dbo].[TR_ModuleEtape] WHERE [IdEtape]=60
SELECT "Id" ,"IdEtape" ,"IdOperateur"  FROM "dbo"."TR_ModuleEtape" WHERE ("IdEtape" = 140 ) 
SELECT "Id" ,"IdEtape" ,"DateHeureSort"  FROM "dbo"."TR_ModuleEtape" WHERE ("IdEtape" = 150 ) 
SELECT "Id" ,"IdDiagGlobal" ,"IdPalette"  FROM "dbo"."TR_Module" 
SELECT "IdPalette" ,"IdTest"  FROM "dbo"."TR_Module" 
SELECT "IdModule" ,"IdModuleEtape" ,"DateHeureEntr" ,"Diagnostic"  FROM "dbo"."VR_NumModule_Liste_VisuMod" "VR" WHERE ((NOT(("IdModuleEtape" IS NULL ) ) AND NOT(("IdModule" = 174370 ) ) ) AND ("Diagnostic" IS NULL ) ) 
SELECT "IdModule" ,"NumModule" ,"IdModuleEtape" ,"DateHeureEntr" ,"Diagnostic" ,"DateHeureSort"  FROM "dbo"."VR_NumModule_Liste_VisuMod" 


