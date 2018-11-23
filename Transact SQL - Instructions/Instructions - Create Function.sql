create function Good_Position()
returns table
as
return (select * from [dbo].[wlobal_rankings] where [Position] <= 50)

go

