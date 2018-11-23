use [Test];
go

declare @nombre int;
select @nombre = count(distinct region) from [dbo].[wlobal_rankings];
select @nombre = 2;

select 
		[Date],
		[Position],
		[Track_Name],
		[Artist],		
		[stream],
		ntile(@nombre) over (partition by [Artist],[Track_Name] order by [Artist],[Track_Name]) as Ensemble
from
		[dbo].[wlobal_rankings];
go
