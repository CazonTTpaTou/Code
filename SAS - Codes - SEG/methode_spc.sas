
proc sort data=stats.spc_cc_sciage_limites;
by Ass_Sci_Equipement;;
run;

PROC Univariate data=STATS.SPC_CC_SCIAGE_LIMITES normal NOPRINT;
by Ass_Sci_Equipement;
var ttv_avg ;
histogram ttv_avg /kernel normal ;
run;
/* observaation des histogrammes et tests de normalité */

proc means data=stats.spc_cc_sciage_limites;
by Ass_Sci_Equipement;
var ttv_avg;
run;

/* scie 22 Norma OK
Scie 17 NOK */

data calcul_Log;
set stats.spc_cc_sciage_limites;
donnees_log=log10(ttv_avg);
run;


/*Norma ok : calcul du cpk*/
/* selectionner la scie*/
/* besoin de la moyenne et de l'et*/
data calcul_Log;
set calcul_log(where=(ass_scie_equipement='HTC 22'));/* table avec par scie la moyenne et l'ecart-type des moyennes*/
Cpk=(60-Moyenne)/(3*ecart_type);
run;

/*tester si Cpk supérieur à 1 */
 /* si non : normalement on ne présente aucune carte de controle */
/* si oui : calcul des limites */

/* Calcul des limites de contrôles et de surveillance sup (pas de inf) */
data limites_TTV_Moyennes;
set calcul_log(where=(ass_scie_equipement='HTC 22'));
lim_ctrl_sup=moyenne+3*ecart_type;
lim_surv_sup=moyenne+2*ecart_type;
run; 

/* Si norma NOK : recuperer les percentiles */
proc means data=calcul_log(where=(ass_sci_equipement='HCT 17')) n mean  P95 P99 ;
	var ttv_avg  ;
	ods output Summary=pct_scie17; 
run;

/* on a les lim soit de controle soit via les percentiles*/

data moyenne_geometrique;/* transformation des données en géometrique*/
set calcul_log;
donnee_geo=10**donnees_log;
run;



/