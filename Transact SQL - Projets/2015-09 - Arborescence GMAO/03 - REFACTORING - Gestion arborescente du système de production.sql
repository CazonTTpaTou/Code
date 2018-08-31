
-- refactoring des tables UAP, Secteur, Procede, Equipement et SousEnsemble en une seule table organisée en arbre

-- suppression des nouvelles vues
IF OBJECT_ID('dbo.V_SYSTEME_PRODUCTION_STP') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_SYSTEME_PRODUCTION_STP;');
GO
IF OBJECT_ID('dbo.V_UAP') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_UAP;');
GO
IF OBJECT_ID('dbo.V_Secteur') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_Secteur;');
GO
IF OBJECT_ID('dbo.V_Procede') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_Procede;');
GO
IF OBJECT_ID('dbo.V_Equipement') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_Equipement;');
GO
IF OBJECT_ID('dbo.V_SousEnsemble') IS NOT NULL
   EXEC ('DROP VIEW dbo.V_SousEnsemble;');
GO

-- suppression des nouvelles tables
IF OBJECT_ID('dbo.T_SYSTEME_PRODUCTION_STP') IS NOT NULL
   EXEC ('DROP TABLE dbo.T_SYSTEME_PRODUCTION_STP;');
GO
IF OBJECT_ID('dbo.T_ENTITE_ENT') IS NOT NULL
   EXEC ('DROP TABLE dbo.T_ENTITE_ENT;');
GO

/******************************************************************************
* création des nouvelles tables de la base                                    *
******************************************************************************/

-- création de la table des niveaux des systèmes de production
CREATE TABLE dbo.T_ENTITE_ENT
(ENT_ID              SMALLINT IDENTITY PRIMARY KEY,
 ENT_LIBELLE         VARCHAR(32));
GO

-- table arborescente des éléments de prod
CREATE TABLE dbo.T_SYSTEME_PRODUCTION_STP
(
	STP_ID                    int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	STP_ID_PERE               int                   NULL FOREIGN KEY REFERENCES dbo.T_SYSTEME_PRODUCTION_STP (STP_ID),
	ENT_ID                    smallint              NULL FOREIGN KEY REFERENCES dbo.T_ENTITE_ENT (ENT_ID),
	STP_LIBELLE               varchar(150)      NOT NULL,
	STP_ACTIF                 smallint          NOT NULL DEFAULT -1 CHECK (STP_ACTIF IN (-1, 0)),
	STP_ORDRE                 smallint              NULL,
	STP_POURCENT_DEPENDANCE   float                 NULL DEFAULT 100 CHECK (STP_POURCENT_DEPENDANCE BETWEEN 0 AND 100),
	STP_CODE_EQUIPEMENT       varchar(20)           NULL,
	STP_NUMERO_FOURNISSEUR    varchar(50)           NULL,
	STP_NUMERO_SERIE          varchar(50)           NULL,
	idFournisseur             int                   NULL FOREIGN KEY REFERENCES dbo.Fournisseur (idFournisseur),
	idModele                  int                   NULL FOREIGN KEY REFERENCES dbo.ModeleEquip  (idModeleEquipe),
	idCategorie               int                   NULL FOREIGN KEY REFERENCES dbo.CategorieEquip (idCatEquip),
	Sysutc                    nvarchar(128)         NULL DEFAULT SYSTEM_USER,
	Sysdhc                    datetime              NULL DEFAULT GETDATE(),
	Sysutm                    nvarchar(128)         NULL,
	Sysdhm                    datetime              NULL,
	_OLD_ID                   int 
);
GO

/******************************************************************************
* insertion des données dans les nouvelles tables de la base                  *
******************************************************************************/

-- insertion des niveaux des systèmes de production
SET IDENTITY_INSERT dbo.T_ENTITE_ENT ON;
INSERT INTO dbo.T_ENTITE_ENT (ENT_ID, ENT_LIBELLE)
VALUES
(1, 'Unité de Production (UAP)'),
(2, 'Secteur de Production'),
(3, 'Parc-procédé'),
(4, 'Équipement'),
(5, 'Sous-équipement');
SET IDENTITY_INSERT dbo.T_ENTITE_ENT OFF;
GO


