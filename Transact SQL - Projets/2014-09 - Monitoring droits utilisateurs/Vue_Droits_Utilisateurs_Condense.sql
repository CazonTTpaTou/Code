CREATE VIEW VUE_Droits_Utilisateurs_Condense
AS
SELECT 
	
	GDU.[Login],
	ASS.[Droits] AS [Droits attribués],
	CASE WHEN(GDU.[AutoriseAD])=-1 THEN 'Actif' ELSE 'Inactif' END AS [Statut]
	
FROM
		dbo.GD_utilisateur AS GDU
			CROSS APPLY 
			dbo.DroitsUsers(GDU.idUtilisateur) AS ASS

-- ORDER BY GDU.[AutoriseAD] DESC,GDU.[Login] ASC

GO

