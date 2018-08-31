CREATE DATABASE DB_PHOTOWATT_DBA
GO
USE DB_PHOTOWATT_DBA
GO

SELECT *
INTO   TRACE_Photowatt_BLOCK_20160609
FROM   tempdb.[dbo].[TRACE_Photowatt_BLOCK];
GO

WITH
T_BLK AS
(
SELECT *, CAST(TextData AS XML) AS DataXml
FROM dbo.TRACE_Photowatt_BLOCK_20160609
)
SELECT t.*, X.BLOCKED_PROCESS.value('(./inputbuf[1])', 'NVARCHAR(max)') AS BLOCKED_QUERY,
            X.BLOCKED_PROCESS.value('(.[1]/@waitresource)', 'VARCHAR(256)') AS BLOCKED_RESOURCE,
			X.BLOCKED_PROCESS.value('(.[1]/@waittime)', 'INT') AS BLOCKED_WAIT_MS,
			X.BLOCKED_PROCESS.value('(.[1]/@lockMode)', 'sysname') AS BLOCKED_LOCK,
			X.BLOCKED_PROCESS.value('(.[1]/@trancount)', 'INT') AS BLOCKED_TRANCOUNT,
			X.BLOCKED_PROCESS.value('(.[1]/@clientapp)', 'NVARCHAR(256)') AS BLOCKED_APPLICATION,
			X.BLOCKED_PROCESS.value('(.[1]/@hostname)', 'sysname') AS BLOCKED_HOST,
			X.BLOCKED_PROCESS.value('(.[1]/@loginname)', 'sysname') AS BLOCKED_LOGIN,
			X.BLOCKED_PROCESS.value('(.[1]/@isolationlevel)', 'sysname') AS BLOCKED_ISOLATION,
			X.BLOCKED_PROCESS.value('(.[1]/@currentdb)', 'SMALLINT') AS BLOCKED_DB_ID,
            Y.BLOCKING_PROCESS.value('(./inputbuf[1])', 'NVARCHAR(max)') AS BLOCKING_QUERY,
		    Y.BLOCKING_PROCESS.value('(.[1]/@status)', 'VARCHAR(128)') AS BLOCKING_STATUS,
			Y.BLOCKING_PROCESS.value('(.[1]/@trancount)', 'INT') AS BLOCKING_TRANCOUNT,
			Y.BLOCKING_PROCESS.value('(.[1]/@clientapp)', 'NVARCHAR(256)') AS BLOCKING_APPLICATION,
			Y.BLOCKING_PROCESS.value('(.[1]/@hostname)', 'sysname') AS BLOCKING_HOST,
			Y.BLOCKING_PROCESS.value('(.[1]/@loginname)', 'sysname') AS BLOCKING_LOGIN,
			Y.BLOCKING_PROCESS.value('(.[1]/@isolationlevel)', 'sysname') AS BLOCKING_ISOLATION,
			Y.BLOCKING_PROCESS.value('(.[1]/@currentdb)', 'SMALLINT') AS BLOCKING_DB_ID           
FROM   T_BLK AS t
       CROSS APPLY DataXml.nodes('/blocked-process-report/blocked-process/process') AS X (BLOCKED_PROCESS)
	   CROSS APPLY DataXml.nodes('/blocked-process-report/blocking-process/process') AS Y (BLOCKING_PROCESS);