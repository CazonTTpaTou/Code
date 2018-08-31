options emailsys=SMTP emailhost=smtp.photowatt.com emailport=25;

LIBNAME AUTO_NP BASE "D:\SAS\AUTOLOAD\VALIBLA";
LIBNAME LANDING2 BASE "D:\SAS\DATAMNGT\LANDING\NO_PUBLIC";
LIBNAME VALIBLA SASIOLA  TAG=HPS  PORT=10011 HOST="srv-sasva.photowatt.local"; 

PROC SQL;
   Create table Work.VerificationDatamarts AS
	   SELECT libname,memname,nobs
	   from dictionary.tables
	   where (upcase(libname)='VALIBLA' 
	          or
	          upcase(libname)='LANDING2') 
	         and
			 upcase(memname)^='DATA_PALPEUR';
	   		 /*SUBSTR(upcase(memname),1,12)='DTM_PRO_TRAC';*/			 
Quit;

PROC SQL;
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

DATA Work.RatioDataMart;
SET Work.RatioDatamarts;
IF ratio >0.6 or ratio <0.4 THEN OUTPUT;
RUN;

/* Macro pour l'envoi de mail des interventions de la veille au service Process */
%macro envoi_mail(dest=,Libelle=);

/* Paramétrage de la fonction d'envoi de mail */
FileName  SENDMAIL Email 	  	
			to 		= ("&dest")
			from	= ("SuiviIntervention@photowatt.com")
			type	= "text/html"
			subject = "SAS VA LASR - Tables en erreur";

/* Détermination du nombre d'intervention de la veille */
PROC SQL;
		SELECT count(*) into: nb_int from Work.RatioDatamart;
quit;

/* Si des interventions ont eu lieu l'email est envoyé */
%if &nb_int >0 
				%then %do;

				/* Tri des interventions de la veille par ancienneté */
				PROC SORT DATA= Work.RatioDatamart;
						by descending ratio ;
				RUN;

				/* Construction du corps de l'email à envoyer */
				ODS HTML BODY=SENDMAIL ;
					title "Sur la dernière actualisation, &nb_int table(s) ont eu des problèmes d'actualisation :";
					PROC report data=Work.RatioDatamart;
						 		columns libname memname nobs Cumul ratio;
					RUN;
				ODS HTML CLOSE;

				%end;

%mend;

/* Envoi des e-mails de notification d'erreur */

%envoi_mail(dest=f.monnery@photowatt.com,libelle=Wafers-Cellules-Modules);




