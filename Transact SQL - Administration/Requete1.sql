EXEC sys.sp_configure N'min server memory (MB)', N'6144'
GO
EXEC sys.sp_configure N'max server memory (MB)', N'8192'
GO
RECONFIGURE WITH OVERRIDE
GO
