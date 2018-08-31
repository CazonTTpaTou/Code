

/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer cette dimension partagée
********    fin du bloc de code en commentaire    ********/

OPTIONS VALIDVARNAME=ANY;

PROC OLAP   DELETE;

   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

DIMENSION "/Shared Data/5_CUBES_OLAP/51_GMAO/Date"
      SHARED              ;


   RUN;

OPTIONS VALIDVARNAME=ANY;

libname GMAO list;

PROC OLAP
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30;

   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

DIMENSION "/Shared Data/5_CUBES_OLAP/51_GMAO/Date"
      SHARED              
      PATH             = 'E:\SAS\7_Cube_OLAP\Dimensions partagées'

      CAPTION          = 'Date'
      SORT_ORDER       = ASCENDING
      DIMTBL           = GMAO.SAS_Dimension_Date
      DIMKEY           = Code_Date
      HIERARCHIES      = (
         Mois 'Années'n Semaines
         ) /* HIERARCHIES */;

      HIERARCHY Mois 
         ALL_MEMBER = 'Tout Mois'
         CAPTION    = 'Mois'
         LEVELS     = (
            Annee Num_Semestre Num_Trimestre Num_Mois Num_JourMois
            ) /* LEVELS */
         DEFAULT;

      HIERARCHY 'Années'n 
         ALL_MEMBER = 'Tout Années'
         CAPTION    = 'Années'
         LEVELS     = (
            Annee Num_Mois
            ) /* LEVELS */;

      HIERARCHY Semaines 
         ALL_MEMBER = 'Tout Semaines'
         CAPTION    = 'Semaines'
         LEVELS     = (
            Annee Num_Semaine Num_Jour_Semaine
            ) /* LEVELS */;

      LEVEL Annee
         FORMAT         =  4.
         CAPTION        =  'Annee'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Semestre
         FORMAT         =  SEMESTRE12.
         CAPTION        =  'Num_Semestre'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Trimestre
         FORMAT         =  TRIMESTRE13.
         CAPTION        =  'Num_Trimestre'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Mois
         FORMAT         =  MOIS11.
         CAPTION        =  'Num_Mois'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_JourMois
         FORMAT         =  3.
         CAPTION        =  'Num_JourMois'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Semaine
         FORMAT         =  WEEK12.
         CAPTION        =  'Num_Semaine'
         SORT_ORDER     =  ASCENDING;

      LEVEL Num_Jour_Semaine
         FORMAT         =  SEMAINE12.
         CAPTION        =  'Num_Jour_Semaine'
         SORT_ORDER     =  ASCENDING;


RUN;
