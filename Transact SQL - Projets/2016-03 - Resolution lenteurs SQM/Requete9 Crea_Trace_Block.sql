/****************************************************/
/* Created by: SQL Server 2012  Profiler          */
/* Date: 22/03/2016  17:46:25         */
/****************************************************/
exec sp_configure 'xp_cmdshell',1 ;
Go
reconfigure ;
go

exec xp_cmdshell 'mkdir "C:\Trace_block\"'
-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set @maxfilesize = 50

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 2, N'C:\Trace_block\BlockReport_20160322_', @maxfilesize, NULL, 25
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 3, @on
exec sp_trace_setevent @TraceID, 137, 4, @on
exec sp_trace_setevent @TraceID, 137, 12, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 14, @on
exec sp_trace_setevent @TraceID, 137, 22, @on
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 24, @on
exec sp_trace_setevent @TraceID, 137, 26, @on
exec sp_trace_setevent @TraceID, 137, 32, @on
exec sp_trace_setevent @TraceID, 137, 41, @on
exec sp_trace_setevent @TraceID, 137, 51, @on
exec sp_trace_setevent @TraceID, 137, 60, @on
exec sp_trace_setevent @TraceID, 137, 64, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
/*
exec sp_trace_setstatus 2, 0;
go
exec sp_trace_setstatus 2, 2;
go
*/