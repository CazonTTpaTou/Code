
OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/RESPECT_PREVENTIF"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'RESPECT_PREVENTIF'
   FACT                   = GMAO.SAS_Table_Faits_Efficacite_Prev;

   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   USE_DIMENSION  Emplacement
      FACTKEY          = Code_Emplacement;


   USE_DIMENSION  Date
      FACTKEY          = Code_Date;

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

   DIMENSION Date_de_Rafraichissement
      CAPTION          = 'Date_de_Rafraichissement'
      SORT_ORDER       = ASCENDING
      HIERARCHIES      = (
         Date_de_Rafraichissement
         ) /* HIERARCHIES */;

      HIERARCHY Date_de_Rafraichissement 
         ALL_MEMBER = 'Tout Date_de_Rafraichissement'
         CAPTION    = 'Date_de_Rafraichissement'
         LEVELS     = (
            Date_Rafraichissement
            ) /* LEVELS */
         DEFAULT;

      LEVEL Date_Rafraichissement
         FORMAT         =  DATETIME22.3
         CAPTION        =  'Date_Rafraichissement'
         SORT_ORDER     =  ASCENDING;

   MEASURE Ecart_moins_20_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_moins_20_pourcent
      CAPTION     = 'Ecart inférieur à 20%'
      FORMAT      = 11.
      DEFAULT;

   MEASURE Ecart_moins_30_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_moins_30_pourcent
      CAPTION     = 'Ecart inférieur à 30%'
      FORMAT      = 11.;

   MEASURE Ecart_moins_40_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_moins_40_pourcent
      CAPTION     = 'Ecart inférieur à 40%'
      FORMAT      = 11.;

   MEASURE Ecart_moins_50_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_moins_50_pourcent
      CAPTION     = 'Ecart inférieur à 50%'
      FORMAT      = 11.;

   MEASURE Ecart_plus_20_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_plus_20_pourcent
      CAPTION     = 'Ecart supérieur à 20%'
      FORMAT      = 11.;

   MEASURE Ecart_plus_30_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_plus_30_pourcent
      CAPTION     = 'Ecart supérieur à 30%'
      FORMAT      = 11.;

   MEASURE Ecart_plus_40_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_plus_40_pourcent
      CAPTION     = 'Ecart supérieur à 40%'
      FORMAT      = 11.;

   MEASURE Ecart_plus_50_pourcentSUM
      STAT        = SUM
      COLUMN      = Ecart_plus_50_pourcent
      CAPTION     = 'Ecart supérieur à 50 %'
      FORMAT      = 11.;

   MEASURE Effectif
      STAT        = N
      COLUMN      = Date_Rafraichissement
      CAPTION     = 'Nombre de préventif'
      FORMAT      = 12.;

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
   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio moins 20 pourcent]' AS 
         '[Measures].[Ecart_moins_20_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio moins 30 pourcent]' AS 
         '[Measures].[Ecart_moins_30_pourcentSUM]/[Measures].[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio moins 40 pourcent]' AS 
         '[Measures].[Ecart_moins_40_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio moins 50 pourcent]' AS 
         '[Measures].[Ecart_moins_50_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio plus 20 pourcent]' AS 
         '[Measures].[Ecart_plus_20_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio plus 30 pourcent]' AS 
         '[Measures].[Ecart_plus_30_pourcentSUM]/[Measures].[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio plus 40 pourcent]' AS 
         '[Measures].[Ecart_plus_40_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';

   DEFINE Member '[RESPECT_PREVENTIF].[Measures].[Ratio plus 50 pourcent]' AS 
         '[Measures].[Ecart_plus_50_pourcentSUM]/[Measures].[Effectif], FORMAT_STRING="PERCENT6."';


   RUN;