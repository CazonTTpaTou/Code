


OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/RELEVE_COMPTEUR"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'SUIVI_RELEVE'
   FACT                   = GMAO.SAS_Table_Faits_Releve_Compteur
;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   DIMENSION Compteur
      CAPTION          = 'Compteur'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Compteur
      DIMKEY           = Code_Compteur
      FACTKEY          = Code_Compteur
      HIERARCHIES      = (
         Compteur 'Nom Compteur'n
         ) /* HIERARCHIES */;

      HIERARCHY Compteur 
         ALL_MEMBER = 'Tout Compteur'
         CAPTION    = 'Compteur'
         LEVELS     = (
            Unite_Compteur Nom_Compteur
            ) /* LEVELS */
         DEFAULT;

      HIERARCHY 'Nom Compteur'n 
         ALL_MEMBER = 'Tout Nom Compteur'
         CAPTION    = 'Nom Compteur'
         LEVELS     = (
            Nom_Compteur
            ) /* LEVELS */;

      LEVEL Unite_Compteur
         FORMAT         =  $25.
         CAPTION        =  'Unite_Compteur'
         SORT_ORDER     =  ASCENDING;

      LEVEL Nom_Compteur
         FORMAT         =  $50.
         CAPTION        =  'Nom_Compteur'
         SORT_ORDER     =  ASCENDING;

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

   DIMENSION Annee_Mois
      CAPTION          = 'Annee_Mois'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Date
      DIMKEY           = Code_Date
      FACTKEY          = Code_Date
      HIERARCHIES      = (
         Annee_Mois
         ) /* HIERARCHIES */;

      HIERARCHY Annee_Mois 
         ALL_MEMBER = 'Tout Annee_Mois'
         CAPTION    = 'Annee_Mois'
         LEVELS     = (
            Annee_1 Num_Mois_1
            ) /* LEVELS */
         DEFAULT;

      LEVEL Annee_1
         COLUMN         =  Annee
         FORMAT         =  11.
         CAPTION        =  'Année'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Mois_1
         COLUMN         =  Num_Mois
         FORMAT         =  MOIS11.
         CAPTION        =  'Mois année'
         SORT_ORDER     =  ASCENDING;

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

   MEASURE Conso_Cumul
      STAT        = SUM
      COLUMN      = Consommation
      CAPTION     = 'Consommation Cumulé'
      FORMAT      = NLNUM20.2
      DEFAULT;

   MEASURE Conso_Moy
      STAT        = AVG
      COLUMN      = Consommation
      CAPTION     = 'Consommation Moyenne'
      FORMAT      = NLNUM20.2;

   MEASURE Nb_releve_Cumul
      STAT        = SUM
      COLUMN      = Nombre_releve
      CAPTION     = 'Nombre relèves Cumulé'
      FORMAT      = NLNUM11.;

   MEASURE Nb_Remise_0_Cumul
      STAT        = SUM
      COLUMN      = Nombre_Remise_0
      CAPTION     = 'Nombre de Remises à 0'
      FORMAT      = NLNUM20.;

   MEASURE Conso
      STAT        = MAX
      COLUMN      = Consommation
      CAPTION     = 'Consommation maximum'
      FORMAT      = NLNUM20.2;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Annee_1 Date_Rafraichissement
      Nom_Compteur Num_Mois_1 Unite_Compteur
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;