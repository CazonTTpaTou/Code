
OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/COUVERTURE_PREVENTIF"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'COUVERTURE_PREVENTIF'
   FACT                   = GMAO.SAS_Table_Faits_Plan_Maintenance
;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   DIMENSION Emplacement
      CAPTION          = 'Emplacement'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Emplacement
      DIMKEY           = Code_Emplacement
      FACTKEY          = Code_Emplacement
      HIERARCHIES      = (
         Emplacement
         ) /* HIERARCHIES */;

      HIERARCHY Emplacement 
         ALL_MEMBER = 'Tout Emplacement'
         CAPTION    = 'Emplacement'
         LEVELS     = (
            Actif Unite Secteur
            Procede Equipement Sous_Equipement
            ) /* LEVELS */
         DEFAULT;

      LEVEL Actif
         FORMAT         =  $50.
         CAPTION        =  'Actif'
         SORT_ORDER     =  ASCENDING;

      LEVEL Unite
         FORMAT         =  $50.
         CAPTION        =  'Unite'
         SORT_ORDER     =  ASCENDING;

      LEVEL Secteur
         FORMAT         =  $50.
         CAPTION        =  'Secteur'
         SORT_ORDER     =  ASCENDING;

      LEVEL Procede
         FORMAT         =  $150.
         CAPTION        =  'Procede'
         SORT_ORDER     =  ASCENDING;

      LEVEL Equipement
         FORMAT         =  $150.
         CAPTION        =  'Equipement'
         SORT_ORDER     =  ASCENDING;

      LEVEL Sous_Equipement
         FORMAT         =  $50.
         CAPTION        =  'Sous_Equipement'
         SORT_ORDER     =  ASCENDING;

   DIMENSION 'Date Rafraichissement'n
      CAPTION          = 'Date Rafraichissement'
      SORT_ORDER       = ASCENDING
      HIERARCHIES      = (
         'Date Rafraichissement'n
         ) /* HIERARCHIES */;

      HIERARCHY 'Date Rafraichissement'n 
         ALL_MEMBER = 'Tout Date Rafraichissement'
         CAPTION    = 'Date Rafraichissement'
         LEVELS     = (
            Date_Rafraichissement
            ) /* LEVELS */
         DEFAULT;

      LEVEL Date_Rafraichissement
         FORMAT         =  DATETIME22.3
         CAPTION        =  'Date_Rafraichissement'
         SORT_ORDER     =  ASCENDING;

   MEASURE PM_Cumul
      STAT        = SUM
      COLUMN      = Plan_Maintenance_Binaire
      CAPTION     = 'Nombre cumulé plan de maintenance'
      FORMAT      = 11.
      DEFAULT;

   MEASURE Nombre_Preventif
      STAT        = SUM
      COLUMN      = Nombre_Preventif
      CAPTION     = 'Nombre de préventif'
      FORMAT      = 11.;

   MEASURE PM_Effectif
      STAT        = N
      COLUMN      = Plan_Maintenance_Binaire
      CAPTION     = 'Nombre d''équipements total'
      FORMAT      = 12.;

   MEASURE Racine_PM
      STAT        = SUM
      COLUMN      = Plan_Maintenance_Racine
      CAPTION     = 'Plan de maintenance équipement'
      FORMAT      = 11.;

   MEASURE Racine_Cumul
      STAT        = SUM
      COLUMN      = Racine
      CAPTION     = 'Nombre d''équipements racine'
      FORMAT      = 11.;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Date_Rafraichissement Equipement Procede
      Secteur Sous_Equipement Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';
   DEFINE Member '[COUVERTURE_PREVENTIF].[Measures].[Taux couverture préventive détaillé]' AS 
         '[Measures].[PM_Cumul]/[Measures].[PM_Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[COUVERTURE_PREVENTIF].[Measures].[Taux couverture préventive racine]' AS 
         '[Measures].[Racine_PM]/[Measures].[Racine_Cumul], FORMAT_STRING="PERCENT6."';


   RUN;