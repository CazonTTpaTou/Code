SELECT
	[Artist],
	[Track_Name],
	[stream]
FROM
	[dbo].[wlobal_rankings]
ORDER BY
	[Date]
COMPUTE SUM([stream]) BY [Date];

GO

