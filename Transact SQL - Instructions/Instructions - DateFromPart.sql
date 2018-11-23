use [Test];
go

select 
		[Track_Name],
		[Artist],		
		[stream],

	datepart(m,[Date]) as months_date,
	datefromparts(year([Date]),datepart(mm,[Date]),1) as date_trunc,
	convert(varchar,year([Date])) + ' - ' + convert(varchar,month([Date])) as date_truncated

from [dbo].[wlobal_rankings];
