Use GMAO_DB;

BEGIN TRANSACTION

Update [dbo].[FichePreventive] SET idService=6 Where idFichePreventive = 655;

IF @@ROWCOUNT = 1
                 BEGIN 
				       PRINT 'Nombre de ligne retourn�e �gale � 1';
				       PRINT 'Transaction bien valid�e !!';
					   COMMIT;
				 END
ELSE BEGIN 
           Print'Nombre de ligne retourn�e diff�rent de 1';
		   Print'Un probl�me est survenu !!';
		   Print 'La transaction est donc annul�e...';
		   ROLLBACK;
	 END
GO
