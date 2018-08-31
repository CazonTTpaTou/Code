/******************************************************************************/
/* FICHE DESCRIPTIVE D'OBJET :                                                */
/*                                                                            */
/* CODE................= Recup_log                                            */
/* AUTEUR..............= Micropole                                            */
/* CREE LE.............= 12/11/2014                                           */
/* TYPE DE L'OBJET.....= PROGRAMME                                            */
/* DOMAINE.............= PHOTOWATT - PRODUCTION                               */
/* PROJET..............= Suivi des logs                                       */
/* LIBELLE.............=                                                      */
/*                                                                            */
/*-----------------------------DESCRIPTION SOMMAIRE --------------------------*/
/* OBJET  : Recupération du Real tiem et du cpu time dans les logs            */
/*          des jobs DIS                                                      */
/*                                                                            */
/*-------------------------------DONNEES---------------------------------------*/
/*                                                                            */
/*                                                                            */
/*                                                                            */
/*                                                                            */
/*-------------------------------FICHIERS--------------------------------------*/
/* Fichiers lus                                                               */
/*         Fichier des logs                                                   */
/* Fichiers mis à jour                                                        */
/*         Aucun                                                              */
/*                                                                            */
/*-----------------------------HISTORIQUE--------------------------------------*/
/* VERSION * AUTEUR      * DATE DE MAJ * COMMENTAIRES                         */
/*---------*-------------*-------------*---------------------------------------*/
/* V1R1M0  * MICROPOLE   * 12/11/2014  * CREATION DE L'OBJET                  */
/*---------*-------------*-------------*---------------------------------------*/
/*         *             *             *                                      */
/************************    FIN CARTOUCHE    *********************************/



/**********************************/
/* Définition des macro-variables */
/**********************************/


/* création du chemin où se trouve la log à lire*/
%let rep=3 - TEMP;
%let date=20140120; 
%let chemin =\\srv-sasdev\Partage\0 - Archives\11 - Mesures performance\1 - Archives\log jobs\&rep.\log\&date.\

%let fic=JOB_TEMP_PRO_WAFERS_1015; /* nom du fichier log à lire */
%let fic_court=%substr("&fic.",5,9); /* pour éviter que le nom des tables soit trop long*/
%put ----> &fic.;
%put ----> &fic_court.;



/**********************************/
/*     Récupération de la log     */
/**********************************/


/*on place le contenu du fichier dans une table */
DATA WORK.&fic_court.;
    LENGTH
        F1               $ 1000 ;
    KEEP
        F1 ;
    FORMAT
        F1               $CHAR1000. ;
    INFORMAT
        F1               $CHAR1000. ;
    INFILE "&chemin.\&fic..log"
        LRECL=132
        ENCODING="WLATIN1"
        TERMSTR=CRLF
        TRUNCOVER ;
    INPUT
        @1     F1               $CHAR1000.
		;
RUN;

/*on ne récupère que les infos importantes : les nom des étapes des sous étapes et les temps */

data &fic_court._time;
set &fic_court.;
if ((index(upcase(F1),"DATA ") ge 1 or index(upcase(F1),"PROC")ge 1) AND index(upcase(F1),"NOTE")  ge 1 
AND index(upcase(F1),"%") = 0)
or index(upcase(F1)," CPU TIME") ge 3 Or index(upcase(F1),"REAL TIME") ge 1 
or index(upcase(F1)," * ETAPE : ") ge 9
then output;
run;

/* mise en place d identifiant pour les étapes et sous étapes */
data &fic_court._id (drop=inter et);
set &fic_court._time;
retain inter et;
if _n_=1 then do; inter=0; nb=inter;et=1; etape=et; end;
else if index(upcase(F1),"* ETAPE :") ge 1 then do;
	nb=inter+1;
	inter=nb;
	etape=1;
	et=etape;
end;
else do;
	nb=inter;
	IF index(upcase(F1),"NOTE") ge 1 then do;
		etape=et+1;
		et=etape;
	end;
	else etape=et; 
end;
run;


/* tri pour pouvoir transposer */

PROC SORT
	DATA=&fic_court._id (KEEP=F1 nb etape)
	OUT=&fic_court._tri
	;
	BY nb etape;
RUN;

/* transposition pour avoir le real time et le cpu time en colonne */
PROC TRANSPOSE DATA=&fic_court._tri
	OUT=&fic_court._trans (rename=(etape=nb_etape)
where=(compress(colonne2) ne "" or index(upcase(colonne1),"* ETAPE :") ge 1))
	PREFIX=Colonne
	NAME=Source
	LABEL='Libellé'n
;
	BY nb etape;
	VAR F1;
RUN;

/* ajustements: récupération uniquement du temps dans les colonnes, du nom de l'étape*/
data &fic_court._fin (drop=test source colonne2 colonne3 where=(index(upcase(ss_etape),"* ETAPE")=0) 
rename=(colonne1=ss_etape ));
set &fic_court._trans;
retain test;
by nb;
if first.nb then do;
	etape=Colonne1;
	test=etape;
end;
else etape=test;
if index(upcase(colonne1),"REAL TIME") ge 1 then do;
	colonne3=colonne2;
	colonne2=colonne1;
	etape="Initialisation";
end;
else etape=scan(strip(etape),5," ");
real_time=scan(colonne2,3," ");
cpu_time=scan(colonne3,3," ");
run;

/* mise à jour des compteurs de sous étape*/
data &fic_court._fin (drop=aa);
set &fic_court._fin;
retain aa;
by nb;
if first.nb then do;
	nb_ss_etape=1;
	aa=1;
end;
else do;
	nb_ss_etape=aa+1;
	aa= nb_ss_etape;
end;
job="&fic.";
run;

/* mise en ordre des colonnes */
data &fic_court._fin (drop=nb_etape);
RETAIN job nb etape nb_ss_etape ss_etape real_time cpu_time colonne4 colonne5;
set &fic_court._fin;
run;