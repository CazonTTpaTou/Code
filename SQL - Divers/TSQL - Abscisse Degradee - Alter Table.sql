use test;
GO

ALTER TABLE [dbo].[wlobal_rankings]
	ADD stream bigint NULL;

GO

INSERT INTO [dbo].[wlobal_rankings] (stream) select streams from [dbo].[wlobal_rankings];

SELECT stream,streams from [dbo].[wlobal_rankings]; 

delete [dbo].[wlobal_rankings] where isnull([Track_Name],'') = '';

update [dbo].[wlobal_rankings] set stream=streams;