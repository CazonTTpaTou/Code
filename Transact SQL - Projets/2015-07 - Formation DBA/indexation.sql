/***************************
****************************
* LES REQUÊTES A OPTIMISER *
****************************
***************************/
/*
SET STATISTICS IO ON
DROP INDEX X ON T_EMPLOYEE_EMP;
CREATE INDEX X ON T_EMPLOYEE_EMP ();
*/

-- 1
SELECT COUNT(*), EMP_SEXE
FROM   T_EMPLOYEE_EMP
WHERE  EMP_SERVICE = 'RH'
GROUP  BY EMP_SEXE;

-- 2
SELECT COUNT(*) AS NOMBRE, 'Homme' AS SEXE
FROM   T_EMPLOYEE_EMP
WHERE  EMP_SERVICE = 'RH'
  AND  EMP_SEXE = 'Homme'
UNION
SELECT COUNT(*) AS NOMBRE, 'Femme' AS SEXE
FROM   T_EMPLOYEE_EMP
WHERE  EMP_SERVICE = 'RH'
  AND  EMP_SEXE = 'Femme';
 
-- 3
SELECT COUNT(*) AS HOMME, 
       (SELECT COUNT(*) 
        FROM   T_EMPLOYEE_EMP
        WHERE  EMP_SERVICE = 'RH'
          AND  EMP_SEXE = 'Femme') AS FEMME
FROM   T_EMPLOYEE_EMP
WHERE  EMP_SERVICE = 'RH'
  AND  EMP_SEXE = 'Homme';

-- 4
SELECT COUNT(*) - (SELECT COUNT(*) 
                   FROM   T_EMPLOYEE_EMP E2
                   WHERE  E2.EMP_SERVICE = E1.EMP_SERVICE
                      AND  EMP_SEXE = 'Femme') AS HOMME,
       (SELECT COUNT(*) 
        FROM   T_EMPLOYEE_EMP E3
        WHERE  E3.EMP_SERVICE = E1.EMP_SERVICE
          AND  EMP_SEXE = 'Femme') AS FEMME
FROM   T_EMPLOYEE_EMP E1
WHERE  EMP_SERVICE = 'RH'
GROUP  BY EMP_SERVICE;

-- 5
WITH 
TALL AS 
(SELECT COUNT(*) NALL 
 FROM dbo.T_EMPLOYEE_EMP 
 WHERE EMP_SERVICE = 'RH'), 
TFEM AS 
(SELECT COUNT(*) NFEM 
 FROM dbo.T_EMPLOYEE_EMP 
 WHERE EMP_SERVICE = 'RH' 
   AND EMP_SEXE = 'Femme') 
SELECT NALL - NFEM AS Homme, NFEM AS Femme 
FROM   TALL 
       CROSS JOIN TFEM;    

-- 6
SELECT SUM(CASE EMP_SEXE
             WHEN 'Homme' THEN 1
             WHEN 'Femme' THEN 0
           END) AS NOMBRE_HOMME,
       SUM(CASE EMP_SEXE
             WHEN 'Homme' THEN 0
             WHEN 'Femme' THEN 1
           END) AS NOMBRE_FEMME
FROM  dbo.T_EMPLOYEE_EMP
WHERE EMP_SERVICE= 'RH';

-- 7
SELECT COUNT(EMP_SEXE) AS NOMBRE,
       CASE EMP_SEXE
	  WHEN 'Femme' THEN 'Femme'
	  WHEN 'Homme' THEN 'Homme'
	  ELSE 'Unknown'
       END AS SEXE
FROM   dbo.T_EMPLOYEE_EMP
WHERE  EMP_SERVICE= 'RH'
GROUP  BY EMP_SEXE;

-- 8
SELECT DISTINCT EMP_SERVICE,
       (SELECT COUNT(*)
        FROM   dbo.T_EMPLOYEE_EMP
        WHERE  EMP_SEXE = 'Homme' 
        AND    EMP_SERVICE= 'RH') AS HOMME, 
       (SELECT COUNT(*)
        FROM   dbo.T_EMPLOYEE_EMP
        WHERE  EMP_SEXE = 'Femme' 
        AND    EMP_SERVICE= 'RH') AS FEMME
FROM  dbo.T_EMPLOYEE_EMP
WHERE EMP_SERVICE = 'RH';

-- 9 (valable uniquement sur SQL Server 2005)
 SELECT COUNT(*) AS Nombre, 'Femme' AS Sexe 
 FROM  dbo.T_EMPLOYEE_EMP 
 WHERE EMP_ID NOT IN (SELECT EMP_ID 
                       FROM   dbo.T_EMPLOYEE_EMP 
                      WHERE  EMP_SERVICE <> 'RH' 
                         OR  EMP_SEXE = 'Homme') 
 UNION ALL 
 SELECT COUNT(*) AS Nombre, 'Homme' AS Sexe 
 FROM  dbo.T_EMPLOYEE_EMP 
 WHERE EMP_ID NOT IN (SELECT EMP_ID 
                      FROM   dbo.T_EMPLOYEE_EMP 
                      WHERE  EMP_SERVICE <> 'RH' 
                         OR  EMP_SEXE = 'Femme');





