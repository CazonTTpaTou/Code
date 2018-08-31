libname ead "D:\SAS\AD\importAD";
libname mymeta "D:\SAS\AD\importMETA";
libname mychg "D:\SAS\AD\importCHG";
libname myerror "D:\SAS\AD\importERROR";

options metaserver="srv-sasva.photowatt.local" /* network name/address of the      */
                                        /*   metadata server.               */
                                        
        metaport=8561               /* Port Metadata Server is listening on.*/

        metauser="sasadm@saspw"  /* Domain Qualified Userid for          */
                                    /*   connection to metadata server.     */

        metapass="sasadmPHOTOWATT@2015"         /* Password for userid above.           */
 
        metaprotocol=bridge         /* Protocol for Metadata Server.        */  

        metarepository=foundation;  /* Default location of user information */
                                    /*   is in the foundation repository.   */
