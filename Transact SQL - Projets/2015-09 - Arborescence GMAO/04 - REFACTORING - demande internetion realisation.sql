/*
-- À mon sens et après analyse des données, 
-- les "idRealisation" suivantes 11835, 12456, 15827, 16650 
-- doivent être supprimés car en anomalies

-- report des anomalies dans une tables d'anomalies
SELECT *
INTO   dbo.Realisation_ANOMALIES
FROM   dbo.Realisation 
WHERE  idRealisation IN (11835, 12456, 15827, 16650);

-- suppression des anomalies
DELETE FROM dbo.Realisation 
WHERE  idRealisation IN (11835, 12456, 15827, 16650);
GO
*/

-- remodélisation de la partie Demande/Intervention/Realisation

-- la table dbo.demande reste inchangée

-- la table dbo.Intervention doit être modifiée comme suit :
ALTER TABLE dbo.Intervention 
   ADD CONSTRAINT UK_Intervention_Demande 
       UNIQUE (idDemande);
   
-- la table dbo.Realisation doit être modifiée comme suit :
ALTER TABLE dbo.Realisation 
   ADD CONSTRAINT UK_Realisation_Intervention
       UNIQUE (idIntervention);
GO

-- la table dbo.Demande recoit une clef étrangère qui sert de lien avec le système de production
ALTER TABLE dbo.Demande
   ADD STP_ID INT NOT NULL CONSTRAINT DF DEFAULT 1
       CONSTRAINT FK_Demande_SYSTEME_PRODUCTION 
	   FOREIGN KEY REFERENCES dbo.T_SYSTEME_PRODUCTION_STP (STP_ID);
GO

-- et maintenant on alimente cette clef
BEGIN TRANSACTION
BEGIN TRY
   ALTER TABLE dbo.Demande DISABLE TRIGGER ChangeEtat;

   UPDATE D
   SET    STP_ID = SP.STP_ID 
   FROM   dbo.Demande AS D
          JOIN dbo.T_SYSTEME_PRODUCTION_STP AS SP
	           ON COALESCE(idSousEnsemble, idEquipement) = _OLD_ID
		          AND CASE WHEN idSousEnsemble IS NULL THEN 4 ELSE 5 END = ENT_ID;

   ALTER TABLE dbo.Demande ENABLE TRIGGER ChangeEtat;

   ALTER TABLE dbo.Demande
	     DROP CONSTRAINT DF;

   COMMIT;
END TRY
BEGIN CATCH
   IF XACT_STATE() <> 0
      ROLLBACK;
   RAISERROR('Transaction annulée');
END CATCH
GO

--==============================================================================--
-- le lien entre demande et le système de production se fait dorénavant via STP_ID
--==============================================================================--

-- renommage des anciennes colonnes pour plus de prudence
EXEC sp_rename 'dbo.Demande.idUAP', '_OLD_idUAP', 'COLUMN';
EXEC sp_rename 'dbo.Demande.idSecteur', '_OLD_idSecteur', 'COLUMN';
EXEC sp_rename 'dbo.Demande.idPiece', '_OLD_idPiece', 'COLUMN';
EXEC sp_rename 'dbo.Demande.idEquipement', '_OLD_idEquipement', 'COLUMN';
EXEC sp_rename 'dbo.Demande.idSousEnsemble', '_OLD_idSousEnsemble', 'COLUMN';
-- ne plus utiliser ces colonnes, si possible les supprimer




