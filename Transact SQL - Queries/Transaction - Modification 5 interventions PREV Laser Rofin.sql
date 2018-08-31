Use Gmao_DB

-- Modification de l'arborescence des 5 interventions pr�ventives sur le laser Rofin
BEGIN TRANSACTION

	UPDATE Demande 

		set idSousEnsemble = 1588
		where idEquipement = 18 and idSousEnsemble = 160

	IF @@ROWCOUNT = 5
		BEGIN
	       PRINT '--Nombre de ligne retourn�e �gale � 5 pour le laser Rofin';
		   PRINT '--Transaction bien valid�e !!';
		COMMIT;
	END

	ELSE 
		BEGIN 
		   Print '--Nombre de ligne impact�e : ' + convert(varchar(5),@@ROWCOUNT);
           Print '--Nombre de ligne retourn�e diff�rent de 5 pour le laser Rofin';
		   Print '--Un probl�me est survenu !!';
		   Print '--La transaction est donc annul�e...';
		   ROLLBACK;
		 END

GO

