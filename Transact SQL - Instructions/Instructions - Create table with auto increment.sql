USE [Test]
GO

/****** Object:  Table [dbo].[wlobal_rankings]    Script Date: 23/11/2018 14:31:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[global_rankings](
	[id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Position] [int] NULL,
	[Track_Name] [nvarchar](150) NULL,
	[Artist] [nvarchar](50) NULL,
	[Streams] [int] NULL,
	[URL] [nvarchar](100) NULL,
	[Date] [datetime2](7) NULL,
	[Region] [nvarchar](50) NULL,
	[stream] [bigint] NULL
) ON [PRIMARY]
GO


