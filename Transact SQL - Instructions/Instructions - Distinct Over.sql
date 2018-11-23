use [Test];
go
select 
		[Date],
		[Position],
		[Track_Name],
		[Artist],		
		[stream],
		count([Position]) over (partition by [Artist],[Track_Name]) as Distinct_Positions
from
		[dbo].[wlobal_rankings];
go
