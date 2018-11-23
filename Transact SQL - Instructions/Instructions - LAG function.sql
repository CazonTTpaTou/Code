select 
			[Artist],
			[Track_Name],
			[Date],
			[stream],
			[Position],
			LAG([Position],1) OVER(partition by [Track_Name] order by [Artist],[Track_Name],[date]) as previous_position

FROM
			[dbo].[wlobal_rankings]

ORDER BY 
			[Artist],
			[Track_Name],
			[Date];

GO



