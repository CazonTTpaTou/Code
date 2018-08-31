* Début du code EG généré (ne pas modifier cette ligne);
* 
*  Application stockée enregistrée par  
*  Enterprise Guide Stored Process Manager V5.1
*
*  ====================================================================
*  Nom de l'application stockée : Nombre_Mois_Filtre
*
*  Description : Détermine la plage d'intervalle du filtre sur la vue
*                V_Lots
*  ====================================================================
*
*  Dictionnaire d'invites de l'application stockée :
*  ____________________________________
*  N_MOIS
*       Type : Numérique
*      Libellé : Nombre de mois du filtre
*       Attr: Visible
*       Desc. : Détermine le nombre de mois d'historique remonté par la
*               requête
*  ____________________________________
*;


*ProcessBody;

%global N_MOIS;

%STPBEGIN;

OPTIONS VALIDVARNAME=ANY;

%macro ExtendValidMemName;

%if %sysevalf(&sysver>=9.3) %then options validmemname=extend;

%mend ExtendValidMemName;

%ExtendValidMemName;

* Fin du code EG généré (ne pas modifier cette ligne);

/*%global Mois;

%let Mois= %sysfunc(inputn(&Mois, 2.)) ;*/

PROC SQL;
UPDATE RE_Cel.V_Lots_Filtre_Parametres
SET Nombre_Mois = &N_Mois;


PROC SQL;
Option missing="0";

