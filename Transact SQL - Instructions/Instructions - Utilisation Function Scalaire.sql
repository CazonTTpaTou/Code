SELECT
	[Date]
	[Artist],
	[Track_Name],
	[stream],
	[dbo].[Round_Stream]([stream]) as stream_rounded
FROM
	[dbo].[wlobal_rankings]
GO


	