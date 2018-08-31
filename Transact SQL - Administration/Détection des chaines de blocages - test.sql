/*
CREATE TABLE sys_dm_exec_requests (session_id INT PRIMARY KEY, blocking_session_id INT)

INSERT INTO sys_dm_exec_requests
SELECT session_id, blocking_session_id
FROM   sys.dm_exec_requests


INSERT INTO sys_dm_exec_requests
(session_id, blocking_session_id) VALUES
(53, 0),
(58, 53),
(59, 58),
(56, 59),
(61, 59),
(62, 59),
(67, 62),
(69, 67),
(70, 62),
(63, 59),
(64, 63),
(65, 63),
(57, 0),
(66, 57),
(71, 66),
(72, 57);
*/

WITH 
T_SESSION AS
(
SELECT session_id, blocking_session_id
FROM   sys_dm_exec_requests AS tout
WHERE  session_id > 50
),
T_LEAD AS
(
SELECT session_id, blocking_session_id
FROM   T_SESSION AS tout
WHERE  session_id > 50
  AND  blocking_session_id = 0
  AND  EXISTS(SELECT * 
              FROM   T_SESSION AS tin
			  WHERE  tin.blocking_session_id = tout.session_id)
),
T_CHAIN AS
(
SELECT session_id AS lead_session_id, session_id, blocking_session_id, 1 AS p
FROM   T_LEAD
UNION  ALL
SELECT C.lead_session_id, S.session_id, S.blocking_session_id, p+1 
FROM   T_CHAIN AS C
       JOIN T_SESSION AS S
	        ON C.session_id = S.blocking_session_id
)
SELECT lead_session_id AS LEAD_BLOCKER, 
       COUNT(*) -1 AS BLOCKED_SESSIONS, 
	   MAX(p) - 1 AS BLOCKED_DEEP
FROM T_CHAIN
GROUP  BY lead_session_id
ORDER BY BLOCKED_SESSIONS DESC, BLOCKED_DEEP DESC;
