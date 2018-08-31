OPTIONS VALIDVARNAME=ANY;

libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/COUV_PLAN_MAINTENANCE"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'COUV_PLAN_MAINTENANCE'
   FACT                   = GMAO.SAS_Table_Faits_Couverture_Maint
;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   USE_DIMENSION  Emplacement
      FACTKEY          = Code_Emplacement;

   DIMENSION Activite
      CAPTION          = 'Activite'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Actif
      DIMKEY           = Code_Actif
      FACTKEY          = Code_Actif
      HIERARCHIES      = (
         Activite
         ) /* HIERARCHIES */;

      HIERARCHY Activite 
         ALL_MEMBER = 'Tout Activite'
         CAPTION    = 'Activite'
         LEVELS     = (
            Actif
            ) /* LEVELS */
         DEFAULT;

      LEVEL Actif
         FORMAT         =  $11.
         CAPTION        =  'Actif'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Type_preventif
      CAPTION          = 'Type_preventif'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Type_Preventif
      DIMKEY           = Code_Type_Planification
      FACTKEY          = Code_Type_Preventif
      HIERARCHIES      = (
         Type_preventif
         ) /* HIERARCHIES */;

      HIERARCHY Type_preventif 
         ALL_MEMBER = 'Tout Type_preventif'
         CAPTION    = 'Type_preventif'
         LEVELS     = (
            Type_planification
            ) /* LEVELS */
         DEFAULT;

      LEVEL Type_planification
         FORMAT         =  $50.
         CAPTION        =  'Type_planification'
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

   MEASURE Nb_Preventif
      STAT        = SUM
      COLUMN      = Nombre_Preventif
      CAPTION     = 'Nombre de Préventifs Cumulé'
      FORMAT      = 11.
      DEFAULT;

   MEASURE Delai_Basculement_Moy
      STAT        = AVG
      COLUMN      = Delai_Basculement
      CAPTION     = 'Délai de Basculement Moyen'
      FORMAT      = 6.;

   MEASURE Freq_Preventif_Moy
      STAT        = AVG
      COLUMN      = Frequence_Preventif
      CAPTION     = 'Frequence Moyenne Préventif'
      FORMAT      = 6.;

   MEASURE Nb_Actions_Moy
      STAT        = AVG
      COLUMN      = Nombre_Actions
      CAPTION     = 'Nombre Moyen d''Actions'
      FORMAT      = 11.;

   MEASURE Nb_Pieces_Jointes_Cumul
      STAT        = SUM
      COLUMN      = Nombre_Pieces_Jointes
      CAPTION     = 'Nombre de Pièces Jointes Cumulé'
      FORMAT      = 11.;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Date_Rafraichissement Equipement
      Procede Secteur Sous_Equipement
      Type_planification Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;