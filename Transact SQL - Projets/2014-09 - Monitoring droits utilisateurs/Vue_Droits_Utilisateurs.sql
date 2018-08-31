CREATE VIEW Vue_Droits_Utilisateurs
AS
SELECT
		GU.idUtilisateur AS [idUtilisateur],
		GU.login AS [Nom],
		GU.autoriseAD AS [Actif],
		GG.libelle AS [Groupe de droits]
		
				FROM dbo.GD_utilisateur_groupe AS GUG

		INNER JOIN dbo.GD_utilisateur AS GU
		ON GUG.idUtilisateur = GU.idUtilisateur
		INNER JOIN dbo.GD_groupe AS GG
		ON GG.idGroupe = GUG.idGroupe
GO
		
		
		