CREATE VIEW RE_CEL.V_LOTS_FILTRE AS
SELECT
 
	Lot AS Lot LABEL = "Lot",
	Groupe AS Groupe LABEL = "Groupe",
	Lot_Serig AS Lot_Serig LABEL = "Lot_Serig",
	Nb_Lots AS Nb_Lots LABEL = "Nb_Lots",
	Statut AS Statut LABEL = "Statut",
	Format AS Format LABEL = "Format",
	Forme AS Forme LABEL = "Forme",
	Materiau AS Materiau LABEL = "Materiau",
	Polarite AS Polarite LABEL = "Polarite",
	Grade AS Grade LABEL = "Grade",
	Fournisseur AS Fournisseur LABEL = "Fournisseur",
	Observations AS Observations LABEL = "Observations",
	Compte AS Compte LABEL = "Compte",
	OF1 AS OF1 LABEL = "OF1",
	OF2 AS OF2 LABEL = "OF2",
	Mep_Poste AS Mep_Poste LABEL = "Mep_Poste",
	Mep_Date_Poste AS Mep_Date_Poste LABEL = "Mep_Date_Poste",
	Meg_Equipe AS Meg_Equipe LABEL = "Meg_Equipe",
	Meg_Obs AS Meg_Obs LABEL = "Meg_Obs",
	Mep_Date_Heure_Sort AS Mep_Date_Heure_Sort LABEL = "Mep_Date_Heure_Sort",
	Mep_Qte_Entr AS Mep_Qte_Entr LABEL = "Mep_Qte_Entr",
	Mep_Qte_Sort AS Mep_Qte_Sort LABEL = "Mep_Qte_Sort",
	Mep_Rej_Total AS Mep_Rej_Total LABEL = "Mep_Rej_Total",
	Mep_Qte_Manq AS Mep_Qte_Manq LABEL = "Mep_Qte_Manq",
	Mep_Rej_Op_Ebr AS Mep_Rej_Op_Ebr LABEL = "Mep_Rej_Op_Ebr",
	Mep_Rej_Op_Asp AS Mep_Rej_Op_Asp LABEL = "Mep_Rej_Op_Asp",
	Mep_Rej_Op_Casse AS Mep_Rej_Op_Casse LABEL = "Mep_Rej_Op_Casse",
	Mep_Rej_Eq_Ebr AS Mep_Rej_Eq_Ebr LABEL = "Mep_Rej_Eq_Ebr",
	Mep_Rej_Eq_Epais AS Mep_Rej_Eq_Epais LABEL = "Mep_Rej_Eq_Epais",
	Mep_Rej_Eq_Dim AS Mep_Rej_Eq_Dim LABEL = "Mep_Rej_Eq_Dim",
	Mep_Equipement AS Mep_Equipement LABEL = "Mep_Equipement",
	Mep_Lot_Matiere AS Mep_Lot_Matiere LABEL = "Mep_Lot_Matiere",
	Textu_Poste AS Textu_Poste LABEL = "Textu_Poste",
	Textu_Date_Poste AS Textu_Date_Poste LABEL = "Textu_Date_Poste",
	Textu_Equipe AS Textu_Equipe LABEL = "Textu_Equipe",
	Textu_Obs AS Textu_Obs LABEL = "Textu_Obs",
	Textu_Date_Heure_Sort AS Textu_Date_Heure_Sort LABEL = "Textu_Date_Heure_Sort",
	Textu_Qte_Entr AS Textu_Qte_Entr LABEL = "Textu_Qte_Entr",
	Textu_Qte_Sort AS Textu_Qte_Sort LABEL = "Textu_Qte_Sort",
	Textu_Rej_Total AS Textu_Rej_Total LABEL = "Textu_Rej_Total",
	Textu_Qte_Manq AS Textu_Qte_Manq LABEL = "Textu_Qte_Manq",
	Textu_Pds_Decap_g AS Textu_Pds_Decap_g LABEL = "Textu_Pds_Decap_g",
	Textu_Rej_Op_Ebr AS Textu_Rej_Op_Ebr LABEL = "Textu_Rej_Op_Ebr",
	Textu_Rej_Op_Asp AS Textu_Rej_Op_Asp LABEL = "Textu_Rej_Op_Asp",
	Textu_Rej_Op_Casse AS Textu_Rej_Op_Casse LABEL = "Textu_Rej_Op_Casse",
	Textu_Rej_Eq_Casse AS Textu_Rej_Eq_Casse LABEL = "Textu_Rej_Eq_Casse",
	Textu_Equipement AS Textu_Equipement LABEL = "Textu_Equipement",
	Diff_Poste AS Diff_Poste LABEL = "Diff_Poste",
	Diff_Date_Poste AS Diff_Date_Poste LABEL = "Diff_Date_Poste",
	Diff_Equipe AS Diff_Equipe LABEL = "Diff_Equipe",
	Diff_Obs AS Diff_Obs LABEL = "Diff_Obs",
	Diff_Date_Heure_Sort AS Diff_Date_Heure_Sort LABEL = "Diff_Date_Heure_Sort",
	Diff_Qte_Entr AS Diff_Qte_Entr LABEL = "Diff_Qte_Entr",
	Diff_Qte_Sort AS Diff_Qte_Sort LABEL = "Diff_Qte_Sort",
	Diff_Rej_Total AS Diff_Rej_Total LABEL = "Diff_Rej_Total",
	Diff_Qte_Manq AS Diff_Qte_Manq LABEL = "Diff_Qte_Manq",
	Diff_Rej_Op_Ebr AS Diff_Rej_Op_Ebr LABEL = "Diff_Rej_Op_Ebr",
	Diff_Rej_Op_Asp AS Diff_Rej_Op_Asp LABEL = "Diff_Rej_Op_Asp",
	Diff_Rej_Op_Casse AS Diff_Rej_Op_Casse LABEL = "Diff_Rej_Op_Casse",
	Diff_Rej_Eq_Casse AS Diff_Rej_Eq_Casse LABEL = "Diff_Rej_Eq_Casse",
	Diff_Equipement AS Diff_Equipement LABEL = "Diff_Equipement",
	Diff_Tube AS Diff_Tube LABEL = "Diff_Tube",
	Diff_R2 AS Diff_R2 LABEL = "Diff_R2",
	Desox_Poste AS Desox_Poste LABEL = "Desox_Poste",
	Desox_Date_Poste AS Desox_Date_Poste LABEL = "Desox_Date_Poste",
	Desox_Equipe AS Desox_Equipe LABEL = "Desox_Equipe",
	Desox_Obs AS Desox_Obs LABEL = "Desox_Obs",
	Desox_Date_Heure_Sort AS Desox_Date_Heure_Sort LABEL = "Desox_Date_Heure_Sort",
	Desox_Qte_Entr AS Desox_Qte_Entr LABEL = "Desox_Qte_Entr",
	Desox_Qte_Sort AS Desox_Qte_Sort LABEL = "Desox_Qte_Sort",
	Desox_Rej_Total AS Desox_Rej_Total LABEL = "Desox_Rej_Total",
	Desox_Qte_Manq AS Desox_Qte_Manq LABEL = "Desox_Qte_Manq",
	Desox_Rej_Op_Ebr AS Desox_Rej_Op_Ebr LABEL = "Desox_Rej_Op_Ebr",
	Desox_Rej_Op_Asp AS Desox_Rej_Op_Asp LABEL = "Desox_Rej_Op_Asp",
	Desox_Rej_Op_Casse AS Desox_Rej_Op_Casse LABEL = "Desox_Rej_Op_Casse",
	Desox_Rej_Eq_Casse AS Desox_Rej_Eq_Casse LABEL = "Desox_Rej_Eq_Casse",
	Desox_Equipement AS Desox_Equipement LABEL = "Desox_Equipement",
	Pecvd_Poste AS Pecvd_Poste LABEL = "Pecvd_Poste",
	Pecvd_Date_Poste AS Pecvd_Date_Poste LABEL = "Pecvd_Date_Poste",
	Pecvd_Equipe AS Pecvd_Equipe LABEL = "Pecvd_Equipe",
	Pecvd_Obs AS Pecvd_Obs LABEL = "Pecvd_Obs",
	Pecvd_Date_Heure_Sort AS Pecvd_Date_Heure_Sort LABEL = "Pecvd_Date_Heure_Sort",
	Pecvd_Qte_Entr AS Pecvd_Qte_Entr LABEL = "Pecvd_Qte_Entr",
	Pecvd_Qte_Sort AS Pecvd_Qte_Sort LABEL = "Pecvd_Qte_Sort",
	Pecvd_Rej_Total AS Pecvd_Rej_Total LABEL = "Pecvd_Rej_Total",
	Pecvd_Qte_Manq AS Pecvd_Qte_Manq LABEL = "Pecvd_Qte_Manq",
	Pecvd_Rej_Op_Ebr AS Pecvd_Rej_Op_Ebr LABEL = "Pecvd_Rej_Op_Ebr",
	Pecvd_Rej_Op_Asp AS Pecvd_Rej_Op_Asp LABEL = "Pecvd_Rej_Op_Asp",
	Pecvd_Rej_Eq_Casse AS Pecvd_Rej_Eq_Casse LABEL = "Pecvd_Rej_Eq_Casse",
	Pecvd_Rej_Eq_B_ AS Pecvd_Rej_Eq_B_ LABEL = "Pecvd_Rej_Eq_B_",
	Pecvd_Rej_Eq_B AS Pecvd_Rej_Eq_B LABEL = "Pecvd_Rej_Eq_B",
	Pecvd_Rej_Eq_C AS Pecvd_Rej_Eq_C LABEL = "Pecvd_Rej_Eq_C",
	Pecvd_Rej_Op_Casse AS Pecvd_Rej_Op_Casse LABEL = "Pecvd_Rej_Op_Casse",
	Pecvd_Equipement AS Pecvd_Equipement LABEL = "Pecvd_Equipement",
	Seri_Poste AS Seri_Poste LABEL = "Seri_Poste",
	Seri_Date_Poste AS Seri_Date_Poste LABEL = "Seri_Date_Poste",
	Seri_Equipe AS Seri_Equipe LABEL = "Seri_Equipe",
	Seri_Obs AS Seri_Obs LABEL = "Seri_Obs",
	Seri_Date_Heure_Sort AS Seri_Date_Heure_Sort LABEL = "Seri_Date_Heure_Sort",
	Seri_Qte_Entr AS Seri_Qte_Entr LABEL = "Seri_Qte_Entr",
	Seri_Qte_Sort AS Seri_Qte_Sort LABEL = "Seri_Qte_Sort",
	Seri_Rej_Total AS Seri_Rej_Total LABEL = "Seri_Rej_Total",
	Serig_Qte_Manq AS Serig_Qte_Manq LABEL = "Serig_Qte_Manq",
	Seri_Rej_Op_Ebr AS Seri_Rej_Op_Ebr LABEL = "Seri_Rej_Op_Ebr",
	Seri_Rej_Op_Asp AS Seri_Rej_Op_Asp LABEL = "Seri_Rej_Op_Asp",
	Seri_Rej_Op_Casse AS Seri_Rej_Op_Casse LABEL = "Seri_Rej_Op_Casse",
	Seri_Rej_Chgt_Ebr AS Seri_Rej_Chgt_Ebr LABEL = "Seri_Rej_Chgt_Ebr",
	Seri_Rej_Chgt_Asp AS Seri_Rej_Chgt_Asp LABEL = "Seri_Rej_Chgt_Asp",
	Seri_Rej_Chgt_Casse AS Seri_Rej_Chgt_Casse LABEL = "Seri_Rej_Chgt_Casse",
	Seri_Rej_Station_1_Ebr AS Seri_Rej_Station_1_Ebr LABEL = "Seri_Rej_Station_1_Ebr",
	Seri_Rej_Station_1_Asp AS Seri_Rej_Station_1_Asp LABEL = "Seri_Rej_Station_1_Asp",
	Seri_Rej_Station_1_Casse AS Seri_Rej_Station_1_Casse LABEL = "Seri_Rej_Station_1_Casse",
	Seri_Rej_Eq_Vision1 AS Seri_Rej_Eq_Vision1 LABEL = "Seri_Rej_Eq_Vision1",
	Seri_Rej_Eq_Manq1 AS Seri_Rej_Eq_Manq1 LABEL = "Seri_Rej_Eq_Manq1",
	Seri_Rej_Station_2_Ebr AS Seri_Rej_Station_2_Ebr LABEL = "Seri_Rej_Station_2_Ebr",
	Seri_Rej_Station_2_Asp AS Seri_Rej_Station_2_Asp LABEL = "Seri_Rej_Station_2_Asp",
	Seri_Rej_Station_2_Casse AS Seri_Rej_Station_2_Casse LABEL = "Seri_Rej_Station_2_Casse",
	Seri_Rej_Eq_Vision2 AS Seri_Rej_Eq_Vision2 LABEL = "Seri_Rej_Eq_Vision2",
	Seri_Rej_Eq_Manq2 AS Seri_Rej_Eq_Manq2 LABEL = "Seri_Rej_Eq_Manq2",
	Seri_Rej_Station_3_Ebr AS Seri_Rej_Station_3_Ebr LABEL = "Seri_Rej_Station_3_Ebr",
	Seri_Rej_Station_3_Asp AS Seri_Rej_Station_3_Asp LABEL = "Seri_Rej_Station_3_Asp",
	Seri_Rej_Station_3_Casse AS Seri_Rej_Station_3_Casse LABEL = "Seri_Rej_Station_3_Casse",
	Seri_Rej_Eq_Vision3 AS Seri_Rej_Eq_Vision3 LABEL = "Seri_Rej_Eq_Vision3",
	Seri_Rej_Eq_Manq3 AS Seri_Rej_Eq_Manq3 LABEL = "Seri_Rej_Eq_Manq3",
	Seri_Rej_Station_4_Ebr AS Seri_Rej_Station_4_Ebr LABEL = "Seri_Rej_Station_4_Ebr",
	Seri_Rej_Station_4_Asp AS Seri_Rej_Station_4_Asp LABEL = "Seri_Rej_Station_4_Asp",
	Seri_Rej_Station_4_Casse AS Seri_Rej_Station_4_Casse LABEL = "Seri_Rej_Station_4_Casse",
	Seri_Rej_Dechgt_Ebr AS Seri_Rej_Dechgt_Ebr LABEL = "Seri_Rej_Dechgt_Ebr",
	Seri_Rej_Dechgt_Asp AS Seri_Rej_Dechgt_Asp LABEL = "Seri_Rej_Dechgt_Asp",
	Seri_Rej_Dechgt_Casse AS Seri_Rej_Dechgt_Casse LABEL = "Seri_Rej_Dechgt_Casse",
	Seri_Equipement AS Seri_Equipement LABEL = "Seri_Equipement",
	Tri_Poste AS Tri_Poste LABEL = "Tri_Poste",
	Tri_Date_Poste AS Tri_Date_Poste LABEL = "Tri_Date_Poste",
	Tri_Equipe AS Tri_Equipe LABEL = "Tri_Equipe",
	Tri_Obs AS Tri_Obs LABEL = "Tri_Obs",
	Tri_Date_Heure_Sort AS Tri_Date_Heure_Sort LABEL = "Tri_Date_Heure_Sort",
	Tri_Qte_Entr AS Tri_Qte_Entr LABEL = "Tri_Qte_Entr",
	Tri_Qte_Sort AS Tri_Qte_Sort LABEL = "Tri_Qte_Sort",
	Tri_Rej_Total AS Tri_Rej_Total LABEL = "Tri_Rej_Total",
	Tri_Qte_Manq AS Tri_Qte_Manq LABEL = "Tri_Qte_Manq",
	Tri_Qte_Non_Retri AS Tri_Qte_Non_Retri LABEL = "Tri_Qte_Non_Retri",
	Tri_Rej_Op_Ebr AS Tri_Rej_Op_Ebr LABEL = "Tri_Rej_Op_Ebr",
	Tri_Rej_Op_Asp AS Tri_Rej_Op_Asp LABEL = "Tri_Rej_Op_Asp",
	Tri_Rej_Op_Casse AS Tri_Rej_Op_Casse LABEL = "Tri_Rej_Op_Casse",
	Tri_Rej_Ep_Casse AS Tri_Rej_Ep_Casse LABEL = "Tri_Rej_Ep_Casse",
	Tri_Qte_Ecart AS Tri_Qte_Ecart LABEL = "Tri_Qte_Ecart",
	Tri_Equipement AS Tri_Equipement LABEL = "Tri_Equipement",
	Tri_Qte_18_8 AS Tri_Qte_18_8 LABEL = "Tri_Qte_18_8",
	Tri_Qte_18_6 AS Tri_Qte_18_6 LABEL = "Tri_Qte_18_6",
	Tri_Qte_18_4 AS Tri_Qte_18_4 LABEL = "Tri_Qte_18_4",
	Tri_Qte_18_2 AS Tri_Qte_18_2 LABEL = "Tri_Qte_18_2",
	Tri_Qte_18_0 AS Tri_Qte_18_0 LABEL = "Tri_Qte_18_0",
	Tri_Qte_17_8 AS Tri_Qte_17_8 LABEL = "Tri_Qte_17_8",
	Tri_Qte_17_6 AS Tri_Qte_17_6 LABEL = "Tri_Qte_17_6",
	Tri_Qte_17_4 AS Tri_Qte_17_4 LABEL = "Tri_Qte_17_4",
	Tri_Qte_17_2 AS Tri_Qte_17_2 LABEL = "Tri_Qte_17_2",
	Tri_Qte_17_0 AS Tri_Qte_17_0 LABEL = "Tri_Qte_17_0",
	Tri_Qte_16_8 AS Tri_Qte_16_8 LABEL = "Tri_Qte_16_8",
	Tri_Qte_16_6 AS Tri_Qte_16_6 LABEL = "Tri_Qte_16_6",
	Tri_Qte_16_4 AS Tri_Qte_16_4 LABEL = "Tri_Qte_16_4",
	Tri_Qte_16_2 AS Tri_Qte_16_2 LABEL = "Tri_Qte_16_2",
	Tri_Qte_16_0 AS Tri_Qte_16_0 LABEL = "Tri_Qte_16_0",


	Tri_Qte_15_8 AS Tri_Qte_15_8 LABEL = "Tri_Qte_15_8",
	Tri_Qte_15_6 AS Tri_Qte_15_6 LABEL = "Tri_Qte_15_6",
	Tri_Qte_15_4 AS Tri_Qte_15_4 LABEL = "Tri_Qte_15_4",
	Tri_Qte_15_2 AS Tri_Qte_15_2 LABEL = "Tri_Qte_15_2",
	Tri_Qte_15_0 AS Tri_Qte_15_0 LABEL = "Tri_Qte_15_0",
	Tri_Qte_14_8 AS Tri_Qte_14_8 LABEL = "Tri_Qte_14_8",
	Tri_Qte_14_6 AS Tri_Qte_14_6 LABEL = "Tri_Qte_14_6",
	Tri_Qte_14_4 AS Tri_Qte_14_4 LABEL = "Tri_Qte_14_4",
	Tri_Qte_14_2 AS Tri_Qte_14_2 LABEL = "Tri_Qte_14_2",
	Tri_Qte_14_0 AS Tri_Qte_14_0 LABEL = "Tri_Qte_14_0",
	Tri_Qte_13_8 AS Tri_Qte_13_8 LABEL = "Tri_Qte_13_8",
	Tri_Qte_13_6 AS Tri_Qte_13_6 LABEL = "Tri_Qte_13_6",
	Tri_Qte_13_4 AS Tri_Qte_13_4 LABEL = "Tri_Qte_13_4",
	Tri_Qte_13_2 AS Tri_Qte_13_2 LABEL = "Tri_Qte_13_2",
	Tri_Qte_13_0 AS Tri_Qte_13_0 LABEL = "Tri_Qte_13_0",
	Tri_Qte_12_8 AS Tri_Qte_12_8 LABEL = "Tri_Qte_12_8",
	Tri_Qte_12_6 AS Tri_Qte_12_6 LABEL = "Tri_Qte_12_6",
	Tri_Qte_12_4 AS Tri_Qte_12_4 LABEL = "Tri_Qte_12_4",
	Tri_Qte_12_2 AS Tri_Qte_12_2 LABEL = "Tri_Qte_12_2",
	Tri_Qte_12_0 AS Tri_Qte_12_0 LABEL = "Tri_Qte_12_0",
	Tri_Qte_L_18_0 AS Tri_Qte_L_18_0 LABEL = "Tri_Qte_L_18_0",
	Tri_Qte_L_17_0 AS Tri_Qte_L_17_0 LABEL = "Tri_Qte_L_17_0",
	Tri_Qte_L_16_0 AS Tri_Qte_L_16_0 LABEL = "Tri_Qte_L_16_0",
	Tri_Qte_L_15_6 AS Tri_Qte_L_15_6 LABEL = "Tri_Qte_L_15_6",
	Tri_Qte_L_14_0 AS Tri_Qte_L_14_0 LABEL = "Tri_Qte_L_14_0",
	Tri_Qte_L_13_6 AS Tri_Qte_L_13_6 LABEL = "Tri_Qte_L_13_6",
	Tri_Qte_L_12_0 AS Tri_Qte_L_12_0 LABEL = "Tri_Qte_L_12_0",
	Tri_Qte_L_11_6 AS Tri_Qte_L_11_6 LABEL = "Tri_Qte_L_11_6",
	Tri_Qte_Al AS Tri_Qte_Al LABEL = "Tri_Qte_Al",
	Tri_Qte_Ak AS Tri_Qte_Ak LABEL = "Tri_Qte_Ak",
	Tri_Qte_Ai AS Tri_Qte_Ai LABEL = "Tri_Qte_Ai",
	Tri_Qte_Aj AS Tri_Qte_Aj LABEL = "Tri_Qte_Aj",
	Tri_Qte_Ah AS Tri_Qte_Ah LABEL = "Tri_Qte_Ah",
	Tri_Qte_Ag AS Tri_Qte_Ag LABEL = "Tri_Qte_Ag",
	Tri_Qte_Af AS Tri_Qte_Af LABEL = "Tri_Qte_Af",
	Tri_Qte_Ae AS Tri_Qte_Ae LABEL = "Tri_Qte_Ae",
	Tri_Qte_Ad AS Tri_Qte_Ad LABEL = "Tri_Qte_Ad",
	Tri_Qte_Ac AS Tri_Qte_Ac LABEL = "Tri_Qte_Ac",
	Tri_Qte_Ab AS Tri_Qte_Ab LABEL = "Tri_Qte_Ab",
	Tri_Qte_Aa AS Tri_Qte_Aa LABEL = "Tri_Qte_Aa",
	Tri_Qte_A0 AS Tri_Qte_A0 LABEL = "Tri_Qte_A0",
	Tri_Qte_A1 AS Tri_Qte_A1 LABEL = "Tri_Qte_A1",
	Tri_Qte_A2 AS Tri_Qte_A2 LABEL = "Tri_Qte_A2",
	Tri_Qte_A3 AS Tri_Qte_A3 LABEL = "Tri_Qte_A3",
	Tri_Qte_B AS Tri_Qte_B LABEL = "Tri_Qte_B",
	Tri_Qte_C AS Tri_Qte_C LABEL = "Tri_Qte_C",
	Tri_Qte_D AS Tri_Qte_D LABEL = "Tri_Qte_D",
	Tri_Qte_E AS Tri_Qte_E LABEL = "Tri_Qte_E",
	Tri_Qte_F AS Tri_Qte_F LABEL = "Tri_Qte_F",
	Tri_Qte_G AS Tri_Qte_G LABEL = "Tri_Qte_G",
	Tri_Qte_H AS Tri_Qte_H LABEL = "Tri_Qte_H",
	Tri_Qte_I AS Tri_Qte_I LABEL = "Tri_Qte_I",
	Tri_Qte_J AS Tri_Qte_J LABEL = "Tri_Qte_J",
	Tri_Qte_K AS Tri_Qte_K LABEL = "Tri_Qte_K",
	Tri_Qte_L AS Tri_Qte_L LABEL = "Tri_Qte_L",
	Tri_Qte_A1L AS Tri_Qte_A1L LABEL = "Tri_Qte_A1L",
	Tri_Qte_M AS Tri_Qte_M LABEL = "Tri_Qte_M",
	Tri_Qte_Eme AS Tri_Qte_Eme LABEL = "Tri_Qte_Eme",
	Tri_Puiss_W AS Tri_Puiss_W LABEL = "Tri_Puiss_W",
	Societe AS Societe LABEL = "Societe",
	Desox_Rej_Eq_Casse_Chgt AS Desox_Rej_Eq_Casse_Chgt LABEL = "Desox_Rej_Eq_Casse_Chgt",
	Desox_Rej_Eq_Asp_Chgt AS Desox_Rej_Eq_Asp_Chgt LABEL = "Desox_Rej_Eq_Asp_Chgt",
	Desox_Rej_Eq_Casse_Dechgt AS Desox_Rej_Eq_Casse_Dechgt LABEL = "Desox_Rej_Eq_Casse_Dechgt",
	Desox_Rej_Eq_Asp_Dechgt AS Desox_Rej_Eq_Asp_Dechgt LABEL = "Desox_Rej_Eq_Asp_Dechgt",
	Diff_Nacelle AS Diff_Nacelle LABEL = "Diff_Nacelle",
	Pecvd_Tube AS Pecvd_Tube LABEL = "Pecvd_Tube",
	Pecvd_Nacelle AS Pecvd_Nacelle LABEL = "Pecvd_Nacelle",
	Tri_FF_Moy AS Tri_FF_Moy LABEL = "Tri_FF_Moy",
	Tri_Rend_Moy AS Tri_Rend_Moy LABEL = "Tri_Rend_Moy",
	Tri_Rs_Moy AS Tri_Rs_Moy LABEL = "Tri_Rs_Moy",
	Tri_Rsh_Moy AS Tri_Rsh_Moy LABEL = "Tri_Rsh_Moy",
	Tri_Qte_Idk AS Tri_Qte_Idk LABEL = "Tri_Qte_Idk",
	Tri_Qte_Div AS Tri_Qte_Div LABEL = "Tri_Qte_Div",
	Tri_Qte_Rsh AS Tri_Qte_Rsh LABEL = "Tri_Qte_Rsh",
	Tri_Qte_20_0 AS Tri_Qte_20_0 LABEL = "Tri_Qte_20_0",
	Tri_Qte_19_8 AS Tri_Qte_19_8 LABEL = "Tri_Qte_19_8",
	Tri_Qte_19_6 AS Tri_Qte_19_6 LABEL = "Tri_Qte_19_6",
	Tri_Qte_19_4 AS Tri_Qte_19_4 LABEL = "Tri_Qte_19_4",
	Tri_Qte_19_2 AS Tri_Qte_19_2 LABEL = "Tri_Qte_19_2",
	Tri_Qte_19_0 AS Tri_Qte_19_0 LABEL = "Tri_Qte_19_0",
	Tri_Qte_L_16_4 AS Tri_Qte_L_16_4 LABEL = "Tri_Qte_L_16_4",
	Textu_Vente_Qte As Textu_Vente_Qte LABEL = "Textu_Vente_Qte",
    Diff_Vente_Qte AS Diff_Vente_Qte LABEL = "Diff_Vente_Qte",
    Desox_Vente_Qte AS Desox_Vente_Qte LABEL = "Desox_Vente_Qte",
    Pecvd_Vente_Qte AS Pecvd_Vente_Qte LABEL = "Pecvd_Vente_Qte",
    Seri_Vente_Qte AS Seri_Vente_Qte LABEL = "Seri_Vente_Qte"

		FROM DS_SQC.V_LOTS,
			 RE_CEL.V_LOTS_FILTRE_PARAMETRES
			 
							WHERE 
								  Textu_Date_Heure_Sort ^=. 
								AND 
								  DATEPART(Textu_Date_Heure_Sort) >= INTNX('month', DATE(), -Nombre_Mois);


PROC SQL;
SELECT * FROM RE_Cel.V_Lots_Filtre_Parametres;
QUIT;

* Début du code EG généré (ne pas modifier cette ligne);
;*';*";*/;quit;
%STPEND;

* Fin du code EG généré (ne pas modifier cette ligne);

