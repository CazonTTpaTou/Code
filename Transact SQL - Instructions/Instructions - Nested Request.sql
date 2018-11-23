use [Test];
go
select 
		[Date],
		[Position],
		[Track_Name],
		[Artist],		
		[stream],
		(select count(distinct [Track_Name]) from [dbo].[wlobal_rankings]) as Distinct_Tracks
from
		[dbo].[wlobal_rankings];
go
