/* Création de la fonction table : GetAssemblages */
CREATE FUNCTION [dbo].[DroitsUsers] (@IdLot int)
RETURNS @retListe TABLE 
(     
     [Droits] nvarchar(1000) NOT NULL     
)
AS   
BEGIN
	-- Déclaration des variables assemblage	
	DECLARE @ASSEMBLAGE_2 VARCHAR(1000)

	-- Initialisation des variables assemblage	
	SET @ASSEMBLAGE_2 = ''

	-- On recherche TOUS les assemblages à l'exception du premier 
	SELECT @ASSEMBLAGE_2 = @ASSEMBLAGE_2 + COALESCE([Groupe de droits] + '; ', '')
	FROM   dbo.Vue_Droits_Utilisateurs
	WHERE  idUtilisateur = @IdLot	
	ORDER BY idUtilisateur ASC

	-- Supprime le point virgule finale parasite si la chaîne est assignée
	IF @ASSEMBLAGE_2 IS NOT NULL AND LEN(@ASSEMBLAGE_2) > 1
	   SET @ASSEMBLAGE_2 = SUBSTRING(@ASSEMBLAGE_2, 1, LEN(@ASSEMBLAGE_2) - 1)
	ELSE
		SET @ASSEMBLAGE_2 = ''
		
	-- Restitue l'information
	INSERT @retListe
	SELECT @ASSEMBLAGE_2
	
	-- Sort de la fonction
	RETURN
END;
GO





