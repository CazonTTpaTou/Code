WITH ListeID
AS
		(SELECT 
				idEquipement,
				Libelle,
				ROW_NUMBER() 
							OVER(ORDER BY idEquipement) AS Numero_Ligne
		 
				FROM Equipement)

SELECT 
		L1.idEquipement,
		L1.Libelle,
		/*L2.Numero_Ligne AS Ligne_Precedente,*/
		L2.idEquipement AS idEquipement_Precedent,
		(L1.Numero_Ligne-L2.Numero_Ligne) AS Delta_Counter,
		CASE WHEN (L1.Numero_Ligne-L2.Numero_Ligne)>1 THEN 'Incrément supérieur à 1' ELSE 'Incrément normal' END AS Delta_Counter_Etat

		FROM ListeID AS L1
		
		INNER JOIN ListeID AS L2
		ON L1.Numero_Ligne = (L2.Numero_Ligne+1)

ORDER BY Delta_Counter_Etat

GO