-- remodélisation des éléments du systèmes de production : 
--   UAP, Secteurs de production, Parc-procédés, Équipements, Sous équipements
-- en une seule table arborescente
WITH 
DATA_BRUTES AS
(
SELECT idUAP, 0 AS idSecteur, 0 AS idProcede, 0 AS idEquipement, 0 AS idSousEnsemble,
       CAST(1 AS SMALLINT) AS NIV_NIVEAU,
       Libelle AS STP_LIBELLE, Actif AS STP_ACTIF, Ordre AS STP_ORDRE, 
	   PourcentageDependance AS STP_POURCENT_DEPENDANCE, 
	   CAST(NULL AS VARCHAR(20)) AS STP_CODE_EQUIPEMENT,
	   CAST(NULL AS VARCHAR(50)) AS STP_NUMERO_FOURNISSEUR,
	   CAST(NULL AS VARCHAR(50)) AS STP_NUMERO_SERIE,
	   CAST(NULL AS INT) AS idFournisseur,
	   CAST(NULL AS INT) AS idModele,
	   CAST(NULL AS INT) AS idCategorie,
	   Sysutc, Sysdhc, Sysutm, Sysdhm,
	   idUAP AS _OLD_ID
FROM   dbo.UAP

UNION ALL

SELECT u.idUAP, idSecteur, 0 AS idProcede, 0 AS idEquipement, 0 AS idSousEnsemble,
       2 AS NIV_NIVEAU, 
       s.Libelle, s.Actif, s.Ordre, s.PourcentageDependance,
	   NULL, NULL, NULL,
	   CAST(NULL AS INT) AS idFournisseur,
	   CAST(NULL AS INT) AS idModele,
	   CAST(NULL AS INT) AS idCategorie,
	   s.Sysutc, s.Sysdhc, s.Sysutm, s.Sysdhm,
	   idSecteur
FROM   dbo.Secteur AS s
       INNER JOIN dbo.UAP AS u
	         ON s.idUAP = u.idUAP

UNION ALL

SELECT u.idUAP, s.idSecteur, idProcede,  0 AS idEquipement, 0 AS idSousEnsemble,
       3 AS NIV_NIVEAU, 
       p.Libelle, p.Actif, p.Ordre, p.PourcentageDependance,
	   NULL, NULL, NULL, 
	   CAST(NULL AS INT) AS idFournisseur,
	   CAST(NULL AS INT) AS idModele,
	   CAST(NULL AS INT) AS idCategorie,
	   NULL AS Sysutc, NULL AS Sysdhc, NULL AS Sysutm, NULL AS Sysdhm,
	   idProcede
FROM   dbo.Procede AS p
       INNER JOIN dbo.Secteur AS s
	         ON p.idSecteur = s.idSecteur
       INNER JOIN dbo.UAP AS u
	         ON s.idUAP = u.idUAP

UNION ALL

SELECT u.idUAP, s.idSecteur, p.idProcede, idEquipement, 0 AS idSousEnsemble,
       4 AS NIV_NIVEAU, 
       e.Libelle, e.Actif, e.Ordre, e.PourcentageDependance,
	   CodeEquipement, NumeroFournisseur, NumeroSerie,
	   idFournisseur,
	   idModele,
	   idCategorie,	    
	   e.Sysutc, e.Sysdhc, e.Sysutm, e.Sysdhm,
	   idEquipement
FROM   dbo.Equipement AS e
       INNER JOIN dbo.Procede AS p
	         ON e.idProcede = p.idProcede
       INNER JOIN dbo.Secteur AS s
	         ON p.idSecteur = s.idSecteur
       INNER JOIN dbo.UAP AS u
	         ON s.idUAP = u.idUAP

UNION ALL

SELECT u.idUAP, s.idSecteur, p.idProcede, e.idEquipement, idSousEnsemble,
       5 AS NIV_NIVEAU, 
       se.Libelle, se.Actif, se.Ordre, se.PourcentageDependance,
	   se.CodeEquipement, NULL, NULL, 
	   CAST(NULL AS INT) AS idFournisseur,
	   CAST(NULL AS INT) AS idModele,
	   CAST(NULL AS INT) AS idCategorie,
	   se.Sysutc, se.Sysdhc, se.Sysutm, se.Sysdhm,
	   idSousEnsemble 
FROM   dbo.SousEnsemble AS se
       INNER JOIN dbo.Equipement AS e
	         ON se.idEquipement = e.idEquipement
       INNER JOIN dbo.Procede AS p
	         ON e.idProcede = p.idProcede
       INNER JOIN dbo.Secteur AS s
	         ON p.idSecteur = s.idSecteur
       INNER JOIN dbo.UAP AS u
	         ON s.idUAP = u.idUAP
),
DATA_KEY AS 
(
SELECT CAST(ROW_NUMBER() OVER(ORDER BY idSousEnsemble, idEquipement, idProcede, idSecteur, idUAP) AS INT) AS STP_ID_CALC, *
FROM   DATA_BRUTES
)
SELECT STP_ID_CALC,
       CASE NIV_NIVEAU 
          WHEN 2 THEN (SELECT STP_ID_CALC 
		               FROM   DATA_KEY AS Din 
					   WHERE  Din.NIV_NIVEAU = 1 
					     AND  Din.idUAP = Dout.idUAP)
          WHEN 3 THEN (SELECT STP_ID_CALC
		               FROM   DATA_KEY AS Din 
					   WHERE  Din.NIV_NIVEAU = 2 
					     AND  Din.idSecteur = Dout.idSecteur)
	      WHEN 4 THEN (SELECT STP_ID_CALC 
		               FROM   DATA_KEY AS Din 
					   WHERE  Din.NIV_NIVEAU = 3 
					     AND  Din.idProcede = Dout.idProcede)
          WHEN 5 THEN (SELECT STP_ID_CALC
		               FROM   DATA_KEY AS Din 
					   WHERE  Din.NIV_NIVEAU = 4 
					     AND  Din.idEquipement = Dout.idEquipement) 
       END AS STP_ID_PERE_CALC, 
	   NIV_NIVEAU, STP_LIBELLE, STP_ACTIF, STP_ORDRE, 
	   STP_POURCENT_DEPENDANCE, 
	   STP_CODE_EQUIPEMENT, STP_NUMERO_FOURNISSEUR, STP_NUMERO_SERIE, 
	   idFournisseur,
	   idModele,
	   idCategorie,
	   Sysutc, Sysdhc, Sysutm, Sysdhm, _OLD_ID
