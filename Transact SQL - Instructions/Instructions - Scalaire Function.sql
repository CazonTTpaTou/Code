CREATE FUNCTION dbo.Count_Position(@idArtist varchar) returns int 
WITH EXECUTE AS CALLER
as
begin
	declare @valeur int;
	select @valeur = count(*) 
	from 
		[dbo].[wlobal_rankings]
	where [Artist] = @idArtist
		  and [Position]<50;

	return(@valeur)
end;

go



