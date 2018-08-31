With OV
AS
(Select 1 As NumOV,'OV N° 1' as TitreOV,0.5 as RatioBudget,1 as NumBudget
UNION
Select 2 As NumOV,'OV N° 2' as TitreOV,0.25 as RatioBudget,1 as NumBudget
UNION
Select 3 As NumOV,'OV N° 3' as TitreOV,0.25 as RatioBudget,1 as NumBudget
UNION
Select 4 As NumOV,'OV N° 4' as TitreOV,0.20 as RatioBudget,2 as NumBudget
UNION
Select 5 As NumOV,'OV N° 5' as TitreOV,0.30 as RatioBudget,2 as NumBudget
UNION
Select 6 As NumOV,'OV N° 6' as TitreOV,0.30 as RatioBudget,2 as NumBudget
UNION
Select 7 As NumOV,'OV N° 7' as TitreOV,0.05 as RatioBudget,2 as NumBudget
UNION
Select 8 As NumOV,'OV N° 8' as TitreOV,0.15 as RatioBudget,2 as NumBudget
),
Budget AS
(Select 1 AS Num_Budget,'Budget 1' As Titre,800 as Montant
UNION
Select 2 AS Num_Budget,'Budget 2' As Titre,400 as Montant),
OV_Budget AS
(Select 

		(Select 
			Max(Budget2.Montant) from Budget AS Budget2
					WHERE Budget2.Num_Budget = Budget.Num_Budget - 1) AS BudgetPrecedent,			
			
		(OV.RatioBudget*Budget.Montant) AS MontantAlloue,	    
		(Select 
			SUM(OV1.RatioBudget*Budget1.Montant) from OV AS OV1
					INNER JOIN Budget AS Budget1
					ON OV1.NumBudget = Budget1.Num_Budget 
					AND OV1.NumOV <= OV.NumOV)  AS BudgetCumule,
		OV.*,
		Budget.*

						FROM OV
						INNER JOIN Budget 
						ON OV.NumBudget = Budget.Num_Budget)

SELECT 

	Titre AS Budget_Reference,
	TitreOV,
	RatioBudget,
	Montant AS Montant_Budget_Reference,
	(RatioBudget*Montant) AS Budget_Alloue,
	(BudgetCumule - Coalesce(BudgetPrecedent,0)) AS Cumul_Montant_Alloue, 
	(Montant - (BudgetCumule - Coalesce(BudgetPrecedent,0))) AS Budget_Restant 
		
		FROM OV_Budget

GO




