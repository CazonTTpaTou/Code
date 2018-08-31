--SET STATISTICS TIME ON
SELECT "VR"."IdModule" ,"VR"."NumModule" ,"VR"."DateHeureEntr" ,"VR"."Diagnostic" ,"VR"."DateHeureSort" ,"TR"."IdPDP" ,"TR"."IdPDPArticle"  FROM "dbo"."VR_NumModule_Liste_CtrlMod" "VR","dbo"."TR_Module" "TR" WHERE ("VR"."IdModule" = "TR"."Id" ) ORDER BY "VR"."IdModuleEtape"  DESC,"VR"."IdModule"  DESC 
SELECT 1  FROM "dbo"."TR_Module" 
SELECT [Id],[IdEtape],[IdStatut] FROM [dbo].[TR_ModuleEtape] WHERE [IdEtape]=60
SELECT "Id" ,"IdEtape" ,"IdOperateur"  FROM "dbo"."TR_ModuleEtape" WHERE ("IdEtape" = 140 ) 
SELECT "Id" ,"IdEtape" ,"DateHeureSort"  FROM "dbo"."TR_ModuleEtape" WHERE ("IdEtape" = 150 ) 
SELECT "Id" ,"IdDiagGlobal" ,"IdPalette"  FROM "dbo"."TR_Module" 
SELECT "IdPalette" ,"IdTest"  FROM "dbo"."TR_Module" 
SELECT "IdModule" ,"IdModuleEtape" ,"DateHeureEntr" ,"Diagnostic"  FROM "dbo"."VR_NumModule_Liste_VisuMod" "VR" WHERE ((NOT(("IdModuleEtape" IS NULL ) ) AND NOT(("IdModule" = 174370 ) ) ) AND ("Diagnostic" IS NULL ) ) 
SELECT "IdModule" ,"NumModule" ,"IdModuleEtape" ,"DateHeureEntr" ,"Diagnostic" ,"DateHeureSort"  FROM "dbo"."VR_NumModule_Liste_VisuMod" 

/*

base copiée non solicité données chaudes (4 executions, retenue la dernière)

(1570 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 858 ms, temps écoulé = 864 ms.

(173591 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 327 ms, temps écoulé = 469 ms.

(49264 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 375 ms, temps écoulé = 761 ms.

(51032 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 359 ms, temps écoulé = 638 ms.

(170214 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 109 ms, temps écoulé = 1495 ms.

(173591 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 62 ms, temps écoulé = 1524 ms.

(173591 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 141 ms, temps écoulé = 717 ms.

(0 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 514 ms, temps écoulé = 523 ms.

(1995 ligne(s) affectée(s))
 SQL Server \endash Temps d'exécution : Temps UC = 515 ms, temps écoulé = 514 ms.

*/

