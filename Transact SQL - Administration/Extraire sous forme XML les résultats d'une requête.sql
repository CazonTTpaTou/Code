SELECT PRS_ID as prsId, PSP_NOM as nom, PSP_PRENOM as prenom, 
      PSP_DATE_NAISSANCE as dateNaissance, PSP_SOUNDEX as soundex,

	  CAST((SELECT *
            FROM   [S_CHB].[T_FACTURE_FAC] AS facture
			WHERE  facture.PRS_ID = personnePhysiques.PRS_ID
            FOR XML AUTO, ROOT('fac'), ELEMENTS) AS xml) AS factures
	  
FROM   [S_PRS].[T_PERSONNE_PHYSIQUE_PSP] AS personnePhysiques
FOR XML AUTO, ROOT('prs'), ELEMENTS


