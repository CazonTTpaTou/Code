* Début du code EG généré (ne pas modifier cette ligne);
* 
*  Application stockée enregistrée par  
*  Enterprise Guide Stored Process Manager V5.1
*
*  ====================================================================
*  Nom de l'application stockée : Application stockée
*  ====================================================================
*
*  Dictionnaire d'invites de l'application stockée :
*  ____________________________________
*  NOM_FICHIER
*       Type : Texte
*      Libellé : Veuillez rentrer le nom du fichier
*       Attr: Visible
*  ____________________________________
*;


*ProcessBody;

%global NOM_FICHIER;

%STPBEGIN;

OPTIONS VALIDVARNAME=ANY;

%macro ExtendValidMemName;

%if %sysevalf(&sysver>=9.3) %then options validmemname=extend;

%mend ExtendValidMemName;

%ExtendValidMemName;

* Fin du code EG généré (ne pas modifier cette ligne);


DATA STATS.&Nom_Fichier;
SET RE_CEL.DOUBLONS_CHGT_ECRAN;
RUN;

* Début du code EG généré (ne pas modifier cette ligne);
;*';*";*/;quit;
%STPEND;

* Fin du code EG généré (ne pas modifier cette ligne);

