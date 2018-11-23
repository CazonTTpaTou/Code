use [Test];
go
select 
		[Date],
		[Position],
		[Track_Name],
		[Artist],		
		[stream],
		sum([stream]) over (partition by [Artist],[Track_Name]) as Cumul_Streams
from
		[dbo].[wlobal_rankings];
go
