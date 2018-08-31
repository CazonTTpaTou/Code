USE _Photowatt_GMAO_DB;
GO

CREATE VIEW dbo.V_Realisation_Timing
AS
SELECT idRealisation, 
       idIntervention, 
       idTypeIntervention,
       idDomaine,
       DebutInter, FinInter, 
       DebutArret, FinArret,
       CASE WHEN TempsArretSaisie IS NOT NULL 
	           THEN DATEADD(hour, TempsArretSaisie, DebutArret)
            WHEN FinArret IS NOT NULL  
			   THEN FinArret
		    ELSE GETDATE()
	   END AS FinArret_CALC,
       FichierJoint,
       EtatRealisation ,
       Domaine,
       DebutPiece
       FinPiece,
	   COALESCE(TempsArretSaisie, 
	            DATEDIFF(second, 
				         DebutArret, 
						 COALESCE(FinArret, 
				                  GETDATE())) / 3600.0) AS DureeArret_CALC
				
FROM   dbo.Realisation;
GO

-- données brutes demande vers timing
CREATE VIEW dbo.V_Demande_Production_Timing
WITH SCHEMABINDING
AS
SELECT SP.STP_ID, D.idDemande, SP.ENT_ID, 
       R.DebutArret, R.FinArret, R.TempsArretSaisie   
FROM   dbo.T_SYSTEME_PRODUCTION_STP AS SP
       JOIN dbo.Demande AS D
	        ON SP.STP_ID = D.STP_ID
       JOIN dbo.Intervention AS I
	        ON D.IdDemande = I.idDemande
	   JOIN dbo.Realisation AS R
	        ON I.idIntervention = R.idIntervention;
GO

CREATE UNIQUE CLUSTERED INDEX XV_Demande_Production_Timing_PK
   ON dbo.V_Demande_Production_Timing (STP_ID, idDemande);
GO
    
-- données calculées demandes vers timing	
CREATE VIEW dbo.V_Demande_Production_Timing_CALC
AS
SELECT STP_ID, idDemande, ENT_ID, 
       DebutArret, 
	   CASE WHEN TempsArretSaisie IS NOT NULL 
	           THEN DATEADD(hour, TempsArretSaisie, DebutArret)
            WHEN FinArret IS NOT NULL  
			   THEN FinArret
		    ELSE GETDATE()
	   END AS FinArret_CALC,
	   COALESCE(TempsArretSaisie, 
	            DATEDIFF(second, 
				         DebutArret, 
						 COALESCE(FinArret, 
				                  GETDATE())) / 3600.0) AS DureeArret_CALC
FROM   dbo.V_Demande_Production_Timing;
GO	 

-- liste des intervalles par équipement et Demande
SELECT * 
FROM   dbo.V_Demande_Production_Timing_CALC
WHERE  DebutArret IS NOT NULL;
GO
--> liste des périodes de rélaisation par système de production avec pourcentage de dépendance
CREATE VIEW dbo.V_Production_Timing_Dependance
AS
SELECT SP.STP_ID, SP.ENT_ID, STP_POURCENT_DEPENDANCE,
       R.DebutArret, CASE WHEN TempsArretSaisie IS NOT NULL 
	           THEN DATEADD(hour, TempsArretSaisie, R.DebutArret)
            WHEN FinArret IS NOT NULL  
			   THEN FinArret
		    ELSE GETDATE()
	   END AS FinArret_CALC   
FROM   dbo.T_SYSTEME_PRODUCTION_STP AS SP
       JOIN dbo.Demande AS D
	        ON SP.STP_ID = D.STP_ID
       JOIN dbo.Intervention AS I
	        ON D.IdDemande = I.idDemande
	   JOIN dbo.Realisation AS R
	        ON I.idIntervention = R.idIntervention
WHERE R.DebutArret IS NOT NULL;
GO

--> agrégation des intervalles
CREATE VIEW dbo.V_Production_Timing_Dependance_Agregate
AS
WITH 
C1 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, DebutArret AS ts, +1 AS genre, NULL AS e,
              ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY DebutArret) AS s
       FROM   dbo.V_Production_Timing_Dependance
       UNION  ALL
       SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, FinArret_CALC AS ts, -1 AS genre, 
              ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY FinArret_CALC) AS e,
              NULL AS s
       FROM dbo.V_Production_Timing_Dependance),
