WITH 
Tampon_0 AS
			(Select 
					PO,Type,PO_Date,DateLivConf,DateLivMaj,DateLivPrev,Date_LastRec,Status,
					convert(Int,DA_CER) AS [Num_DA_Numerique]
							FROM [DTM].[DTM_PUR].[DTM_PUR_COMMANDES_LIGNES]
							Where coalesce(DA_CER,'')<>'' AND Type like 'DA' AND left(DA_CER,1) like'0'),
Tampon AS 
			(SELECT 

					PO AS [Num_Commande],
					Type AS [Type_Commande],
					[Num_DA_Numerique],

					Min(PO_Date) AS [Date_Commande],

					CASE 
						 WHEN coalesce(Min([DateLivConf]),0) <> 0 THEN Min([DateLivConf])
						 WHEN coalesce(Min([DateLivMaj]),0) <> 0 THEN Min([DateLivMaj])
						 WHEN coalesce(Min([DateLivPrev]),0) <> 0 THEN Min([DateLivPrev])
					END AS Date_Livraison_Estim,

					Min(DateLivConf) AS [Date_Livraison],

					Min([DateLivConf]) AS [Date_Liv_Conf],
					Min([DateLivMaj]) AS [Date_Liv_Maj],
					Min([Date_LastRec]) AS [Date_Last_REC]
				
							FROM Tampon_0	  	  	  
							GROUP BY PO,[Num_DA_Numerique],Type),
Tampon_2 AS

			(Select 
					Num_DA_Numerique,
					Status,
					Row_Number() Over(Partition BY Num_DA_Numerique ORDER BY Status DESC) AS Numero
	  
							FROM Tampon_0						
							GROUP BY Num_DA_Numerique,Status)

SELECT 
			 TAMPON.* ,
			 TAMPON_2.Status AS Statut

				FROM TAMPON
			
				LEFT OUTER JOIN TAMPON_2
				ON Tampon.Num_DA_Numerique = Tampon_2.Num_DA_Numerique
			
				WHERE Tampon_2.Numero=1;
	  
GO


	  
	  --17511



