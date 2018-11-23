select 

	WR.[Date],
	WR.[Position],
	WR.[Artist],
	WR.[Track_Name],
	WR.[Streams]
 
from [dbo].[wlobal_rankings] as WR
cross apply Good_Position() as GP

where 
	WR.[Date] = GP.[Date]
	AND WR.Artist = GP.Artist
	AND WR.Track_Name = GP.Track_Name;

GO




