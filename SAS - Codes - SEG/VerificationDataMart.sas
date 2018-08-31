LIBNAME AUTO_NP BASE "D:\SAS\AUTOLOAD\VALIBLA";
LIBNAME LANDING2 BASE "D:\SAS\DATAMNGT\LANDING\NO_PUBLIC";
LIBNAME VALIBLA SASIOLA  TAG=HPS  PORT=10011 HOST="srv-sasva.photowatt.local"; 

proc sql;
   Create table Work.VerificationDatamarts AS
	   SELECT libname,memname,nobs
	   from dictionary.tables
	   where (upcase(libname)='VALIBLA' 
	          or
	          upcase(libname)='LANDING2') 
	         and
	   		 SUBSTR(upcase(memname),1,12)='DTM_PRO_TRAC';
quit;

Proc SQL;
	Create Table Work.CumulDatamarts AS
		SELECT memname,SUM(nobs) as Cumul
		FROM Work.VerificationDatamarts
		GROUP BY memname;
Quit;

PROC SQL;
	Create table Work.RatioDatamarts AS
		SELECT T1.libname,T1.memname,T1.nobs,T2.Cumul,T1.nobs/T2.Cumul As ratio
			FROM Work.VerificationDatamarts AS T1			  
			INNER JOIN 
				 Work.CumulDatamarts AS T2
				 ON T1.memname = T2.memname;
Quit;

PROC PRINT data=Work.RatioDatamarts;
RUN;
