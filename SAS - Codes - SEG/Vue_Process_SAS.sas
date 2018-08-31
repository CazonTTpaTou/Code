PROC SQL;
SELECT	*

	FROM GMAO.VUE_Process_Liste_Intervention
	ORDER BY Recence DESC, Date_Debut DESC;

QUIT;

