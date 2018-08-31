/*
Détails de l'index absent de SQLQuery44.sql - SRV-SASSQL\SASSQLPROD.DTM (sassql (59))
Le processeur de requêtes estime que l'implémentation de l'index suivant peut améliorer le coût de requête de 47.8848%.
*/

/*
USE [DTM]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [DTM_PUR].[DTM_PUR_COMMANDES_LIGNES] ([Type])
INCLUDE ([PO],[PO_Date],[DA_CER],[DateLivPrev],[DateLivConf],[DateLivMaj],[Date_LastRec])
GO
*/
