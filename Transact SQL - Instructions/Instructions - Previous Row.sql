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
			[dbo].[global_rankings])
SELECT
			WR1.[Artist],
			WR1.[Track_Name],
			WR1.[Date],

			WR1.[stream],
			CASE WHEN WR1.[Track_Name] = WR2.[Track_Name] THEN WR2.[stream] ELSE 0 END as Previous_Stream,
			CASE WHEN WR1.[Track_Name] = WR2.[Track_Name] THEN (WR1.[stream] - WR2.[stream]) ELSE 0 END as  Delta_Stream,
			 
			WR1.[Position],
			CASE WHEN WR1.[Track_Name] = WR2.[Track_Name] THEN WR2.[Position] ELSE 0 END as Previous_Position,
			CASE WHEN WR1.[Track_Name] = WR2.[Track_Name] THEN (WR1.[Position] - WR2.[Position]) ELSE 0 END as  Delta_Position
			
	FROM WR11 as WR1
	INNER JOIN WR11 as WR2
		ON WR1.[num] = WR2.[num]+1

	ORDER BY WR1.[Artist],
			 WR1.[Track_Name],
			 WR1.[Date];

GO