INTO #t
FROM DATA_KEY AS Dout;
GO

SET IDENTITY_INSERT dbo.T_SYSTEME_PRODUCTION_STP ON;
INSERT INTO dbo.T_SYSTEME_PRODUCTION_STP 
      (STP_ID, STP_ID_PERE, ENT_ID, STP_LIBELLE, STP_ACTIF, STP_ORDRE, 
	   STP_POURCENT_DEPENDANCE, STP_CODE_EQUIPEMENT, STP_NUMERO_FOURNISSEUR, STP_NUMERO_SERIE, 
	   idFournisseur, idModele, idCategorie,
	   Sysutc, Sysdhc, Sysutm, Sysdhm, _OLD_ID) 
SELECT * FROM #t;
SET IDENTITY_INSERT dbo.T_SYSTEME_PRODUCTION_STP OFF;
GO

DROP TABLE #t;
GO

/******************************************************************************
* Déclencheur pour mise à jour des informations système des date et user      *
******************************************************************************/
-- trigger sur UPDATE dbo.T_SYSTEME_PRODUCTION_STP
CREATE TRIGGER E_U_T_SYSTEME_PRODUCTION_STP
ON dbo.T_SYSTEME_PRODUCTION_STP
AFTER UPDATE
AS
SET NOCOUNT ON;
-- on rajoute l'info de niveau
UPDATE sp
SET    ENT_ID = COALESCE(pere.ENT_ID + 1, 1)
FROM   dbo.T_SYSTEME_PRODUCTION_STP AS sp
       INNER JOIN inserted AS i
	         ON sp.STP_ID = i.STP_ID
	   LEFT OUTER JOIN dbo.T_SYSTEME_PRODUCTION_STP AS pere
	        ON sp.STP_ID_PERE = pere.STP_ID;
