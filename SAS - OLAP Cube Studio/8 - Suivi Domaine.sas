


OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_DOMAINE"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'SUIVI_DOMAINE'
   FACT                   = GMAO.SAS_Table_Faits_Suivi_Domaine
;


METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   USE_DIMENSION  Date
      FACTKEY          = Code_Date;


   USE_DIMENSION  Equipements
      FACTKEY          = Code_Emplacement;

   DIMENSION Domaines
      CAPTION          = 'Domaines'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Domaine
      DIMKEY           = Code_Domaine
      FACTKEY          = Dimension_domaine
      HIERARCHIES      = (
         Domaines
         ) /* HIERARCHIES */;

      HIERARCHY Domaines 
         ALL_MEMBER = 'Tout Domaines'
         CAPTION    = 'Domaines'
         LEVELS     = (
            Domaine_Intervention
            ) /* LEVELS */
         DEFAULT;

      LEVEL Domaine_Intervention
         FORMAT         =  $50.
         CAPTION        =  'Domaine_Intervention'
         SORT_ORDER     =  ASCENDING;

   DIMENSION 'Date rafraichissement'n
      CAPTION          = 'Date rafraichissement'
      SORT_ORDER       = ASCENDING
      HIERARCHIES      = (
         'Date rafraichissement'n
         ) /* HIERARCHIES */;

      HIERARCHY 'Date rafraichissement'n 
         ALL_MEMBER = 'Tout Date rafraichissement'
         CAPTION    = 'Date rafraichissement'
         LEVELS     = (
            Date_Rafraichissement
            ) /* LEVELS */
         DEFAULT;

      LEVEL Date_Rafraichissement
         FORMAT         =  DATETIME22.3
         CAPTION        =  'Date_Rafraichissement'
         SORT_ORDER     =  ASCENDING;

   MEASURE 'Nombre domaine'n
      STAT        = N
      COLUMN      = Dimension_domaine
      CAPTION     = 'Nombre de domaine'
      FORMAT      = 12.
      DEFAULT;

   AGGREGATION /* Par défaut */
      /* levels */
      Actif Annee 
      Date_Rafraichissement Domaine_Intervention Equipement
      Num_Jour_Semaine Num_JourMois
      Num_Mois Num_Semaine Num_Semestre
      Num_Trimestre Procede Secteur
      Sous_Equipement Unite
      / /* options */
      NAME      = 'Par défaut';
   DEFINE Member '[SUIVI_DOMAINE].[Measures].[Réparatition par domaine]' AS 
         ' [Measures].[Nombre Domaine]  
/   
([Measures].[Nombre Domaine],[Domaines].[Domaines].CurrentMember.Parent), FORMAT_STRING="PERCENT6."';


   RUN;