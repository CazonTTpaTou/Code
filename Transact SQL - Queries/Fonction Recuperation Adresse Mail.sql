
/* Utilisation de la base SQC_DB */
USE [SQC_DB]
GO

/* ------------------------------------------------------------- */
/* FONCTION : GetEmailDestinataires                              */
/* ------------------------------------------------------------- */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEmailDestinataires]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetEmailDestinataires]
GO
	
CREATE FUNCTION [dbo].[GetEmailDestinataires] (@P_CONTEXTE int, @P_ENTITE int, @P_POSTE nvarchar(5), @P_EQUIPE int)
RETURNS @retListe TABLE 
(
     ListeAdresses nvarchar(1000) NOT NULL
)
AS   
BEGIN
	-- Déclaration de la variable d'empilement des contacts
	DECLARE @ALL_ADRESSES VARCHAR(1000)
	
	-- On recherche TOUS les destinataires à prevenir en cas d'echec
	SELECT @ALL_ADRESSES = @ALL_ADRESSES + COALESCE(T.Adresse + ';', '')
	FROM	(SELECT DISTINCT Adresse 
	         FROM 	VP_MAILING_CONTEXTES
			 WHERE	Actif = -1
			 AND	IdContexte = @P_CONTEXTE
			 AND	(Entite = 3 OR Entite = @P_ENTITE)
			 AND	(Poste IS NULL OR Poste = '@P_POSTE')
			 AND	(Equipe IS NULL OR Equipe = @P_EQUIPE)) as T
 		
	-- Supprime le point virgule finale parasite si la chaîne est assignée
	IF @ALL_ADRESSES IS NOT NULL AND LEN(@ALL_ADRESSES) > 1
	   SET @ALL_ADRESSES = SUBSTRING(@ALL_ADRESSES, 1, LEN(@ALL_ADRESSES) - 1)
	ELSE
		SET @ALL_ADRESSES = ''
		
	-- Restitue l'information
	INSERT @retListe
	SELECT @ALL_ADRESSES
	
	-- Sort de la fonction
	RETURN
END;
