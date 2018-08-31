


OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_ACTIVITES"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'SUIVI_ACTIVITES'
   FACT                   = GMAO.SAS_Table_Faits_Suivi_Activite
;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   USE_DIMENSION  Equipements
      FACTKEY          = Code_Emplacement;

   DIMENSION Demandeur
      CAPTION          = 'Demandeur'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Demandeur
      DIMKEY           = Code_Demandeur
      FACTKEY          = Code_Demandeur
      HIERARCHIES      = (
         Demandeur
         ) /* HIERARCHIES */;

      HIERARCHY Demandeur 
         ALL_MEMBER = 'Tout Demandeur'
         CAPTION    = 'Demandeur'
         LEVELS     = (
            Nom_Demandeur
            ) /* LEVELS */
         DEFAULT;

      LEVEL Nom_Demandeur
         FORMAT         =  $50.
         CAPTION        =  'Nom_Demandeur'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Intervenant
      CAPTION          = 'Intervenant'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Intervenant
      DIMKEY           = Code_Intervenant
      FACTKEY          = Code_Intervenant
      HIERARCHIES      = (
         Intervenant
         ) /* HIERARCHIES */;

      HIERARCHY Intervenant 
         ALL_MEMBER = 'Tout Intervenant'
         CAPTION    = 'Intervenant'
         LEVELS     = (
            Nom_Service Nom_Intervenant
            ) /* LEVELS */
         DEFAULT;

      LEVEL Nom_Service
         FORMAT         =  $50.
         CAPTION        =  'Nom_Service'
         SORT_ORDER     =  ASCENDING;

      LEVEL Nom_Intervenant
         FORMAT         =  $50.
         CAPTION        =  'Nom_Intervenant'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Services
      CAPTION          = 'Services'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Service
      DIMKEY           = Code_Service
      FACTKEY          = Code_Service
      HIERARCHIES      = (
         Services
         ) /* HIERARCHIES */;

      HIERARCHY Services 
         ALL_MEMBER = 'Tout Services'
         CAPTION    = 'Services'
         LEVELS     = (
            Service
            ) /* LEVELS */
         DEFAULT;

      LEVEL Service
         FORMAT         =  $50.
         CAPTION        =  'Service'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Temps
      CAPTION          = 'Temps'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Temps
      DIMKEY           = Code_Temps
      FACTKEY          = Code_Temps
      HIERARCHIES      = (
         Temps Poste_Heure_Minutes
         ) /* HIERARCHIES */;

      HIERARCHY Temps 
         ALL_MEMBER = 'Tout Temps'
         CAPTION    = 'Temps'
         LEVELS     = (
            Heure Minute Seconde
            ) /* LEVELS */
         DEFAULT;

      HIERARCHY Poste_Heure_Minutes 
         ALL_MEMBER = 'Tout Poste_Heure_Minutes'
         CAPTION    = 'Poste_Heure_Minutes'
         LEVELS     = (
            Poste Heure Minute
            ) /* LEVELS */;

      LEVEL Heure
         FORMAT         =  11.
         CAPTION        =  'Heure'
         SORT_ORDER     =  ASCENDING;

      LEVEL Minute
         FORMAT         =  $30.
         CAPTION        =  'Minute'
         SORT_ORDER     =  ASCENDING;

      LEVEL Seconde
         FORMAT         =  11.
         CAPTION        =  'Seconde'
         SORT_ORDER     =  ASCENDING;

      LEVEL Poste
         FORMAT         =  $10.
         CAPTION        =  'Poste'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Urgence
      CAPTION          = 'Urgence'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Urgence
      DIMKEY           = Code_Urgence
      FACTKEY          = Code_Urgence
      HIERARCHIES      = (
         Urgence
         ) /* HIERARCHIES */;

      HIERARCHY Urgence 
         ALL_MEMBER = 'Tout Urgence'
         CAPTION    = 'Urgence'
         LEVELS     = (
            Degre_Urgence Priorite
            ) /* LEVELS */
         DEFAULT;

      LEVEL Degre_Urgence
         FORMAT         =  $50.
         CAPTION        =  'Degre_Urgence'
         SORT_ORDER     =  ASCENDING;

      LEVEL Priorite
         FORMAT         =  $50.
         CAPTION        =  'Priorite'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Type_Interventions
      CAPTION          = 'Type_Interventions'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Type_Inter_Urgence
      DIMKEY           = Code
      FACTKEY          = Code_Type_Inter_Urgence
      HIERARCHIES      = (
         Type_Interventions
         ) /* HIERARCHIES */;

      HIERARCHY Type_Interventions 
         ALL_MEMBER = 'Tout Type_Interventions'
         CAPTION    = 'Type_Interventions'
         LEVELS     = (
            Type_Intervention
            ) /* LEVELS */
         DEFAULT;

      LEVEL Type_Intervention
         COLUMN         =  Libelle
         FORMAT         =  $50.
         CAPTION        =  'Libelle'
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

   DIMENSION 'Année mois'n
      CAPTION          = 'Année mois'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Date
      DIMKEY           = Code_Date
      FACTKEY          = Code_Date
      HIERARCHIES      = (
         'Année mois'n
         ) /* HIERARCHIES */;

      HIERARCHY 'Année mois'n 
         ALL_MEMBER = 'Tout Année mois'
         CAPTION    = 'Année mois'
         LEVELS     = (
            Annee_1 Num_Mois_1
            ) /* LEVELS */
         DEFAULT;

      LEVEL Annee_1
         COLUMN         =  Annee
         FORMAT         =  11.
         CAPTION        =  'Annee'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Mois_1
         COLUMN         =  Num_Mois
         FORMAT         =  MOIS11.
         CAPTION        =  'Num_Mois'
         SORT_ORDER     =  ASCENDING;

   MEASURE 'Nombre actions par intervenant'n
      STAT        = SUM
      COLUMN      = Nombre_action_intervenant
      CAPTION     = 'Cumul du nombre d''actions'
      FORMAT      = NLNUM11.
      DEFAULT;

   MEASURE 'Temps moyen par action'n
      STAT        = AVG
      COLUMN      = Temps_moyen_intervenant_action
      CAPTION     = 'Temps Moyen par action'
      FORMAT      = NLNUM14.2;

   MEASURE 'Cumul temps intervention'n
      STAT        = SUM
      COLUMN      = Temps_passe_intervenant
      CAPTION     = 'Cumul du temps d''intervention'
      FORMAT      = NLNUM14.2;

   MEASURE 'Nombre intervention'n
      STAT        = N
      COLUMN      = Temps_passe_intervenant
      CAPTION     = 'Nombre d''interventions'
      FORMAT      = 12.;

   MEASURE 'Temps moyen par intervention'n
      STAT        = AVG
      COLUMN      = Temps_passe_intervenant
      CAPTION     = 'Temps moyen par intervenant'
      FORMAT      = 14.2;

   MEASURE 'Ecart type temps intervention'n
      STAT        = STD
      COLUMN      = Temps_passe_intervenant
      CAPTION     = 'Ecart-type de des temps d''intervention'
      FORMAT      = 14.2;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Annee_1 Date_Rafraichissement Degre_Urgence Equipement
      Heure Minute Nom_Demandeur Nom_Intervenant Nom_Service
      Num_Mois_1 Poste Priorite Procede Seconde
      Secteur Service Sous_Equipement Type_Intervention Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;