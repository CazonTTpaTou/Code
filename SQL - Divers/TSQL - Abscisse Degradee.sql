use Test;
go

WITH Max_Date as (select max(date) as Maxi from [dbo].[wlobal_rankings]),
Principal as (select *,
case 
	when datediff(day,date,(select Maxi from Max_Date)) =0 then '0 - Current day'
    when datediff(day,date,(select Maxi from Max_Date)) =1 then '1 - day 1'
	when datediff(day,date,(select Maxi from Max_Date)) =2 then '2 - day 2'
	when datediff(day,date,(select Maxi from Max_Date)) =3 then '3 - day 3'
	when datediff(day,date,(select Maxi from Max_Date)) =4 then '4 - day 4'
	when datediff(day,date,(select Maxi from Max_Date)) =5 then '5 - day 5'
	when datediff(day,date,(select Maxi from Max_Date)) =6 then '6 - day 6'
	when datediff(day,date,(select Maxi from Max_Date)) =6 then '6 - day 6'
	when datediff(day,date,(select Maxi from Max_Date)) >6 and datediff(day,date,(select Maxi from Max_Date)) <=14 then '7 - Week 1'
	when datediff(day,date,(select Maxi from Max_Date)) >15 and datediff(day,date,(select Maxi from Max_Date)) <=21 then '8 - Week 2'
	when datediff(day,date,(select Maxi from Max_Date)) >22 and datediff(day,date,(select Maxi from Max_Date)) <=28 then '9 - Week 3'
	when datediff(day,date,(select Maxi from Max_Date)) >29 and datediff(day,date,(select Maxi from Max_Date)) <=60 then '10 - Month 2'
	when datediff(day,date,(select Maxi from Max_Date)) >60 and datediff(day,date,(select Maxi from Max_Date)) <=90 then '11 - Month 3'
	when datediff(day,date,(select Maxi from Max_Date)) >90 and datediff(day,date,(select Maxi from Max_Date)) <=180 then '12 - Trimester 2'
	when datediff(day,date,(select Maxi from Max_Date)) >180 and datediff(day,date,(select Maxi from Max_Date)) <=270 then '13 - Trimester 3'
	when datediff(day,date,(select Maxi from Max_Date)) >270 and datediff(day,date,(select Maxi from Max_Date)) <=360 then '14 - Trimester 4'
	else '15 - Year 2'
	END
	AS Abscisse_Degradee

	FROM [dbo].[wlobal_rankings])
	
	SELECT 
		Abscisse_Degradee
		,AVG(stream) as mean_stream
	FROM
		Principal
	GROUP BY Abscisse_Degradee	
	ORDER BY mean_stream DESC
	;

GO