C2 AS (SELECT C1.*, ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY ts, genre DESC) 
                 AS se
       FROM   C1),
C3 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, ts, 
              FLOOR((ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY ts) - 1) / 2 + 1) 
                 AS grpnum
       FROM   C2
       WHERE  COALESCE(s - (se - s) - 1, (se - e) - e) = 0),
C4 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, MIN(ts) AS DebutArret, max(ts) AS FinArret_CALC
       FROM C3
       GROUP BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, grpnum)
SELECT A.STP_ID, A.ENT_ID, A.STP_POURCENT_DEPENDANCE, A.DebutArret, A.FinArret_CALC
FROM   (SELECT DISTINCT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE 
        FROM   dbo.V_Production_Timing_Dependance) AS U
       CROSS APPLY (SELECT *
                    FROM   C4
                    WHERE  STP_ID = U.STP_ID
					  AND  ENT_ID = U.ENT_ID
					  AND  STP_POURCENT_DEPENDANCE = U.STP_POURCENT_DEPENDANCE) AS A;
GO

--> exemple utilisation :
SELECT *, DATEDIFF(second, DebutArret, FinArret_CALC) / 3600.0 AS DureeArret_CALC
FROM   dbo.V_Production_Timing_Dependance_Agregate
ORDER  BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, DebutArret, FinArret_CALC;


--> remonter à l'entité supérieure demandée

CREATE INDEX X_SQLpro_Realisation_DebutArret_InterFinTemps
   ON dbo.Realisation (DebutArret)
   INCLUDE (idIntervention, FinArret, TempsArretSaisie);

CREATE INDEX X_SQLpro_Realisation_FinArret_InterDebTemps
   ON dbo.Realisation (FinArret)
   INCLUDE (idIntervention, DebutArret, TempsArretSaisie);

CREATE INDEX X_SQLpro_Demnde_STP_idDemande
   ON dbo.Demande (STP_ID)
   INCLUDE (idDemande);
GO

--> procédure de calcul des arrêts agrégés à différentss niveaux
ALTER PROCEDURE dbo.P_PLAGE_FONCTIONNEMENT @DEBUT   DATETIME2(0), 
                                           @FIN     DATETIME2(0),
										   @ENT_ID  INT
AS
SET NOCOUNT ON;

/******************************************************************************
* ATTENTION : ne tiens pas encore en compte des calcul de pourcentage d'arrêts
* combinés; par exemple si 2 sous-ensembles d'un même Parc-procédé se recoupent 
* au niveau de l'intervalle d'arrêt, alors il y a 3 périodes dans l'ordre
* chronologique :
*    période 1, sous ensemble 1, pourcentage dépendance A
*    période 2, sous ensemble 1 et 2, pourcentage dépendance A + B
*    période 3, sous ensemble 1, pourcentage dépendance B 
******************************************************************************/

--> requête 1 : info de base
WITH
PTD_ALL AS
(
SELECT SP.STP_ID, STP_ID_PERE, SP.ENT_ID, STP_POURCENT_DEPENDANCE,
       R.DebutArret, CASE WHEN TempsArretSaisie IS NOT NULL 
	           THEN DATEADD(hour, TempsArretSaisie, R.DebutArret)
            WHEN FinArret IS NOT NULL  
			   THEN FinArret
		    ELSE GETDATE()
	   END AS FinArret_CALC   
FROM   dbo.T_SYSTEME_PRODUCTION_STP AS SP
       JOIN dbo.Demande AS D
	        ON SP.STP_ID = D.STP_ID
       JOIN dbo.Intervention AS I
	        ON D.IdDemande = I.idDemande
	   JOIN dbo.Realisation AS R
	        ON I.idIntervention = R.idIntervention
WHERE R.DebutArret IS NOT NULL
)
SELECT *
INTO   #PTD_ALL
FROM   PTD_ALL;

