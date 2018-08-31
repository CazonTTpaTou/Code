

OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/DO_TEMPS_ARRET"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'DO_TEMPS_ARRET'
   FACT                   = GMAO.SAS_Table_Faits_Capacite_Prod
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

   MEASURE DO_Equip_Moy
      STAT        = AVG
      COLUMN      = DO_Equipement
      CAPTION     = 'DO Moyen équipement avec impact sous équipement'
      FORMAT      = PERCENT6.2
      DEFAULT;

   MEASURE DO_Procede_Moy
      STAT        = AVG
      COLUMN      = DO_Procede
      CAPTION     = 'DO Moyen procédé avec impact équipement'
      FORMAT      = PERCENT6.2;

   MEASURE DO_Secteur_Moy
      STAT        = AVG
      COLUMN      = DO_Secteur
      CAPTION     = 'DO Moyen secteur avec impact procédé'
      FORMAT      = PERCENT6.2;

   MEASURE DO_UAP_Moy
      STAT        = AVG
      COLUMN      = DO_UAP
      CAPTION     = 'DO Moyen UAP avec impact secteur'
      FORMAT      = PERCENT6.2;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Annee 
      Date_Rafraichissement Equipement 
      Num_Jour_Semaine Num_JourMois Num_Mois
      Num_Semaine Num_Semestre Num_Trimestre
      Procede Secteur
      Sous_Equipement Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;