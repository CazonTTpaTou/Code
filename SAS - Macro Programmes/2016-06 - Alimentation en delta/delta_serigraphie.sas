/* parse delta directory */
filename inmac "D:\SAS\Config\Lev1\SASApp\SASEnvironment\SASMacro";
%include inmac ( getnames.sas );
options mprint symbolgen;

data _null_;
   x "del /F /Q E:\SAS\listSerigraphie.txt";
run;

%GETNAMES(D:\SAS\DATAMNGT\LANDING\NO_PUBLIC\DELTA,E:\SAS\listSerigraphie.txt);

filename fileref "E:\SAS\listSerigraphie.txt";

%let nbfile=0;

data liste_fichiers;
    infile fileref truncover;
    input var1 $32.;
run;

proc sql noprint;
create table liste_fichiers_serigraphie
as select * from liste_fichiers
where UPCASE(var1) like 'DTM_SERIGRAPHIE%'
order by var1;
quit;

data _null_;
set liste_fichiers_serigraphie end=eof;
    call symput("filename"!!trim(left(_N_)),scan(trim(left(var1)),1,'.'));
    if eof then call symput("nbfile",trim(left(_N_)));
run;

/* get last date */
options validvarname=ANY;
libname delta2 "D:\SAS\DATAMNGT\LANDING\NO_PUBLIC\DELTA";

%let LAST_DATE=;
%macro get_last_date;
%if &nbfile eq 0 %then %do;
proc sql noprint;
SELECT PUT(MAX('Mesure Date Heure'n),datetime20.) into :LAST_DATE
FROM LANDING2.DTM_SERIGRAPHIE;
quit;
%end;
%else %do;
proc sql noprint;
SELECT PUT(MAX('Mesure Date Heure'n),datetime20.) into :LAST_DATE
FROM DELTA2.&&filename&nbfile.;
quit;
%end;
%mend;
%get_last_date;

data _null_;
a=input("&LAST_DATE",datetime20.);
call symput('LAST_DATE_CHR',trim(left("'"))!!trim(left("&LAST_DATE"))!!trim(left("'DT")));
call symput('LAST_DATE_NUM',catx("_",put(datepart(a),ddmmyyn6.),compress(translate(put(timepart(a),HHMM8.2),'',':.'))));
run;

%put &LAST_DATE_NUM;
%put &LAST_DATE_CHR;

/* create delta table */
%vdb_dt(DELTA2.DTM_SERIGRAPHIE&LAST_DATE_NUM.);
proc sql noprint;
    create table DELTA2.DTM_SERIGRAPHIE&LAST_DATE_NUM. AS SELECT
        VUE_METIER_MESURES.'Société'n length=11 format=$11. AS 'Société'n,
        VUE_METIER_MESURES.Produit length=255 format=$255. AS Produit,
        VUE_METIER_MESURES.Equipement length=50 format=$50. AS Equipement,
        VUE_METIER_MESURES.Voie length=50 format=$50. AS Voie,
        VUE_METIER_MESURES.'Carte de contrôle'n length=255 format=$255. AS 'Carte de contrôle'n,
        VUE_METIER_MESURES.'Mesure Type'n length=255 format=$255. AS 'Mesure Type'n,
        VUE_METIER_MESURES.'Mesure Date Poste'n length=8 format=DATETIME22.3 AS 'Mesure Date Poste'n,
        VUE_METIER_MESURES.'Mesure Date Heure'n length=8 format=DATETIME22.3 AS 'Mesure Date Heure'n,
        VUE_METIER_MESURES.'Mesure Date'n length=8 format=DATETIME22.3 AS 'Mesure Date'n,
        VUE_METIER_MESURES.'Mesure Jour'n length=30 format=$30. AS 'Mesure Jour'n,
        VUE_METIER_MESURES.'Mesure Heure'n length=8 format=DATETIME22.3 AS 'Mesure Heure'n,
        VUE_METIER_MESURES.'Mesure Opérateur'n length=5 format=$5. AS 'Mesure Opérateur'n,
        VUE_METIER_MESURES.'Mesure Equipe'n length=10 format=$10. AS 'Mesure Equipe'n,
        VUE_METIER_MESURES.'Mesure Poste'n length=10 format=$10. AS 'Mesure Poste'n,
        VUE_METIER_MESURES.'Mesure Observation'n length=1024 format=$1024. AS 'Mesure Observation'n,
        VUE_METIER_MESURES.'Valeur Minimale Dérogation'n length=8 AS 'Valeur Minimale Dérogation'n,
        VUE_METIER_MESURES.'Valeur Minimale Critique'n length=8 AS 'Valeur Minimale Critique'n,
        VUE_METIER_MESURES.'Valeur mesurée'n length=8 AS 'Valeur mesurée'n,
        VUE_METIER_MESURES.'Valeur Maximale Critique'n length=8 AS 'Valeur Maximale Critique'n,
        VUE_METIER_MESURES.'Valeur Maximale Dérogation'n length=8 AS 'Valeur Maximale Dérogation'n,
        VUE_METIER_MESURES.'Dérogation Code'n length=20 format=$20. AS 'Dérogation Code'n,
        VUE_METIER_MESURES.'Dérogation Date Début'n length=8 format=DATETIME22.3 AS 'Dérogation Date Début'n,
        VUE_METIER_MESURES.'Dérogation Date Fin'n length=8 format=DATETIME22.3 AS 'Dérogation Date Fin'n,
        VUE_METIER_MESURES.'Dérogation Commentaire'n length=1024 format=$1024. AS 'Dérogation Commentaire'n,
        DATETIME ()  length=8 format=DATETIME22.3 AS Heure_Actualisation 
    FROM
        SQC.VUE_METIER_MESURES VUE_METIER_MESURES
    where VUE_METIER_MESURES.'Mesure Date Heure'n >&LAST_DATE_CHR.;
quit;
