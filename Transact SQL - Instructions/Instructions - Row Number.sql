SELECT
	[Artist],
	[Track_Name],
	[stream],
	Row_Number() over(order by stream DESC) as Rank_Number
FROM
	[dbo].[wlobal_rankings]
ORDER BY
	[stream] DESC;

GO

