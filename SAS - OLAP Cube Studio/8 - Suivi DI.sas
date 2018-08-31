


OPTIONS VALIDVARNAME=ANY;


libname GMAO list;

PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_DI"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   PATH                   = 'E:\SAS\7_Cube_OLAP'
   DESCRIPTION            = 'SUIVI_DI'
   FACT                   = GMAO.SAS_Table_Faits_Suivi_DI
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

   DIMENSION Services
      CAPTION          = 'Service'
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

   DIMENSION Type_Intervention
      CAPTION          = 'Type_Intervention'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Type_Inter_Urgence
      DIMKEY           = Code
      FACTKEY          = Code_Type_Inter_Urgence
      HIERARCHIES      = (
         Type_Intervention
         ) /* HIERARCHIES */;

      HIERARCHY Type_Intervention 
         ALL_MEMBER = 'Tout Type_Intervention'
         CAPTION    = 'Type_Intervention'
         LEVELS     = (
            Libelle
            ) /* LEVELS */
         DEFAULT;

      LEVEL Libelle
         FORMAT         =  $50.
         CAPTION        =  'Libelle'
         SORT_ORDER     =  ASCENDING;

   DIMENSION Heures
      CAPTION          = 'Heure'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Temps
      DIMKEY           = Code_Temps
      FACTKEY          = Code_Temps
      HIERARCHIES      = (
         Heures
         ) /* HIERARCHIES */;

      HIERARCHY Heures 
         ALL_MEMBER = 'Tout Heures'
         CAPTION    = 'Heures'
         LEVELS     = (
            Poste Heure
            ) /* LEVELS */
         DEFAULT;

      LEVEL Poste
         FORMAT         =  $10.
         CAPTION        =  'Poste'
         SORT_ORDER     =  ASCENDING;

      LEVEL Heure
         FORMAT         =  11.
         CAPTION        =  'Heure'
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
            Priorite
            ) /* LEVELS */
         DEFAULT;

      LEVEL Priorite
         FORMAT         =  $50.
         CAPTION        =  'Priorite'
         SORT_ORDER     =  ASCENDING;

   MEASURE Duree_avant_realisationSUM
      STAT        = SUM
      COLUMN      = Duree_avant_realisation
      CAPTION     = 'Cumul durée avant réalisation'
      FORMAT      = 14.2
      DEFAULT;

   MEASURE Duree_InterventionSUM
      STAT        = SUM
      COLUMN      = Duree_Intervention
      CAPTION     = 'Cumul durée d''intervention'
      FORMAT      = 14.2;

   MEASURE Duree_realisationSUM
      STAT        = SUM
      COLUMN      = Duree_realisation
      CAPTION     = 'Cumul durée de realisation'
      FORMAT      = 14.2;

   MEASURE Nombre_intervenantAVG
      STAT        = AVG
      COLUMN      = Nombre_intervenant
      CAPTION     = 'Nombre moyen d''intervenant'
      FORMAT      = 14.2;

   MEASURE Nombre_Pieces_jointesAVG
      STAT        = AVG
      COLUMN      = Nombre_Pieces_jointes
      CAPTION     = 'Nombre moyenne de pièces jointes'
      FORMAT      = 11.;

   MEASURE Ratio_Duree_intervention_DureAVG
      STAT        = AVG
      COLUMN      = Ratio_Duree_intervention_Duree_T
      CAPTION     = 'Ratio moyen durée d''intervention'
      FORMAT      = 14.4;

   MEASURE Ratio_Tps_attente_piece_DureeAVG
      STAT        = AVG
      COLUMN      = Ratio_Tps_attente_piece_Duree_Tr
      CAPTION     = 'Ratio moyen temps attente pièce'
      FORMAT      = 14.4;

   MEASURE Ratio_Tps_avant_real_Duree_TrAVG
      STAT        = AVG
      COLUMN      = Ratio_Tps_avant_real_Duree_Trait
      CAPTION     = 'Ratio moyen durée avant réalisation'
      FORMAT      = 14.4;

   MEASURE Temps_arret_netSUM
      STAT        = SUM
      COLUMN      = Temps_arret_net
      CAPTION     = 'Cumul des temps d''arrêt nets'
      FORMAT      = 14.2;

   MEASURE Temps_arret_netN
      STAT        = N
      COLUMN      = Temps_arret_net
      CAPTION     = 'Nombre d''arrêts'
      FORMAT      = 12.;

   MEASURE Temps_arret_netAVG
      STAT        = AVG
      COLUMN      = Temps_arret_net
      CAPTION     = 'Temps d''arrêt moyen'
      FORMAT      = 14.2;

   MEASURE Temps_attente_pieceSUM
      STAT        = SUM
      COLUMN      = Temps_attente_piece
      CAPTION     = 'Cumul des temps attente pièce'
      FORMAT      = 14.2;

   MEASURE Temps_interventionSUM
      STAT        = SUM
      COLUMN      = Temps_intervention
      CAPTION     = 'Cumul des durées de traitement'
      FORMAT      = 14.2;

   MEASURE Duree_TraitementSUM
      STAT        = SUM
      COLUMN      = Duree_Traitement
      CAPTION     = 'Cumul des durées de traitement'
      FORMAT      = 14.2;

   MEASURE Nombre_intervenantSUM
      STAT        = SUM
      COLUMN      = Nombre_intervenant
      CAPTION     = 'Cumul du Nombre d''intervenant'
      FORMAT      = 14.2;

   MEASURE Duree_TraitementAVG
      STAT        = AVG
      COLUMN      = Duree_Traitement
      CAPTION     = 'Durée de traitement moyenne'
      FORMAT      = 14.2;

   MEASURE Duree_TraitementSTD
      STAT        = STD
      COLUMN      = Duree_Traitement
      CAPTION     = 'Ecart-type des durées de traitement'
      FORMAT      = 14.2;

   MEASURE _Code_InterventionN
      STAT        = N
      COLUMN      = _Code_Intervention
      CAPTION     = 'Nombre d''interventions'
      FORMAT      = 12.;

   AGGREGATION /* PAR DÉFAUT */
      /* levels */
      Actif Annee Date_Rafraichissement Equipement
      Heure Libelle Nom_Demandeur Num_Jour_Semaine
      Num_JourMois Num_Mois Num_Semaine Num_Semestre Num_Trimestre
      Poste Priorite Procede Secteur
      Service Sous_Equipement Unite
      / /* options */
      NAME      = 'PAR DÉFAUT';

   RUN;