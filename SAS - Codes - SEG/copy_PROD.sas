/**********************************************************************************************************************/
/* FICHE DESCRIPTIVE DU PROGRAMME :                                                                                   */
/*                                                                                                                    */
/* NOM.................= copy_prod                                                                                    */
/* MODELE..............=                                                                                              */
/* LIBELLE.............= Programme de copie d'une table de prod vers un r�pertoire donn� (recette technique)          */
/*                                                                                                                    */
/*---------------------------------------------- DESCRIPTION SOMMAIRE --------------------------------------------------*/
/* OBJET  : macro de copie des tables de prod vers un r�pertoire de DEV (n�cessaire pour une recette technique)       */
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



/* macro desc_variable : g�n�re un fichier excel avec les modalit�s de chacune des variables
on trouvera un onglet par variables �tudi�es
param�tres : 
- bib 		-> biblioth�que de la PROD (o� se trouve la table � r�cup�rer) 
- tab 		-> nom de la table � r�cup�rer
- path_sort -> chemin o� d�poser la table
*/
%macro copy_PROD(path_sort=, bib=,tab=);

libname sortie "&path_sort";

data sortie.&tab.;
set &bib..&tab;
run;

%mend;

%copy_PROD(path_sort=\\srv-sasdev\Partage\Suivi\Ticket 7767\recette, bib=DTM_PUR, tab=DTM_PUR_ARTICLES_SEGMENTATION);