-- on rajoute les info systèmes 
UPDATE dbo.T_SYSTEME_PRODUCTION_STP 
   SET Sysutm = SYSTEM_USER,
	   Sysdhm = GETDATE()
WHERE  STP_ID IN (SELECT STP_ID FROM inserted);
GO

/******************************************************************************
* création de la vue générale de l'arbre des entités                          *
******************************************************************************/
CREATE VIEW dbo.V_SYSTEME_PRODUCTION_STP
AS
SELECT STP_ID, ENT_LIBELLE, STP_ID_PERE, sp.ENT_ID, STP_LIBELLE, STP_ACTIF, STP_ORDRE, 
       STP_POURCENT_DEPENDANCE, STP_CODE_EQUIPEMENT, STP_NUMERO_FOURNISSEUR, STP_NUMERO_SERIE, 
	   Sysutc, Sysdhc, Sysutm, Sysdhm
FROM   dbo.T_SYSTEME_PRODUCTION_STP AS sp
       INNER JOIN dbo.T_ENTITE_ENT AS n
	         ON sp.ENT_ID = n.ENT_ID;
GO


/******************************************************************************
* création des vues équivalentes aux anciennes tables                         *
******************************************************************************/

CREATE VIEW dbo.V_UAP
AS
SELECT STP_ID AS idUAP, 
       STP_LIBELLE AS Libelle, STP_ACTIF AS Actif, STP_ORDRE As Ordre, 
       STP_POURCENT_DEPENDANCE AS PourcentageDependance, ENT_ID
FROM   dbo.T_SYSTEME_PRODUCTION_STP
WHERE  ENT_ID = 1
WITH CHECK OPTION;
GO

CREATE VIEW dbo.V_Secteur
AS
SELECT STP_ID AS idSecteur, STP_ID_PERE AS idUAP, 
       STP_LIBELLE AS Libelle, STP_ACTIF AS Actif, STP_ORDRE As Ordre, 
       STP_POURCENT_DEPENDANCE AS PourcentageDependance, ENT_ID
FROM   dbo.T_SYSTEME_PRODUCTION_STP
WHERE  ENT_ID = 2
WITH CHECK OPTION;
GO

CREATE VIEW dbo.V_Procede
AS
SELECT STP_ID AS idProcede, STP_LIBELLE AS Libelle, STP_ID_PERE AS idSecteur, 
       STP_ACTIF AS Actif, STP_ORDRE As Ordre, 
       STP_POURCENT_DEPENDANCE AS PourcentageDependance, ENT_ID
FROM   dbo.T_SYSTEME_PRODUCTION_STP
WHERE  ENT_ID = 3
WITH CHECK OPTION;
GO

CREATE VIEW dbo.V_Equipement
AS
SELECT STP_ID AS idEquipement, STP_LIBELLE AS Libelle, STP_ID_PERE AS idProcede, 
       STP_ACTIF AS Actif, STP_ORDRE As Ordre, 
       STP_POURCENT_DEPENDANCE AS PourcentageDependance, 
	   STP_CODE_EQUIPEMENT AS CodeEquipement,
	   idFournisseur,
	   idModele,
	   idCategorie,
       STP_NUMERO_FOURNISSEUR AS NumeroFournisseur,
       STP_NUMERO_SERIE AS NumeroSerie, ENT_ID
FROM   dbo.T_SYSTEME_PRODUCTION_STP
WHERE  ENT_ID = 4
WITH CHECK OPTION;
GO

CREATE VIEW dbo.V_SousEnsemble
AS
SELECT STP_ID AS idSousEnsemble, STP_LIBELLE AS Libelle, STP_ID_PERE AS idEquipement, 
       STP_ACTIF AS Actif, STP_ORDRE As Ordre,
	   STP_CODE_EQUIPEMENT AS CodeEquipement,
       STP_POURCENT_DEPENDANCE AS PourcentageDependance, ENT_ID
FROM   dbo.T_SYSTEME_PRODUCTION_STP
WHERE  ENT_ID = 5
WITH CHECK OPTION;
GO

















