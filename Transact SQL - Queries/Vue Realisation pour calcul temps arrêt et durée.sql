USE _Photowatt_GMAO_DB;
GO

CREATE VIEW dbo.V_Realisation
AS
SELECT idRealisation, 
       idIntervention, 
       idTypeIntervention,
       idDomaine,
       DebutInter, FinInter, 
       DebutArret, CASE WHEN TempsArretSaisie IS NOT NULL 
	                         THEN DATEADD(hour, 
							              TempsArretSaisie, 
										  DebutArret)
						  WHEN FinArret IS NOT NULL  
						     THEN FinArret
					      ELSE GETDATE()
					 END AS FinArret,
       FichierJoint,
       EtatRealisation ,
       Domaine,
       DebutPiece
       FinPiece,
	   COALESCE(TempsArretSaisie, 
	            DATEDIFF(second, 
				         DebutArret, 
						 COALESCE(FinArret, 
				                  GETDATE())) * 3600.0) AS DureeArret
				
FROM   dbo.Realisation;
GO



/*
debut et fin sont : 
1) DebutArret
2) Si TempsArretSaisie NOT NULL, alors DebutArret + TempsArretSaisie (en heures décimales)
   Si TempsArretSaisie NULL, alors FinArret si NOT NULL
   sinon DATEHEURE COURANTE
*/



