USE [SQM_DB]
GO
DBCC SHRINKFILE (N'sqmdb_Log' , 1024)
GO
USE [master]
GO
ALTER DATABASE [SQM_DB] MODIFY FILE ( NAME = N'sqmdb_Data', SIZE = 1048576KB , FILEGROWTH = 25600KB )
GO
ALTER DATABASE [SQM_DB] ADD FILE ( NAME = N'sqmdb_data2', FILENAME = N'D:\MSSQL\MSSQL10_50.SQM\MSSQL\SQM_MDF\SQM_DB.ndf' , SIZE = 1048576KB , FILEGROWTH = 25600KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [SQM_DB] MODIFY FILE ( NAME = N'sqmdb_Log', FILEGROWTH = 25600KB )
GO
