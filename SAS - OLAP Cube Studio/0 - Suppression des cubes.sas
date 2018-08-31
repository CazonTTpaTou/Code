

/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/COUV_PLAN_MAINTENANCE"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;



/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/

OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/COUVERTURE_PREVENTIF"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;



/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/RESPECT_PREVENTIF"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


  METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;




/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/INDICATEURS_MAINT"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


 METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;




/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/

OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/RELEVE_COMPTEUR"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


 METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;



/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/DO_TEMPS_ARRET"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


  METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;


/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_ACTIVITES"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


   METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;


/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_DI"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;

METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;



/********    Enlevez les marques de commentaire sur cette partie du code pour pouvoir supprimer ce cube
********    fin du bloc de code en commentaire    ********/
OPTIONS VALIDVARNAME=ANY;


PROC OLAP
   CUBE                   = "/Shared Data/5_CUBES_OLAP/51_GMAO/SUIVI_DOMAINE"
   MAX_RETRIES            = 3
   MAX_RETRY_WAIT         = 60
   MIN_RETRY_WAIT         = 30
   DELETE;


  METASVR
      HOST        = "srv-sas"
      PORT        = 8561
      OLAP_SCHEMA = "SASApp - OLAP Schema"
      USERID="PWSASPROD" 
      pw="PWs@sPROD";

   RUN;

