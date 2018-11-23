use [Test];
go
with 
table_date as 
(
				select 
						[Track_Name],
						[Artist],		
						[stream],					
						year([Date]) as date_truncated

				from 
						[dbo].[wlobal_rankings])

SELECT
		[Track_Name],
		[Artist],	
		[2017] as 'Year-2017',
		[2018] as 'Year-2018'
FROM
		table_date
PIVOT (SUM([stream]) FOR date_truncated IN ([2017],[2018])) as Total_Streams;

GO

