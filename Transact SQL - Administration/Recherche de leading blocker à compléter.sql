--SELECT * FROM sys.dm_exec_requests

WITH TB AS
(SELECT session_id AS leading_id, session_id, blocking_session_id, 1 as niveau
 FROM   sys.dm_exec_requests
 WHERE  blocking_session_id = 0
   AND  session_id > 50
 UNION ALL  
 SELECT TB.leading_id, er.session_id, er.blocking_session_id, niveau + 1
 FROM   sys.dm_exec_requests AS er
        INNER JOIN TB
              ON er.blocking_session_id = TB.session_id),
TFINAL AS
(SELECT *, ROW_NUMBER() OVER(PARTITION BY leading_id ORDER BY niveau DESC) AS N
 FROM   TB)            
SELECT *
FROM   TFINAL
WHERE  N = 1  

KILL 59         
