-- Script SQL pour correction des filtres GMAO
USE GMAO_DB;
GO

-- REQUETE 1;
-- RETABLISSEMENT DES FILTRES INACTIFS RACTIVES PAR ERREUR
BEGIN TRANSACTION
UPDATE [dbo].[FiltreIntervention] SET FiltreActif=0 
WHERE idFiltreInter IN
			(127,132,133,141,142,324,430,431,163,164,314,181,182,257,271,273,274,298,569,162,208,219,221,275,
			276,277,278,279,280,281,282,284,285,286,287,288,289,290,429,436,592,617,671,545,565,514,31,69,71,115,117,119,121,134,17,
			28,29,32,552,553,15,16,67,197,205,207,236,33,126,183,6,318,319,320,145,146,171,172,173,174,175,176,177,178,195,206,344,
			345,443,444,466,471,472,475,496,516,580,584,585,593,594,609,270,333,419,7,8,9,10,11,12,13,14,30,34,35,40,41,42,43,44,45,
			46,47,48,49,50,51,52,88,89,90,91,92,93,94,95,96,97,105,150,151,152,153,154,155,156,157,212,213,338,421,422,439,459,269,53,
			54,55,56,65,66,72,110,111,112,113,114,149,168,169,170,291,292,293,294,295,296,378,425,440,441,442,467,531,192,37,68,158,
			161,38,39,332,180,187,188,256,307,622,639,260,261,262,334,358,576,518,464,465,468,469,561,532,612,408,412,413,586,363,
			506,507,508,509,510,511,427,504,457,458,596,644,476,455,456,558,566,629,477,478,488);
IF @@ROWCOUNT = 240  
                 BEGIN 
				       PRINT 'Nombre de ligne retournée égale à 240';
				       PRINT 'Transaction validée !!';
					   COMMIT;
				 END
ELSE BEGIN 
           Print'Nombre de ligne retournée différent de 240';
		   Print 'La transaction est annulée';
		   ROLLBACK;
	 END
GO

-- REQUETE 2;
-- SUPPRESSION DES FILTRES de M. FIGUEIRIDO JM

BEGIN TRANSACTION
DELETE FROM [dbo].[FiltreIntervention] 
WHERE idUtilisateur = 20 and FiltreActif = 0;
IF @@ROWCOUNT = 23  
                 BEGIN 
				       PRINT 'Nombre de ligne retournée égale à 23';
				       PRINT 'Transaction validée !!';
					   COMMIT;
				 END
ELSE BEGIN 
           Print'Nombre de ligne retournée différent de 23';
		   Print 'La transaction est annulée';
		   ROLLBACK;
	 END
GO

-- REQUETE 3;
-- REACTIVATION DU FILTRE DE F.REYMOND

BEGIN TRANSACTION
Update [dbo].[FiltreIntervention] SET FiltreActif = -1 Where idFiltreInter = 557;
GO
IF @@ROWCOUNT = 1  
                 BEGIN 
				       PRINT 'Nombre de ligne retournée égale à 1';
				       PRINT 'Transaction validée !!';
					   COMMIT;
				 END
ELSE BEGIN 
           Print'Nombre de ligne retournée différent de 1';
		   Print 'La transaction est annulée';
		   ROLLBACK;
	 END
GO

