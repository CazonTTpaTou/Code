
OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/INDICATEURS_MAINT"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'INDICATEURS_MAINT'
   FACT                   = GMAO.SAS_Table_Faits_Indicateur_Maint
;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   USE_DIMENSION  Equipements
      FACTKEY          = Code_Emplacement;

   DIMENSION Rafraichissement
      CAPTION          = 'Rafraichissement'
      SORT_ORDER       = ASCENDING
      HIERARCHIES      = (
         Rafraichissement
         ) /* HIERARCHIES */;

      HIERARCHY Rafraichissement 
         ALL_MEMBER = 'Tout Rafraichissement'
         CAPTION    = 'Rafraichissement'
         LEVELS     = (
            Date_Rafraichissement
            ) /* LEVELS */
         DEFAULT;

      LEVEL Date_Rafraichissement
         FORMAT         =  DATETIME22.3
         CAPTION        =  'Date_Rafraichissement'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Date
      CAPTION          = 'Date'
      SORT_ORDER       = ASCENDING
      HIERARCHIES      = (
         Date
         ) /* HIERARCHIES */;

      HIERARCHY Date 
         ALL_MEMBER = 'Tout Date'
         CAPTION    = 'Date'
         LEVELS     = (
            Libelle_Date
            ) /* LEVELS */
         DEFAULT;

      LEVEL Libelle_Date
         FORMAT         =  $43.
         CAPTION        =  'Libelle_Date'
         SORT_ORDER     =  ASCENDING;

   MEASURE MTBF_HAVG
      STAT        = AVG
      COLUMN      = MTBF_H
      CAPTION     = 'MTBF_H'
      FORMAT      = NLNUM16.2
      DEFAULT;

   MEASURE MTBF_HSTD
      STAT        = STD
      COLUMN      = MTBF_H
      CAPTION     = 'Ecart-type de MTBF_H'
      FORMAT      = NLNUM16.2;

   MEASURE MTBF_JSTD
      STAT        = STD
      COLUMN      = MTBF_J
      CAPTION     = 'Ecart-type de MTBF_J'
      FORMAT      = NLNUM16.2;

   MEASURE MTBF_JAVG
      STAT        = AVG
      COLUMN      = MTBF_J
      CAPTION     = ' MTBF_J'
      FORMAT      = NLNUM16.2;

   MEASURE MTTR_HAVG
      STAT        = AVG
      COLUMN      = MTTR_H
      CAPTION     = 'MTTR_H'
      FORMAT      = NLNUM16.2;

   MEASURE MTTR_HSTD
      STAT        = STD
      COLUMN      = MTTR_H
      CAPTION     = 'Ecart-type de MTTR_H'
      FORMAT      = NLNUM16.2;

   MEASURE MTTR_JAVG
      STAT        = AVG
      COLUMN      = MTTR_J
      CAPTION     = 'MTTR_J'
      FORMAT      = NLNUM16.2;

   MEASURE MTTR_JSTD
      STAT        = STD
      COLUMN      = MTTR_J
      CAPTION     = 'Ecart-type de MTTR_J'
      FORMAT      = NLNUM16.2;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Date_Rafraichissement Equipement Libelle_Date
      Procede Secteur Sous_Equipement Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;