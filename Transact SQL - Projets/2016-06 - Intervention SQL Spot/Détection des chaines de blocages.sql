WITH 
/******************************************************************************
* Fr�d�ric Brouard, SQLpro@SQLspot.com, MVP Microsoft SQL Server - 2016-06-09 *
*******************************************************************************
* D�TECTION DES CHAINES DE BLOCAGE                                            * 
* Cette requ�te pr�sente les sessions bloquant les autres sessions en         *
* d�terminant la session � la t�te d'une chaine de blocage (LEAD_BLOCKER)     *
* avec le nombre de sessions bloqu�es et la longueur maximale de la cha�ne de *
* blocage.                                                                    *
* Ceci permet de d�terminer quelle session est � annuler en priorit� en cas   *
* blocage intempestif                                                         *
******************************************************************************/
T_SESSION AS
(
SELECT session_id, blocking_session_id
FROM   sys.dm_exec_requests AS tout
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