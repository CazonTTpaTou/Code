USE [Test];
GO

WITH 
WR11 as (
		SELECT 
			ROW_NUMBER() over(order by [Artist],[Track_Name],[Date]) as num,
			[Artist],
			[Track_Name],
			[Date],
			[stream],
			[Position]
		FROM 
			[dbo].[wlobal_rankings])

SELECT
			WR1.[Artist],
			WR1.[Track_Name],
			WR1.[stream],
			WR2.[stream] as Previous_Stream,
			(WR1.[stream] - WR2.[stream]) as Delta_Stream,
			WR1.[Position],
			WR2.[Position] as Previous_Position,
			(WR1.[Position] - WR2.[Position]) as Delta_Position

	FROM WR11 as WR1
	INNER JOIN WR11 as WR2
		ON WR1.num = WR2.num+1

	ORDER BY WR1.[Artist],
			 WR1.[Track_Name],
			 WR1.[Date];

GO





