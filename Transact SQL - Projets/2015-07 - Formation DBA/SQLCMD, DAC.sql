----------------------------------------------------
--                   session 1
----------------------------------------------------
USE tempdb
GO

DROP TABLE temp

CREATE TABLE temp (texte varchar(50))
INSERT INTO temp (texte) VALUES ('ne bougez pas, j''arrive !')

BEGIN TRANSACTION

SELECT texte
FROM temp WITH(holdlock, rowlock)

----------------------------------------------------
--                   session 2
----------------------------------------------------
USE tempdb
GO

BEGIN TRANSACTION

UPDATE temp
SET texte = 'attendez-moi !!'

-- ensuite ...
-- ROLLBACK

----------------------------------------------------
--                   DAC
----------------------------------------------------
SELECT 
CAST(DB_NAME(t1.resource_database_id) as char(20)) as db,
CAST(t1.request_mode as char(5)) mode,
t1.request_session_id spid,
t2.blocking_session_id bloquePar
FROM sys.dm_tran_locks as t1
INNER JOIN sys.dm_os_waiting_tasks as t2 ON t1.lock_owner_address = t2.resource_address

