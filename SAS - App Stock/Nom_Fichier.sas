* D�but du code EG g�n�r� (ne pas modifier cette ligne);
* 
*  Application stock�e enregistr�e par  
*  Enterprise Guide Stored Process Manager V5.1
*
*  ====================================================================
*  Nom de l'application stock�e : Application stock�e
*  ====================================================================
*
*  Dictionnaire d'invites de l'application stock�e :
*  ____________________________________
*  NOM_FICHIER
*       Type : Texte
*      Libell� : Veuillez rentrer le nom du fichier
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

* Fin du code EG g�n�r� (ne pas modifier cette ligne);


DATA STATS.&Nom_Fichier;
SET RE_CEL.DOUBLONS_CHGT_ECRAN;
RUN;

* D�but du code EG g�n�r� (ne pas modifier cette ligne);
;*';*";*/;quit;
%STPEND;

* Fin du code EG g�n�r� (ne pas modifier cette ligne);

