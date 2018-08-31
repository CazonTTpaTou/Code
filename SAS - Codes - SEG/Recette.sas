/**********************************************************************************************************************/
/* FICHE DESCRIPTIVE DU PROGRAMME :                                                                                   */
/*                                                                                                                    */
/* NOM.................= Recette                                                                                      */
/* MODELE..............=                                                                                              */
/* LIBELLE.............= Programme de validation des developpements (recette technique)                               */
/*                                                                                                                    */
/*---------------------------------------------- DESCRIPTION SOMMAIRE --------------------------------------------------*/
/* OBJET  : 3 Macros présentes : - desc_variable sort un fichier excel avec les modalités de chacune des variables    */
/*              - compare_dev_prod compare les structure et les données des tables de DEV avec les tables en PROD     */
/*              - test_dev appelle les 2 macros précédentes                                                           */
/*                                                                                                                    */
/*---------------------------------------------- DONNEES ---------------------------------------------------------------*/
/*                                                                                                                    */
/*                                                                                                                    */
/*                                                                                                                    */
/*                                                                                                                    */
/*---------------------------------------------- HISTORIQUE ------------------------------------------------------------*/
/* VERSION * AUTEUR        * DATE DE MAJ *       COMMENTAIRES                                                         */
/*---------*---------------*-------------*------------------------------------------------------------------------------*/
/* M001C01 * M.MORNET      * 06/03/2014  * CREATION DE L'OBJET                                                        */
/*---------*---------------*-------------*------------------------------------------------------------------------------*/
/*         *               *             *                                                                            */
/************************                        FIN CARTOUCHE                        *********************************/


/* macro desc_variable : génère un fichier excel avec les modalités de chacune des variables
on trouvera un onglet par variables étudiées
paramètres : 
- bib 		-> bibliothèque de la DEV (où se trouve la table à tester) 
- tab 		-> nom de la table à tester
- listvar 	-> liste des variables (séparées par une ,) à tester)
- path_sort -> chemin où se trouvera le fichier Excel de sortie
*/

%macro desc_variable(bib=, tab=,var=,listvar=,path_sort=);

data _null_ ;
call symput("nb",count(&listvar,",")+1);
run;

%put ----> nb : &nb;

%do i=1 %to &nb;
	%let var=%scan(&listvar,&i,",");
	%put ----> var : &var;

	proc sql;
	create table desc_&var as
	select &var, count(*) as nb
	from &bib..&tab
	group by &var
	order by &var
	;
	quit;

	PROC EXPORT DATA = work.desc_&var
	OUTFILE = "&path_sort\&tab..xls"
	DBMS = EXCEL
	REPLACE ;
	SHEET = "&var" ;
	RUN ; 
%end;

proc datasets lib=work kill nolist memtype=data;
quit;

%mend;


/* macro desc_variable : compare_dev_prod compare les structure et les données des tables de DEV 
avec les tables en PROD
paramètres : 
- path_prod -> chemin où se trouve la table de PROD (préalablement rapatrié en DEV)
- bib 		-> bibliothèque de la DEV (où se trouve la table à tester) 
- tab 		-> nom de la table à tester
- listvar 	-> liste des variables (séparées par une ,) à tester)
*/

%macro compare_dev_prod(path_prod=,bib=, tab=, listvar=);
libname PROD "&path_prod";

	
data _null_;
call symput ("listvar2", tranwrd(&listvar,","," "));
run;

data tab2 (drop=&listvar2);
set &bib..&tab;
run;



proc contents data=tab2 out=contents_dev 
(drop=libname memname charset crdate modate);
run;

proc contents data=PROD.&tab out=contents_prod (drop=libname memname charset crdate modate);
run;

proc compare base=contents_prod compare=contents_dev out=structure outbase outcompare outdiff outnoequal criterion=0.01;
run;


proc sql;
select count(*) into : nb_err_struc
from structure;
quit;

%if &nb_err_struc=0 %then %do;
	proc sort data=tab2;
	by _all_;
	run;

	proc sort data=PROD.&tab;
	by _all_;
	run;

	proc compare base=PROD.&tab compare=tab2 out=&tab outbase outcompare outdiff outnoequal criterion=0.01;
	run;

%end;
 
proc datasets library = work ;
    DELETE tab2 contents: ;
run;

%mend;

/* macro test_dev exécute l'ensemble des tests de recette pour une table donnée en
appelant les 2 macros précédentes */

%macro test_dev();

%let listvar=
Code_Grade,
Libelle_Grade,
Code_Techno,
Libelle_Techno, 
Code_Type_Cel,		
Libelle_Type_Cel,	
Code_Nb_Cel,
Libelle_Nb_Cel,
Code_Encadrement,
Libelle_Encadrement	,
Code_Sortie,	
Libelle_Sortie,		
Code_Verre,		
Libelle_Verre,
Code_Lamine,	
Libelle_Lamine,	
Libelle_Puissance,
Nom_Commerce,
Puissance_Totale,
ItemType;

%let biblio= DTM_PUR;
%let table=DTM_PUR_ARTICLES_SEGMENTATION;
%let root=E:\Partage\Suivi\Ticket 7767;
%let chemin_Prod=E:\Partage\Suivi\Ticket 7767\recette;


%desc_variable(bib=&biblio, tab=&table, listvar="&listvar",path_sort=&root);

%compare_dev_prod(path_prod=&chemin_prod,bib=&biblio, tab=&table, listvar="&listvar");

%mend;

%test_dev();


