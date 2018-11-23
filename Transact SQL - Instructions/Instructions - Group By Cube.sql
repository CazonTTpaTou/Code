SELECT
	[Artist],
	[Track_Name],
	SUM([stream])
FROM
	[dbo].[wlobal_rankings]
GROUP BY
	[Artist],
	[Track_Name]
WITH CUBE;
