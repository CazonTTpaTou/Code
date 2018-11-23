USE [Test]
GO

/****** Object:  UserDefinedFunction [dbo].[Count_Position]    Script Date: 22/11/2018 13:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Round_Stream](@stream bigint) returns bigint 
WITH EXECUTE AS CALLER
as
begin
	declare @valeur bigint;
	select @valeur = Floor(@stream / 100) * 100;

	return(@valeur)
end;

GO

