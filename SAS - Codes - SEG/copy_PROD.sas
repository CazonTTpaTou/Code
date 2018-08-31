/**********************************************************************************************************************/
/* FICHE DESCRIPTIVE DU PROGRAMME :                                                                                   */
/*                                                                                                                    */
/* NOM.................= copy_prod                                                                                    */
/* MODELE..............=                                                                                              */
/* LIBELLE.............= Programme de copie d'une table de prod vers un répertoire donné (recette technique)          */
/*                                                                                                                    */
/*---------------------------------------------- DESCRIPTION SOMMAIRE --------------------------------------------------*/
/* OBJET  : macro de copie des tables de prod vers un répertoire de DEV (nécessaire pour une recette technique)       */
/*                                                                                                                    */
/*                                                                                                                    */
/*                                                                                                                    */
/*---------------------------------------------- DONNEES ---------------------------------------------------------------*/
/*                                                                                                                    */
/*                                                                                                                    */
/*                                                                                                                    */
/*                                                                                                                    */
/*---------------------------------------------- HISTORIQUE ------------------------------------------------------------*/
/* VERSION * AUTEUR        * DATE DE MAJ *       COMMENTAIRES                                                         */
/*---------*---------------*-------------*------------------------------------------------------------------------------*/
/* M001C01 * M.MORNET      * 06/03/2014  * CREATION DE L'OBJET                                                        */
/*---------*---------------*-------------*------------------------------------------------------------------------------*/
/*         *               *             *                                                                            */
/************************                        FIN CARTOUCHE                        *********************************/



/* macro desc_variable : génère un fichier excel avec les modalités de chacune des variables
on trouvera un onglet par variables étudiées
paramètres : 
- bib 		-> bibliothèque de la PROD (où se trouve la table à récupérer) 
- tab 		-> nom de la table à récupérer
- path_sort -> chemin où déposer la table
*/
%macro copy_PROD(path_sort=, bib=,tab=);

libname sortie "&path_sort";

data sortie.&tab.;
set &bib..&tab;
run;

%mend;

%copy_PROD(path_sort=\\srv-sasdev\Partage\Suivi\Ticket 7767\recette, bib=DTM_PUR, tab=DTM_PUR_ARTICLES_SEGMENTATION);




