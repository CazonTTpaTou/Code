
/**
 * CRUD_BiblioCallbackHandler.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.5.4  Built on : Dec 19, 2010 (08:18:42 CET)
 */

    package service;

    /**
     *  CRUD_BiblioCallbackHandler Callback class, Users can extend this class and implement
     *  their own receiveResult and receiveError methods.
     */
    public abstract class CRUD_BiblioCallbackHandler{



    protected Object clientData;

    /**
    * User can pass in any object that needs to be accessed once the NonBlocking
    * Web service call is finished and appropriate method of this CallBack is called.
    * @param clientData Object mechanism by which the user can pass in user data
    * that will be avilable at the time this callback is called.
    */
    public CRUD_BiblioCallbackHandler(Object clientData){
        this.clientData = clientData;
    }

    /**
    * Please use this constructor if you don't want to set any clientData
    */
    public CRUD_BiblioCallbackHandler(){
        this.clientData = null;
    }

    /**
     * Get the client data
     */

     public Object getClientData() {
        return clientData;
     }

        
           /**
            * auto generated Axis2 call back method for consulter_Oeuvre method
            * override this method for handling normal response from consulter_Oeuvre operation
            */
           public void receiveResultconsulter_Oeuvre(
                    service.CRUD_BiblioStub.Consulter_OeuvreResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from consulter_Oeuvre operation
           */
            public void receiveErrorconsulter_Oeuvre(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for retirer_Oeuvre method
            * override this method for handling normal response from retirer_Oeuvre operation
            */
           public void receiveResultretirer_Oeuvre(
                    service.CRUD_BiblioStub.Retirer_OeuvreResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from retirer_Oeuvre operation
           */
            public void receiveErrorretirer_Oeuvre(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for liste_Adherent method
            * override this method for handling normal response from liste_Adherent operation
            */
           public void receiveResultliste_Adherent(
                    service.CRUD_BiblioStub.Liste_AdherentResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from liste_Adherent operation
           */
            public void receiveErrorliste_Adherent(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for ajouter_Oeuvre method
            * override this method for handling normal response from ajouter_Oeuvre operation
            */
           public void receiveResultajouter_Oeuvre(
                    service.CRUD_BiblioStub.Ajouter_OeuvreResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from ajouter_Oeuvre operation
           */
            public void receiveErrorajouter_Oeuvre(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for liste_Proprio method
            * override this method for handling normal response from liste_Proprio operation
            */
           public void receiveResultliste_Proprio(
                    service.CRUD_BiblioStub.Liste_ProprioResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from liste_Proprio operation
           */
            public void receiveErrorliste_Proprio(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for reserver_Oeuvre method
            * override this method for handling normal response from reserver_Oeuvre operation
            */
           public void receiveResultreserver_Oeuvre(
                    service.CRUD_BiblioStub.Reserver_OeuvreResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from reserver_Oeuvre operation
           */
            public void receiveErrorreserver_Oeuvre(java.lang.Exception e) {
            }
                
           /**
            * auto generated Axis2 call back method for liste_Oeuvre method
            * override this method for handling normal response from liste_Oeuvre operation
            */
           public void receiveResultliste_Oeuvre(
                    service.CRUD_BiblioStub.Liste_OeuvreResponse result
                        ) {
           }

          /**
           * auto generated Axis2 Error handler
           * override this method for handling error response from liste_Oeuvre operation
           */
            public void receiveErrorliste_Oeuvre(java.lang.Exception e) {
            }
                


    }
    