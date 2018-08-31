--Select * from AdresseIP
--GO
SELECT AVG(VAL) FROM
((Select Max(IP.idAdresseIP) AS VAL FROM (Select top( 
											SELECT Case When T.N % 2 = 0 Then T.N/2 
												 ELSE (T.N+1)/2 
													END AS TopN
												from (Select count(*) AS N From AdresseIP) AS T)
												idAdresseIP
												FROM AdresseIP) AS IP)
UNION

(Select Min(IP.idAdresseIP) AS VAL FROM (Select top( 
											SELECT Case When T.N % 2 = 0 Then T.N/2 
												 ELSE (T.N+1)/2 
													END AS TopN
												from (Select count(*) AS N From AdresseIP) AS T)
												idAdresseIP
												FROM AdresseIP order by AdresseIP DESC) AS IP
)) AS Med
GO

Select idAdresseIP FROM AdresseIP;
GO