--> requête 2 : limite de temps
SELECT *
INTO   #PTD_LIMITE
FROM   #PTD_ALL
WHERE  FinArret_CALC > COALESCE(@DEBUT, '19000101') 
  AND  DebutArret    < COALESCE(@FIN, '99991231');

CREATE INDEX X1
  ON #PTD_LIMITE (STP_ID_PERE)
  INCLUDE (STP_POURCENT_DEPENDANCE, DebutArret, FinArret_CALC);

--> requête 3 : arbre
WITH
PTD_TREE AS
(
SELECT STP_ID, STP_ID_PERE, ENT_ID, STP_POURCENT_DEPENDANCE,
       DebutArret, FinArret_CALC  
FROM   #PTD_LIMITE AS A
UNION ALL
SELECT STP.STP_ID, STP.STP_ID_PERE, STP.ENT_ID, P.STP_POURCENT_DEPENDANCE,
       P.DebutArret, P.FinArret_CALC
FROM   #PTD_LIMITE AS P
       JOIN dbo.T_SYSTEME_PRODUCTION_STP AS STP 
	        ON P.STP_ID_PERE = STP.STP_ID
)
SELECT *
INTO   #PDT_TREE
FROM   PTD_TREE
WHERE  ENT_ID <= COALESCE(@ENT_ID, 1);

CREATE INDEX X2
  ON #PDT_TREE (STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, DebutArret);

CREATE INDEX X3
  ON #PDT_TREE (STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, FinArret_CALC);

--> requête 4 : agrégat
WITH
PTD AS
(SELECT DISTINCT STP_ID, STP_ID_PERE, ENT_ID, STP_POURCENT_DEPENDANCE,
        DebutArret, FinArret_CALC
 FROM   #PDT_TREE
 WHERE  ENT_ID = COALESCE(@ENT_ID, 1)
),
C1 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, DebutArret AS ts, +1 AS genre, NULL AS e,
              ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY DebutArret) AS s
       FROM   PTD
       UNION  ALL
       SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, FinArret_CALC AS ts, -1 AS genre, 
              ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY FinArret_CALC) AS e,
              NULL AS s
       FROM PTD),
C2 AS (SELECT C1.*, ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY ts, genre DESC) 
                 AS se
       FROM   C1),
C3 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, ts, 
              FLOOR((ROW_NUMBER() OVER(PARTITION BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE ORDER BY ts) - 1) / 2 + 1) 
                 AS grpnum
       FROM   C2
       WHERE  COALESCE(s - (se - s) - 1, (se - e) - e) = 0),
C4 AS (SELECT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, MIN(ts) AS DebutArret, max(ts) AS FinArret_CALC
       FROM C3
       GROUP BY STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE, grpnum),
C5 AS (SELECT A.STP_ID, A.ENT_ID, A.STP_POURCENT_DEPENDANCE, 
              CASE WHEN A.DebutArret    < @DEBUT THEN @DEBUT ELSE A.DebutArret    END AS DebutArret, 
	          CASE WHEN A.FinArret_CALC > @FIN   THEN @FIN   ELSE A.FinArret_CALC END AS FinArret
        FROM   (SELECT DISTINCT STP_ID, ENT_ID, STP_POURCENT_DEPENDANCE 
                FROM   PTD) AS U
              CROSS APPLY (SELECT *
                           FROM   C4
                           WHERE  STP_ID = U.STP_ID
					         AND  ENT_ID = U.ENT_ID
					         AND  STP_POURCENT_DEPENDANCE = U.STP_POURCENT_DEPENDANCE) AS A)
SELECT *, DATEDIFF(second, DebutArret, FinArret) / 3600.0 AS Duree_Arret  
FROM   C5
ORDER BY STP_ID, DebutArret

GO


--> test de la proc :

EXEC dbo.P_PLAGE_FONCTIONNEMENT '19990101', '21001231', 5

/*
ENT_ID ENT_LIBELLE
------ --------------------------------
1      Unité de Production (UAP)
2      Secteur de Production
3      Parc-procédé
4      Équipement
5      Sous-équipement
*/

