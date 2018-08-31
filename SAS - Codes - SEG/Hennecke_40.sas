/* ----------------------------------------
Code exporté depuis SAS Enterprise Guide
DATE : mercredi 13 décembre 2017     HEURE : 10:08:22
PROJET : Hennecke_40
CHEMIN DU PROJET : C:\Users\pwsasdev\Desktop\Hennecke_40.egp
---------------------------------------- */

/* Affectation d'une bibliothèque pour SASApp.STATS */
;
/* Affectation d'une bibliothèque pour SASApp.DTM_PRO */
;


/* Conditionally delete set of tables or views, if they exists          */
/* If the member does not exist, then no action is performed   */
%macro _eg_conditional_dropds /parmbuff;
	
   	%local num;
   	%local stepneeded;
   	%local stepstarted;
   	%local dsname;
	%local name;

   	%let num=1;
	/* flags to determine whether a PROC SQL step is needed */
	/* or even started yet                                  */
	%let stepneeded=0;
	%let stepstarted=0;
   	%let dsname= %qscan(&syspbuff,&num,',()');
	%do %while(&dsname ne);	
		%let name = %sysfunc(left(&dsname));
		%if %qsysfunc(exist(&name)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;

			%end;
				drop table &name;
		%end;

		%if %sysfunc(exist(&name,view)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;
			%end;
				drop view &name;
		%end;
		%let num=%eval(&num+1);
      	%let dsname=%qscan(&syspbuff,&num,',()');
	%end;
	%if &stepstarted %then %do;
		quit;
	%end;
%mend _eg_conditional_dropds;


/* Build where clauses from stored process parameters */

%macro _eg_WhereParam( COLUMN, PARM, OPERATOR, TYPE=S, MATCHALL=_ALL_VALUES_, MATCHALL_CLAUSE=1, MAX= , IS_EXPLICIT=0);

  %local q1 q2 sq1 sq2;
  %local isEmpty;
  %local isEqual isNotEqual;
  %local isIn isNotIn;
  %local isString;
  %local isBetween;

  %let isEqual = ("%QUPCASE(&OPERATOR)" = "EQ" OR "&OPERATOR" = "=");
  %let isNotEqual = ("%QUPCASE(&OPERATOR)" = "NE" OR "&OPERATOR" = "<>");
  %let isIn = ("%QUPCASE(&OPERATOR)" = "IN");
  %let isNotIn = ("%QUPCASE(&OPERATOR)" = "NOT IN");
  %let isString = (%QUPCASE(&TYPE) eq S or %QUPCASE(&TYPE) eq STRING );
  %if &isString %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%");
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq D or %QUPCASE(&TYPE) eq DATE %then 
  %do;
    %let q1=%str(%");
    %let q2=%str(%"d);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq T or %QUPCASE(&TYPE) eq TIME %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%"t);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq DT or %QUPCASE(&TYPE) eq DATETIME %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%"dt);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else
  %do;
    %let q1=;
    %let q2=;
	%let sq1=;
    %let sq2=;
  %end;
  
  %if "&PARM" = "" %then %let PARM=&COLUMN;

  %let isBetween = ("%QUPCASE(&OPERATOR)"="BETWEEN" or "%QUPCASE(&OPERATOR)"="NOT BETWEEN");

  %if "&MAX" = "" %then %do;
    %let MAX = &parm._MAX;
    %if &isBetween %then %let PARM = &parm._MIN;
  %end;

  %if not %symexist(&PARM) or (&isBetween and not %symexist(&MAX)) %then %do;
    %if &IS_EXPLICIT=0 %then %do;
		not &MATCHALL_CLAUSE
	%end;
	%else %do;
	    not 1=1
	%end;
  %end;
  %else %if "%qupcase(&&&PARM)" = "%qupcase(&MATCHALL)" %then %do;
    %if &IS_EXPLICIT=0 %then %do;
	    &MATCHALL_CLAUSE
	%end;
	%else %do;
	    1=1
	%end;	
  %end;
  %else %if (not %symexist(&PARM._count)) or &isBetween %then %do;
    %let isEmpty = ("&&&PARM" = "");
    %if (&isEqual AND &isEmpty AND &isString) %then
       &COLUMN is null;
    %else %if (&isNotEqual AND &isEmpty AND &isString) %then
       &COLUMN is not null;
    %else %do;
	   %if &IS_EXPLICIT=0 %then %do;
           &COLUMN &OPERATOR %unquote(&q1)&&&PARM%unquote(&q2)
	   %end;
	   %else %do;
	       &COLUMN &OPERATOR %unquote(%nrstr(&sq1))&&&PARM%unquote(%nrstr(&sq2))
	   %end;
       %if &isBetween %then 
          AND %unquote(&q1)&&&MAX%unquote(&q2);
    %end;
  %end;
  %else 
  %do;
	%local emptyList;
  	%let emptyList = %symexist(&PARM._count);
  	%if &emptyList %then %let emptyList = &&&PARM._count = 0;
	%if (&emptyList) %then
	%do;
		%if (&isNotin) %then
		   1;
		%else
			0;
	%end;
	%else %if (&&&PARM._count = 1) %then 
    %do;
      %let isEmpty = ("&&&PARM" = "");
      %if (&isIn AND &isEmpty AND &isString) %then
        &COLUMN is null;
      %else %if (&isNotin AND &isEmpty AND &isString) %then
        &COLUMN is not null;
      %else %do;
	    %if &IS_EXPLICIT=0 %then %do;
            &COLUMN &OPERATOR (%unquote(&q1)&&&PARM%unquote(&q2))
	    %end;
		%else %do;
		    &COLUMN &OPERATOR (%unquote(%nrstr(&sq1))&&&PARM%unquote(%nrstr(&sq2)))
		%end;
	  %end;
    %end;
    %else 
    %do;
       %local addIsNull addIsNotNull addComma;
       %let addIsNull = %eval(0);
       %let addIsNotNull = %eval(0);
       %let addComma = %eval(0);
       (&COLUMN &OPERATOR ( 
       %do i=1 %to &&&PARM._count; 
          %let isEmpty = ("&&&PARM&i" = "");
          %if (&isString AND &isEmpty AND (&isIn OR &isNotIn)) %then
          %do;
             %if (&isIn) %then %let addIsNull = 1;
             %else %let addIsNotNull = 1;
          %end;
          %else
          %do;		     
            %if &addComma %then %do;,%end;
			%if &IS_EXPLICIT=0 %then %do;
                %unquote(&q1)&&&PARM&i%unquote(&q2) 
			%end;
			%else %do;
			    %unquote(%nrstr(&sq1))&&&PARM&i%unquote(%nrstr(&sq2)) 
			%end;
            %let addComma = %eval(1);
          %end;
       %end;) 
       %if &addIsNull %then OR &COLUMN is null;
       %else %if &addIsNotNull %then AND &COLUMN is not null;
       %do;)
       %end;
    %end;
  %end;
%mend;

/* ---------------------------------- */
/* MACRO: enterpriseguide             */
/* PURPOSE: define a macro variable   */
/*   that contains the file system    */
/*   path of the WORK library on the  */
/*   server.  Note that different     */
/*   logic is needed depending on the */
/*   server type.                     */
/* ---------------------------------- */
%macro enterpriseguide;
%global sasworklocation;
%local tempdsn unique_dsn path;

%if &sysscp=OS %then %do; /* MVS Server */
	%if %sysfunc(getoption(filesystem))=MVS %then %do;
        /* By default, physical file name will be considered a classic MVS data set. */
	    /* Construct dsn that will be unique for each concurrent session under a particular account: */
		filename egtemp '&egtemp' disp=(new,delete); /* create a temporary data set */
 		%let tempdsn=%sysfunc(pathname(egtemp)); /* get dsn */
		filename egtemp clear; /* get rid of data set - we only wanted its name */
		%let unique_dsn=".EGTEMP.%substr(&tempdsn, 1, 16).PDSE"; 
		filename egtmpdir &unique_dsn
			disp=(new,delete,delete) space=(cyl,(5,5,50))
			dsorg=po dsntype=library recfm=vb
			lrecl=8000 blksize=8004 ;
		options fileext=ignore ;
	%end; 
 	%else %do; 
        /* 
		By default, physical file name will be considered an HFS 
		(hierarchical file system) file. 
		*/
		%if "%sysfunc(getoption(filetempdir))"="" %then %do;
			filename egtmpdir '/tmp';
		%end;
		%else %do;
			filename egtmpdir "%sysfunc(getoption(filetempdir))";
		%end;
	%end; 
	%let path=%sysfunc(pathname(egtmpdir));
    %let sasworklocation=%sysfunc(quote(&path));  
%end; /* MVS Server */
%else %do;
	%let sasworklocation = "%sysfunc(getoption(work))/";
%end;
%if &sysscp=VMS_AXP %then %do; /* Alpha VMS server */
	%let sasworklocation = "%sysfunc(getoption(work))";                         
%end;
%if &sysscp=CMS %then %do; 
	%let path = %sysfunc(getoption(work));                         
	%let sasworklocation = "%substr(&path, %index(&path,%str( )))";
%end;
%mend enterpriseguide;

%enterpriseguide

/* save the current settings of XPIXELS and YPIXELS */
/* so that they can be restored later               */
%macro _sas_pushchartsize(new_xsize, new_ysize);
	%global _savedxpixels _savedypixels;
	options nonotes;
	proc sql noprint;
	select setting into :_savedxpixels
	from sashelp.vgopt
	where optname eq "XPIXELS";
	select setting into :_savedypixels
	from sashelp.vgopt
	where optname eq "YPIXELS";
	quit;
	options notes;
	GOPTIONS XPIXELS=&new_xsize YPIXELS=&new_ysize;
%mend;

/* restore the previous values for XPIXELS and YPIXELS */
%macro _sas_popchartsize;
	%if %symexist(_savedxpixels) %then %do;
		GOPTIONS XPIXELS=&_savedxpixels YPIXELS=&_savedypixels;
		%symdel _savedxpixels / nowarn;
		%symdel _savedypixels / nowarn;
	%end;
%mend;

ODS PROCTITLE;
OPTIONS DEV=ACTIVEX;
GOPTIONS XPIXELS=0 YPIXELS=0;
FILENAME EGSRX TEMP;
ODS tagsets.sasreport13(ID=EGSRX) FILE=EGSRX
    STYLE=HtmlBlue
    STYLESHEET=(URL="file:///C:/Program%20Files/SASHomeV94/SASEnterpriseGuide/6.1/Styles/HtmlBlue.css")
    NOGTITLE
    NOGFOOTNOTE
    GPATH=&sasworklocation
    ENCODING=UTF8
    options(rolap="on")
;

/*   DEBUT DE NOEUD : defauts_absdegradee   */
%LET _CLIENTTASKLABEL='defauts_absdegradee';
%LET _CLIENTPROJECTPATH='C:\Users\pwsasdev\Desktop\Hennecke_40.egp';
%LET _CLIENTPROJECTNAME='Hennecke_40.egp';

GOPTIONS ACCESSIBLE;
%_eg_conditional_dropds(WORK.QUERY_FOR_USER_HENNECKE_0000);

PROC SQL;
   CREATE TABLE WORK.QUERY_FOR_USER_HENNECKE_0000 AS 
   SELECT /* def_Thickn */
            (case
            when QThickn > 4 then
            1
            else
            0
            end) LABEL="def_Thickn" AS def_Thickn, 
          /* def_Strie_sur_tranche */
            (case
            when QSawEdge > 4 then
            1
            else
            0
            end) LABEL="def_Strie_sur_tranche" AS def_Strie_sur_tranche, 
          /* def_Chip */
            (case
            when QChip >4 then
            1
            else
            0
            end) LABEL="def_Chip" AS def_Chip, 
          /* def_Ebrechure_sur_tranche */
            (case
            when QEdge > 4 then
            1
            else
            0
            end
            ) LABEL="def_Ebrechure_sur_tranche" AS def_Ebrechure_sur_tranche, 
          /* def_Taille */
            (case
            when QSize > 4 then
            1
            else
            0
            end) LABEL="def_Taille" AS def_Taille, 
          /* def_taille_diagonale */
            (case
            when QDSize > 4 then
            1
            else
            0
            end) LABEL="def_taille_diagonale" AS def_taille_diagonale, 
          /* def_Rectangularite */
            (case
            when QRect > 4 then
            1
            else
            0
            end) LABEL="def_Rectangularite" AS def_Rectangularite, 
          /* def_Long_chanfrein */
            (case
            when QChLen > 4 then
            1
            else
            0
            end) LABEL="def_Long_chanfrein" AS def_Long_chanfrein, 
          /* def_Mesure_angle */
            (case
            when QChAngle > 4 then
            1
            else
            0
            end) LABEL="def_Mesure_angle" AS def_Mesure_angle, 
          /* def_parallelisme */
            (case
            when QUnp > 4 then
            1
            else
            0
            end) LABEL="def_parallelisme" AS def_parallelisme, 
          /* def_Ondulations */
            (case
            when QSaw2 > 4 then
            1
            else
            0
            end) LABEL="def_Ondulations" AS def_Ondulations, 
          /* def_Stries */
            (case
            when QSaw1 > 4 then
            1
            else
            0
            end) LABEL="def_Stries" AS def_Stries, 
          /* def_TTV */
            (case
            when QTTV > 4 then
            1
            else 0
            end) LABEL="def_TTV" AS def_TTV, 
          /* def_BOW */
            (case
            when QBOW > 4 then
            1
            else
            0
            end) LABEL="def_BOW" AS def_BOW, 
          /* abs_degradee */
            (CASE 
               WHEN    Annee  = Year(today()) AND Month(DatePart(Time))  = Month(today()) AND Week(DatePart(Time))  = 
            Week(today())   then cats('z',jour)
            
                    WHEN    Annee  = Year(today()) AND Month(DatePart(Time))  = Month(today()) AND 
            Week(DatePart(Time))  <> Week(today())    then semaine
            
                    WHEN    Annee  = Year(today()) AND Month(DatePart(Time))  <> Month(today()) then cats('m',mois)
            
               ELSE cats('a',annee)
            END
            ) LABEL="abs_degradee" AS abs_degradee, 
          t1.N_Assemblage, 
          t1.Time, 
          t1.semaine, 
          t1.mois, 
          t1.trimestre, 
          t1.annee
      FROM STATS.USER_HENNECKE t1;
QUIT;

GOPTIONS NOACCESSIBLE;


%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTNAME=;


/*   DEBUT DE NOEUD : Filtrer et trier   */
%LET _CLIENTTASKLABEL='Filtrer et trier';
%LET _CLIENTPROJECTPATH='C:\Users\pwsasdev\Desktop\Hennecke_40.egp';
%LET _CLIENTPROJECTNAME='Hennecke_40.egp';

GOPTIONS ACCESSIBLE;
%_eg_conditional_dropds(WORK.FILTER_FOR_DTM_PRO_TRAC_WAF_0000);

PROC SQL;
   CREATE TABLE WORK.FILTER_FOR_DTM_PRO_TRAC_WAF_0000 AS 
   SELECT t1.Assemblage_Num, 
          t1.Type_assemblage, 
          t1.Ass_Sci_Equipement
      FROM DTM_PRO.DTM_PRO_TRAC_WAFERS t1;
QUIT;

GOPTIONS NOACCESSIBLE;
%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTNAME=;


/*   DEBUT DE NOEUD : Générateur de requêtes1   */
%LET _CLIENTTASKLABEL='Générateur de requêtes1';
%LET _CLIENTPROJECTPATH='C:\Users\pwsasdev\Desktop\Hennecke_40.egp';
%LET _CLIENTPROJECTNAME='Hennecke_40.egp';

GOPTIONS ACCESSIBLE;
%_eg_conditional_dropds(WORK.QUERY_FOR_USER_HENNECKE_0001);

PROC SQL;
   CREATE TABLE WORK.QUERY_FOR_USER_HENNECKE_0001 AS 
   SELECT t1.def_Thickn, 
          t1.def_Strie_sur_tranche, 
          t1.def_Chip, 
          t1.def_Ebrechure_sur_tranche, 
          t1.def_Taille, 
          t1.def_taille_diagonale, 
          t1.def_Rectangularite, 
          t1.def_Long_chanfrein, 
          t1.def_Mesure_angle, 
          t1.def_parallelisme, 
          t1.def_Ondulations, 
          t1.def_Stries, 
          t1.def_TTV, 
          t1.def_BOW, 
          t1.abs_degradee, 
          t1.N_Assemblage, 
          t1.Time, 
          t1.semaine, 
          t1.mois, 
          t1.trimestre, 
          t1.annee, 
          t2.Assemblage_Num, 
          t2.Type_assemblage, 
          t2.Ass_Sci_Equipement
      FROM WORK.QUERY_FOR_USER_HENNECKE_0000 t1
           LEFT JOIN WORK.FILTER_FOR_DTM_PRO_TRAC_WAF_0000 t2 ON (t1.N_Assemblage = t2.Assemblage_Num);
QUIT;

GOPTIONS NOACCESSIBLE;



%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTNAME=;


/*   DEBUT DE NOEUD : calcul_pourcentage   */
%LET _CLIENTTASKLABEL='calcul_pourcentage';
%LET _CLIENTPROJECTPATH='C:\Users\pwsasdev\Desktop\Hennecke_40.egp';
%LET _CLIENTPROJECTNAME='Hennecke_40.egp';

GOPTIONS ACCESSIBLE;
%_eg_conditional_dropds(WORK.QUERY_FOR_USER_HENNECKE_0002);

PROC SQL;
   CREATE TABLE WORK.QUERY_FOR_USER_HENNECKE_0002 AS 
   SELECT DISTINCT /* Pourcent_Thickn */
                     (sum(def_Thickn)/count(Time)) FORMAT=PERCENT6.3 LABEL="Pourcent_Thickn" AS Pourcent_Thickn, 
          /* pourcent_strie_tranche */
            (sum(def_Strie_sur_tranche)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_strie_tranche" AS 
            pourcent_strie_tranche, 
          /* pourcent_Chip */
            (sum(def_Chip)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Chip" AS pourcent_Chip, 
          /* pourcent_ebrechure_tranche */
            (sum(def_Ebrechure_sur_tranche)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_ebrechure_tranche" AS 
            pourcent_ebrechure_tranche, 
          /* pourcent_Taille */
            (sum(def_Taille)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Taille" AS pourcent_Taille, 
          /* pourcent_Taille_diagonale */
            (sum(def_taille_diagonale)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Taille_diagonale" AS 
            pourcent_Taille_diagonale, 
          /* pourcent_rectag */
            (sum(def_Rectangularite)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_rectag" AS pourcent_rectag, 
          /* pourcent_Long_chanfrein */
            (sum(def_Long_chanfrein)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Long_chanfrein" AS 
            pourcent_Long_chanfrein, 
          /* pourcent_Mesure_angle */
            (sum(def_Mesure_angle)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Mesure_angle" AS pourcent_Mesure_angle, 
          /* pourcent_parallelisme */
            (sum(def_parallelisme)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_parallelisme" AS pourcent_parallelisme, 
          /* pourcent_Ondulations */
            (sum(def_Ondulations)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Ondulations" AS pourcent_Ondulations, 
          /* pourcent_Stries */
            (sum(def_Stries)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_Stries" AS pourcent_Stries, 
          /* pourcent_TTV */
            (sum(def_TTV)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_TTV" AS pourcent_TTV, 
          /* pourcent_BOW */
            (sum(def_BOW)/count(Time)) FORMAT=PERCENT6.3 LABEL="pourcent_BOW" AS pourcent_BOW, 
          t1.Type_assemblage, 
          t1.Ass_Sci_Equipement, 
          /* COUNT_of_Time */
            (COUNT(t1.Time)) AS COUNT_of_Time, 
          t1.abs_degradee
      FROM WORK.QUERY_FOR_USER_HENNECKE_0001 t1
      GROUP BY t1.abs_degradee,
               t1.Type_assemblage,
               t1.Ass_Sci_Equipement;
QUIT;

GOPTIONS NOACCESSIBLE;


%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTNAME=;


/*   DEBUT DE NOEUD : categorie_def   */
%LET _CLIENTTASKLABEL='categorie_def';
%LET _CLIENTPROJECTPATH='C:\Users\pwsasdev\Desktop\Hennecke_40.egp';
%LET _CLIENTPROJECTNAME='Hennecke_40.egp';

GOPTIONS ACCESSIBLE;
%_eg_conditional_dropds(WORK.QUERY_FOR_USER_HENNECKE_0003);

PROC SQL;
   CREATE TABLE WORK.QUERY_FOR_USER_HENNECKE_0003 AS 
   SELECT /* rejet_ebrechure */
            ( pourcent_strie_tranche + pourcent_Chip + pourcent_ebrechure_tranche ) FORMAT=PERCENT6.3 LABEL=
            "rejet_ebrechure" AS rejet_ebrechure, 
          /* rejet_Dimension */
            (pourcent_Taille + pourcent_Taille_diagonale + pourcent_rectag + pourcent_Long_chanfrein + 
            pourcent_Mesure_angle + pourcent_parallelisme) FORMAT=PERCENT6.3 LABEL="rejet_Dimension" AS rejet_Dimension, 
          t1.Pourcent_Thickn, 
          t1.pourcent_Stries, 
          t1.pourcent_TTV, 
          t1.pourcent_BOW, 
          t1.pourcent_Ondulations, 
          t1.abs_degradee, 
          t1.Type_assemblage, 
          t1.Ass_Sci_Equipement
      FROM WORK.QUERY_FOR_USER_HENNECKE_0002 t1;
QUIT;

GOPTIONS NOACCESSIBLE;


%LET _CLIENTTASKLABEL=;
%LET _CLIENTPROJECTPATH=;
%LET _CLIENTPROJECTNAME=;

;*';*";*/;quit;run;
ODS _ALL_ CLOSE;
