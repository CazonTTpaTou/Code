Use Gmao_DB

-- Modification de l'arborescence des 5 interventions préventives sur le laser Rofin
BEGIN TRANSACTION

	UPDATE Demande 

		set idSousEnsemble = 1588
		where idEquipement = 18 and idSousEnsemble = 160

	IF @@ROWCOUNT = 5
		BEGIN
	       PRINT '--Nombre de ligne retournée égale à 5 pour le laser Rofin';
		   PRINT '--Transaction bien validée !!';
		COMMIT;
	END

	ELSE 
		BEGIN 
		   Print '--Nombre de ligne impactée : ' + convert(varchar(5),@@ROWCOUNT);
           Print '--Nombre de ligne retournée différent de 5 pour le laser Rofin';
		   Print '--Un problème est survenu !!';
		   Print '--La transaction est donc annulée...';
		   ROLLBACK;
		 END

GO

