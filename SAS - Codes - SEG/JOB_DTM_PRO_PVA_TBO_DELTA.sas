/**************************************************************************** 
 * Job :                     JOB_DTM_PRO_PVA_TBO_DELTA    A51VJW1Q.BR0003RN * 
 * Description :                                                            * 
 *                                                                          * 
 * Metadata Server :         srv-sas                                        * 
 * Port :                    8561                                           * 
 * Emplacement :             /Shared Data/3_JOBS/35_DTM/PRO                 * 
 *                                                                          * 
 * Serveur :                 SASApp                       A51VJW1Q.AR000002 * 
 *                                                                          * 
 * Tables source :           VUE_METIER_MESURES -         A51VJW1Q.BH0000HH * 
 *                            DS_SQC.VUE_METIER_MESURES                     * 
 *                           V_LOTS_DWH_DELTA -           A51VJW1Q.BH0000LE * 
 *                            DS_SQC.V_LOTS_DWH_DELTA                       * 
 * Tables cibles :           DTM_PRO_TBO_PVA -            A51VJW1Q.BH0000HX * 
 *                            DTM_PRO.DTM_PRO_TBO_PVA                       * 
 *                           CARTE_CONTROLE -             A51VJW1Q.BH0000K7 * 
 *                            DTM_PRO.CARTE_CONTROLE                        * 
 *                           DWH_SQC_LOTS -               A51VJW1Q.BH0000EK * 
 *                            DS_DWH.DWH_SQC_LOTS                           * 
 *                           CARTE_CONTROLE -             A51VJW1Q.BH0000K7 * 
 *                            DTM_PRO.CARTE_CONTROLE                        * 
 *                                                                          * 
 * Généré le :               dimanche 26 février 2017 19 h 53 CET           * 
 * Par :                     pwsasprod@PHOTOWATT                            * 
 * Version :                 SAS Data Integration Studio 4.6                * 
 ****************************************************************************/ 

/* Macro-variables globales  */ 
%let jobID = %quote(A51VJW1Q.BR0003RN);
%let etls_jobName = %nrquote(JOB_DTM_PRO_PVA_TBO_DELTA);
%let etls_userID = %nrquote(pwsasprod@PHOTOWATT);

/* Programme d'installation pour la saisie des codes de retour  */ 
%global job_rc trans_rc sqlrc ;
%let sysrc = 0;
%let job_rc = 0;
%let trans_rc = 0;
%let sqlrc = 0;
%global etls_stepStartTime; 
/* initialize syserr to 0 */
data _null_; run;

%macro rcSet(error); 
   %if (&error gt &trans_rc) %then 
      %let trans_rc = &error;
   %if (&error gt &job_rc) %then 
      %let job_rc = &error;
%mend rcSet; 

%macro rcSetDS(error); 
   if &error gt input(symget('trans_rc'),12.) then 
      call symput('trans_rc',trim(left(put(&error,12.))));
   if &error gt input(symget('job_rc'),12.) then 
      call symput('job_rc',trim(left(put(&error,12.))));
%mend rcSetDS; 

/* Créer les macro-variables des métadonnées */
%let IOMServer      = %nrquote(SASApp);
%let metaPort       = %nrquote(8561);
%let metaServer     = %nrquote(srv-sas);

/* Définir les options des métadonnées */
options metaport       = &metaPort 
        metaserver     = "&metaServer"; 

/* Programme d'installation pour la capture de l'état des jobs  */ 
%let etls_startTime = %sysfunc(datetime(),datetime.);
%let etls_recordsBefore = 0;
%let etls_recordsAfter = 0;
%let etls_lib = 0;
%let etls_table = 0;

%global etls_debug; 
%macro etls_setDebug; 
   %if %str(&etls_debug) ne 0 %then 
      OPTIONS MPRINT%str(;); 
%mend; 
%etls_setDebug; 

/*==========================================================================* 
 * Etape :                   Table Loader                 A51VJW1Q.BV000688 * 
 * Transformation :          Chargeur de tables (Version 2.1)               * 
 * Description :                                                            * 
 *                                                                          * 
 * Table source :            V_LOTS_DWH_DELTA -           A51VJW1Q.BH0000LE * 
 *                            DS_SQC.V_LOTS_DWH_DELTA                       * 
 * Table cible :             DWH_SQC_LOTS -               A51VJW1Q.BH0000EK * 
 *                            DS_DWH.DWH_SQC_LOTS                           * 
 *                                                                          * 
 * Avertissements :                                                         * 
 * La colonne cible de la correspondance Assemblage_1 est trop courte pour  * 
 *  la colonne source spécifiée Assemblage_1. Les valeurs seront tronquées. * 
 * La colonne cible de la correspondance Assemblage_2_ est trop courte pour * 
 *  la colonne source spécifiée Assemblage_2_. Les valeurs seront tronquées. * 
 * La colonne cible de la correspondance Lingot_1 est trop courte pour la   * 
 *  colonne source spécifiée Lingot_1. Les valeurs seront tronquées.        * 
 * La colonne cible de la correspondance Lingot_2_ est trop courte pour la  * 
 *  colonne source spécifiée Lingot_2_. Les valeurs seront tronquées.       * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV000688);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

/* Accéder aux données pour DS_DWH  */ 
LIBNAME DS_DWH ODBC  DATASRC=DWH_PROD  SCHEMA=dbo  AUTHDOMAIN="SQLServer" ;
%rcSet(&syslibrc); 

%let SYSLAST = %nrquote(DS_SQC.V_LOTS_DWH_DELTA); 

%let SYS_SQL_IP_SPEEDO = Y;
%let SYS_SQL_MAPPUTTO = sas_put;
%let SYS_SQLREDUCEPUT = DBMS;
%global etls_sql_pushDown;
%let etls_sql_pushDown = -1;
option DBIDIRECTEXEC;

%global etls_tableExist;
%global etls_numIndex;
%global etls_lastTable;
%let etls_tableExist = -1; 
%let etls_numIndex = -1; 
%let etls_lastTable = &SYSLAST; 

/*---- Define load data macro  ----*/ 

/* --------------------------------------------------------------
   Load Technique Selection: Replace - Truncate
   Constraint and index action selections: 'ASIS','ASIS','ASIS','ASIS'
   Additional options selections... 
      Set unmapped to missing on updates: false 
   -------------------------------------------------------------- */
%macro etls_loader;

   %let etls_tableOptions = ;
   
   /*---- Map the columns  ----*/ 
   proc datasets lib = work nolist nowarn memtype = (data view);
      delete WN7DXLF0;
   quit;
   
   data _null_;
      put "NOTE: La colonne cible de la correspondance Assemblage_1 est trop"
           " courte pour la colonne source spécifiée Assemblage_1. Les valeurs"
           " seront tronquées.";
   run;
   
   data _null_;
      put "NOTE: La colonne cible de la correspondance Assemblage_2_ est trop"
           " courte pour la colonne source spécifiée Assemblage_2_. Les valeurs"
           " seront tronquées.";
   run;
   
   data _null_;
      put "NOTE: La colonne cible de la correspondance Lingot_1 est trop courte"
           " pour la colonne source spécifiée Lingot_1. Les valeurs seront"
           " tronquées.";
   run;
   
   data _null_;
      put "NOTE: La colonne cible de la correspondance Lingot_2_ est trop"
           " courte pour la colonne source spécifiée Lingot_2_. Les valeurs"
           " seront tronquées.";
   run;
   
   data _null_;
      put "NOTE: The following column(s) do not have a column mapping, so the"
           " value(s) will be set to missing: PECVD_QuantiteManqMach,"
           " SERIG_QuantiteManqMach, TRI_QuantiteManqMach";
   run;
   
   %put %str(NOTE: Mapping columns ...);
   proc sql;
      create view work.WN7DXLF0 as
         select
            Societe,
            Lot,
            Groupable,
            Groupe,
            Lot_Serig,
            Nb_Lots,
            Statut,
            Format,
            Forme,
            Materiau,
            Polarite,
            Grade,
            Fournisseur,
            Assemblage_1 length = 50   
               format = $50.
               informat = $50.,
            Assemblage_2_ length = 414   
               format = $414.
               informat = $414.,
            Lingot_1 length = 50   
               format = $50.
               informat = $50.,
            Lingot_2_ length = 414   
               format = $414.
               informat = $414.,
            Observations,
            Compte,
            OF1,
            OF2,
            Meg_Mode,
            Meg_Poste,
            Meg_Date_Poste,
            Meg_Equipe,
            Meg_Matricule,
            Meg_Obs,
            Meg_Date_Heure,
            Meg_Equipement,
            Mep_Mode,
            Mep_Poste,
            Mep_Date_Poste,
            Mep_Equipe,
            Mep_Matricule,
            Mep_Obs,
            Mep_Date_Heure_Entr,
            Mep_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Mep_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Mep_Date_Heure_Sort,
            Mep_Date_Sort,
            Mep_Qte_Entr,
            Mep_Qte_Sort,
            Mep_Rej_Total,
            Mep_Qte_Manq,
            Mep_Rej_Op_Ebr,
            Mep_Rej_Op_Asp,
            Mep_Rej_Op_Casse,
            Mep_Rej_Eq_Ebr,
            Mep_Rej_Eq_Epais,
            Mep_Rej_Eq_Dim,
            Mep_Equipement,
            Mep_Lot_Matiere,
            Textu_Mode,
            Textu_Poste,
            Textu_Date_Poste,
            Textu_Equipe,
            Textu_Matricule,
            Textu_Obs,
            Textu_Date_Heure_Entr,
            Textu_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Textu_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Textu_Date_Heure_Sort,
            Textu_Date_Sort,
            Textu_Qte_Entr,
            Textu_Qte_Sort,
            Textu_Rej_Total,
            Textu_Qte_Manq,
            Textu_Pds_Decap_g,
            Textu_Rej_Op_Ebr,
            Textu_Rej_Op_Asp,
            Textu_Rej_Op_Casse,
            Textu_Rej_Eq_Casse,
            Textu_Equipement,
            Diff_Mode,
            Diff_Poste,
            Diff_Date_Poste,
            Diff_Equipe,
            Diff_Matricule,
            Diff_Obs,
            Diff_Date_Heure_Entr,
            Diff_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Diff_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Diff_Date_Heure_Sort,
            Diff_Date_Sort,
            Diff_Qte_Entr,
            Diff_Qte_Sort,
            Diff_Rej_Total,
            Diff_Qte_Manq,
            Diff_Rej_Op_Ebr,
            Diff_Rej_Op_Asp,
            Diff_Rej_Op_Casse,
            Diff_Rej_Eq_Casse,
            Diff_Equipement,
            Diff_Tube,
            Diff_Recette,
            Diff_Nacelle,
            Diff_Nacelle_Cpt,
            Diff_R2,
            Desox_Mode,
            Desox_Poste,
            Desox_Date_Poste,
            Desox_Equipe,
            Desox_Matricule,
            Desox_Obs,
            Desox_Date_Heure_Entr,
            Desox_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Desox_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Desox_Date_Heure_Sort,
            Desox_Date_Sort,
            Desox_Qte_Entr,
            Desox_Qte_Sort,
            Desox_Rej_Total,
            Desox_Qte_Manq,
            Desox_Rej_Op_Ebr,
            Desox_Rej_Op_Asp,
            Desox_Rej_Op_Casse,
            Desox_Rej_Eq_Casse,
            Desox_Equipement,
            Desox_Bac,
            Desox_Rej_Eq_Casse_Chgt,
            Desox_Rej_Eq_Asp_Chgt,
            Desox_Rej_Eq_Casse_Dechgt,
            Desox_Rej_Eq_Asp_Dechgt,
            Desox_RShunt,
            Pecvd_Mode,
            Pecvd_Poste,
            Pecvd_Date_Poste,
            Pecvd_Equipe,
            Pecvd_Matricule,
            Pecvd_Obs,
            Pecvd_Date_Heure_Entr,
            Pecvd_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Pecvd_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Pecvd_Date_Heure_Sort,
            Pecvd_Date_Sort,
            Pecvd_Qte_Entr,
            Pecvd_Qte_Sort,
            Pecvd_Rej_Total,
            Pecvd_Qte_Manq,
            Pecvd_Rej_Op_Ebr,
            Pecvd_Rej_Op_Asp,
            Pecvd_Rej_Op_Casse,
            Pecvd_Rej_Eq_B_,
            Pecvd_Rej_Eq_B,
            Pecvd_Rej_Eq_C,
            Pecvd_Rej_Eq_Casse,
            Pecvd_Equipement,
            Pecvd_Tube,
            Pecvd_Cth_Recette,
            Pecvd_Nacelle,
            Pecvd_Nacelle_Cpt,
            Pecvd_Vision_Recette,
            Seri_Mode,
            Seri_Poste,
            Seri_Date_Poste,
            Seri_Equipe,
            Seri_Matricule,
            Seri_Obs,
            Seri_Date_Heure_Entr,
            Seri_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Seri_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Seri_Date_Heure_Sort,
            Seri_Date_Sort,
            Seri_Qte_Entr,
            Seri_Qte_Sort,
            Seri_Rej_Total,
            Serig_Qte_Manq,
            Seri_Rej_Op_Ebr,
            Seri_Rej_Op_Asp,
            Seri_Rej_Op_Casse,
            Seri_Rej_Op_GradeB,
            Seri_Rej_Chgt_Ebr,
            Seri_Rej_Chgt_Asp,
            Seri_Rej_Chgt_Casse,
            Seri_Rej_Station_1_Ebr,
            Seri_Rej_Station_1_Asp,
            Seri_Rej_Station_1_Casse,
            Seri_Rej_Eq_Vision1,
            Seri_Rej_Eq_Manq1,
            Seri_Rej_Station_2_Ebr,
            Seri_Rej_Station_2_Asp,
            Seri_Rej_Station_2_Casse,
            Seri_Rej_Eq_Vision2,
            Seri_Rej_Eq_Manq2,
            Seri_Rej_Station_3_Ebr,
            Seri_Rej_Station_3_Asp,
            Seri_Rej_Station_3_Casse,
            Seri_Rej_Eq_Vision3,
            Seri_Rej_Eq_Manq3,
            Seri_Rej_Station_4_Ebr,
            Seri_Rej_Station_4_Asp,
            Seri_Rej_Station_4_Casse,
            Seri_Rej_Dechgt_Ebr,
            Seri_Rej_Dechgt_Asp,
            Seri_Rej_Dechgt_Casse,
            Seri_Equipement,
            Seri_Profil_Cuisson,
            (TRIM(LEFT(PUT(Seri_Num_Lot_Encre,BEST32.)))) as Seri_Num_Lot_Encre length = 50
               format = $50.
               informat = $50.,
            Seri_P1_Pds_Encre_mg,
            (TRIM(LEFT(PUT(Seri_P1_Ecran,BEST32.)))) as Seri_P1_Ecran length = 20
               format = $20.
               informat = $20.,
            Seri_P1_Num_Ecran,
            (TRIM(LEFT(PUT(Seri_P1_Cause_Chg_Ecran,BEST32.)))) as Seri_P1_Cause_Chg_Ecran length = 50
               format = $50.
               informat = $50.,
            Seri_P2_Pds_Encre_mg,
            (TRIM(LEFT(PUT(Seri_P2_Ecran,BEST32.)))) as Seri_P2_Ecran length = 20
               format = $20.
               informat = $20.,
            Seri_P2_Num_Ecran,
            (TRIM(LEFT(PUT(Seri_P2_Cause_Chg_Ecran,BEST32.)))) as Seri_P2_Cause_Chg_Ecran length = 50
               format = $50.
               informat = $50.,
            Seri_N1_Pds_Encre_mg,
            (TRIM(LEFT(PUT(Seri_N1_Ecran,BEST32.)))) as Seri_N1_Ecran length = 20
               format = $20.
               informat = $20.,
            Seri_N1_Num_Ecran,
            (TRIM(LEFT(PUT(Seri_N1_Cause_Chg_Ecran,BEST32.)))) as Seri_N1_Cause_Chg_Ecran length = 50
               format = $50.
               informat = $50.,
            Seri_N2_Pds_Encre_mg,
            (TRIM(LEFT(PUT(Seri_N2_Ecran,BEST32.)))) as Seri_N2_Ecran length = 20
               format = $20.
               informat = $20.,
            Seri_N2_Num_Ecran,
            (TRIM(LEFT(PUT(Seri_N2_Cause_Chg_Ecran,BEST32.)))) as Seri_N2_Cause_Chg_Ecran length = 50
               format = $50.
               informat = $50.,
            Tri_Mode,
            Tri_Poste,
            Tri_Date_Poste,
            (CASE   
               WHEN Tri_Date_Poste ^=.   
               THEN   
               PUT(YEAR(DATEPART(Tri_Date_Poste)), 4.)||'S'||  
               PUT(WEEK(DATEPART(Tri_Date_Poste), 'V'), z2.)  
                ELSE '' END) as Tri_Sem_Poste length = 8,
            (CASE   
               WHEN Tri_Date_Poste ^=. THEN   
               PUT(YEAR(DATEPART(Tri_Date_Poste)), 4.)||'M'||PUT(MONTH(DATEPART(Tri_Date_Poste)), z2.)   
               ELSE '' END) as Tri_Mois_Poste length = 8,
            Tri_Equipe,
            Tri_Matricule,
            Tri_Obs,
            Tri_Date_Heure_Entr,
            Tri_Date_Heure_Deb   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Tri_Date_Heure_Fin   
               format = DATETIME22.3
               informat = DATETIME22.3,
            Tri_Date_Heure_Sort,
            Tri_Date_Sort,
            Tri_Qte_Entr,
            Tri_Qte_Sort,
            Tri_Rej_Total,
            Tri_Qte_Manq,
            Tri_Qte_Non_Retri,
            Tri_Rej_Op_Ebr,
            Tri_Rej_Op_Asp,
            Tri_Rej_Op_Casse,
            Tri_Rej_Op_GradeB,
            Tri_Rej_Ep_Casse,
            Tri_Qte_Ecart,
            Tri_Equipement,
            Tri_Qte_22_0,
            Tri_Qte_21_8,
            Tri_Qte_21_6,
            Tri_Qte_21_4,
            Tri_Qte_21_2,
            Tri_Qte_21_0,
            Tri_Qte_20_8,
            Tri_Qte_20_6,
            Tri_Qte_20_4,
            Tri_Qte_20_2,
            Tri_Qte_20_0,
            Tri_Qte_19_8,
            Tri_Qte_19_6,
            Tri_Qte_19_4,
            Tri_Qte_19_2,
            Tri_Qte_19_0,
            Tri_Qte_18_8,
            Tri_Qte_18_6,
            Tri_Qte_18_4,
            Tri_Qte_18_2,
            Tri_Qte_18_0,
            Tri_Qte_17_8,
            Tri_Qte_17_6,
            Tri_Qte_17_4,
            Tri_Qte_17_2,
            Tri_Qte_17_0,
            Tri_Qte_16_8,
            Tri_Qte_16_6,
            Tri_Qte_16_4,
            Tri_Qte_16_2,
            Tri_Qte_16_0,
            Tri_Qte_15_8,
            Tri_Qte_15_6,
            Tri_Qte_15_4,
            Tri_Qte_15_2,
            Tri_Qte_15_0,
            Tri_Qte_14_8,
            Tri_Qte_14_6,
            Tri_Qte_14_4,
            Tri_Qte_14_2,
            Tri_Qte_14_0,
            Tri_Qte_13_8,
            Tri_Qte_13_6,
            Tri_Qte_13_4,
            Tri_Qte_13_2,
            Tri_Qte_13_0,
            Tri_Qte_12_8,
            Tri_Qte_12_6,
            Tri_Qte_12_4,
            Tri_Qte_12_2,
            Tri_Qte_12_0,
            Tri_Qte_L_18_0,
            Tri_Qte_L_17_0,
            Tri_Qte_L_16_0,
            Tri_Qte_L_15_6,
            Tri_Qte_L_14_0,
            Tri_Qte_L_13_6,
            Tri_Qte_L_12_0,
            Tri_Qte_L_11_6,
            Tri_Qte_Al,
            Tri_Qte_Ak,
            Tri_Qte_Ai,
            Tri_Qte_Aj,
            Tri_Qte_Ah,
            Tri_Qte_Ag,
            Tri_Qte_Af,
            Tri_Qte_Ae,
            Tri_Qte_Ad,
            Tri_Qte_Ac,
            Tri_Qte_Ab,
            Tri_Qte_Aa,
            Tri_Qte_A0,
            Tri_Qte_A1,
            Tri_Qte_A2,
            Tri_Qte_A3,
            Tri_Qte_B,
            Tri_Qte_C,
            Tri_Qte_D,
            Tri_Qte_E,
            Tri_Qte_F,
            Tri_Qte_G,
            Tri_Qte_H,
            Tri_Qte_I,
            Tri_Qte_J,
            Tri_Qte_K,
            Tri_Qte_L,
            Tri_Qte_A1L,
            Tri_Qte_M,
            Tri_Qte_Eme,
            Tri_Qte_Rsh,
            Tri_Puiss_W,
            Tri_Puiss_22_0,
            Tri_Puiss_21_8,
            Tri_Puiss_21_6,
            Tri_Puiss_21_4,
            Tri_Puiss_21_2,
            Tri_Puiss_21_0,
            Tri_Puiss_20_8,
            Tri_Puiss_20_6,
            Tri_Puiss_20_4,
            Tri_Puiss_20_2,
            Tri_Puiss_20_0,
            Tri_Puiss_19_8,
            Tri_Puiss_19_6,
            Tri_Puiss_19_4,
            Tri_Puiss_19_2,
            Tri_Puiss_19_0,
            Tri_Puiss_18_8,
            Tri_Puiss_18_6,
            Tri_Puiss_18_4,
            Tri_Puiss_18_2,
            Tri_Puiss_18_0,
            Tri_Puiss_17_8,
            Tri_Puiss_17_6,
            Tri_Puiss_17_4,
            Tri_Puiss_17_2,
            Tri_Puiss_17_0,
            Tri_Puiss_16_8,
            Tri_Puiss_16_6,
            Tri_Puiss_16_4,
            Tri_Puiss_16_2,
            Tri_Puiss_16_0,
            Tri_Puiss_15_8,
            Tri_Puiss_15_6,
            Tri_Puiss_15_4,
            Tri_Puiss_15_2,
            Tri_Puiss_15_0,
            Tri_Puiss_14_8,
            Tri_Puiss_14_6,
            Tri_Puiss_14_4,
            Tri_Puiss_14_2,
            Tri_Puiss_14_0,
            Tri_Puiss_13_8,
            Tri_Puiss_13_6,
            Tri_Puiss_13_4,
            Tri_Puiss_13_2,
            Tri_Puiss_13_0,
            Tri_Puiss_12_8,
            Tri_Puiss_12_6,
            Tri_Puiss_12_4,
            Tri_Puiss_12_2,
            Tri_Puiss_12_0,
            Tri_Puiss_L_18_0,
            Tri_Puiss_L_17_0,
            Tri_Puiss_L_16_0,
            Tri_Puiss_L_15_6,
            Tri_Puiss_L_14_0,
            Tri_Puiss_L_13_6,
            Tri_Puiss_L_12_0,
            Tri_Puiss_L_11_6,
            Tri_Puiss_Al,
            Tri_Puiss_Ak,
            Tri_Puiss_Aj,
            Tri_Puiss_Ai,
            Tri_Puiss_Ah,
            Tri_Puiss_Ag,
            Tri_Puiss_Af,
            Tri_Puiss_Ae,
            Tri_Puiss_Ad,
            Tri_Puiss_Ac,
            Tri_Puiss_Ab,
            Tri_Puiss_Aa,
            Tri_Puiss_A0,
            Tri_Puiss_A1,
            Tri_Puiss_A2,
            Tri_Puiss_A3,
            Tri_Puiss_B,
            Tri_Puiss_C,
            Tri_Puiss_D,
            Tri_Puiss_E,
            Tri_Puiss_F,
            Tri_Puiss_G,
            Tri_Puiss_H,
            Tri_Puiss_I,
            Tri_Puiss_J,
            Tri_Puiss_K,
            Tri_Puiss_L,
            Tri_Puiss_A1L,
            Tri_Puiss_M,
            Tri_Puiss_Eme,
            Tri_Puiss_Rsh,
            Tri_Fichier,
            Tri_Date_Heure_Fichier,
            Tri_Date_Heure_Import,
            Tri_Date_Heure_Mes_Min,
            Tri_Date_Heure_Mes_Max,
            Tri_Run,
            Tri_Wafer_Desc,
            Tri_Retri,
            Tri_Voc_Med,
            Tri_Voc_Moy,
            Tri_Voc_Ect,
            Tri_Voc_Ectr,
            Tri_Voc_Min,
            Tri_Voc_Max,
            Tri_Voc_Ampl,
            Tri_Isc_Med,
            Tri_Isc_Moy,
            Tri_Isc_Ect,
            Tri_Isc_Ectr,
            Tri_Isc_Min,
            Tri_Isc_Max,
            Tri_Isc_Ampl,
            Tri_Vmax_Med,
            Tri_Vmax_Moy,
            Tri_Vmax_Ect,
            Tri_Vmax_Ectr,
            Tri_Vmax_Min,
            Tri_Vmax_Max,
            Tri_Vmax_Ampl,
            Tri_Imax_Med,
            Tri_Imax_Moy,
            Tri_Imax_Ect,
            Tri_Imax_Ectr,
            Tri_Imax_Min,
            Tri_Imax_Max,
            Tri_Imax_Ampl,
            Tri_Pmax_Med,
            Tri_Pmax_Moy,
            Tri_Pmax_Ect,
            Tri_Pmax_Ectr,
            Tri_Pmax_Min,
            Tri_Pmax_Max,
            Tri_Pmax_Ampl,
            Tri_FF_Med,
            Tri_FF_Moy,
            Tri_FF_Ect,
            Tri_FF_Ectr,
            Tri_FF_Min,
            Tri_FF_Max,
            Tri_FF_Ampl,
            Tri_Rend_Med,
            Tri_Rend_Moy,
            Tri_Rend_Ect,
            Tri_Rend_Ectr,
            Tri_Rend_Min,
            Tri_Rend_Max,
            Tri_Rend_Ampl,
            Tri_Rs_Med,
            Tri_Rs_Moy,
            Tri_Rs_Ect,
            Tri_Rs_Ectr,
            Tri_Rs_Min,
            Tri_Rs_Max,
            Tri_Rs_Ampl,
            Tri_Rsh_Med,
            Tri_Rsh_Moy,
            Tri_Rsh_Ect,
            Tri_Rsh_Ectr,
            Tri_Rsh_Min,
            Tri_Rsh_Max,
            Tri_Rsh_Ampl,
            Tri_I_Vref_Med,
            Tri_I_Vref_Moy,
            Tri_I_Vref_Ect,
            Tri_I_Vref_Ectr,
            Tri_I_Vref_Min,
            Tri_I_Vref_Max,
            Tri_I_Vref_Ampl,
            Tri_Irrad_Med,
            Tri_Irrad_Moy,
            Tri_Irrad_Ect,
            Tri_Irrad_Ectr,
            Tri_Irrad_Min,
            Tri_Irrad_Max,
            Tri_Irrad_Ampl,
            Tri_IrrDev_Med,
            Tri_IrrDev_Moy,
            Tri_IrrDev_Ect,
            Tri_IrrDev_Ectr,
            Tri_IrrDev_Min,
            Tri_IrrDev_Max,
            Tri_IrrDev_Ampl,
            Tri_T_mon_Med,
            Tri_T_mon_Moy,
            Tri_T_mon_Ect,
            Tri_T_mon_Ectr,
            Tri_T_mon_Min,
            Tri_T_mon_Max,
            Tri_T_mon_Ampl,
            Tri_T_cell_Med,
            Tri_T_cell_Moy,
            Tri_T_cell_Ect,
            Tri_T_cell_Ectr,
            Tri_T_cell_Min,
            Tri_T_cell_Max,
            Tri_T_cell_Ampl,
            Tri_CoeffI_Med,
            Tri_CoeffI_Moy,
            Tri_CoeffI_Ect,
            Tri_CoeffI_Ectr,
            Tri_CoeffI_Min,
            Tri_CoeffI_Max,
            Tri_CoeffI_Ampl,
            Tri_CoeffV_Med,
            Tri_CoeffV_Moy,
            Tri_CoeffV_Ect,
            Tri_CoeffV_Ectr,
            Tri_CoeffV_Min,
            Tri_CoeffV_Max,
            Tri_CoeffV_Ampl,
            Tri_CoeffP_Med,
            Tri_CoeffP_Moy,
            Tri_CoeffP_Ect,
            (datetime()) as DateHeureSAS length = 8
               format = DATETIME22.3
               informat = DATETIME22.3,
            Tri_CoeffP_Ectr,
            Tri_CoeffP_Min,
            Tri_CoeffP_Max,
            Tri_CoeffP_Ampl,
            Textu_Rej_Eq_Casse_Chgt,
            Textu_Rej_Eq_Casse_Dechgt,
            Exe_Date_Heure,
            MeP_Rej_Param_Nom,
            MeP_Rej_Param_Qte,
            Textu_Rej_Param_Nom,
            Textu_Rej_Param_Qte,
            Textu_Vente_Observ,
            Textu_Vente_Qte,
            Diff_Rej_Param_Nom,
            Diff_Rej_Param_Qte,
            Diff_Vente_Observ,
            Diff_Vente_Qte,
            Desox_Rej_Param_Nom,
            Desox_Rej_Param_Qte,
            Desox_Vente_Observ,
            Desox_Vente_Qte,
            Pecvd_Rej_Param_Nom,
            Pecvd_Rej_Param_Qte,
            Pecvd_Vente_Observ,
            Pecvd_Vente_Qte,
            Seri_Rej_Param_Nom,
            Seri_Rej_Param_Qte,
            Seri_Vente_Observ,
            Seri_Vente_Qte,
            Tri_Rej_Param_Nom,
            Tri_Rej_Param_Qte,
            Tri_Rej_Eq_Meca_MC,
            Tri_Rej_Eq_Meca_Geom,
            Tri_Rej_Eq_Meca_Div,
            Tri_Qte_Idk,
            Tri_Qte_Div,
            Tri_Qte_L_12_2,
            Tri_Qte_L_12_4,
            Tri_Qte_L_12_6,
            Tri_Qte_L_12_8,
            Tri_Qte_L_13_0,
            Tri_Qte_L_13_2,
            Tri_Qte_L_13_4,
            Tri_Qte_L_13_8,
            Tri_Qte_L_14_2,
            Tri_Qte_L_14_4,
            Tri_Qte_L_14_6,
            Tri_Qte_L_14_8,
            Tri_Qte_L_15_0,
            Tri_Qte_L_15_2,
            Tri_Qte_L_15_4,
            Tri_Qte_L_15_8,
            Tri_Qte_L_16_2,
            Tri_Qte_L_16_4,
            Tri_Qte_L_16_6,
            Tri_Qte_L_16_8,
            Tri_Qte_L_17_2,
            Tri_Qte_L_17_4,
            Tri_Qte_L_17_6,
            Tri_Qte_L_17_8,
            Tri_Qte_L_18_2,
            Tri_Qte_L_18_4,
            Tri_Qte_L_18_6,
            Tri_Qte_L_18_8,
            Tri_Qte_L_19_0,
            Tri_Qte_L_19_2,
            Tri_Qte_L_19_4,
            Tri_Qte_L_19_6,
            Tri_Qte_L_19_8,
            Tri_Qte_L_20_0,
            Tri_Qte_L_20_2,
            Tri_Puiss_Idk,
            Tri_Puiss_Div,
            Tri_Puiss_L_12_2,
            Tri_Puiss_L_12_4,
            Tri_Puiss_L_12_6,
            Tri_Puiss_L_12_8,
            Tri_Puiss_L_13_0,
            Tri_Puiss_L_13_2,
            Tri_Puiss_L_13_4,
            Tri_Puiss_L_13_8,
            Tri_Puiss_L_14_2,
            Tri_Puiss_L_14_4,
            Tri_Puiss_L_14_6,
            Tri_Puiss_L_14_8,
            Tri_Puiss_L_15_0,
            Tri_Puiss_L_15_2,
            Tri_Puiss_L_15_4,
            Tri_Puiss_L_15_8,
            Tri_Puiss_L_16_2,
            Tri_Puiss_L_16_4,
            Tri_Puiss_L_16_6,
            Tri_Puiss_L_16_8,
            Tri_Puiss_L_17_2,
            Tri_Puiss_L_17_4,
            Tri_Puiss_L_17_6,
            Tri_Puiss_L_17_8,
            Tri_Puiss_L_18_2,
            Tri_Puiss_L_18_4,
            Tri_Puiss_L_18_6,
            Tri_Puiss_L_18_8,
            Tri_Puiss_L_19_0,
            Tri_Puiss_L_19_2,
            Tri_Puiss_L_19_4,
            Tri_Puiss_L_19_6,
            Tri_Puiss_L_19_8,
            Tri_Puiss_L_20_0,
            Tri_Puiss_L_20_2,
            Textu_Rej_Eq_Doubl,
            Textu_Rej_Eq_Epais,
            PECVD_OnOffLine,
            PECVD_DateHeureDebutCycle,
            PECVD_DateHeureFinCycle,
            PECVD_QuantiteEntreeMach,
            PECVD_QuantiteSortieMach,
            PECVD_QuantiteRejetMach,
            PECVD_QuantiteRejetOper,
            SERIG_OnOffLine,
            SERIG_DateHeureDebutCycle,
            SERIG_DateHeureFinCycle,
            SERIG_QuantiteEntreeMach,
            SERIG_QuantiteSortieMach,
            SERIG_QuantiteRejetMach,
            SERIG_QuantiteRejetOper,
            TRI_OnOffLine,
            TRI_DateHeureDebutCycle,
            TRI_DateHeureFinCycle,
            TRI_QuantiteEntreeMach,
            TRI_QuantiteSortieMach,
            TRI_QuantiteRejetMach,
            TRI_QuantiteRejetOper,
            Tri_IDK_Med,
            Tri_IDK_Moy,
            Tri_IDK_Ect,
            Tri_IDK_Ectr,
            Tri_IDK_Min,
            Tri_IDK_Max,
            Tri_IDK_Ampl,
            PECVD_QuantiteManqEntree,
            PECVD_QuantiteAjout,
            SERIG_QuantiteManqEntree,
            SERIG_QuantiteAjout,
            TRI_QuantiteManqEntree,
            TRI_QuantiteAjout,
            SERIG_RejEquipAspectInitial,
            . as PECVD_QuantiteManqMach length = 8
               format = 11.
               informat = 11.,
            . as SERIG_QuantiteManqMach length = 8
               format = 11.
               informat = 11.,
            . as TRI_QuantiteManqMach length = 8
               format = 11.
               informat = 11.
      from &etls_lastTable
      ;
   quit;
   
   %let SYSLAST = work.WN7DXLF0;
   
   %let etls_lastTable = &SYSLAST; 
   %let etls_tableOptions = ; 
   
   /* Determine if the target table exists  */ 
   %let etls_tableExist = %eval(%sysfunc(exist(DS_DWH.DWH_SQC_LOTS, DATA)) or 
         %sysfunc(exist(DS_DWH.DWH_SQC_LOTS, VIEW))); 
   
   /*---- Create a new table  ----*/ 
   %if (&etls_tableExist eq 0) %then 
   %do;  /* if table does not exist  */ 
   
      %put %str(NOTE: Creating table ...);
      
      data DS_DWH.DWH_SQC_LOTS
              (dbnull = (
                         Societe = NO
                         Lot = NO
                         Groupable = NO
                         Groupe = NO
                         Lot_Serig = YES
                         Nb_Lots = YES
                         Statut = YES
                         Format = YES
                         Forme = YES
                         Materiau = YES
                         Polarite = YES
                         Grade = YES
                         Fournisseur = YES
                         Assemblage_1 = YES
                         Assemblage_2_ = NO
                         Lingot_1 = YES
                         Lingot_2_ = NO
                         Observations = NO
                         Compte = NO
                         OF1 = YES
                         OF2 = YES
                         Meg_Mode = NO
                         Meg_Poste = YES
                         Meg_Date_Poste = YES
                         Meg_Equipe = YES
                         Meg_Matricule = YES
                         Meg_Obs = YES
                         Meg_Date_Heure = YES
                         Meg_Equipement = YES
                         Mep_Mode = NO
                         Mep_Poste = YES
                         Mep_Date_Poste = YES
                         Mep_Equipe = YES
                         Mep_Matricule = YES
                         Mep_Obs = YES
                         Mep_Date_Heure_Entr = YES
                         Mep_Date_Heure_Deb = YES
                         Mep_Date_Heure_Fin = YES
                         Mep_Date_Heure_Sort = YES
                         Mep_Date_Sort = YES
                         Mep_Qte_Entr = YES
                         Mep_Qte_Sort = YES
                         Mep_Rej_Total = YES
                         Mep_Qte_Manq = YES
                         Mep_Rej_Op_Ebr = YES
                         Mep_Rej_Op_Asp = YES
                         Mep_Rej_Op_Casse = YES
                         Mep_Rej_Eq_Ebr = YES
                         Mep_Rej_Eq_Epais = YES
                         Mep_Rej_Eq_Dim = YES
                         Mep_Equipement = YES
                         Mep_Lot_Matiere = YES
                         Textu_Mode = NO
                         Textu_Poste = YES
                         Textu_Date_Poste = YES
                         Textu_Equipe = YES
                         Textu_Matricule = YES
                         Textu_Obs = YES
                         Textu_Date_Heure_Entr = YES
                         Textu_Date_Heure_Deb = YES
                         Textu_Date_Heure_Fin = YES
                         Textu_Date_Heure_Sort = YES
                         Textu_Date_Sort = YES
                         Textu_Qte_Entr = YES
                         Textu_Qte_Sort = YES
                         Textu_Rej_Total = YES
                         Textu_Qte_Manq = YES
                         Textu_Pds_Decap_g = YES
                         Textu_Rej_Op_Ebr = YES
                         Textu_Rej_Op_Asp = YES
                         Textu_Rej_Op_Casse = YES
                         Textu_Rej_Eq_Casse = YES
                         Textu_Equipement = YES
                         Diff_Mode = NO
                         Diff_Poste = YES
                         Diff_Date_Poste = YES
                         Diff_Equipe = YES
                         Diff_Matricule = YES
                         Diff_Obs = YES
                         Diff_Date_Heure_Entr = YES
                         Diff_Date_Heure_Deb = YES
                         Diff_Date_Heure_Fin = YES
                         Diff_Date_Heure_Sort = YES
                         Diff_Date_Sort = YES
                         Diff_Qte_Entr = YES
                         Diff_Qte_Sort = YES
                         Diff_Rej_Total = YES
                         Diff_Qte_Manq = YES
                         Diff_Rej_Op_Ebr = YES
                         Diff_Rej_Op_Asp = YES
                         Diff_Rej_Op_Casse = YES
                         Diff_Rej_Eq_Casse = YES
                         Diff_Equipement = YES
                         Diff_Tube = YES
                         Diff_Recette = YES
                         Diff_Nacelle = YES
                         Diff_Nacelle_Cpt = YES
                         Diff_R2 = YES
                         Desox_Mode = NO
                         Desox_Poste = YES
                         Desox_Date_Poste = YES
                         Desox_Equipe = YES
                         Desox_Matricule = YES
                         Desox_Obs = YES
                         Desox_Date_Heure_Entr = YES
                         Desox_Date_Heure_Deb = YES
                         Desox_Date_Heure_Fin = YES
                         Desox_Date_Heure_Sort = YES
                         Desox_Date_Sort = YES
                         Desox_Qte_Entr = YES
                         Desox_Qte_Sort = YES
                         Desox_Rej_Total = YES
                         Desox_Qte_Manq = YES
                         Desox_Rej_Op_Ebr = YES
                         Desox_Rej_Op_Asp = YES
                         Desox_Rej_Op_Casse = YES
                         Desox_Rej_Eq_Casse = YES
                         Desox_Equipement = YES
                         Desox_Bac = YES
                         Desox_Rej_Eq_Casse_Chgt = YES
                         Desox_Rej_Eq_Asp_Chgt = YES
                         Desox_Rej_Eq_Casse_Dechgt = YES
                         Desox_Rej_Eq_Asp_Dechgt = YES
                         Desox_RShunt = YES
                         Pecvd_Mode = NO
                         Pecvd_Poste = YES
                         Pecvd_Date_Poste = YES
                         Pecvd_Equipe = YES
                         Pecvd_Matricule = YES
                         Pecvd_Obs = YES
                         Pecvd_Date_Heure_Entr = YES
                         Pecvd_Date_Heure_Deb = YES
                         Pecvd_Date_Heure_Fin = YES
                         Pecvd_Date_Heure_Sort = YES
                         Pecvd_Date_Sort = YES
                         Pecvd_Qte_Entr = YES
                         Pecvd_Qte_Sort = YES
                         Pecvd_Rej_Total = YES
                         Pecvd_Qte_Manq = YES
                         Pecvd_Rej_Op_Ebr = YES
                         Pecvd_Rej_Op_Asp = YES
                         Pecvd_Rej_Op_Casse = YES
                         Pecvd_Rej_Eq_B_ = YES
                         Pecvd_Rej_Eq_B = YES
                         Pecvd_Rej_Eq_C = YES
                         Pecvd_Rej_Eq_Casse = YES
                         Pecvd_Equipement = YES
                         Pecvd_Tube = YES
                         Pecvd_Cth_Recette = YES
                         Pecvd_Nacelle = YES
                         Pecvd_Nacelle_Cpt = YES
                         Pecvd_Vision_Recette = YES
                         Seri_Mode = NO
                         Seri_Poste = YES
                         Seri_Date_Poste = YES
                         Seri_Equipe = YES
                         Seri_Matricule = YES
                         Seri_Obs = YES
                         Seri_Date_Heure_Entr = YES
                         Seri_Date_Heure_Deb = YES
                         Seri_Date_Heure_Fin = YES
                         Seri_Date_Heure_Sort = YES
                         Seri_Date_Sort = YES
                         Seri_Qte_Entr = YES
                         Seri_Qte_Sort = YES
                         Seri_Rej_Total = YES
                         Serig_Qte_Manq = YES
                         Seri_Rej_Op_Ebr = YES
                         Seri_Rej_Op_Asp = YES
                         Seri_Rej_Op_Casse = YES
                         Seri_Rej_Op_GradeB = YES
                         Seri_Rej_Chgt_Ebr = YES
                         Seri_Rej_Chgt_Asp = YES
                         Seri_Rej_Chgt_Casse = YES
                         Seri_Rej_Station_1_Ebr = YES
                         Seri_Rej_Station_1_Asp = YES
                         Seri_Rej_Station_1_Casse = YES
                         Seri_Rej_Eq_Vision1 = YES
                         Seri_Rej_Eq_Manq1 = YES
                         Seri_Rej_Station_2_Ebr = YES
                         Seri_Rej_Station_2_Asp = YES
                         Seri_Rej_Station_2_Casse = YES
                         Seri_Rej_Eq_Vision2 = YES
                         Seri_Rej_Eq_Manq2 = YES
                         Seri_Rej_Station_3_Ebr = YES
                         Seri_Rej_Station_3_Asp = YES
                         Seri_Rej_Station_3_Casse = YES
                         Seri_Rej_Eq_Vision3 = YES
                         Seri_Rej_Eq_Manq3 = YES
                         Seri_Rej_Station_4_Ebr = YES
                         Seri_Rej_Station_4_Asp = YES
                         Seri_Rej_Station_4_Casse = YES
                         Seri_Rej_Dechgt_Ebr = YES
                         Seri_Rej_Dechgt_Asp = YES
                         Seri_Rej_Dechgt_Casse = YES
                         Seri_Equipement = YES
                         Seri_Profil_Cuisson = YES
                         Seri_Num_Lot_Encre = YES
                         Seri_P1_Pds_Encre_mg = YES
                         Seri_P1_Ecran = YES
                         Seri_P1_Num_Ecran = YES
                         Seri_P1_Cause_Chg_Ecran = YES
                         Seri_P2_Pds_Encre_mg = YES
                         Seri_P2_Ecran = YES
                         Seri_P2_Num_Ecran = YES
                         Seri_P2_Cause_Chg_Ecran = YES
                         Seri_N1_Pds_Encre_mg = YES
                         Seri_N1_Ecran = YES
                         Seri_N1_Num_Ecran = YES
                         Seri_N1_Cause_Chg_Ecran = YES
                         Seri_N2_Pds_Encre_mg = YES
                         Seri_N2_Ecran = YES
                         Seri_N2_Num_Ecran = YES
                         Seri_N2_Cause_Chg_Ecran = YES
                         Tri_Mode = NO
                         Tri_Poste = YES
                         Tri_Date_Poste = YES
                         Tri_Sem_Poste = YES
                         Tri_Mois_Poste = YES
                         Tri_Equipe = YES
                         Tri_Matricule = YES
                         Tri_Obs = YES
                         Tri_Date_Heure_Entr = YES
                         Tri_Date_Heure_Deb = YES
                         Tri_Date_Heure_Fin = YES
                         Tri_Date_Heure_Sort = YES
                         Tri_Date_Sort = YES
                         Tri_Qte_Entr = YES
                         Tri_Qte_Sort = YES
                         Tri_Rej_Total = YES
                         Tri_Qte_Manq = YES
                         Tri_Qte_Non_Retri = YES
                         Tri_Rej_Op_Ebr = YES
                         Tri_Rej_Op_Asp = YES
                         Tri_Rej_Op_Casse = YES
                         Tri_Rej_Op_GradeB = YES
                         Tri_Rej_Ep_Casse = YES
                         Tri_Qte_Ecart = YES
                         Tri_Equipement = YES
                         Tri_Qte_22_0 = NO
                         Tri_Qte_21_8 = NO
                         Tri_Qte_21_6 = NO
                         Tri_Qte_21_4 = NO
                         Tri_Qte_21_2 = NO
                         Tri_Qte_21_0 = NO
                         Tri_Qte_20_8 = NO
                         Tri_Qte_20_6 = NO
                         Tri_Qte_20_4 = NO
                         Tri_Qte_20_2 = NO
                         Tri_Qte_20_0 = NO
                         Tri_Qte_19_8 = NO
                         Tri_Qte_19_6 = NO
                         Tri_Qte_19_4 = NO
                         Tri_Qte_19_2 = NO
                         Tri_Qte_19_0 = NO
                         Tri_Qte_18_8 = NO
                         Tri_Qte_18_6 = NO
                         Tri_Qte_18_4 = NO
                         Tri_Qte_18_2 = NO
                         Tri_Qte_18_0 = NO
                         Tri_Qte_17_8 = NO
                         Tri_Qte_17_6 = NO
                         Tri_Qte_17_4 = NO
                         Tri_Qte_17_2 = NO
                         Tri_Qte_17_0 = NO
                         Tri_Qte_16_8 = NO
                         Tri_Qte_16_6 = NO
                         Tri_Qte_16_4 = NO
                         Tri_Qte_16_2 = NO
                         Tri_Qte_16_0 = NO
                         Tri_Qte_15_8 = NO
                         Tri_Qte_15_6 = NO
                         Tri_Qte_15_4 = NO
                         Tri_Qte_15_2 = NO
                         Tri_Qte_15_0 = NO
                         Tri_Qte_14_8 = NO
                         Tri_Qte_14_6 = NO
                         Tri_Qte_14_4 = NO
                         Tri_Qte_14_2 = NO
                         Tri_Qte_14_0 = NO
                         Tri_Qte_13_8 = NO
                         Tri_Qte_13_6 = NO
                         Tri_Qte_13_4 = NO
                         Tri_Qte_13_2 = NO
                         Tri_Qte_13_0 = NO
                         Tri_Qte_12_8 = NO
                         Tri_Qte_12_6 = NO
                         Tri_Qte_12_4 = NO
                         Tri_Qte_12_2 = NO
                         Tri_Qte_12_0 = NO
                         Tri_Qte_L_18_0 = NO
                         Tri_Qte_L_17_0 = NO
                         Tri_Qte_L_16_0 = NO
                         Tri_Qte_L_15_6 = NO
                         Tri_Qte_L_14_0 = NO
                         Tri_Qte_L_13_6 = NO
                         Tri_Qte_L_12_0 = NO
                         Tri_Qte_L_11_6 = NO
                         Tri_Qte_Al = NO
                         Tri_Qte_Ak = NO
                         Tri_Qte_Ai = NO
                         Tri_Qte_Aj = NO
                         Tri_Qte_Ah = NO
                         Tri_Qte_Ag = NO
                         Tri_Qte_Af = NO
                         Tri_Qte_Ae = NO
                         Tri_Qte_Ad = NO
                         Tri_Qte_Ac = NO
                         Tri_Qte_Ab = NO
                         Tri_Qte_Aa = NO
                         Tri_Qte_A0 = NO
                         Tri_Qte_A1 = NO
                         Tri_Qte_A2 = NO
                         Tri_Qte_A3 = NO
                         Tri_Qte_B = NO
                         Tri_Qte_C = NO
                         Tri_Qte_D = NO
                         Tri_Qte_E = NO
                         Tri_Qte_F = NO
                         Tri_Qte_G = NO
                         Tri_Qte_H = NO
                         Tri_Qte_I = NO
                         Tri_Qte_J = NO
                         Tri_Qte_K = NO
                         Tri_Qte_L = NO
                         Tri_Qte_A1L = NO
                         Tri_Qte_M = NO
                         Tri_Qte_Eme = NO
                         Tri_Qte_Rsh = YES
                         Tri_Puiss_W = YES
                         Tri_Puiss_22_0 = NO
                         Tri_Puiss_21_8 = NO
                         Tri_Puiss_21_6 = NO
                         Tri_Puiss_21_4 = NO
                         Tri_Puiss_21_2 = NO
                         Tri_Puiss_21_0 = NO
                         Tri_Puiss_20_8 = NO
                         Tri_Puiss_20_6 = NO
                         Tri_Puiss_20_4 = NO
                         Tri_Puiss_20_2 = NO
                         Tri_Puiss_20_0 = NO
                         Tri_Puiss_19_8 = NO
                         Tri_Puiss_19_6 = NO
                         Tri_Puiss_19_4 = NO
                         Tri_Puiss_19_2 = NO
                         Tri_Puiss_19_0 = NO
                         Tri_Puiss_18_8 = NO
                         Tri_Puiss_18_6 = NO
                         Tri_Puiss_18_4 = NO
                         Tri_Puiss_18_2 = NO
                         Tri_Puiss_18_0 = NO
                         Tri_Puiss_17_8 = NO
                         Tri_Puiss_17_6 = NO
                         Tri_Puiss_17_4 = NO
                         Tri_Puiss_17_2 = NO
                         Tri_Puiss_17_0 = NO
                         Tri_Puiss_16_8 = NO
                         Tri_Puiss_16_6 = NO
                         Tri_Puiss_16_4 = NO
                         Tri_Puiss_16_2 = NO
                         Tri_Puiss_16_0 = NO
                         Tri_Puiss_15_8 = NO
                         Tri_Puiss_15_6 = NO
                         Tri_Puiss_15_4 = NO
                         Tri_Puiss_15_2 = NO
                         Tri_Puiss_15_0 = NO
                         Tri_Puiss_14_8 = NO
                         Tri_Puiss_14_6 = NO
                         Tri_Puiss_14_4 = NO
                         Tri_Puiss_14_2 = NO
                         Tri_Puiss_14_0 = NO
                         Tri_Puiss_13_8 = NO
                         Tri_Puiss_13_6 = NO
                         Tri_Puiss_13_4 = NO
                         Tri_Puiss_13_2 = NO
                         Tri_Puiss_13_0 = NO
                         Tri_Puiss_12_8 = NO
                         Tri_Puiss_12_6 = NO
                         Tri_Puiss_12_4 = NO
                         Tri_Puiss_12_2 = NO
                         Tri_Puiss_12_0 = NO
                         Tri_Puiss_L_18_0 = NO
                         Tri_Puiss_L_17_0 = NO
                         Tri_Puiss_L_16_0 = NO
                         Tri_Puiss_L_15_6 = NO
                         Tri_Puiss_L_14_0 = NO
                         Tri_Puiss_L_13_6 = NO
                         Tri_Puiss_L_12_0 = NO
                         Tri_Puiss_L_11_6 = NO
                         Tri_Puiss_Al = NO
                         Tri_Puiss_Ak = NO
                         Tri_Puiss_Aj = NO
                         Tri_Puiss_Ai = NO
                         Tri_Puiss_Ah = NO
                         Tri_Puiss_Ag = NO
                         Tri_Puiss_Af = NO
                         Tri_Puiss_Ae = NO
                         Tri_Puiss_Ad = NO
                         Tri_Puiss_Ac = NO
                         Tri_Puiss_Ab = NO
                         Tri_Puiss_Aa = NO
                         Tri_Puiss_A0 = NO
                         Tri_Puiss_A1 = NO
                         Tri_Puiss_A2 = NO
                         Tri_Puiss_A3 = NO
                         Tri_Puiss_B = NO
                         Tri_Puiss_C = NO
                         Tri_Puiss_D = NO
                         Tri_Puiss_E = NO
                         Tri_Puiss_F = NO
                         Tri_Puiss_G = NO
                         Tri_Puiss_H = NO
                         Tri_Puiss_I = NO
                         Tri_Puiss_J = NO
                         Tri_Puiss_K = NO
                         Tri_Puiss_L = NO
                         Tri_Puiss_A1L = NO
                         Tri_Puiss_M = NO
                         Tri_Puiss_Eme = NO
                         Tri_Puiss_Rsh = YES
                         Tri_Fichier = YES
                         Tri_Date_Heure_Fichier = YES
                         Tri_Date_Heure_Import = YES
                         Tri_Date_Heure_Mes_Min = YES
                         Tri_Date_Heure_Mes_Max = YES
                         Tri_Run = YES
                         Tri_Wafer_Desc = YES
                         Tri_Retri = YES
                         Tri_Voc_Med = YES
                         Tri_Voc_Moy = YES
                         Tri_Voc_Ect = YES
                         Tri_Voc_Ectr = YES
                         Tri_Voc_Min = YES
                         Tri_Voc_Max = YES
                         Tri_Voc_Ampl = YES
                         Tri_Isc_Med = YES
                         Tri_Isc_Moy = YES
                         Tri_Isc_Ect = YES
                         Tri_Isc_Ectr = YES
                         Tri_Isc_Min = YES
                         Tri_Isc_Max = YES
                         Tri_Isc_Ampl = YES
                         Tri_Vmax_Med = YES
                         Tri_Vmax_Moy = YES
                         Tri_Vmax_Ect = YES
                         Tri_Vmax_Ectr = YES
                         Tri_Vmax_Min = YES
                         Tri_Vmax_Max = YES
                         Tri_Vmax_Ampl = YES
                         Tri_Imax_Med = YES
                         Tri_Imax_Moy = YES
                         Tri_Imax_Ect = YES
                         Tri_Imax_Ectr = YES
                         Tri_Imax_Min = YES
                         Tri_Imax_Max = YES
                         Tri_Imax_Ampl = YES
                         Tri_Pmax_Med = YES
                         Tri_Pmax_Moy = YES
                         Tri_Pmax_Ect = YES
                         Tri_Pmax_Ectr = YES
                         Tri_Pmax_Min = YES
                         Tri_Pmax_Max = YES
                         Tri_Pmax_Ampl = YES
                         Tri_FF_Med = YES
                         Tri_FF_Moy = YES
                         Tri_FF_Ect = YES
                         Tri_FF_Ectr = YES
                         Tri_FF_Min = YES
                         Tri_FF_Max = YES
                         Tri_FF_Ampl = YES
                         Tri_Rend_Med = YES
                         Tri_Rend_Moy = YES
                         Tri_Rend_Ect = YES
                         Tri_Rend_Ectr = YES
                         Tri_Rend_Min = YES
                         Tri_Rend_Max = YES
                         Tri_Rend_Ampl = YES
                         Tri_Rs_Med = YES
                         Tri_Rs_Moy = YES
                         Tri_Rs_Ect = YES
                         Tri_Rs_Ectr = YES
                         Tri_Rs_Min = YES
                         Tri_Rs_Max = YES
                         Tri_Rs_Ampl = YES
                         Tri_Rsh_Med = YES
                         Tri_Rsh_Moy = YES
                         Tri_Rsh_Ect = YES
                         Tri_Rsh_Ectr = YES
                         Tri_Rsh_Min = YES
                         Tri_Rsh_Max = YES
                         Tri_Rsh_Ampl = YES
                         Tri_I_Vref_Med = YES
                         Tri_I_Vref_Moy = YES
                         Tri_I_Vref_Ect = YES
                         Tri_I_Vref_Ectr = YES
                         Tri_I_Vref_Min = YES
                         Tri_I_Vref_Max = YES
                         Tri_I_Vref_Ampl = YES
                         Tri_Irrad_Med = YES
                         Tri_Irrad_Moy = YES
                         Tri_Irrad_Ect = YES
                         Tri_Irrad_Ectr = YES
                         Tri_Irrad_Min = YES
                         Tri_Irrad_Max = YES
                         Tri_Irrad_Ampl = YES
                         Tri_IrrDev_Med = YES
                         Tri_IrrDev_Moy = YES
                         Tri_IrrDev_Ect = YES
                         Tri_IrrDev_Ectr = YES
                         Tri_IrrDev_Min = YES
                         Tri_IrrDev_Max = YES
                         Tri_IrrDev_Ampl = YES
                         Tri_T_mon_Med = YES
                         Tri_T_mon_Moy = YES
                         Tri_T_mon_Ect = YES
                         Tri_T_mon_Ectr = YES
                         Tri_T_mon_Min = YES
                         Tri_T_mon_Max = YES
                         Tri_T_mon_Ampl = YES
                         Tri_T_cell_Med = YES
                         Tri_T_cell_Moy = YES
                         Tri_T_cell_Ect = YES
                         Tri_T_cell_Ectr = YES
                         Tri_T_cell_Min = YES
                         Tri_T_cell_Max = YES
                         Tri_T_cell_Ampl = YES
                         Tri_CoeffI_Med = YES
                         Tri_CoeffI_Moy = YES
                         Tri_CoeffI_Ect = YES
                         Tri_CoeffI_Ectr = YES
                         Tri_CoeffI_Min = YES
                         Tri_CoeffI_Max = YES
                         Tri_CoeffI_Ampl = YES
                         Tri_CoeffV_Med = YES
                         Tri_CoeffV_Moy = YES
                         Tri_CoeffV_Ect = YES
                         Tri_CoeffV_Ectr = YES
                         Tri_CoeffV_Min = YES
                         Tri_CoeffV_Max = YES
                         Tri_CoeffV_Ampl = YES
                         Tri_CoeffP_Med = YES
                         Tri_CoeffP_Moy = YES
                         Tri_CoeffP_Ect = YES
                         DateHeureSAS = YES
                         Tri_CoeffP_Ectr = YES
                         Tri_CoeffP_Min = YES
                         Tri_CoeffP_Max = YES
                         Tri_CoeffP_Ampl = YES
                         Textu_Rej_Eq_Casse_Chgt = YES
                         Textu_Rej_Eq_Casse_Dechgt = YES
                         Exe_Date_Heure = YES
                         MeP_Rej_Param_Nom = YES
                         MeP_Rej_Param_Qte = YES
                         Textu_Rej_Param_Nom = YES
                         Textu_Rej_Param_Qte = YES
                         Textu_Vente_Observ = YES
                         Textu_Vente_Qte = YES
                         Diff_Rej_Param_Nom = YES
                         Diff_Rej_Param_Qte = YES
                         Diff_Vente_Observ = YES
                         Diff_Vente_Qte = YES
                         Desox_Rej_Param_Nom = YES
                         Desox_Rej_Param_Qte = YES
                         Desox_Vente_Observ = YES
                         Desox_Vente_Qte = YES
                         Pecvd_Rej_Param_Nom = YES
                         Pecvd_Rej_Param_Qte = YES
                         Pecvd_Vente_Observ = YES
                         Pecvd_Vente_Qte = YES
                         Seri_Rej_Param_Nom = YES
                         Seri_Rej_Param_Qte = YES
                         Seri_Vente_Observ = YES
                         Seri_Vente_Qte = YES
                         Tri_Rej_Param_Nom = YES
                         Tri_Rej_Param_Qte = YES
                         Tri_Rej_Eq_Meca_MC = YES
                         Tri_Rej_Eq_Meca_Geom = YES
                         Tri_Rej_Eq_Meca_Div = YES
                         Tri_Qte_Idk = YES
                         Tri_Qte_Div = YES
                         Tri_Qte_L_12_2 = YES
                         Tri_Qte_L_12_4 = YES
                         Tri_Qte_L_12_6 = YES
                         Tri_Qte_L_12_8 = YES
                         Tri_Qte_L_13_0 = YES
                         Tri_Qte_L_13_2 = YES
                         Tri_Qte_L_13_4 = YES
                         Tri_Qte_L_13_8 = YES
                         Tri_Qte_L_14_2 = YES
                         Tri_Qte_L_14_4 = YES
                         Tri_Qte_L_14_6 = YES
                         Tri_Qte_L_14_8 = YES
                         Tri_Qte_L_15_0 = YES
                         Tri_Qte_L_15_2 = YES
                         Tri_Qte_L_15_4 = YES
                         Tri_Qte_L_15_8 = YES
                         Tri_Qte_L_16_2 = YES
                         Tri_Qte_L_16_4 = YES
                         Tri_Qte_L_16_6 = YES
                         Tri_Qte_L_16_8 = YES
                         Tri_Qte_L_17_2 = YES
                         Tri_Qte_L_17_4 = YES
                         Tri_Qte_L_17_6 = YES
                         Tri_Qte_L_17_8 = YES
                         Tri_Qte_L_18_2 = YES
                         Tri_Qte_L_18_4 = YES
                         Tri_Qte_L_18_6 = YES
                         Tri_Qte_L_18_8 = YES
                         Tri_Qte_L_19_0 = YES
                         Tri_Qte_L_19_2 = YES
                         Tri_Qte_L_19_4 = YES
                         Tri_Qte_L_19_6 = YES
                         Tri_Qte_L_19_8 = YES
                         Tri_Qte_L_20_0 = YES
                         Tri_Qte_L_20_2 = YES
                         Tri_Puiss_Idk = YES
                         Tri_Puiss_Div = YES
                         Tri_Puiss_L_12_2 = YES
                         Tri_Puiss_L_12_4 = YES
                         Tri_Puiss_L_12_6 = YES
                         Tri_Puiss_L_12_8 = YES
                         Tri_Puiss_L_13_0 = YES
                         Tri_Puiss_L_13_2 = YES
                         Tri_Puiss_L_13_4 = YES
                         Tri_Puiss_L_13_8 = YES
                         Tri_Puiss_L_14_2 = YES
                         Tri_Puiss_L_14_4 = YES
                         Tri_Puiss_L_14_6 = YES
                         Tri_Puiss_L_14_8 = YES
                         Tri_Puiss_L_15_0 = YES
                         Tri_Puiss_L_15_2 = YES
                         Tri_Puiss_L_15_4 = YES
                         Tri_Puiss_L_15_8 = YES
                         Tri_Puiss_L_16_2 = YES
                         Tri_Puiss_L_16_4 = YES
                         Tri_Puiss_L_16_6 = YES
                         Tri_Puiss_L_16_8 = YES
                         Tri_Puiss_L_17_2 = YES
                         Tri_Puiss_L_17_4 = YES
                         Tri_Puiss_L_17_6 = YES
                         Tri_Puiss_L_17_8 = YES
                         Tri_Puiss_L_18_2 = YES
                         Tri_Puiss_L_18_4 = YES
                         Tri_Puiss_L_18_6 = YES
                         Tri_Puiss_L_18_8 = YES
                         Tri_Puiss_L_19_0 = YES
                         Tri_Puiss_L_19_2 = YES
                         Tri_Puiss_L_19_4 = YES
                         Tri_Puiss_L_19_6 = YES
                         Tri_Puiss_L_19_8 = YES
                         Tri_Puiss_L_20_0 = YES
                         Tri_Puiss_L_20_2 = YES
                         Textu_Rej_Eq_Doubl = YES
                         Textu_Rej_Eq_Epais = YES
                         PECVD_OnOffLine = YES
                         PECVD_DateHeureDebutCycle = YES
                         PECVD_DateHeureFinCycle = YES
                         PECVD_QuantiteEntreeMach = YES
                         PECVD_QuantiteSortieMach = YES
                         PECVD_QuantiteRejetMach = YES
                         PECVD_QuantiteRejetOper = YES
                         SERIG_OnOffLine = YES
                         SERIG_DateHeureDebutCycle = YES
                         SERIG_DateHeureFinCycle = YES
                         SERIG_QuantiteEntreeMach = YES
                         SERIG_QuantiteSortieMach = YES
                         SERIG_QuantiteRejetMach = YES
                         SERIG_QuantiteRejetOper = YES
                         TRI_OnOffLine = YES
                         TRI_DateHeureDebutCycle = YES
                         TRI_DateHeureFinCycle = YES
                         TRI_QuantiteEntreeMach = YES
                         TRI_QuantiteSortieMach = YES
                         TRI_QuantiteRejetMach = YES
                         TRI_QuantiteRejetOper = YES
                         Tri_IDK_Med = YES
                         Tri_IDK_Moy = YES
                         Tri_IDK_Ect = YES
                         Tri_IDK_Ectr = YES
                         Tri_IDK_Min = YES
                         Tri_IDK_Max = YES
                         Tri_IDK_Ampl = YES
                         PECVD_QuantiteManqEntree = NO
                         PECVD_QuantiteAjout = NO
                         SERIG_QuantiteManqEntree = NO
                         SERIG_QuantiteAjout = NO
                         TRI_QuantiteManqEntree = NO
                         TRI_QuantiteAjout = NO
                         SERIG_RejEquipAspectInitial = NO
                         PECVD_QuantiteManqMach = YES
                         SERIG_QuantiteManqMach = YES
                         TRI_QuantiteManqMach = YES));
         attrib Societe length = $11
            format = $11.
            informat = $11.
            label = 'Societe'; 
         attrib Lot length = $50
            format = $50.
            informat = $50.
            label = 'Lot'; 
         attrib Groupable length = $3
            format = $3.
            informat = $3.
            label = 'Groupable'; 
         attrib Groupe length = $3
            format = $3.
            informat = $3.
            label = 'Groupe'; 
         attrib Lot_Serig length = $50
            format = $50.
            informat = $50.
            label = 'Lot Serig'; 
         attrib Nb_Lots length = 8
            format = 11.
            informat = 11.
            label = 'Nb Lots'; 
         attrib Statut length = $50
            format = $50.
            informat = $50.
            label = 'Statut'; 
         attrib Format length = 8
            format = 11.
            informat = 11.
            label = 'Format'; 
         attrib Forme length = $50
            format = $50.
            informat = $50.
            label = 'Forme'; 
         attrib Materiau length = $50
            format = $50.
            informat = $50.
            label = 'Materiau'; 
         attrib Polarite length = $50
            format = $50.
            informat = $50.
            label = 'Polarite'; 
         attrib Grade length = $50
            format = $50.
            informat = $50.
            label = 'Grade'; 
         attrib Fournisseur length = $50
            format = $50.
            informat = $50.
            label = 'Fournisseur'; 
         attrib Assemblage_1 length = $50
            format = $50.
            informat = $50.
            label = 'Assemblage 1'; 
         attrib Assemblage_2_ length = $414
            format = $414.
            informat = $414.
            label = 'Assemblage 2+'; 
         attrib Lingot_1 length = $50
            format = $50.
            informat = $50.
            label = 'Lingot 1'; 
         attrib Lingot_2_ length = $414
            format = $414.
            informat = $414.
            label = 'Lingot 2+'; 
         attrib Observations length = $1828
            format = $1828.
            informat = $1828.
            label = 'Observations'; 
         attrib Compte length = 8
            format = 11.
            informat = 11.
            label = 'Compte'; 
         attrib OF1 length = $50
            format = $50.
            informat = $50.
            label = 'OF1'; 
         attrib OF2 length = $50
            format = $50.
            informat = $50.
            label = 'OF2'; 
         attrib Meg_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Meg Mode'; 
         attrib Meg_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Meg Poste'; 
         attrib Meg_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Meg Date Poste'; 
         attrib Meg_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Meg Equipe'; 
         attrib Meg_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Meg Matricule'; 
         attrib Meg_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Meg Obs'; 
         attrib Meg_Date_Heure length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Meg Date Heure'; 
         attrib Meg_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Meg Equipement'; 
         attrib Mep_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Mep Mode'; 
         attrib Mep_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Mep Poste'; 
         attrib Mep_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Poste'; 
         attrib Mep_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Mep Equipe'; 
         attrib Mep_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Mep Matricule'; 
         attrib Mep_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Mep Obs'; 
         attrib Mep_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Heure Entr'; 
         attrib Mep_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Heure Deb'; 
         attrib Mep_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Heure Fin'; 
         attrib Mep_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Heure Sort'; 
         attrib Mep_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mep Date Sort'; 
         attrib Mep_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Mep Qte Entr'; 
         attrib Mep_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Mep Qte Sort'; 
         attrib Mep_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Total'; 
         attrib Mep_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Mep Qte Manq'; 
         attrib Mep_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Op Ebr'; 
         attrib Mep_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Op Asp'; 
         attrib Mep_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Op Casse'; 
         attrib Mep_Rej_Eq_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Eq Ebr'; 
         attrib Mep_Rej_Eq_Epais length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Eq Epais'; 
         attrib Mep_Rej_Eq_Dim length = 8
            format = 11.
            informat = 11.
            label = 'Mep Rej Eq Dim'; 
         attrib Mep_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Mep Equipement'; 
         attrib Mep_Lot_Matiere length = $50
            format = $50.
            informat = $50.
            label = 'Mep Lot Matiere'; 
         attrib Textu_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Textu Mode'; 
         attrib Textu_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Textu Poste'; 
         attrib Textu_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Poste'; 
         attrib Textu_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Textu Equipe'; 
         attrib Textu_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Textu Matricule'; 
         attrib Textu_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Textu Obs'; 
         attrib Textu_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Heure Entr'; 
         attrib Textu_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Heure Deb'; 
         attrib Textu_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Heure Fin'; 
         attrib Textu_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Heure Sort'; 
         attrib Textu_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Textu Date Sort'; 
         attrib Textu_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Textu Qte Entr'; 
         attrib Textu_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Textu Qte Sort'; 
         attrib Textu_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Total'; 
         attrib Textu_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Textu Qte Manq'; 
         attrib Textu_Pds_Decap_g length = 8
            label = 'Textu Pds Decap g'; 
         attrib Textu_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Op Ebr'; 
         attrib Textu_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Op Asp'; 
         attrib Textu_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Op Casse'; 
         attrib Textu_Rej_Eq_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Eq Casse'; 
         attrib Textu_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Textu Equipement'; 
         attrib Diff_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Diff Mode'; 
         attrib Diff_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Diff Poste'; 
         attrib Diff_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Poste'; 
         attrib Diff_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Diff Equipe'; 
         attrib Diff_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Diff Matricule'; 
         attrib Diff_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Diff Obs'; 
         attrib Diff_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Heure Entr'; 
         attrib Diff_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Heure Deb'; 
         attrib Diff_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Heure Fin'; 
         attrib Diff_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Heure Sort'; 
         attrib Diff_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Diff Date Sort'; 
         attrib Diff_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Diff Qte Entr'; 
         attrib Diff_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Diff Qte Sort'; 
         attrib Diff_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Total'; 
         attrib Diff_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Diff Qte Manq'; 
         attrib Diff_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Op Ebr'; 
         attrib Diff_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Op Asp'; 
         attrib Diff_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Op Casse'; 
         attrib Diff_Rej_Eq_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Eq Casse'; 
         attrib Diff_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Diff Equipement'; 
         attrib Diff_Tube length = 8
            format = 11.
            informat = 11.
            label = 'Diff Tube'; 
         attrib Diff_Recette length = $50
            format = $50.
            informat = $50.
            label = 'Diff Recette'; 
         attrib Diff_Nacelle length = 8
            format = 11.
            informat = 11.
            label = 'Diff Nacelle'; 
         attrib Diff_Nacelle_Cpt length = 8
            format = 11.
            informat = 11.
            label = 'Diff Nacelle Cpt'; 
         attrib Diff_R2 length = 8
            label = 'Diff R2'; 
         attrib Desox_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Desox Mode'; 
         attrib Desox_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Desox Poste'; 
         attrib Desox_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Poste'; 
         attrib Desox_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Desox Equipe'; 
         attrib Desox_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Desox Matricule'; 
         attrib Desox_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Desox Obs'; 
         attrib Desox_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Heure Entr'; 
         attrib Desox_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Heure Deb'; 
         attrib Desox_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Heure Fin'; 
         attrib Desox_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Heure Sort'; 
         attrib Desox_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Desox Date Sort'; 
         attrib Desox_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Desox Qte Entr'; 
         attrib Desox_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Desox Qte Sort'; 
         attrib Desox_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Total'; 
         attrib Desox_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Desox Qte Manq'; 
         attrib Desox_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Op Ebr'; 
         attrib Desox_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Op Asp'; 
         attrib Desox_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Op Casse'; 
         attrib Desox_Rej_Eq_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Eq Casse'; 
         attrib Desox_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Desox Equipement'; 
         attrib Desox_Bac length = 8
            format = 11.
            informat = 11.
            label = 'Desox Bac'; 
         attrib Desox_Rej_Eq_Casse_Chgt length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Eq Casse Chgt'; 
         attrib Desox_Rej_Eq_Asp_Chgt length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Eq Asp Chgt'; 
         attrib Desox_Rej_Eq_Casse_Dechgt length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Eq Casse Dechgt'; 
         attrib Desox_Rej_Eq_Asp_Dechgt length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Eq Asp Dechgt'; 
         attrib Desox_RShunt length = 8
            label = 'Desox RShunt'; 
         attrib Pecvd_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Pecvd Mode'; 
         attrib Pecvd_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Pecvd Poste'; 
         attrib Pecvd_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Poste'; 
         attrib Pecvd_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Equipe'; 
         attrib Pecvd_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Pecvd Matricule'; 
         attrib Pecvd_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Pecvd Obs'; 
         attrib Pecvd_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Heure Entr'; 
         attrib Pecvd_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Heure Deb'; 
         attrib Pecvd_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Heure Fin'; 
         attrib Pecvd_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Heure Sort'; 
         attrib Pecvd_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Pecvd Date Sort'; 
         attrib Pecvd_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Qte Entr'; 
         attrib Pecvd_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Qte Sort'; 
         attrib Pecvd_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Total'; 
         attrib Pecvd_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Qte Manq'; 
         attrib Pecvd_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Op Ebr'; 
         attrib Pecvd_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Op Asp'; 
         attrib Pecvd_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Op Casse'; 
         attrib Pecvd_Rej_Eq_B_ length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Eq B+'; 
         attrib Pecvd_Rej_Eq_B length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Eq B'; 
         attrib Pecvd_Rej_Eq_C length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Eq C'; 
         attrib Pecvd_Rej_Eq_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Eq Casse'; 
         attrib Pecvd_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Pecvd Equipement'; 
         attrib Pecvd_Tube length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Tube'; 
         attrib Pecvd_Cth_Recette length = $50
            format = $50.
            informat = $50.
            label = 'Pecvd Cth Recette'; 
         attrib Pecvd_Nacelle length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Nacelle'; 
         attrib Pecvd_Nacelle_Cpt length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Nacelle Cpt'; 
         attrib Pecvd_Vision_Recette length = $50
            format = $50.
            informat = $50.
            label = 'Pecvd Vision Recette'; 
         attrib Seri_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Seri Mode'; 
         attrib Seri_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Seri Poste'; 
         attrib Seri_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Poste'; 
         attrib Seri_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Seri Equipe'; 
         attrib Seri_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Seri Matricule'; 
         attrib Seri_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Seri Obs'; 
         attrib Seri_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Heure Entr'; 
         attrib Seri_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Heure Deb'; 
         attrib Seri_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Heure Fin'; 
         attrib Seri_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Heure Sort'; 
         attrib Seri_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Seri Date Sort'; 
         attrib Seri_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Qte Entr'; 
         attrib Seri_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Seri Qte Sort'; 
         attrib Seri_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Total'; 
         attrib Serig_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Serig Qte Manq'; 
         attrib Seri_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Op Ebr'; 
         attrib Seri_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Op Asp'; 
         attrib Seri_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Op Casse'; 
         attrib Seri_Rej_Op_GradeB length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Op GradeB'; 
         attrib Seri_Rej_Chgt_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Chgt Ebr'; 
         attrib Seri_Rej_Chgt_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Chgt Asp'; 
         attrib Seri_Rej_Chgt_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Chgt Casse'; 
         attrib Seri_Rej_Station_1_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 1 Ebr'; 
         attrib Seri_Rej_Station_1_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 1 Asp'; 
         attrib Seri_Rej_Station_1_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 1 Casse'; 
         attrib Seri_Rej_Eq_Vision1 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Vision1'; 
         attrib Seri_Rej_Eq_Manq1 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Manq1'; 
         attrib Seri_Rej_Station_2_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 2 Ebr'; 
         attrib Seri_Rej_Station_2_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 2 Asp'; 
         attrib Seri_Rej_Station_2_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 2 Casse'; 
         attrib Seri_Rej_Eq_Vision2 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Vision2'; 
         attrib Seri_Rej_Eq_Manq2 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Manq2'; 
         attrib Seri_Rej_Station_3_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 3 Ebr'; 
         attrib Seri_Rej_Station_3_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 3 Asp'; 
         attrib Seri_Rej_Station_3_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 3 Casse'; 
         attrib Seri_Rej_Eq_Vision3 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Vision3'; 
         attrib Seri_Rej_Eq_Manq3 length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Eq Manq3'; 
         attrib Seri_Rej_Station_4_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 4 Ebr'; 
         attrib Seri_Rej_Station_4_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 4 Asp'; 
         attrib Seri_Rej_Station_4_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Station 4 Casse'; 
         attrib Seri_Rej_Dechgt_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Dechgt Ebr'; 
         attrib Seri_Rej_Dechgt_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Dechgt Asp'; 
         attrib Seri_Rej_Dechgt_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Dechgt Casse'; 
         attrib Seri_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Seri Equipement'; 
         attrib Seri_Profil_Cuisson length = $50
            format = $50.
            informat = $50.
            label = 'Seri Profil Cuisson'; 
         attrib Seri_Num_Lot_Encre length = $50
            format = $50.
            informat = $50.
            label = 'Seri Num Lot Encre'; 
         attrib Seri_P1_Pds_Encre_mg length = 8
            label = 'Seri P1 Pds Encre mg'; 
         attrib Seri_P1_Ecran length = $20
            format = $20.
            informat = $20.
            label = 'Seri P1 Ecran'; 
         attrib Seri_P1_Num_Ecran length = 8
            format = 11.
            informat = 11.
            label = 'Seri P1 Num Ecran'; 
         attrib Seri_P1_Cause_Chg_Ecran length = $50
            format = $50.
            informat = $50.
            label = 'Seri P1 Cause Chg Ecran'; 
         attrib Seri_P2_Pds_Encre_mg length = 8
            label = 'Seri P2 Pds Encre mg'; 
         attrib Seri_P2_Ecran length = $20
            format = $20.
            informat = $20.
            label = 'Seri P2 Ecran'; 
         attrib Seri_P2_Num_Ecran length = 8
            format = 11.
            informat = 11.
            label = 'Seri P2 Num Ecran'; 
         attrib Seri_P2_Cause_Chg_Ecran length = $50
            format = $50.
            informat = $50.
            label = 'Seri P2 Cause Chg Ecran'; 
         attrib Seri_N1_Pds_Encre_mg length = 8
            label = 'Seri N1 Pds Encre mg'; 
         attrib Seri_N1_Ecran length = $20
            format = $20.
            informat = $20.
            label = 'Seri N1 Ecran'; 
         attrib Seri_N1_Num_Ecran length = 8
            format = 11.
            informat = 11.
            label = 'Seri N1 Num Ecran'; 
         attrib Seri_N1_Cause_Chg_Ecran length = $50
            format = $50.
            informat = $50.
            label = 'Seri N1 Cause Chg Ecran'; 
         attrib Seri_N2_Pds_Encre_mg length = 8
            label = 'Seri N2 Pds Encre mg'; 
         attrib Seri_N2_Ecran length = $20
            format = $20.
            informat = $20.
            label = 'Seri N2 Ecran'; 
         attrib Seri_N2_Num_Ecran length = 8
            format = 11.
            informat = 11.
            label = 'Seri N2 Num Ecran'; 
         attrib Seri_N2_Cause_Chg_Ecran length = $50
            format = $50.
            informat = $50.
            label = 'Seri N2 Cause Chg Ecran'; 
         attrib Tri_Mode length = $11
            format = $11.
            informat = $11.
            label = 'Tri Mode'; 
         attrib Tri_Poste length = $5
            format = $5.
            informat = $5.
            label = 'Tri Poste'; 
         attrib Tri_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Poste'; 
         attrib Tri_Sem_Poste length = $8
            label = 'Tri_Sem_Poste'; 
         attrib Tri_Mois_Poste length = $8
            label = 'Tri_Mois_Poste'; 
         attrib Tri_Equipe length = 8
            format = 11.
            informat = 11.
            label = 'Tri Equipe'; 
         attrib Tri_Matricule length = $5
            format = $5.
            informat = $5.
            label = 'Tri Matricule'; 
         attrib Tri_Obs length = $255
            format = $255.
            informat = $255.
            label = 'Tri Obs'; 
         attrib Tri_Date_Heure_Entr length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Entr'; 
         attrib Tri_Date_Heure_Deb length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Deb'; 
         attrib Tri_Date_Heure_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Fin'; 
         attrib Tri_Date_Heure_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Sort'; 
         attrib Tri_Date_Sort length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Sort'; 
         attrib Tri_Qte_Entr length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Entr'; 
         attrib Tri_Qte_Sort length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Sort'; 
         attrib Tri_Rej_Total length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Total'; 
         attrib Tri_Qte_Manq length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Manq'; 
         attrib Tri_Qte_Non_Retri length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Non Retri'; 
         attrib Tri_Rej_Op_Ebr length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Op Ebr'; 
         attrib Tri_Rej_Op_Asp length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Op Asp'; 
         attrib Tri_Rej_Op_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Op Casse'; 
         attrib Tri_Rej_Op_GradeB length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Op GradeB'; 
         attrib Tri_Rej_Ep_Casse length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Ep Casse'; 
         attrib Tri_Qte_Ecart length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ecart'; 
         attrib Tri_Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Tri Equipement'; 
         attrib Tri_Qte_22_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 22_0'; 
         attrib Tri_Qte_21_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 21_8'; 
         attrib Tri_Qte_21_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 21_6'; 
         attrib Tri_Qte_21_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 21_4'; 
         attrib Tri_Qte_21_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 21_2'; 
         attrib Tri_Qte_21_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 21_0'; 
         attrib Tri_Qte_20_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 20_8'; 
         attrib Tri_Qte_20_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 20_6'; 
         attrib Tri_Qte_20_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 20_4'; 
         attrib Tri_Qte_20_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 20_2'; 
         attrib Tri_Qte_20_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 20_0'; 
         attrib Tri_Qte_19_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 19_8'; 
         attrib Tri_Qte_19_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 19_6'; 
         attrib Tri_Qte_19_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 19_4'; 
         attrib Tri_Qte_19_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 19_2'; 
         attrib Tri_Qte_19_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 19_0'; 
         attrib Tri_Qte_18_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 18_8'; 
         attrib Tri_Qte_18_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 18_6'; 
         attrib Tri_Qte_18_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 18_4'; 
         attrib Tri_Qte_18_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 18_2'; 
         attrib Tri_Qte_18_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 18_0'; 
         attrib Tri_Qte_17_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 17_8'; 
         attrib Tri_Qte_17_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 17_6'; 
         attrib Tri_Qte_17_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 17_4'; 
         attrib Tri_Qte_17_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 17_2'; 
         attrib Tri_Qte_17_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 17_0'; 
         attrib Tri_Qte_16_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 16_8'; 
         attrib Tri_Qte_16_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 16_6'; 
         attrib Tri_Qte_16_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 16_4'; 
         attrib Tri_Qte_16_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 16_2'; 
         attrib Tri_Qte_16_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 16_0'; 
         attrib Tri_Qte_15_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 15_8'; 
         attrib Tri_Qte_15_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 15_6'; 
         attrib Tri_Qte_15_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 15_4'; 
         attrib Tri_Qte_15_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 15_2'; 
         attrib Tri_Qte_15_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 15_0'; 
         attrib Tri_Qte_14_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 14_8'; 
         attrib Tri_Qte_14_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 14_6'; 
         attrib Tri_Qte_14_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 14_4'; 
         attrib Tri_Qte_14_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 14_2'; 
         attrib Tri_Qte_14_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 14_0'; 
         attrib Tri_Qte_13_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 13_8'; 
         attrib Tri_Qte_13_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 13_6'; 
         attrib Tri_Qte_13_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 13_4'; 
         attrib Tri_Qte_13_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 13_2'; 
         attrib Tri_Qte_13_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 13_0'; 
         attrib Tri_Qte_12_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 12_8'; 
         attrib Tri_Qte_12_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 12_6'; 
         attrib Tri_Qte_12_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 12_4'; 
         attrib Tri_Qte_12_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 12_2'; 
         attrib Tri_Qte_12_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte 12_0'; 
         attrib Tri_Qte_L_18_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-18_0'; 
         attrib Tri_Qte_L_17_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-17_0'; 
         attrib Tri_Qte_L_16_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-16_0'; 
         attrib Tri_Qte_L_15_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-15_6'; 
         attrib Tri_Qte_L_14_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-14_0'; 
         attrib Tri_Qte_L_13_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-13_6'; 
         attrib Tri_Qte_L_12_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-12_0'; 
         attrib Tri_Qte_L_11_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-11_6'; 
         attrib Tri_Qte_Al length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Al'; 
         attrib Tri_Qte_Ak length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ak'; 
         attrib Tri_Qte_Ai length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ai'; 
         attrib Tri_Qte_Aj length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Aj'; 
         attrib Tri_Qte_Ah length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ah'; 
         attrib Tri_Qte_Ag length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ag'; 
         attrib Tri_Qte_Af length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Af'; 
         attrib Tri_Qte_Ae length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ae'; 
         attrib Tri_Qte_Ad length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ad'; 
         attrib Tri_Qte_Ac length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ac'; 
         attrib Tri_Qte_Ab length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Ab'; 
         attrib Tri_Qte_Aa length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Aa'; 
         attrib Tri_Qte_A0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte A0'; 
         attrib Tri_Qte_A1 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte A1'; 
         attrib Tri_Qte_A2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte A2'; 
         attrib Tri_Qte_A3 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte A3'; 
         attrib Tri_Qte_B length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte B'; 
         attrib Tri_Qte_C length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte C'; 
         attrib Tri_Qte_D length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte D'; 
         attrib Tri_Qte_E length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte E'; 
         attrib Tri_Qte_F length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte F'; 
         attrib Tri_Qte_G length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte G'; 
         attrib Tri_Qte_H length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte H'; 
         attrib Tri_Qte_I length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte I'; 
         attrib Tri_Qte_J length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte J'; 
         attrib Tri_Qte_K length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte K'; 
         attrib Tri_Qte_L length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L'; 
         attrib Tri_Qte_A1L length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte A1L'; 
         attrib Tri_Qte_M length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte M'; 
         attrib Tri_Qte_Eme length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Eme'; 
         attrib Tri_Qte_Rsh length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Rsh'; 
         attrib Tri_Puiss_W length = 8
            label = 'Tri Puiss W'; 
         attrib Tri_Puiss_22_0 length = 8
            label = 'Tri Puiss 22_0'; 
         attrib Tri_Puiss_21_8 length = 8
            label = 'Tri Puiss 21_8'; 
         attrib Tri_Puiss_21_6 length = 8
            label = 'Tri Puiss 21_6'; 
         attrib Tri_Puiss_21_4 length = 8
            label = 'Tri Puiss 21_4'; 
         attrib Tri_Puiss_21_2 length = 8
            label = 'Tri Puiss 21_2'; 
         attrib Tri_Puiss_21_0 length = 8
            label = 'Tri Puiss 21_0'; 
         attrib Tri_Puiss_20_8 length = 8
            label = 'Tri Puiss 20_8'; 
         attrib Tri_Puiss_20_6 length = 8
            label = 'Tri Puiss 20_6'; 
         attrib Tri_Puiss_20_4 length = 8
            label = 'Tri Puiss 20_4'; 
         attrib Tri_Puiss_20_2 length = 8
            label = 'Tri Puiss 20_2'; 
         attrib Tri_Puiss_20_0 length = 8
            label = 'Tri Puiss 20_0'; 
         attrib Tri_Puiss_19_8 length = 8
            label = 'Tri Puiss 19_8'; 
         attrib Tri_Puiss_19_6 length = 8
            label = 'Tri Puiss 19_6'; 
         attrib Tri_Puiss_19_4 length = 8
            label = 'Tri Puiss 19_4'; 
         attrib Tri_Puiss_19_2 length = 8
            label = 'Tri Puiss 19_2'; 
         attrib Tri_Puiss_19_0 length = 8
            label = 'Tri Puiss 19_0'; 
         attrib Tri_Puiss_18_8 length = 8
            label = 'Tri Puiss 18_8'; 
         attrib Tri_Puiss_18_6 length = 8
            label = 'Tri Puiss 18_6'; 
         attrib Tri_Puiss_18_4 length = 8
            label = 'Tri Puiss 18_4'; 
         attrib Tri_Puiss_18_2 length = 8
            label = 'Tri Puiss 18_2'; 
         attrib Tri_Puiss_18_0 length = 8
            label = 'Tri Puiss 18_0'; 
         attrib Tri_Puiss_17_8 length = 8
            label = 'Tri Puiss 17_8'; 
         attrib Tri_Puiss_17_6 length = 8
            label = 'Tri Puiss 17_6'; 
         attrib Tri_Puiss_17_4 length = 8
            label = 'Tri Puiss 17_4'; 
         attrib Tri_Puiss_17_2 length = 8
            label = 'Tri Puiss 17_2'; 
         attrib Tri_Puiss_17_0 length = 8
            label = 'Tri Puiss 17_0'; 
         attrib Tri_Puiss_16_8 length = 8
            label = 'Tri Puiss 16_8'; 
         attrib Tri_Puiss_16_6 length = 8
            label = 'Tri Puiss 16_6'; 
         attrib Tri_Puiss_16_4 length = 8
            label = 'Tri Puiss 16_4'; 
         attrib Tri_Puiss_16_2 length = 8
            label = 'Tri Puiss 16_2'; 
         attrib Tri_Puiss_16_0 length = 8
            label = 'Tri Puiss 16_0'; 
         attrib Tri_Puiss_15_8 length = 8
            label = 'Tri Puiss 15_8'; 
         attrib Tri_Puiss_15_6 length = 8
            label = 'Tri Puiss 15_6'; 
         attrib Tri_Puiss_15_4 length = 8
            label = 'Tri Puiss 15_4'; 
         attrib Tri_Puiss_15_2 length = 8
            label = 'Tri Puiss 15_2'; 
         attrib Tri_Puiss_15_0 length = 8
            label = 'Tri Puiss 15_0'; 
         attrib Tri_Puiss_14_8 length = 8
            label = 'Tri Puiss 14_8'; 
         attrib Tri_Puiss_14_6 length = 8
            label = 'Tri Puiss 14_6'; 
         attrib Tri_Puiss_14_4 length = 8
            label = 'Tri Puiss 14_4'; 
         attrib Tri_Puiss_14_2 length = 8
            label = 'Tri Puiss 14_2'; 
         attrib Tri_Puiss_14_0 length = 8
            label = 'Tri Puiss 14_0'; 
         attrib Tri_Puiss_13_8 length = 8
            label = 'Tri Puiss 13_8'; 
         attrib Tri_Puiss_13_6 length = 8
            label = 'Tri Puiss 13_6'; 
         attrib Tri_Puiss_13_4 length = 8
            label = 'Tri Puiss 13_4'; 
         attrib Tri_Puiss_13_2 length = 8
            label = 'Tri Puiss 13_2'; 
         attrib Tri_Puiss_13_0 length = 8
            label = 'Tri Puiss 13_0'; 
         attrib Tri_Puiss_12_8 length = 8
            label = 'Tri Puiss 12_8'; 
         attrib Tri_Puiss_12_6 length = 8
            label = 'Tri Puiss 12_6'; 
         attrib Tri_Puiss_12_4 length = 8
            label = 'Tri Puiss 12_4'; 
         attrib Tri_Puiss_12_2 length = 8
            label = 'Tri Puiss 12_2'; 
         attrib Tri_Puiss_12_0 length = 8
            label = 'Tri Puiss 12_0'; 
         attrib Tri_Puiss_L_18_0 length = 8
            label = 'Tri Puiss L-18_0'; 
         attrib Tri_Puiss_L_17_0 length = 8
            label = 'Tri Puiss L-17_0'; 
         attrib Tri_Puiss_L_16_0 length = 8
            label = 'Tri Puiss L-16_0'; 
         attrib Tri_Puiss_L_15_6 length = 8
            label = 'Tri Puiss L-15_6'; 
         attrib Tri_Puiss_L_14_0 length = 8
            label = 'Tri Puiss L-14_0'; 
         attrib Tri_Puiss_L_13_6 length = 8
            label = 'Tri Puiss L-13_6'; 
         attrib Tri_Puiss_L_12_0 length = 8
            label = 'Tri Puiss L-12_0'; 
         attrib Tri_Puiss_L_11_6 length = 8
            label = 'Tri Puiss L-11_6'; 
         attrib Tri_Puiss_Al length = 8
            label = 'Tri Puiss Al'; 
         attrib Tri_Puiss_Ak length = 8
            label = 'Tri Puiss Ak'; 
         attrib Tri_Puiss_Aj length = 8
            label = 'Tri Puiss Aj'; 
         attrib Tri_Puiss_Ai length = 8
            label = 'Tri Puiss Ai'; 
         attrib Tri_Puiss_Ah length = 8
            label = 'Tri Puiss Ah'; 
         attrib Tri_Puiss_Ag length = 8
            label = 'Tri Puiss Ag'; 
         attrib Tri_Puiss_Af length = 8
            label = 'Tri Puiss Af'; 
         attrib Tri_Puiss_Ae length = 8
            label = 'Tri Puiss Ae'; 
         attrib Tri_Puiss_Ad length = 8
            label = 'Tri Puiss Ad'; 
         attrib Tri_Puiss_Ac length = 8
            label = 'Tri Puiss Ac'; 
         attrib Tri_Puiss_Ab length = 8
            label = 'Tri Puiss Ab'; 
         attrib Tri_Puiss_Aa length = 8
            label = 'Tri Puiss Aa'; 
         attrib Tri_Puiss_A0 length = 8
            label = 'Tri Puiss A0'; 
         attrib Tri_Puiss_A1 length = 8
            label = 'Tri Puiss A1'; 
         attrib Tri_Puiss_A2 length = 8
            label = 'Tri Puiss A2'; 
         attrib Tri_Puiss_A3 length = 8
            label = 'Tri Puiss A3'; 
         attrib Tri_Puiss_B length = 8
            label = 'Tri Puiss B'; 
         attrib Tri_Puiss_C length = 8
            label = 'Tri Puiss C'; 
         attrib Tri_Puiss_D length = 8
            label = 'Tri Puiss D'; 
         attrib Tri_Puiss_E length = 8
            label = 'Tri Puiss E'; 
         attrib Tri_Puiss_F length = 8
            label = 'Tri Puiss F'; 
         attrib Tri_Puiss_G length = 8
            label = 'Tri Puiss G'; 
         attrib Tri_Puiss_H length = 8
            label = 'Tri Puiss H'; 
         attrib Tri_Puiss_I length = 8
            label = 'Tri Puiss I'; 
         attrib Tri_Puiss_J length = 8
            label = 'Tri Puiss J'; 
         attrib Tri_Puiss_K length = 8
            label = 'Tri Puiss K'; 
         attrib Tri_Puiss_L length = 8
            label = 'Tri Puiss L'; 
         attrib Tri_Puiss_A1L length = 8
            label = 'Tri Puiss A1L'; 
         attrib Tri_Puiss_M length = 8
            label = 'Tri Puiss M'; 
         attrib Tri_Puiss_Eme length = 8
            label = 'Tri Puiss Eme'; 
         attrib Tri_Puiss_Rsh length = 8
            label = 'Tri Puiss Rsh'; 
         attrib Tri_Fichier length = $50
            format = $50.
            informat = $50.
            label = 'Tri Fichier'; 
         attrib Tri_Date_Heure_Fichier length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Fichier'; 
         attrib Tri_Date_Heure_Import length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Import'; 
         attrib Tri_Date_Heure_Mes_Min length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Mes Min'; 
         attrib Tri_Date_Heure_Mes_Max length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Tri Date Heure Mes Max'; 
         attrib Tri_Run length = $255
            format = $255.
            informat = $255.
            label = 'Tri Run'; 
         attrib Tri_Wafer_Desc length = $255
            format = $255.
            informat = $255.
            label = 'Tri Wafer Desc'; 
         attrib Tri_Retri length = 8
            format = 11.
            informat = 11.
            label = 'Tri Retri'; 
         attrib Tri_Voc_Med length = 8
            label = 'Tri Voc Med'; 
         attrib Tri_Voc_Moy length = 8
            label = 'Tri Voc Moy'; 
         attrib Tri_Voc_Ect length = 8
            label = 'Tri Voc Ect'; 
         attrib Tri_Voc_Ectr length = 8
            label = 'Tri Voc Ectr'; 
         attrib Tri_Voc_Min length = 8
            label = 'Tri Voc Min'; 
         attrib Tri_Voc_Max length = 8
            label = 'Tri Voc Max'; 
         attrib Tri_Voc_Ampl length = 8
            label = 'Tri Voc Ampl'; 
         attrib Tri_Isc_Med length = 8
            label = 'Tri Isc Med'; 
         attrib Tri_Isc_Moy length = 8
            label = 'Tri Isc Moy'; 
         attrib Tri_Isc_Ect length = 8
            label = 'Tri Isc Ect'; 
         attrib Tri_Isc_Ectr length = 8
            label = 'Tri Isc Ectr'; 
         attrib Tri_Isc_Min length = 8
            label = 'Tri Isc Min'; 
         attrib Tri_Isc_Max length = 8
            label = 'Tri Isc Max'; 
         attrib Tri_Isc_Ampl length = 8
            label = 'Tri Isc Ampl'; 
         attrib Tri_Vmax_Med length = 8
            label = 'Tri Vmax Med'; 
         attrib Tri_Vmax_Moy length = 8
            label = 'Tri Vmax Moy'; 
         attrib Tri_Vmax_Ect length = 8
            label = 'Tri Vmax Ect'; 
         attrib Tri_Vmax_Ectr length = 8
            label = 'Tri Vmax Ectr'; 
         attrib Tri_Vmax_Min length = 8
            label = 'Tri Vmax Min'; 
         attrib Tri_Vmax_Max length = 8
            label = 'Tri Vmax Max'; 
         attrib Tri_Vmax_Ampl length = 8
            label = 'Tri Vmax Ampl'; 
         attrib Tri_Imax_Med length = 8
            label = 'Tri Imax Med'; 
         attrib Tri_Imax_Moy length = 8
            label = 'Tri Imax Moy'; 
         attrib Tri_Imax_Ect length = 8
            label = 'Tri Imax Ect'; 
         attrib Tri_Imax_Ectr length = 8
            label = 'Tri Imax Ectr'; 
         attrib Tri_Imax_Min length = 8
            label = 'Tri Imax Min'; 
         attrib Tri_Imax_Max length = 8
            label = 'Tri Imax Max'; 
         attrib Tri_Imax_Ampl length = 8
            label = 'Tri Imax Ampl'; 
         attrib Tri_Pmax_Med length = 8
            label = 'Tri Pmax Med'; 
         attrib Tri_Pmax_Moy length = 8
            label = 'Tri Pmax Moy'; 
         attrib Tri_Pmax_Ect length = 8
            label = 'Tri Pmax Ect'; 
         attrib Tri_Pmax_Ectr length = 8
            label = 'Tri Pmax Ectr'; 
         attrib Tri_Pmax_Min length = 8
            label = 'Tri Pmax Min'; 
         attrib Tri_Pmax_Max length = 8
            label = 'Tri Pmax Max'; 
         attrib Tri_Pmax_Ampl length = 8
            label = 'Tri Pmax Ampl'; 
         attrib Tri_FF_Med length = 8
            label = 'Tri FF Med'; 
         attrib Tri_FF_Moy length = 8
            label = 'Tri FF Moy'; 
         attrib Tri_FF_Ect length = 8
            label = 'Tri FF Ect'; 
         attrib Tri_FF_Ectr length = 8
            label = 'Tri FF Ectr'; 
         attrib Tri_FF_Min length = 8
            label = 'Tri FF Min'; 
         attrib Tri_FF_Max length = 8
            label = 'Tri FF Max'; 
         attrib Tri_FF_Ampl length = 8
            label = 'Tri FF Ampl'; 
         attrib Tri_Rend_Med length = 8
            label = 'Tri Rend Med'; 
         attrib Tri_Rend_Moy length = 8
            label = 'Tri Rend Moy'; 
         attrib Tri_Rend_Ect length = 8
            label = 'Tri Rend Ect'; 
         attrib Tri_Rend_Ectr length = 8
            label = 'Tri Rend Ectr'; 
         attrib Tri_Rend_Min length = 8
            label = 'Tri Rend Min'; 
         attrib Tri_Rend_Max length = 8
            label = 'Tri Rend Max'; 
         attrib Tri_Rend_Ampl length = 8
            label = 'Tri Rend Ampl'; 
         attrib Tri_Rs_Med length = 8
            label = 'Tri Rs Med'; 
         attrib Tri_Rs_Moy length = 8
            label = 'Tri Rs Moy'; 
         attrib Tri_Rs_Ect length = 8
            label = 'Tri Rs Ect'; 
         attrib Tri_Rs_Ectr length = 8
            label = 'Tri Rs Ectr'; 
         attrib Tri_Rs_Min length = 8
            label = 'Tri Rs Min'; 
         attrib Tri_Rs_Max length = 8
            label = 'Tri Rs Max'; 
         attrib Tri_Rs_Ampl length = 8
            label = 'Tri Rs Ampl'; 
         attrib Tri_Rsh_Med length = 8
            label = 'Tri Rsh Med'; 
         attrib Tri_Rsh_Moy length = 8
            label = 'Tri Rsh Moy'; 
         attrib Tri_Rsh_Ect length = 8
            label = 'Tri Rsh Ect'; 
         attrib Tri_Rsh_Ectr length = 8
            label = 'Tri Rsh Ectr'; 
         attrib Tri_Rsh_Min length = 8
            label = 'Tri Rsh Min'; 
         attrib Tri_Rsh_Max length = 8
            label = 'Tri Rsh Max'; 
         attrib Tri_Rsh_Ampl length = 8
            label = 'Tri Rsh Ampl'; 
         attrib Tri_I_Vref_Med length = 8
            label = 'Tri I@Vref Med'; 
         attrib Tri_I_Vref_Moy length = 8
            label = 'Tri I@Vref Moy'; 
         attrib Tri_I_Vref_Ect length = 8
            label = 'Tri I@Vref Ect'; 
         attrib Tri_I_Vref_Ectr length = 8
            label = 'Tri I@Vref Ectr'; 
         attrib Tri_I_Vref_Min length = 8
            label = 'Tri I@Vref Min'; 
         attrib Tri_I_Vref_Max length = 8
            label = 'Tri I@Vref Max'; 
         attrib Tri_I_Vref_Ampl length = 8
            label = 'Tri I@Vref Ampl'; 
         attrib Tri_Irrad_Med length = 8
            label = 'Tri Irrad Med'; 
         attrib Tri_Irrad_Moy length = 8
            label = 'Tri Irrad Moy'; 
         attrib Tri_Irrad_Ect length = 8
            label = 'Tri Irrad Ect'; 
         attrib Tri_Irrad_Ectr length = 8
            label = 'Tri Irrad Ectr'; 
         attrib Tri_Irrad_Min length = 8
            label = 'Tri Irrad Min'; 
         attrib Tri_Irrad_Max length = 8
            label = 'Tri Irrad Max'; 
         attrib Tri_Irrad_Ampl length = 8
            label = 'Tri Irrad Ampl'; 
         attrib Tri_IrrDev_Med length = 8
            label = 'Tri IrrDev Med'; 
         attrib Tri_IrrDev_Moy length = 8
            label = 'Tri IrrDev Moy'; 
         attrib Tri_IrrDev_Ect length = 8
            label = 'Tri IrrDev Ect'; 
         attrib Tri_IrrDev_Ectr length = 8
            label = 'Tri IrrDev Ectr'; 
         attrib Tri_IrrDev_Min length = 8
            label = 'Tri IrrDev Min'; 
         attrib Tri_IrrDev_Max length = 8
            label = 'Tri IrrDev Max'; 
         attrib Tri_IrrDev_Ampl length = 8
            label = 'Tri IrrDev Ampl'; 
         attrib Tri_T_mon_Med length = 8
            label = 'Tri T°mon Med'; 
         attrib Tri_T_mon_Moy length = 8
            label = 'Tri T°mon Moy'; 
         attrib Tri_T_mon_Ect length = 8
            label = 'Tri T°mon Ect'; 
         attrib Tri_T_mon_Ectr length = 8
            label = 'Tri T°mon Ectr'; 
         attrib Tri_T_mon_Min length = 8
            label = 'Tri T°mon Min'; 
         attrib Tri_T_mon_Max length = 8
            label = 'Tri T°mon Max'; 
         attrib Tri_T_mon_Ampl length = 8
            label = 'Tri T°mon Ampl'; 
         attrib Tri_T_cell_Med length = 8
            label = 'Tri T°cell Med'; 
         attrib Tri_T_cell_Moy length = 8
            label = 'Tri T°cell Moy'; 
         attrib Tri_T_cell_Ect length = 8
            label = 'Tri T°cell Ect'; 
         attrib Tri_T_cell_Ectr length = 8
            label = 'Tri T°cell Ectr'; 
         attrib Tri_T_cell_Min length = 8
            label = 'Tri T°cell Min'; 
         attrib Tri_T_cell_Max length = 8
            label = 'Tri T°cell Max'; 
         attrib Tri_T_cell_Ampl length = 8
            label = 'Tri T°cell Ampl'; 
         attrib Tri_CoeffI_Med length = 8
            label = 'Tri CoeffI Med'; 
         attrib Tri_CoeffI_Moy length = 8
            label = 'Tri CoeffI Moy'; 
         attrib Tri_CoeffI_Ect length = 8
            label = 'Tri CoeffI Ect'; 
         attrib Tri_CoeffI_Ectr length = 8
            label = 'Tri CoeffI Ectr'; 
         attrib Tri_CoeffI_Min length = 8
            label = 'Tri CoeffI Min'; 
         attrib Tri_CoeffI_Max length = 8
            label = 'Tri CoeffI Max'; 
         attrib Tri_CoeffI_Ampl length = 8
            label = 'Tri CoeffI Ampl'; 
         attrib Tri_CoeffV_Med length = 8
            label = 'Tri CoeffV Med'; 
         attrib Tri_CoeffV_Moy length = 8
            label = 'Tri CoeffV Moy'; 
         attrib Tri_CoeffV_Ect length = 8
            label = 'Tri CoeffV Ect'; 
         attrib Tri_CoeffV_Ectr length = 8
            label = 'Tri CoeffV Ectr'; 
         attrib Tri_CoeffV_Min length = 8
            label = 'Tri CoeffV Min'; 
         attrib Tri_CoeffV_Max length = 8
            label = 'Tri CoeffV Max'; 
         attrib Tri_CoeffV_Ampl length = 8
            label = 'Tri CoeffV Ampl'; 
         attrib Tri_CoeffP_Med length = 8
            label = 'Tri CoeffP Med'; 
         attrib Tri_CoeffP_Moy length = 8
            label = 'Tri CoeffP Moy'; 
         attrib Tri_CoeffP_Ect length = 8
            label = 'Tri CoeffP Ect'; 
         attrib DateHeureSAS length = 8
            format = DATETIME22.3
            informat = DATETIME22.3; 
         attrib Tri_CoeffP_Ectr length = 8
            label = 'Tri CoeffP Ectr'; 
         attrib Tri_CoeffP_Min length = 8
            label = 'Tri CoeffP Min'; 
         attrib Tri_CoeffP_Max length = 8
            label = 'Tri CoeffP Max'; 
         attrib Tri_CoeffP_Ampl length = 8
            label = 'Tri CoeffP Ampl'; 
         attrib Textu_Rej_Eq_Casse_Chgt length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Eq Casse Chgt'; 
         attrib Textu_Rej_Eq_Casse_Dechgt length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Eq Casse Dechgt'; 
         attrib Exe_Date_Heure length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Exe Date Heure'; 
         attrib MeP_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'MeP Rej Param Nom'; 
         attrib MeP_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'MeP Rej Param Qte'; 
         attrib Textu_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Textu Rej Param Nom'; 
         attrib Textu_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Param Qte'; 
         attrib Textu_Vente_Observ length = $255
            format = $255.
            informat = $255.
            label = 'Textu Vente Observ'; 
         attrib Textu_Vente_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Textu Vente Qte'; 
         attrib Diff_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Diff Rej Param Nom'; 
         attrib Diff_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Diff Rej Param Qte'; 
         attrib Diff_Vente_Observ length = $255
            format = $255.
            informat = $255.
            label = 'Diff Vente Observ'; 
         attrib Diff_Vente_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Diff Vente Qte'; 
         attrib Desox_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Desox Rej Param Nom'; 
         attrib Desox_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Desox Rej Param Qte'; 
         attrib Desox_Vente_Observ length = $255
            format = $255.
            informat = $255.
            label = 'Desox Vente Observ'; 
         attrib Desox_Vente_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Desox Vente Qte'; 
         attrib Pecvd_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Pecvd Rej Param Nom'; 
         attrib Pecvd_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Rej Param Qte'; 
         attrib Pecvd_Vente_Observ length = $255
            format = $255.
            informat = $255.
            label = 'Pecvd Vente Observ'; 
         attrib Pecvd_Vente_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Pecvd Vente Qte'; 
         attrib Seri_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Seri Rej Param Nom'; 
         attrib Seri_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Seri Rej Param Qte'; 
         attrib Seri_Vente_Observ length = $255
            format = $255.
            informat = $255.
            label = 'Seri Vente Observ'; 
         attrib Seri_Vente_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Seri Vente Qte'; 
         attrib Tri_Rej_Param_Nom length = $20
            format = $20.
            informat = $20.
            label = 'Tri Rej Param Nom'; 
         attrib Tri_Rej_Param_Qte length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Param Qte'; 
         attrib Tri_Rej_Eq_Meca_MC length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Eq Meca MC'; 
         attrib Tri_Rej_Eq_Meca_Geom length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Eq Meca Geom'; 
         attrib Tri_Rej_Eq_Meca_Div length = 8
            format = 11.
            informat = 11.
            label = 'Tri Rej Eq Meca Div'; 
         attrib Tri_Qte_Idk length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Idk'; 
         attrib Tri_Qte_Div length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte Div'; 
         attrib Tri_Qte_L_12_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-12_2'; 
         attrib Tri_Qte_L_12_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-12_4'; 
         attrib Tri_Qte_L_12_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-12_6'; 
         attrib Tri_Qte_L_12_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-12_8'; 
         attrib Tri_Qte_L_13_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-13_0'; 
         attrib Tri_Qte_L_13_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-13_2'; 
         attrib Tri_Qte_L_13_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-13_4'; 
         attrib Tri_Qte_L_13_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-13_8'; 
         attrib Tri_Qte_L_14_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-14_2'; 
         attrib Tri_Qte_L_14_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-14_4'; 
         attrib Tri_Qte_L_14_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-14_6'; 
         attrib Tri_Qte_L_14_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-14_8'; 
         attrib Tri_Qte_L_15_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-15_0'; 
         attrib Tri_Qte_L_15_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-15_2'; 
         attrib Tri_Qte_L_15_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-15_4'; 
         attrib Tri_Qte_L_15_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-15_8'; 
         attrib Tri_Qte_L_16_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-16_2'; 
         attrib Tri_Qte_L_16_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-16_4'; 
         attrib Tri_Qte_L_16_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-16_6'; 
         attrib Tri_Qte_L_16_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-16_8'; 
         attrib Tri_Qte_L_17_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-17_2'; 
         attrib Tri_Qte_L_17_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-17_4'; 
         attrib Tri_Qte_L_17_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-17_6'; 
         attrib Tri_Qte_L_17_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-17_8'; 
         attrib Tri_Qte_L_18_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-18_2'; 
         attrib Tri_Qte_L_18_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-18_4'; 
         attrib Tri_Qte_L_18_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-18_6'; 
         attrib Tri_Qte_L_18_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-18_8'; 
         attrib Tri_Qte_L_19_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-19_0'; 
         attrib Tri_Qte_L_19_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-19_2'; 
         attrib Tri_Qte_L_19_4 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-19_4'; 
         attrib Tri_Qte_L_19_6 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-19_6'; 
         attrib Tri_Qte_L_19_8 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-19_8'; 
         attrib Tri_Qte_L_20_0 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-20_0'; 
         attrib Tri_Qte_L_20_2 length = 8
            format = 11.
            informat = 11.
            label = 'Tri Qte L-20_2'; 
         attrib Tri_Puiss_Idk length = 8
            label = 'Tri Puiss Idk'; 
         attrib Tri_Puiss_Div length = 8
            label = 'Tri Puiss Div'; 
         attrib Tri_Puiss_L_12_2 length = 8
            label = 'Tri Puiss L-12_2'; 
         attrib Tri_Puiss_L_12_4 length = 8
            label = 'Tri Puiss L-12_4'; 
         attrib Tri_Puiss_L_12_6 length = 8
            label = 'Tri Puiss L-12_6'; 
         attrib Tri_Puiss_L_12_8 length = 8
            label = 'Tri Puiss L-12_8'; 
         attrib Tri_Puiss_L_13_0 length = 8
            label = 'Tri Puiss L-13_0'; 
         attrib Tri_Puiss_L_13_2 length = 8
            label = 'Tri Puiss L-13_2'; 
         attrib Tri_Puiss_L_13_4 length = 8
            label = 'Tri Puiss L-13_4'; 
         attrib Tri_Puiss_L_13_8 length = 8
            label = 'Tri Puiss L-13_8'; 
         attrib Tri_Puiss_L_14_2 length = 8
            label = 'Tri Puiss L-14_2'; 
         attrib Tri_Puiss_L_14_4 length = 8
            label = 'Tri Puiss L-14_4'; 
         attrib Tri_Puiss_L_14_6 length = 8
            label = 'Tri Puiss L-14_6'; 
         attrib Tri_Puiss_L_14_8 length = 8
            label = 'Tri Puiss L-14_8'; 
         attrib Tri_Puiss_L_15_0 length = 8
            label = 'Tri Puiss L-15_0'; 
         attrib Tri_Puiss_L_15_2 length = 8
            label = 'Tri Puiss L-15_2'; 
         attrib Tri_Puiss_L_15_4 length = 8
            label = 'Tri Puiss L-15_4'; 
         attrib Tri_Puiss_L_15_8 length = 8
            label = 'Tri Puiss L-15_8'; 
         attrib Tri_Puiss_L_16_2 length = 8
            label = 'Tri Puiss L-16_2'; 
         attrib Tri_Puiss_L_16_4 length = 8
            label = 'Tri Puiss L-16_4'; 
         attrib Tri_Puiss_L_16_6 length = 8
            label = 'Tri Puiss L-16_6'; 
         attrib Tri_Puiss_L_16_8 length = 8
            label = 'Tri Puiss L-16_8'; 
         attrib Tri_Puiss_L_17_2 length = 8
            label = 'Tri Puiss L-17_2'; 
         attrib Tri_Puiss_L_17_4 length = 8
            label = 'Tri Puiss L-17_4'; 
         attrib Tri_Puiss_L_17_6 length = 8
            label = 'Tri Puiss L-17_6'; 
         attrib Tri_Puiss_L_17_8 length = 8
            label = 'Tri Puiss L-17_8'; 
         attrib Tri_Puiss_L_18_2 length = 8
            label = 'Tri Puiss L-18_2'; 
         attrib Tri_Puiss_L_18_4 length = 8
            label = 'Tri Puiss L-18_4'; 
         attrib Tri_Puiss_L_18_6 length = 8
            label = 'Tri Puiss L-18_6'; 
         attrib Tri_Puiss_L_18_8 length = 8
            label = 'Tri Puiss L-18_8'; 
         attrib Tri_Puiss_L_19_0 length = 8
            label = 'Tri Puiss L-19_0'; 
         attrib Tri_Puiss_L_19_2 length = 8
            label = 'Tri Puiss L-19_2'; 
         attrib Tri_Puiss_L_19_4 length = 8
            label = 'Tri Puiss L-19_4'; 
         attrib Tri_Puiss_L_19_6 length = 8
            label = 'Tri Puiss L-19_6'; 
         attrib Tri_Puiss_L_19_8 length = 8
            label = 'Tri Puiss L-19_8'; 
         attrib Tri_Puiss_L_20_0 length = 8
            label = 'Tri Puiss L-20_0'; 
         attrib Tri_Puiss_L_20_2 length = 8
            label = 'Tri Puiss L-20_2'; 
         attrib Textu_Rej_Eq_Doubl length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Eq Doubl'; 
         attrib Textu_Rej_Eq_Epais length = 8
            format = 11.
            informat = 11.
            label = 'Textu Rej Eq Epais'; 
         attrib PECVD_OnOffLine length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_OnOffLine'; 
         attrib PECVD_DateHeureDebutCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'PECVD_DateHeureDebutCycle'; 
         attrib PECVD_DateHeureFinCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'PECVD_DateHeureFinCycle'; 
         attrib PECVD_QuantiteEntreeMach length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteEntreeMach'; 
         attrib PECVD_QuantiteSortieMach length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteSortieMach'; 
         attrib PECVD_QuantiteRejetMach length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteRejetMach'; 
         attrib PECVD_QuantiteRejetOper length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteRejetOper'; 
         attrib SERIG_OnOffLine length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_OnOffLine'; 
         attrib SERIG_DateHeureDebutCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'SERIG_DateHeureDebutCycle'; 
         attrib SERIG_DateHeureFinCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'SERIG_DateHeureFinCycle'; 
         attrib SERIG_QuantiteEntreeMach length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteEntreeMach'; 
         attrib SERIG_QuantiteSortieMach length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteSortieMach'; 
         attrib SERIG_QuantiteRejetMach length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteRejetMach'; 
         attrib SERIG_QuantiteRejetOper length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteRejetOper'; 
         attrib TRI_OnOffLine length = 8
            format = 11.
            informat = 11.
            label = 'TRI_OnOffLine'; 
         attrib TRI_DateHeureDebutCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'TRI_DateHeureDebutCycle'; 
         attrib TRI_DateHeureFinCycle length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'TRI_DateHeureFinCycle'; 
         attrib TRI_QuantiteEntreeMach length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteEntreeMach'; 
         attrib TRI_QuantiteSortieMach length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteSortieMach'; 
         attrib TRI_QuantiteRejetMach length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteRejetMach'; 
         attrib TRI_QuantiteRejetOper length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteRejetOper'; 
         attrib Tri_IDK_Med length = 8
            label = 'Tri IDK Med'; 
         attrib Tri_IDK_Moy length = 8
            label = 'Tri IDK Moy'; 
         attrib Tri_IDK_Ect length = 8
            label = 'Tri IDK Ect'; 
         attrib Tri_IDK_Ectr length = 8
            label = 'Tri IDK Ectr'; 
         attrib Tri_IDK_Min length = 8
            label = 'Tri IDK Min'; 
         attrib Tri_IDK_Max length = 8
            label = 'Tri IDK Max'; 
         attrib Tri_IDK_Ampl length = 8
            label = 'Tri IDK Ampl'; 
         attrib PECVD_QuantiteManqEntree length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteManqEntree'; 
         attrib PECVD_QuantiteAjout length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteAjout'; 
         attrib SERIG_QuantiteManqEntree length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteManqEntree'; 
         attrib SERIG_QuantiteAjout length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteAjout'; 
         attrib TRI_QuantiteManqEntree length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteManqEntree'; 
         attrib TRI_QuantiteAjout length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteAjout'; 
         attrib SERIG_RejEquipAspectInitial length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_RejEquipAspectInitial'; 
         attrib PECVD_QuantiteManqMach length = 8
            format = 11.
            informat = 11.
            label = 'PECVD_QuantiteManqMach'; 
         attrib SERIG_QuantiteManqMach length = 8
            format = 11.
            informat = 11.
            label = 'SERIG_QuantiteManqMach'; 
         attrib TRI_QuantiteManqMach length = 8
            format = 11.
            informat = 11.
            label = 'TRI_QuantiteManqMach'; 
         call missing(of _all_);
         stop;
      run;
      
      %rcSet(&syserr); 
      
   %end;  /* if table does not exist  */ 
   
   %else 
   %do;  /* table exists */ 
      /*---- Truncate a table  ----*/ 
      %put %str(NOTE: Truncating table ...);
      proc sql;
         connect to ODBC
         ( 
             DATASRC=DWH_PROD AUTHDOMAIN="SQLServer" 
         ); 
         reset noprint; 
         
         execute 
         ( 
            truncate table dbo.DWH_SQC_LOTS
         ) by ODBC; 
         
         %rcSet(&sqlrc); 
         
         disconnect from ODBC; 
      quit; 
      
      %rcSet(&sqlrc); 
      
   %end; /* table exists */ 
   
   /*---- Append  ----*/ 
   %put %str(NOTE: Appending data ...);
   
   proc append base = DS_DWH.DWH_SQC_LOTS 
      data = &etls_lastTable (&etls_tableOptions)  force ; 
    run; 
   
   %rcSet(&syserr); 
   
   proc datasets lib = work nolist nowarn memtype = (data view);
      delete WN7DXLF0;
   quit;
   
%mend etls_loader;
%etls_loader;



/**  Step end Table Loader **/

/*---- Début du code écrit par l'utilisateur  ----*/ 

/*==========================================================================* 
 * Etape :                   app stockée                  A51VJW1Q.BV0005VK * 
 * Transformation :          Ecrit par l'utilisateur                        * 
 * Description :                                                            * 
 *                                                                          * 
 * Table cible :             Ecrit par l'utilisateur -    A51VJW1Q.BS0002DT * 
 *                            work.SORTIE                                   * 
 *                                                                          * 
 * Ecrit par l'utilisateur : AS_JOB_DTM_PRO_TBO_PVA.sas: SASApp @           * 
 *                           E:\SAS\5_Applications_stockees\Production\A    * 
 *                           S_JOB_DTM_PRO_TBO_PVA.sas                      * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV0005VK);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

%let _INPUT_count = 0;
%let _OUTPUT_count = 1;
%let _OUTPUT = work.SORTIE;
%let _OUTPUT_connect = ;
%let _OUTPUT_engine = ;
%let _OUTPUT_memtype = DATA;
%let _OUTPUT_options = %nrquote();
%let _OUTPUT_alter = %nrquote();
%let _OUTPUT_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0002DT%(WorkTable%));
%let _OUTPUT_type = 1;
%let _OUTPUT_label = %nrquote();
/* Liste des colonnes cibles à conserver  */ 
%let _OUTPUT_keep = Societe Lot TypeSilicium Format Fournisseur Etape Date Annee Trimestre 
        Mois Semaine Equipement Poste PosteOrdreTri Equipe Observations 
        QteStock QteEntree QteSortie Rejet Manque RejetCasse RejetAspect 
        RejetAutre RejetChar RejetStation1 RejetStation2 RejetStation3 
        RejetStation4 RejetDechar RejetOperateur RejetMicroCrack MepQteEntree 
        MepQteSortie TextuQteEntree TextuQteSortie DiffQteEntree DiffQteSortie 
        DesoxQteEntree DesoxQteSortie PecvdQteEntree PecvdQteSortie 
        SeriQteEntree SeriQteSortie TriQteEntree TriQteSortie DateHeureSAS;
%let _OUTPUT_col_count = 47;
%let _OUTPUT_col0_name = Societe;
%let _OUTPUT_col0_table = work.SORTIE;
%let _OUTPUT_col0_length = 20;
%let _OUTPUT_col0_type = $;
%let _OUTPUT_col0_format = $20.;
%let _OUTPUT_col0_informat = $20.;
%let _OUTPUT_col0_label = %nrquote(Societe);
%let _OUTPUT_col0_exp = ;
%let _OUTPUT_col0_input_count = 0;
%let _OUTPUT_col1_name = Lot;
%let _OUTPUT_col1_table = work.SORTIE;
%let _OUTPUT_col1_length = 50;
%let _OUTPUT_col1_type = $;
%let _OUTPUT_col1_format = $50.;
%let _OUTPUT_col1_informat = $50.;
%let _OUTPUT_col1_label = %nrquote(Lot);
%let _OUTPUT_col1_exp = ;
%let _OUTPUT_col1_input_count = 0;
%let _OUTPUT_col2_name = TypeSilicium;
%let _OUTPUT_col2_table = work.SORTIE;
%let _OUTPUT_col2_length = 20;
%let _OUTPUT_col2_type = $;
%let _OUTPUT_col2_format = $20.;
%let _OUTPUT_col2_informat = $20.;
%let _OUTPUT_col2_label = %nrquote(TypeSilicium);
%let _OUTPUT_col2_exp = ;
%let _OUTPUT_col2_input_count = 0;
%let _OUTPUT_col3_name = Format;
%let _OUTPUT_col3_table = work.SORTIE;
%let _OUTPUT_col3_length = 8;
%let _OUTPUT_col3_type = ;
%let _OUTPUT_col3_format = 12.;
%let _OUTPUT_col3_informat = 12.;
%let _OUTPUT_col3_label = %nrquote(Format);
%let _OUTPUT_col3_exp = ;
%let _OUTPUT_col3_input_count = 0;
%let _OUTPUT_col4_name = Fournisseur;
%let _OUTPUT_col4_table = work.SORTIE;
%let _OUTPUT_col4_length = 50;
%let _OUTPUT_col4_type = $;
%let _OUTPUT_col4_format = $50.;
%let _OUTPUT_col4_informat = $50.;
%let _OUTPUT_col4_label = %nrquote(Fournisseur);
%let _OUTPUT_col4_exp = ;
%let _OUTPUT_col4_input_count = 0;
%let _OUTPUT_col5_name = Etape;
%let _OUTPUT_col5_table = work.SORTIE;
%let _OUTPUT_col5_length = 50;
%let _OUTPUT_col5_type = $;
%let _OUTPUT_col5_format = $50.;
%let _OUTPUT_col5_informat = $50.;
%let _OUTPUT_col5_label = %nrquote(Etape);
%let _OUTPUT_col5_exp = ;
%let _OUTPUT_col5_input_count = 0;
%let _OUTPUT_col6_name = Date;
%let _OUTPUT_col6_table = work.SORTIE;
%let _OUTPUT_col6_length = 8;
%let _OUTPUT_col6_type = ;
%let _OUTPUT_col6_format = DATETIME22.3;
%let _OUTPUT_col6_informat = DATETIME22.3;
%let _OUTPUT_col6_label = %nrquote(Date);
%let _OUTPUT_col6_exp = ;
%let _OUTPUT_col6_input_count = 0;
%let _OUTPUT_col7_name = Annee;
%let _OUTPUT_col7_table = work.SORTIE;
%let _OUTPUT_col7_length = 8;
%let _OUTPUT_col7_type = ;
%let _OUTPUT_col7_format = ;
%let _OUTPUT_col7_informat = ;
%let _OUTPUT_col7_label = %nrquote(Annee);
%let _OUTPUT_col7_exp = ;
%let _OUTPUT_col7_input_count = 0;
%let _OUTPUT_col8_name = Trimestre;
%let _OUTPUT_col8_table = work.SORTIE;
%let _OUTPUT_col8_length = 6;
%let _OUTPUT_col8_type = $;
%let _OUTPUT_col8_format = $6.;
%let _OUTPUT_col8_informat = $6.;
%let _OUTPUT_col8_label = %nrquote(Trimestre);
%let _OUTPUT_col8_exp = ;
%let _OUTPUT_col8_input_count = 0;
%let _OUTPUT_col9_name = Mois;
%let _OUTPUT_col9_table = work.SORTIE;
%let _OUTPUT_col9_length = 7;
%let _OUTPUT_col9_type = $;
%let _OUTPUT_col9_format = $7.;
%let _OUTPUT_col9_informat = $7.;
%let _OUTPUT_col9_label = %nrquote(Mois);
%let _OUTPUT_col9_exp = ;
%let _OUTPUT_col9_input_count = 0;
%let _OUTPUT_col10_name = Semaine;
%let _OUTPUT_col10_table = work.SORTIE;
%let _OUTPUT_col10_length = 7;
%let _OUTPUT_col10_type = $;
%let _OUTPUT_col10_format = $7.;
%let _OUTPUT_col10_informat = $7.;
%let _OUTPUT_col10_label = %nrquote(Semaine);
%let _OUTPUT_col10_exp = ;
%let _OUTPUT_col10_input_count = 0;
%let _OUTPUT_col11_name = Equipement;
%let _OUTPUT_col11_table = work.SORTIE;
%let _OUTPUT_col11_length = 50;
%let _OUTPUT_col11_type = $;
%let _OUTPUT_col11_format = $50.;
%let _OUTPUT_col11_informat = $50.;
%let _OUTPUT_col11_label = %nrquote(Equipement);
%let _OUTPUT_col11_exp = ;
%let _OUTPUT_col11_input_count = 0;
%let _OUTPUT_col12_name = Poste;
%let _OUTPUT_col12_table = work.SORTIE;
%let _OUTPUT_col12_length = 5;
%let _OUTPUT_col12_type = $;
%let _OUTPUT_col12_format = $5.;
%let _OUTPUT_col12_informat = $5.;
%let _OUTPUT_col12_label = %nrquote(Poste);
%let _OUTPUT_col12_exp = ;
%let _OUTPUT_col12_input_count = 0;
%let _OUTPUT_col13_name = PosteOrdreTri;
%let _OUTPUT_col13_table = work.SORTIE;
%let _OUTPUT_col13_length = 8;
%let _OUTPUT_col13_type = ;
%let _OUTPUT_col13_format = ;
%let _OUTPUT_col13_informat = ;
%let _OUTPUT_col13_label = %nrquote(PosteOrdreTri);
%let _OUTPUT_col13_exp = ;
%let _OUTPUT_col13_input_count = 0;
%let _OUTPUT_col14_name = Equipe;
%let _OUTPUT_col14_table = work.SORTIE;
%let _OUTPUT_col14_length = 8;
%let _OUTPUT_col14_type = ;
%let _OUTPUT_col14_format = ;
%let _OUTPUT_col14_informat = ;
%let _OUTPUT_col14_label = %nrquote(Equipe);
%let _OUTPUT_col14_exp = ;
%let _OUTPUT_col14_input_count = 0;
%let _OUTPUT_col15_name = Observations;
%let _OUTPUT_col15_table = work.SORTIE;
%let _OUTPUT_col15_length = 255;
%let _OUTPUT_col15_type = $;
%let _OUTPUT_col15_format = $255.;
%let _OUTPUT_col15_informat = $255.;
%let _OUTPUT_col15_label = %nrquote(Observations);
%let _OUTPUT_col15_exp = ;
%let _OUTPUT_col15_input_count = 0;
%let _OUTPUT_col16_name = QteStock;
%let _OUTPUT_col16_table = work.SORTIE;
%let _OUTPUT_col16_length = 8;
%let _OUTPUT_col16_type = ;
%let _OUTPUT_col16_format = ;
%let _OUTPUT_col16_informat = ;
%let _OUTPUT_col16_label = %nrquote(QteStock);
%let _OUTPUT_col16_exp = ;
%let _OUTPUT_col16_input_count = 0;
%let _OUTPUT_col17_name = QteEntree;
%let _OUTPUT_col17_table = work.SORTIE;
%let _OUTPUT_col17_length = 8;
%let _OUTPUT_col17_type = ;
%let _OUTPUT_col17_format = ;
%let _OUTPUT_col17_informat = ;
%let _OUTPUT_col17_label = %nrquote(QteEntree);
%let _OUTPUT_col17_exp = ;
%let _OUTPUT_col17_input_count = 0;
%let _OUTPUT_col18_name = QteSortie;
%let _OUTPUT_col18_table = work.SORTIE;
%let _OUTPUT_col18_length = 8;
%let _OUTPUT_col18_type = ;
%let _OUTPUT_col18_format = ;
%let _OUTPUT_col18_informat = ;
%let _OUTPUT_col18_label = %nrquote(QteSortie);
%let _OUTPUT_col18_exp = ;
%let _OUTPUT_col18_input_count = 0;
%let _OUTPUT_col19_name = Rejet;
%let _OUTPUT_col19_table = work.SORTIE;
%let _OUTPUT_col19_length = 8;
%let _OUTPUT_col19_type = ;
%let _OUTPUT_col19_format = ;
%let _OUTPUT_col19_informat = ;
%let _OUTPUT_col19_label = %nrquote(Rejet);
%let _OUTPUT_col19_exp = ;
%let _OUTPUT_col19_input_count = 0;
%let _OUTPUT_col20_name = Manque;
%let _OUTPUT_col20_table = work.SORTIE;
%let _OUTPUT_col20_length = 8;
%let _OUTPUT_col20_type = ;
%let _OUTPUT_col20_format = ;
%let _OUTPUT_col20_informat = ;
%let _OUTPUT_col20_label = %nrquote(Manque);
%let _OUTPUT_col20_exp = ;
%let _OUTPUT_col20_input_count = 0;
%let _OUTPUT_col21_name = RejetCasse;
%let _OUTPUT_col21_table = work.SORTIE;
%let _OUTPUT_col21_length = 8;
%let _OUTPUT_col21_type = ;
%let _OUTPUT_col21_format = ;
%let _OUTPUT_col21_informat = ;
%let _OUTPUT_col21_label = %nrquote(RejetCasse);
%let _OUTPUT_col21_exp = ;
%let _OUTPUT_col21_input_count = 0;
%let _OUTPUT_col22_name = RejetAspect;
%let _OUTPUT_col22_table = work.SORTIE;
%let _OUTPUT_col22_length = 8;
%let _OUTPUT_col22_type = ;
%let _OUTPUT_col22_format = ;
%let _OUTPUT_col22_informat = ;
%let _OUTPUT_col22_label = %nrquote(RejetAspect);
%let _OUTPUT_col22_exp = ;
%let _OUTPUT_col22_input_count = 0;
%let _OUTPUT_col23_name = RejetAutre;
%let _OUTPUT_col23_table = work.SORTIE;
%let _OUTPUT_col23_length = 8;
%let _OUTPUT_col23_type = ;
%let _OUTPUT_col23_format = ;
%let _OUTPUT_col23_informat = ;
%let _OUTPUT_col23_label = %nrquote(RejetAutre);
%let _OUTPUT_col23_exp = ;
%let _OUTPUT_col23_input_count = 0;
%let _OUTPUT_col24_name = RejetChar;
%let _OUTPUT_col24_table = work.SORTIE;
%let _OUTPUT_col24_length = 8;
%let _OUTPUT_col24_type = ;
%let _OUTPUT_col24_format = ;
%let _OUTPUT_col24_informat = ;
%let _OUTPUT_col24_label = %nrquote(RejetChar);
%let _OUTPUT_col24_exp = ;
%let _OUTPUT_col24_input_count = 0;
%let _OUTPUT_col25_name = RejetStation1;
%let _OUTPUT_col25_table = work.SORTIE;
%let _OUTPUT_col25_length = 8;
%let _OUTPUT_col25_type = ;
%let _OUTPUT_col25_format = ;
%let _OUTPUT_col25_informat = ;
%let _OUTPUT_col25_label = %nrquote(RejetStation1);
%let _OUTPUT_col25_exp = ;
%let _OUTPUT_col25_input_count = 0;
%let _OUTPUT_col26_name = RejetStation2;
%let _OUTPUT_col26_table = work.SORTIE;
%let _OUTPUT_col26_length = 8;
%let _OUTPUT_col26_type = ;
%let _OUTPUT_col26_format = ;
%let _OUTPUT_col26_informat = ;
%let _OUTPUT_col26_label = %nrquote(RejetStation2);
%let _OUTPUT_col26_exp = ;
%let _OUTPUT_col26_input_count = 0;
%let _OUTPUT_col27_name = RejetStation3;
%let _OUTPUT_col27_table = work.SORTIE;
%let _OUTPUT_col27_length = 8;
%let _OUTPUT_col27_type = ;
%let _OUTPUT_col27_format = ;
%let _OUTPUT_col27_informat = ;
%let _OUTPUT_col27_label = %nrquote(RejetStation3);
%let _OUTPUT_col27_exp = ;
%let _OUTPUT_col27_input_count = 0;
%let _OUTPUT_col28_name = RejetStation4;
%let _OUTPUT_col28_table = work.SORTIE;
%let _OUTPUT_col28_length = 8;
%let _OUTPUT_col28_type = ;
%let _OUTPUT_col28_format = ;
%let _OUTPUT_col28_informat = ;
%let _OUTPUT_col28_label = %nrquote(RejetStation4);
%let _OUTPUT_col28_exp = ;
%let _OUTPUT_col28_input_count = 0;
%let _OUTPUT_col29_name = RejetDechar;
%let _OUTPUT_col29_table = work.SORTIE;
%let _OUTPUT_col29_length = 8;
%let _OUTPUT_col29_type = ;
%let _OUTPUT_col29_format = ;
%let _OUTPUT_col29_informat = ;
%let _OUTPUT_col29_label = %nrquote(RejetDechar);
%let _OUTPUT_col29_exp = ;
%let _OUTPUT_col29_input_count = 0;
%let _OUTPUT_col30_name = RejetOperateur;
%let _OUTPUT_col30_table = work.SORTIE;
%let _OUTPUT_col30_length = 8;
%let _OUTPUT_col30_type = ;
%let _OUTPUT_col30_format = ;
%let _OUTPUT_col30_informat = ;
%let _OUTPUT_col30_label = %nrquote(RejetOperateur);
%let _OUTPUT_col30_exp = ;
%let _OUTPUT_col30_input_count = 0;
%let _OUTPUT_col31_name = RejetMicroCrack;
%let _OUTPUT_col31_table = work.SORTIE;
%let _OUTPUT_col31_length = 8;
%let _OUTPUT_col31_type = ;
%let _OUTPUT_col31_format = ;
%let _OUTPUT_col31_informat = ;
%let _OUTPUT_col31_label = %nrquote(RejetMicroCrack);
%let _OUTPUT_col31_exp = ;
%let _OUTPUT_col31_input_count = 0;
%let _OUTPUT_col32_name = MepQteEntree;
%let _OUTPUT_col32_table = work.SORTIE;
%let _OUTPUT_col32_length = 8;
%let _OUTPUT_col32_type = ;
%let _OUTPUT_col32_format = 12.;
%let _OUTPUT_col32_informat = 12.;
%let _OUTPUT_col32_label = %nrquote(MepQteEntree);
%let _OUTPUT_col32_exp = ;
%let _OUTPUT_col32_input_count = 0;
%let _OUTPUT_col33_name = MepQteSortie;
%let _OUTPUT_col33_table = work.SORTIE;
%let _OUTPUT_col33_length = 8;
%let _OUTPUT_col33_type = ;
%let _OUTPUT_col33_format = 12.;
%let _OUTPUT_col33_informat = 12.;
%let _OUTPUT_col33_label = %nrquote(MepQteSortie);
%let _OUTPUT_col33_exp = ;
%let _OUTPUT_col33_input_count = 0;
%let _OUTPUT_col34_name = TextuQteEntree;
%let _OUTPUT_col34_table = work.SORTIE;
%let _OUTPUT_col34_length = 8;
%let _OUTPUT_col34_type = ;
%let _OUTPUT_col34_format = 12.;
%let _OUTPUT_col34_informat = 12.;
%let _OUTPUT_col34_label = %nrquote(TextuQteEntree);
%let _OUTPUT_col34_exp = ;
%let _OUTPUT_col34_input_count = 0;
%let _OUTPUT_col35_name = TextuQteSortie;
%let _OUTPUT_col35_table = work.SORTIE;
%let _OUTPUT_col35_length = 8;
%let _OUTPUT_col35_type = ;
%let _OUTPUT_col35_format = 12.;
%let _OUTPUT_col35_informat = 12.;
%let _OUTPUT_col35_label = %nrquote(TextuQteSortie);
%let _OUTPUT_col35_exp = ;
%let _OUTPUT_col35_input_count = 0;
%let _OUTPUT_col36_name = DiffQteEntree;
%let _OUTPUT_col36_table = work.SORTIE;
%let _OUTPUT_col36_length = 8;
%let _OUTPUT_col36_type = ;
%let _OUTPUT_col36_format = 12.;
%let _OUTPUT_col36_informat = 12.;
%let _OUTPUT_col36_label = %nrquote(DiffQteEntree);
%let _OUTPUT_col36_exp = ;
%let _OUTPUT_col36_input_count = 0;
%let _OUTPUT_col37_name = DiffQteSortie;
%let _OUTPUT_col37_table = work.SORTIE;
%let _OUTPUT_col37_length = 8;
%let _OUTPUT_col37_type = ;
%let _OUTPUT_col37_format = 12.;
%let _OUTPUT_col37_informat = 12.;
%let _OUTPUT_col37_label = %nrquote(DiffQteSortie);
%let _OUTPUT_col37_exp = ;
%let _OUTPUT_col37_input_count = 0;
%let _OUTPUT_col38_name = DesoxQteEntree;
%let _OUTPUT_col38_table = work.SORTIE;
%let _OUTPUT_col38_length = 8;
%let _OUTPUT_col38_type = ;
%let _OUTPUT_col38_format = 12.;
%let _OUTPUT_col38_informat = 12.;
%let _OUTPUT_col38_label = %nrquote(DesoxQteEntree);
%let _OUTPUT_col38_exp = ;
%let _OUTPUT_col38_input_count = 0;
%let _OUTPUT_col39_name = DesoxQteSortie;
%let _OUTPUT_col39_table = work.SORTIE;
%let _OUTPUT_col39_length = 8;
%let _OUTPUT_col39_type = ;
%let _OUTPUT_col39_format = 12.;
%let _OUTPUT_col39_informat = 12.;
%let _OUTPUT_col39_label = %nrquote(DesoxQteSortie);
%let _OUTPUT_col39_exp = ;
%let _OUTPUT_col39_input_count = 0;
%let _OUTPUT_col40_name = PecvdQteEntree;
%let _OUTPUT_col40_table = work.SORTIE;
%let _OUTPUT_col40_length = 8;
%let _OUTPUT_col40_type = ;
%let _OUTPUT_col40_format = 12.;
%let _OUTPUT_col40_informat = 12.;
%let _OUTPUT_col40_label = %nrquote(PecvdQteEntree);
%let _OUTPUT_col40_exp = ;
%let _OUTPUT_col40_input_count = 0;
%let _OUTPUT_col41_name = PecvdQteSortie;
%let _OUTPUT_col41_table = work.SORTIE;
%let _OUTPUT_col41_length = 8;
%let _OUTPUT_col41_type = ;
%let _OUTPUT_col41_format = 12.;
%let _OUTPUT_col41_informat = 12.;
%let _OUTPUT_col41_label = %nrquote(PecvdQteSortie);
%let _OUTPUT_col41_exp = ;
%let _OUTPUT_col41_input_count = 0;
%let _OUTPUT_col42_name = SeriQteEntree;
%let _OUTPUT_col42_table = work.SORTIE;
%let _OUTPUT_col42_length = 8;
%let _OUTPUT_col42_type = ;
%let _OUTPUT_col42_format = 12.;
%let _OUTPUT_col42_informat = 12.;
%let _OUTPUT_col42_label = %nrquote(SeriQteEntree);
%let _OUTPUT_col42_exp = ;
%let _OUTPUT_col42_input_count = 0;
%let _OUTPUT_col43_name = SeriQteSortie;
%let _OUTPUT_col43_table = work.SORTIE;
%let _OUTPUT_col43_length = 8;
%let _OUTPUT_col43_type = ;
%let _OUTPUT_col43_format = 12.;
%let _OUTPUT_col43_informat = 12.;
%let _OUTPUT_col43_label = %nrquote(SeriQteSortie);
%let _OUTPUT_col43_exp = ;
%let _OUTPUT_col43_input_count = 0;
%let _OUTPUT_col44_name = TriQteEntree;
%let _OUTPUT_col44_table = work.SORTIE;
%let _OUTPUT_col44_length = 8;
%let _OUTPUT_col44_type = ;
%let _OUTPUT_col44_format = 12.;
%let _OUTPUT_col44_informat = 12.;
%let _OUTPUT_col44_label = %nrquote(TriQteEntree);
%let _OUTPUT_col44_exp = ;
%let _OUTPUT_col44_input_count = 0;
%let _OUTPUT_col45_name = TriQteSortie;
%let _OUTPUT_col45_table = work.SORTIE;
%let _OUTPUT_col45_length = 8;
%let _OUTPUT_col45_type = ;
%let _OUTPUT_col45_format = 12.;
%let _OUTPUT_col45_informat = 12.;
%let _OUTPUT_col45_label = %nrquote(TriQteSortie);
%let _OUTPUT_col45_exp = ;
%let _OUTPUT_col45_input_count = 0;
%let _OUTPUT_col46_name = DateHeureSAS;
%let _OUTPUT_col46_table = work.SORTIE;
%let _OUTPUT_col46_length = 8;
%let _OUTPUT_col46_type = ;
%let _OUTPUT_col46_format = DATETIME22.3;
%let _OUTPUT_col46_informat = DATETIME22.3;
%let _OUTPUT_col46_label = %nrquote(DateHeureSAS);
%let _OUTPUT_col46_exp = ;
%let _OUTPUT_col46_input_count = 0;

%let _OUTPUT1 = work.SORTIE;
%let _OUTPUT1_connect = ;
%let _OUTPUT1_engine = ;
%let _OUTPUT1_memtype = DATA;
%let _OUTPUT1_options = %nrquote();
%let _OUTPUT1_alter = %nrquote();
%let _OUTPUT1_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0002DT%(WorkTable%));
%let _OUTPUT1_type = 1;
%let _OUTPUT1_label = %nrquote();
/* Liste des colonnes cibles à conserver  */ 
%let _OUTPUT1_keep = Societe Lot TypeSilicium Format Fournisseur Etape Date Annee Trimestre 
        Mois Semaine Equipement Poste PosteOrdreTri Equipe Observations 
        QteStock QteEntree QteSortie Rejet Manque RejetCasse RejetAspect 
        RejetAutre RejetChar RejetStation1 RejetStation2 RejetStation3 
        RejetStation4 RejetDechar RejetOperateur RejetMicroCrack MepQteEntree 
        MepQteSortie TextuQteEntree TextuQteSortie DiffQteEntree DiffQteSortie 
        DesoxQteEntree DesoxQteSortie PecvdQteEntree PecvdQteSortie 
        SeriQteEntree SeriQteSortie TriQteEntree TriQteSortie DateHeureSAS;
%let _OUTPUT1_col_count = 47;
%let _OUTPUT1_col0_name = Societe;
%let _OUTPUT1_col0_table = work.SORTIE;
%let _OUTPUT1_col0_length = 20;
%let _OUTPUT1_col0_type = $;
%let _OUTPUT1_col0_format = $20.;
%let _OUTPUT1_col0_informat = $20.;
%let _OUTPUT1_col0_label = %nrquote(Societe);
%let _OUTPUT1_col0_exp = ;
%let _OUTPUT1_col0_input_count = 0;
%let _OUTPUT1_col1_name = Lot;
%let _OUTPUT1_col1_table = work.SORTIE;
%let _OUTPUT1_col1_length = 50;
%let _OUTPUT1_col1_type = $;
%let _OUTPUT1_col1_format = $50.;
%let _OUTPUT1_col1_informat = $50.;
%let _OUTPUT1_col1_label = %nrquote(Lot);
%let _OUTPUT1_col1_exp = ;
%let _OUTPUT1_col1_input_count = 0;
%let _OUTPUT1_col2_name = TypeSilicium;
%let _OUTPUT1_col2_table = work.SORTIE;
%let _OUTPUT1_col2_length = 20;
%let _OUTPUT1_col2_type = $;
%let _OUTPUT1_col2_format = $20.;
%let _OUTPUT1_col2_informat = $20.;
%let _OUTPUT1_col2_label = %nrquote(TypeSilicium);
%let _OUTPUT1_col2_exp = ;
%let _OUTPUT1_col2_input_count = 0;
%let _OUTPUT1_col3_name = Format;
%let _OUTPUT1_col3_table = work.SORTIE;
%let _OUTPUT1_col3_length = 8;
%let _OUTPUT1_col3_type = ;
%let _OUTPUT1_col3_format = 12.;
%let _OUTPUT1_col3_informat = 12.;
%let _OUTPUT1_col3_label = %nrquote(Format);
%let _OUTPUT1_col3_exp = ;
%let _OUTPUT1_col3_input_count = 0;
%let _OUTPUT1_col4_name = Fournisseur;
%let _OUTPUT1_col4_table = work.SORTIE;
%let _OUTPUT1_col4_length = 50;
%let _OUTPUT1_col4_type = $;
%let _OUTPUT1_col4_format = $50.;
%let _OUTPUT1_col4_informat = $50.;
%let _OUTPUT1_col4_label = %nrquote(Fournisseur);
%let _OUTPUT1_col4_exp = ;
%let _OUTPUT1_col4_input_count = 0;
%let _OUTPUT1_col5_name = Etape;
%let _OUTPUT1_col5_table = work.SORTIE;
%let _OUTPUT1_col5_length = 50;
%let _OUTPUT1_col5_type = $;
%let _OUTPUT1_col5_format = $50.;
%let _OUTPUT1_col5_informat = $50.;
%let _OUTPUT1_col5_label = %nrquote(Etape);
%let _OUTPUT1_col5_exp = ;
%let _OUTPUT1_col5_input_count = 0;
%let _OUTPUT1_col6_name = Date;
%let _OUTPUT1_col6_table = work.SORTIE;
%let _OUTPUT1_col6_length = 8;
%let _OUTPUT1_col6_type = ;
%let _OUTPUT1_col6_format = DATETIME22.3;
%let _OUTPUT1_col6_informat = DATETIME22.3;
%let _OUTPUT1_col6_label = %nrquote(Date);
%let _OUTPUT1_col6_exp = ;
%let _OUTPUT1_col6_input_count = 0;
%let _OUTPUT1_col7_name = Annee;
%let _OUTPUT1_col7_table = work.SORTIE;
%let _OUTPUT1_col7_length = 8;
%let _OUTPUT1_col7_type = ;
%let _OUTPUT1_col7_format = ;
%let _OUTPUT1_col7_informat = ;
%let _OUTPUT1_col7_label = %nrquote(Annee);
%let _OUTPUT1_col7_exp = ;
%let _OUTPUT1_col7_input_count = 0;
%let _OUTPUT1_col8_name = Trimestre;
%let _OUTPUT1_col8_table = work.SORTIE;
%let _OUTPUT1_col8_length = 6;
%let _OUTPUT1_col8_type = $;
%let _OUTPUT1_col8_format = $6.;
%let _OUTPUT1_col8_informat = $6.;
%let _OUTPUT1_col8_label = %nrquote(Trimestre);
%let _OUTPUT1_col8_exp = ;
%let _OUTPUT1_col8_input_count = 0;
%let _OUTPUT1_col9_name = Mois;
%let _OUTPUT1_col9_table = work.SORTIE;
%let _OUTPUT1_col9_length = 7;
%let _OUTPUT1_col9_type = $;
%let _OUTPUT1_col9_format = $7.;
%let _OUTPUT1_col9_informat = $7.;
%let _OUTPUT1_col9_label = %nrquote(Mois);
%let _OUTPUT1_col9_exp = ;
%let _OUTPUT1_col9_input_count = 0;
%let _OUTPUT1_col10_name = Semaine;
%let _OUTPUT1_col10_table = work.SORTIE;
%let _OUTPUT1_col10_length = 7;
%let _OUTPUT1_col10_type = $;
%let _OUTPUT1_col10_format = $7.;
%let _OUTPUT1_col10_informat = $7.;
%let _OUTPUT1_col10_label = %nrquote(Semaine);
%let _OUTPUT1_col10_exp = ;
%let _OUTPUT1_col10_input_count = 0;
%let _OUTPUT1_col11_name = Equipement;
%let _OUTPUT1_col11_table = work.SORTIE;
%let _OUTPUT1_col11_length = 50;
%let _OUTPUT1_col11_type = $;
%let _OUTPUT1_col11_format = $50.;
%let _OUTPUT1_col11_informat = $50.;
%let _OUTPUT1_col11_label = %nrquote(Equipement);
%let _OUTPUT1_col11_exp = ;
%let _OUTPUT1_col11_input_count = 0;
%let _OUTPUT1_col12_name = Poste;
%let _OUTPUT1_col12_table = work.SORTIE;
%let _OUTPUT1_col12_length = 5;
%let _OUTPUT1_col12_type = $;
%let _OUTPUT1_col12_format = $5.;
%let _OUTPUT1_col12_informat = $5.;
%let _OUTPUT1_col12_label = %nrquote(Poste);
%let _OUTPUT1_col12_exp = ;
%let _OUTPUT1_col12_input_count = 0;
%let _OUTPUT1_col13_name = PosteOrdreTri;
%let _OUTPUT1_col13_table = work.SORTIE;
%let _OUTPUT1_col13_length = 8;
%let _OUTPUT1_col13_type = ;
%let _OUTPUT1_col13_format = ;
%let _OUTPUT1_col13_informat = ;
%let _OUTPUT1_col13_label = %nrquote(PosteOrdreTri);
%let _OUTPUT1_col13_exp = ;
%let _OUTPUT1_col13_input_count = 0;
%let _OUTPUT1_col14_name = Equipe;
%let _OUTPUT1_col14_table = work.SORTIE;
%let _OUTPUT1_col14_length = 8;
%let _OUTPUT1_col14_type = ;
%let _OUTPUT1_col14_format = ;
%let _OUTPUT1_col14_informat = ;
%let _OUTPUT1_col14_label = %nrquote(Equipe);
%let _OUTPUT1_col14_exp = ;
%let _OUTPUT1_col14_input_count = 0;
%let _OUTPUT1_col15_name = Observations;
%let _OUTPUT1_col15_table = work.SORTIE;
%let _OUTPUT1_col15_length = 255;
%let _OUTPUT1_col15_type = $;
%let _OUTPUT1_col15_format = $255.;
%let _OUTPUT1_col15_informat = $255.;
%let _OUTPUT1_col15_label = %nrquote(Observations);
%let _OUTPUT1_col15_exp = ;
%let _OUTPUT1_col15_input_count = 0;
%let _OUTPUT1_col16_name = QteStock;
%let _OUTPUT1_col16_table = work.SORTIE;
%let _OUTPUT1_col16_length = 8;
%let _OUTPUT1_col16_type = ;
%let _OUTPUT1_col16_format = ;
%let _OUTPUT1_col16_informat = ;
%let _OUTPUT1_col16_label = %nrquote(QteStock);
%let _OUTPUT1_col16_exp = ;
%let _OUTPUT1_col16_input_count = 0;
%let _OUTPUT1_col17_name = QteEntree;
%let _OUTPUT1_col17_table = work.SORTIE;
%let _OUTPUT1_col17_length = 8;
%let _OUTPUT1_col17_type = ;
%let _OUTPUT1_col17_format = ;
%let _OUTPUT1_col17_informat = ;
%let _OUTPUT1_col17_label = %nrquote(QteEntree);
%let _OUTPUT1_col17_exp = ;
%let _OUTPUT1_col17_input_count = 0;
%let _OUTPUT1_col18_name = QteSortie;
%let _OUTPUT1_col18_table = work.SORTIE;
%let _OUTPUT1_col18_length = 8;
%let _OUTPUT1_col18_type = ;
%let _OUTPUT1_col18_format = ;
%let _OUTPUT1_col18_informat = ;
%let _OUTPUT1_col18_label = %nrquote(QteSortie);
%let _OUTPUT1_col18_exp = ;
%let _OUTPUT1_col18_input_count = 0;
%let _OUTPUT1_col19_name = Rejet;
%let _OUTPUT1_col19_table = work.SORTIE;
%let _OUTPUT1_col19_length = 8;
%let _OUTPUT1_col19_type = ;
%let _OUTPUT1_col19_format = ;
%let _OUTPUT1_col19_informat = ;
%let _OUTPUT1_col19_label = %nrquote(Rejet);
%let _OUTPUT1_col19_exp = ;
%let _OUTPUT1_col19_input_count = 0;
%let _OUTPUT1_col20_name = Manque;
%let _OUTPUT1_col20_table = work.SORTIE;
%let _OUTPUT1_col20_length = 8;
%let _OUTPUT1_col20_type = ;
%let _OUTPUT1_col20_format = ;
%let _OUTPUT1_col20_informat = ;
%let _OUTPUT1_col20_label = %nrquote(Manque);
%let _OUTPUT1_col20_exp = ;
%let _OUTPUT1_col20_input_count = 0;
%let _OUTPUT1_col21_name = RejetCasse;
%let _OUTPUT1_col21_table = work.SORTIE;
%let _OUTPUT1_col21_length = 8;
%let _OUTPUT1_col21_type = ;
%let _OUTPUT1_col21_format = ;
%let _OUTPUT1_col21_informat = ;
%let _OUTPUT1_col21_label = %nrquote(RejetCasse);
%let _OUTPUT1_col21_exp = ;
%let _OUTPUT1_col21_input_count = 0;
%let _OUTPUT1_col22_name = RejetAspect;
%let _OUTPUT1_col22_table = work.SORTIE;
%let _OUTPUT1_col22_length = 8;
%let _OUTPUT1_col22_type = ;
%let _OUTPUT1_col22_format = ;
%let _OUTPUT1_col22_informat = ;
%let _OUTPUT1_col22_label = %nrquote(RejetAspect);
%let _OUTPUT1_col22_exp = ;
%let _OUTPUT1_col22_input_count = 0;
%let _OUTPUT1_col23_name = RejetAutre;
%let _OUTPUT1_col23_table = work.SORTIE;
%let _OUTPUT1_col23_length = 8;
%let _OUTPUT1_col23_type = ;
%let _OUTPUT1_col23_format = ;
%let _OUTPUT1_col23_informat = ;
%let _OUTPUT1_col23_label = %nrquote(RejetAutre);
%let _OUTPUT1_col23_exp = ;
%let _OUTPUT1_col23_input_count = 0;
%let _OUTPUT1_col24_name = RejetChar;
%let _OUTPUT1_col24_table = work.SORTIE;
%let _OUTPUT1_col24_length = 8;
%let _OUTPUT1_col24_type = ;
%let _OUTPUT1_col24_format = ;
%let _OUTPUT1_col24_informat = ;
%let _OUTPUT1_col24_label = %nrquote(RejetChar);
%let _OUTPUT1_col24_exp = ;
%let _OUTPUT1_col24_input_count = 0;
%let _OUTPUT1_col25_name = RejetStation1;
%let _OUTPUT1_col25_table = work.SORTIE;
%let _OUTPUT1_col25_length = 8;
%let _OUTPUT1_col25_type = ;
%let _OUTPUT1_col25_format = ;
%let _OUTPUT1_col25_informat = ;
%let _OUTPUT1_col25_label = %nrquote(RejetStation1);
%let _OUTPUT1_col25_exp = ;
%let _OUTPUT1_col25_input_count = 0;
%let _OUTPUT1_col26_name = RejetStation2;
%let _OUTPUT1_col26_table = work.SORTIE;
%let _OUTPUT1_col26_length = 8;
%let _OUTPUT1_col26_type = ;
%let _OUTPUT1_col26_format = ;
%let _OUTPUT1_col26_informat = ;
%let _OUTPUT1_col26_label = %nrquote(RejetStation2);
%let _OUTPUT1_col26_exp = ;
%let _OUTPUT1_col26_input_count = 0;
%let _OUTPUT1_col27_name = RejetStation3;
%let _OUTPUT1_col27_table = work.SORTIE;
%let _OUTPUT1_col27_length = 8;
%let _OUTPUT1_col27_type = ;
%let _OUTPUT1_col27_format = ;
%let _OUTPUT1_col27_informat = ;
%let _OUTPUT1_col27_label = %nrquote(RejetStation3);
%let _OUTPUT1_col27_exp = ;
%let _OUTPUT1_col27_input_count = 0;
%let _OUTPUT1_col28_name = RejetStation4;
%let _OUTPUT1_col28_table = work.SORTIE;
%let _OUTPUT1_col28_length = 8;
%let _OUTPUT1_col28_type = ;
%let _OUTPUT1_col28_format = ;
%let _OUTPUT1_col28_informat = ;
%let _OUTPUT1_col28_label = %nrquote(RejetStation4);
%let _OUTPUT1_col28_exp = ;
%let _OUTPUT1_col28_input_count = 0;
%let _OUTPUT1_col29_name = RejetDechar;
%let _OUTPUT1_col29_table = work.SORTIE;
%let _OUTPUT1_col29_length = 8;
%let _OUTPUT1_col29_type = ;
%let _OUTPUT1_col29_format = ;
%let _OUTPUT1_col29_informat = ;
%let _OUTPUT1_col29_label = %nrquote(RejetDechar);
%let _OUTPUT1_col29_exp = ;
%let _OUTPUT1_col29_input_count = 0;
%let _OUTPUT1_col30_name = RejetOperateur;
%let _OUTPUT1_col30_table = work.SORTIE;
%let _OUTPUT1_col30_length = 8;
%let _OUTPUT1_col30_type = ;
%let _OUTPUT1_col30_format = ;
%let _OUTPUT1_col30_informat = ;
%let _OUTPUT1_col30_label = %nrquote(RejetOperateur);
%let _OUTPUT1_col30_exp = ;
%let _OUTPUT1_col30_input_count = 0;
%let _OUTPUT1_col31_name = RejetMicroCrack;
%let _OUTPUT1_col31_table = work.SORTIE;
%let _OUTPUT1_col31_length = 8;
%let _OUTPUT1_col31_type = ;
%let _OUTPUT1_col31_format = ;
%let _OUTPUT1_col31_informat = ;
%let _OUTPUT1_col31_label = %nrquote(RejetMicroCrack);
%let _OUTPUT1_col31_exp = ;
%let _OUTPUT1_col31_input_count = 0;
%let _OUTPUT1_col32_name = MepQteEntree;
%let _OUTPUT1_col32_table = work.SORTIE;
%let _OUTPUT1_col32_length = 8;
%let _OUTPUT1_col32_type = ;
%let _OUTPUT1_col32_format = 12.;
%let _OUTPUT1_col32_informat = 12.;
%let _OUTPUT1_col32_label = %nrquote(MepQteEntree);
%let _OUTPUT1_col32_exp = ;
%let _OUTPUT1_col32_input_count = 0;
%let _OUTPUT1_col33_name = MepQteSortie;
%let _OUTPUT1_col33_table = work.SORTIE;
%let _OUTPUT1_col33_length = 8;
%let _OUTPUT1_col33_type = ;
%let _OUTPUT1_col33_format = 12.;
%let _OUTPUT1_col33_informat = 12.;
%let _OUTPUT1_col33_label = %nrquote(MepQteSortie);
%let _OUTPUT1_col33_exp = ;
%let _OUTPUT1_col33_input_count = 0;
%let _OUTPUT1_col34_name = TextuQteEntree;
%let _OUTPUT1_col34_table = work.SORTIE;
%let _OUTPUT1_col34_length = 8;
%let _OUTPUT1_col34_type = ;
%let _OUTPUT1_col34_format = 12.;
%let _OUTPUT1_col34_informat = 12.;
%let _OUTPUT1_col34_label = %nrquote(TextuQteEntree);
%let _OUTPUT1_col34_exp = ;
%let _OUTPUT1_col34_input_count = 0;
%let _OUTPUT1_col35_name = TextuQteSortie;
%let _OUTPUT1_col35_table = work.SORTIE;
%let _OUTPUT1_col35_length = 8;
%let _OUTPUT1_col35_type = ;
%let _OUTPUT1_col35_format = 12.;
%let _OUTPUT1_col35_informat = 12.;
%let _OUTPUT1_col35_label = %nrquote(TextuQteSortie);
%let _OUTPUT1_col35_exp = ;
%let _OUTPUT1_col35_input_count = 0;
%let _OUTPUT1_col36_name = DiffQteEntree;
%let _OUTPUT1_col36_table = work.SORTIE;
%let _OUTPUT1_col36_length = 8;
%let _OUTPUT1_col36_type = ;
%let _OUTPUT1_col36_format = 12.;
%let _OUTPUT1_col36_informat = 12.;
%let _OUTPUT1_col36_label = %nrquote(DiffQteEntree);
%let _OUTPUT1_col36_exp = ;
%let _OUTPUT1_col36_input_count = 0;
%let _OUTPUT1_col37_name = DiffQteSortie;
%let _OUTPUT1_col37_table = work.SORTIE;
%let _OUTPUT1_col37_length = 8;
%let _OUTPUT1_col37_type = ;
%let _OUTPUT1_col37_format = 12.;
%let _OUTPUT1_col37_informat = 12.;
%let _OUTPUT1_col37_label = %nrquote(DiffQteSortie);
%let _OUTPUT1_col37_exp = ;
%let _OUTPUT1_col37_input_count = 0;
%let _OUTPUT1_col38_name = DesoxQteEntree;
%let _OUTPUT1_col38_table = work.SORTIE;
%let _OUTPUT1_col38_length = 8;
%let _OUTPUT1_col38_type = ;
%let _OUTPUT1_col38_format = 12.;
%let _OUTPUT1_col38_informat = 12.;
%let _OUTPUT1_col38_label = %nrquote(DesoxQteEntree);
%let _OUTPUT1_col38_exp = ;
%let _OUTPUT1_col38_input_count = 0;
%let _OUTPUT1_col39_name = DesoxQteSortie;
%let _OUTPUT1_col39_table = work.SORTIE;
%let _OUTPUT1_col39_length = 8;
%let _OUTPUT1_col39_type = ;
%let _OUTPUT1_col39_format = 12.;
%let _OUTPUT1_col39_informat = 12.;
%let _OUTPUT1_col39_label = %nrquote(DesoxQteSortie);
%let _OUTPUT1_col39_exp = ;
%let _OUTPUT1_col39_input_count = 0;
%let _OUTPUT1_col40_name = PecvdQteEntree;
%let _OUTPUT1_col40_table = work.SORTIE;
%let _OUTPUT1_col40_length = 8;
%let _OUTPUT1_col40_type = ;
%let _OUTPUT1_col40_format = 12.;
%let _OUTPUT1_col40_informat = 12.;
%let _OUTPUT1_col40_label = %nrquote(PecvdQteEntree);
%let _OUTPUT1_col40_exp = ;
%let _OUTPUT1_col40_input_count = 0;
%let _OUTPUT1_col41_name = PecvdQteSortie;
%let _OUTPUT1_col41_table = work.SORTIE;
%let _OUTPUT1_col41_length = 8;
%let _OUTPUT1_col41_type = ;
%let _OUTPUT1_col41_format = 12.;
%let _OUTPUT1_col41_informat = 12.;
%let _OUTPUT1_col41_label = %nrquote(PecvdQteSortie);
%let _OUTPUT1_col41_exp = ;
%let _OUTPUT1_col41_input_count = 0;
%let _OUTPUT1_col42_name = SeriQteEntree;
%let _OUTPUT1_col42_table = work.SORTIE;
%let _OUTPUT1_col42_length = 8;
%let _OUTPUT1_col42_type = ;
%let _OUTPUT1_col42_format = 12.;
%let _OUTPUT1_col42_informat = 12.;
%let _OUTPUT1_col42_label = %nrquote(SeriQteEntree);
%let _OUTPUT1_col42_exp = ;
%let _OUTPUT1_col42_input_count = 0;
%let _OUTPUT1_col43_name = SeriQteSortie;
%let _OUTPUT1_col43_table = work.SORTIE;
%let _OUTPUT1_col43_length = 8;
%let _OUTPUT1_col43_type = ;
%let _OUTPUT1_col43_format = 12.;
%let _OUTPUT1_col43_informat = 12.;
%let _OUTPUT1_col43_label = %nrquote(SeriQteSortie);
%let _OUTPUT1_col43_exp = ;
%let _OUTPUT1_col43_input_count = 0;
%let _OUTPUT1_col44_name = TriQteEntree;
%let _OUTPUT1_col44_table = work.SORTIE;
%let _OUTPUT1_col44_length = 8;
%let _OUTPUT1_col44_type = ;
%let _OUTPUT1_col44_format = 12.;
%let _OUTPUT1_col44_informat = 12.;
%let _OUTPUT1_col44_label = %nrquote(TriQteEntree);
%let _OUTPUT1_col44_exp = ;
%let _OUTPUT1_col44_input_count = 0;
%let _OUTPUT1_col45_name = TriQteSortie;
%let _OUTPUT1_col45_table = work.SORTIE;
%let _OUTPUT1_col45_length = 8;
%let _OUTPUT1_col45_type = ;
%let _OUTPUT1_col45_format = 12.;
%let _OUTPUT1_col45_informat = 12.;
%let _OUTPUT1_col45_label = %nrquote(TriQteSortie);
%let _OUTPUT1_col45_exp = ;
%let _OUTPUT1_col45_input_count = 0;
%let _OUTPUT1_col46_name = DateHeureSAS;
%let _OUTPUT1_col46_table = work.SORTIE;
%let _OUTPUT1_col46_length = 8;
%let _OUTPUT1_col46_type = ;
%let _OUTPUT1_col46_format = DATETIME22.3;
%let _OUTPUT1_col46_informat = DATETIME22.3;
%let _OUTPUT1_col46_label = %nrquote(DateHeureSAS);
%let _OUTPUT1_col46_exp = ;
%let _OUTPUT1_col46_input_count = 0;

* Début du code EG généré (ne pas modifier cette ligne);
*
*  Application stockée enregistrée par
*  Enterprise Guide Stored Process Manager V6.1
*
*  ====================================================================
*  Nom de l'application stockée : AS_JOB_DTM_PRO_TBO_PVA
*  ====================================================================
*;


*ProcessBody;
/*
%STPBEGIN;*/

/* Begin Librefs */
LIBNAME DS_DWH ODBC  DATASRC=DWH_PROD  SCHEMA=dbo  USER=SASSQL  PASSWORD="{SAS002}3625302A43996237206B48FF5188832F3A71A582" ;

/* End Librefs */

* Fin du code EG généré (ne pas modifier cette ligne);


/* --- Début des fonctions de macros partagées. --- */

/* Conditionally delete set of tables or views, if they exists          */
/* If the member does not exist, then no action is performed   */
%macro _eg_conditional_dropds /parmbuff;
   	%let num=1;
	/* flags to determine whether a PROC SQL step is needed */
	/* or even started yet                                  */
	%let stepneeded=0;
	%let stepstarted=0;
   	%let dsname=%scan(&syspbuff,&num,',()');
	%do %while(&dsname ne);	
		%if %sysfunc(exist(&dsname)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;
			%end;
				drop table &dsname;
		%end;
		%if %sysfunc(exist(&dsname,view)) %then %do;
			%let stepneeded=1;
			%if (&stepstarted eq 0) %then %do;
				proc sql;
				%let stepstarted=1;
			%end;
				drop view &dsname;
		%end;
		%let num=%eval(&num+1);
      	%let dsname=%scan(&syspbuff,&num,',()');
	%end;
	%if &stepstarted %then %do;
		quit;
	%end;
%mend _eg_conditional_dropds;

/* Build where clauses from stored process parameters */

%macro _eg_WhereParam( COLUMN, PARM, OPERATOR, TYPE=S, MATCHALL=_ALL_VALUES_, MATCHALL_CLAUSE=1, MAX= , IS_EXPLICIT=0);
  %local q1 q2 sq1 sq2;
  %local isEmpty;
  %local isEqual;
  %let isEqual = ("%QUPCASE(&OPERATOR)" = "EQ" OR "&OPERATOR" = "=");
  %let isNotEqual = ("%QUPCASE(&OPERATOR)" = "NE" OR "&OPERATOR" = "<>");
  %let isIn = ("%QUPCASE(&OPERATOR)" = "IN");
  %let isNotIn = ("%QUPCASE(&OPERATOR)" = "NOT IN");
  %local isString;
  %let isString = (%QUPCASE(&TYPE) eq S or %QUPCASE(&TYPE) eq STRING );
  %if &isString %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%");
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq D or %QUPCASE(&TYPE) eq DATE %then 
  %do;
    %let q1=%str(%");
    %let q2=%str(%"d);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq T or %QUPCASE(&TYPE) eq TIME %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%"t);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else %if %QUPCASE(&TYPE) eq DT or %QUPCASE(&TYPE) eq DATETIME %then
  %do;
    %let q1=%str(%");
    %let q2=%str(%"dt);
	%let sq1=%str(%'); 
    %let sq2=%str(%'); 
  %end;
  %else
  %do;
    %let q1=;
    %let q2=;
	%let sq1=;
    %let sq2=;
  %end;
  
  %if "&PARM" = "" %then %let PARM=&COLUMN;

  %local isBetween;
  %let isBetween = ("%QUPCASE(&OPERATOR)"="BETWEEN" or "%QUPCASE(&OPERATOR)"="NOT BETWEEN");

  %if "&MAX" = "" %then %do;
    %let MAX = &parm._MAX;
    %if &isBetween %then %let PARM = &parm._MIN;
  %end;

  %if not %symexist(&PARM) or (&isBetween and not %symexist(&MAX)) %then %do;
    %if &IS_EXPLICIT=0 %then %do;
		not &MATCHALL_CLAUSE
	%end;
	%else %do;
	    not 1=1
	%end;
  %end;
  %else %if "%qupcase(&&&PARM)" = "%qupcase(&MATCHALL)" %then %do;
    %if &IS_EXPLICIT=0 %then %do;
	    &MATCHALL_CLAUSE
	%end;
	%else %do;
	    1=1
	%end;	
  %end;
  %else %if (not %symexist(&PARM._count)) or &isBetween %then %do;
    %let isEmpty = ("&&&PARM" = "");
    %if (&isEqual AND &isEmpty AND &isString) %then
       &COLUMN is null;
    %else %if (&isNotEqual AND &isEmpty AND &isString) %then
       &COLUMN is not null;
    %else %do;
	   %if &IS_EXPLICIT=0 %then %do;
           &COLUMN &OPERATOR %unquote(&q1)&&&PARM%unquote(&q2)
	   %end;
	   %else %do;
	       &COLUMN &OPERATOR %unquote(%nrstr(&sq1))&&&PARM%unquote(%nrstr(&sq2))
	   %end;
       %if &isBetween %then 
          AND %unquote(&q1)&&&MAX%unquote(&q2);
    %end;
  %end;
  %else 
  %do;
	%local emptyList;
  	%let emptyList = %symexist(&PARM._count);
  	%if &emptyList %then %let emptyList = &&&PARM._count = 0;
	%if (&emptyList) %then
	%do;
		%if (&isNotin) %then
		   1;
		%else
			0;
	%end;
	%else %if (&&&PARM._count = 1) %then 
    %do;
      %let isEmpty = ("&&&PARM" = "");
      %if (&isIn AND &isEmpty AND &isString) %then
        &COLUMN is null;
      %else %if (&isNotin AND &isEmpty AND &isString) %then
        &COLUMN is not null;
      %else %do;
	    %if &IS_EXPLICIT=0 %then %do;
            &COLUMN &OPERATOR (%unquote(&q1)&&&PARM%unquote(&q2))
	    %end;
		%else %do;
		    &COLUMN &OPERATOR (%unquote(%nrstr(&sq1))&&&PARM%unquote(%nrstr(&sq2)))
		%end;
	  %end;
    %end;
    %else 
    %do;
       %local addIsNull addIsNotNull addComma;
       %let addIsNull = %eval(0);
       %let addIsNotNull = %eval(0);
       %let addComma = %eval(0);
       (&COLUMN &OPERATOR ( 
       %do i=1 %to &&&PARM._count; 
          %let isEmpty = ("&&&PARM&i" = "");
          %if (&isString AND &isEmpty AND (&isIn OR &isNotIn)) %then
          %do;
             %if (&isIn) %then %let addIsNull = 1;
             %else %let addIsNotNull = 1;
          %end;
          %else
          %do;		     
            %if &addComma %then %do;,%end;
			%if &IS_EXPLICIT=0 %then %do;
                %unquote(&q1)&&&PARM&i%unquote(&q2) 
			%end;
			%else %do;
			    %unquote(%nrstr(&sq1))&&&PARM&i%unquote(%nrstr(&sq2)) 
			%end;
            %let addComma = %eval(1);
          %end;
       %end;) 
       %if &addIsNull %then OR &COLUMN is null;
       %else %if &addIsNotNull %then AND &COLUMN is not null;
       %do;)
       %end;
    %end;
  %end;
%mend;
/* --- Fin des fonctions de macros partagées. --- */

/* --- Début du code de "Code Planning ". --- */
/* Définition du paramètre d'historique */
%let Historique_nb_mois = 2;

/* Création d'une table temporaire glissante des dates et des postes */
data work.Planning (drop=i);

	format Date_poste ddmmyy8.;
	format Date_poste_000000 datetime22.3; /* Format de date les jointure avec les datetime de SQL Server. */
	format Poste $5.;
	
	/* Pour la date courante, les postes déependent du jour de la semaine et de l'heure */
	Date_poste = date();
	Date_poste_000000 = dhms(Date_poste, 0, 0, 0); 

	if weekday(Date_poste) in (2 ,3, 4, 5, 6) then do;
		if time() >= '5:00't then do;
			Poste = 'M';
			Poste_ordre_tri = 1;
			output;
		end;	
		if time() >= '13:00't then do;
			Poste = 'S';
			Poste_ordre_tri = 2;
			output;
		end;
		if time() >= '21:00't then do;
			Poste = 'N';
			Poste_ordre_tri = 3;
			output;
		end;
	end;
	else do;	
		if time() >= '5:00't then do;
			Poste = 'WE M';
			Poste_ordre_tri = 4;
			output;
		end;
		if time() >= '17:00't then do;
			Poste = 'WE N';
			Poste_ordre_tri = 5;
			output;
		end;
	end;

	/* Pour les dates passées, les postes sont fonction du jour de la semaine uniquement */
	i = 1;
	do while (intck('month', date() - i, date()) <= &Historique_nb_mois);

		Date_poste = date() - i;
		Date_poste_000000 = dhms(Date_poste, 0, 0, 0); 

		if weekday(Date_poste) in (2 ,3, 4, 5, 6) then do;
			Poste = 'M';
			Poste_ordre_tri = 1;
			output;	
			Poste = 'S';
			Poste_ordre_tri = 2;
			output;
			Poste = 'N';
			Poste_ordre_tri = 3;
			output;
		end;
		else do;	
			Poste = 'WE M';
			Poste_ordre_tri = 4;
			output;
			Poste = 'WE N';
			Poste_ordre_tri = 5;
			output;
		end;

		i = i + 1;

	end;

run; 

/* Création de la table temporaire des sociétés */
data work.Societe;

	infile datalines delimiter=',';
	format Societe $20.;
	input Societe $;

	datalines;
PV Alliance
EDF ENR PWT
;

run;

/* Création de la table temporaire des types de silicium. */
data work.Type_silicium;
	length Type_silicium $20.;
	input Type_silicium $20.;
	
	datalines;
Multi
Mono
Multilike
Monolike
MULTI PROJET
FULL MONO
MULTI EXT
FULL MONO EXT
MONO PROJET
FULL MONO PROJET
MONOLIKE PROJET
;

run;



/* Création de la table temporaire des étapes. */
data work.Etape;

	infile datalines delimiter=',';
	format Etape $50.;
	input Etape $;

	datalines;
01. Mise en panier
02. Texturisation
03. Diffusion
04. Desoxydation
05. Pecvd
06. Sérigraphie
07. Tri
;

run;
 

/* Croisement des tables temporaires */
proc sql noprint;

	create table work.Planning_type_si as
		select *
		from Planning, Societe, Etape, Type_silicium
		order by date_poste desc, Poste_ordre_tri desc, Societe, Etape, Type_Silicium;

quit;

/* Supression des tables temporaires */
proc datasets lib=WORK nolist memtype=(data view);

	delete Societe Planning Type_silicium Etape;

run; 

quit;




/* --- Fin du code de "Code Planning ". --- */

/* --- Début du code de "Définition  biblitothèque DTM_PRO". --- */
/*LIBNAME DTM_PRO ODBC  DATASRC=DTM_DEV  SCHEMA=DTM_PRO  USER=SASSQL  PASSWORD="{sas001}c0BzLXNxbDIwMDg=" ;*/
/*
LIBNAME DTM_PRO ODBC  DATASRC=DTM_DEV  SCHEMA=DTM_PRO  USER=SASSQL  PASSWORD="{sas001}c0BzLXNxbDIwMDg=" ;
*/

libname DTM_PRO "E:\Donnees_SAS\DTM_PRO";
/* --- Fin du code de "Définition  biblitothèque DTM_PRO". --- */

/* --- Début du code de "Données Mep". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_MEP);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_MEP AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('01. Mise en panier') AS Etape, 
          /* OrdreTri */
            (1) AS OrdreTri, 
          DWH_SQC_LOTS.Mep_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Mep_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Mep_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Mep_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Mep_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Mep_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Mep_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Mep_Qte_Manq LABEL='' AS Manque, 

          DWH_SQC_LOTS.Mep_Rej_Op_Casse LABEL='' AS RejetCasse, 
          DWH_SQC_LOTS.Mep_Rej_Op_Asp LABEL='' AS RejetAspect, 
          /* RejetAutre */
            (SUM(DWH_SQC_LOTS.Mep_Rej_Op_Ebr, DWH_SQC_LOTS.Mep_Rej_Eq_Ebr, DWH_SQC_LOTS.Mep_Rej_Eq_Epais, 
            DWH_SQC_LOTS.Mep_Rej_Eq_Dim)) AS RejetAutre, 
          DWH_SQC_LOTS.Mep_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Mep_Qte_Entr LABEL='' AS MepQteEntree, 
          DWH_SQC_LOTS.Mep_Qte_Sort LABEL='' AS MepQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Mep_Date_Poste <> . AND DWH_SQC_LOTS.Groupe = 'non' AND intck('month', 
           datepart(DWH_SQC_LOTS.Mep_Date_Poste), date()) <= &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données Mep". --- */

/* --- Début du code de "Données  Textu". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_TEXTU);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_TEXTU AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('02. Texturisation') AS Etape, 
          /* OrdreTri */
            (2) AS OrdreTri, 
          DWH_SQC_LOTS.Textu_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Textu_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Textu_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Textu_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Textu_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Textu_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Textu_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Textu_Qte_Manq LABEL='' AS Manque, 
          /* RejetCasse */
            (SUM(DWH_SQC_LOTS.Textu_Rej_Eq_Casse, DWH_SQC_LOTS.Textu_Rej_Op_Casse)) AS RejetCasse, 
          DWH_SQC_LOTS.Textu_Rej_Op_Asp LABEL='' AS RejetAspect, 
          DWH_SQC_LOTS.Textu_Rej_Op_Ebr LABEL='' AS RejetAutre, 
          DWH_SQC_LOTS.Textu_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Textu_Qte_Entr LABEL='' AS TextuQteEntree, 
          DWH_SQC_LOTS.Textu_Qte_Sort LABEL='' AS TextuQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Textu_Date_Poste <> . AND DWH_SQC_LOTS.Groupe = 'non' AND intck('month', 
           datepart(DWH_SQC_LOTS.Textu_Date_Poste), date()) <= &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données  Textu". --- */

/* --- Début du code de "Données  Diff". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_DIFF);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_DIFF AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('03. Diffusion') AS Etape, 
          /* OrdreTri */
            (3) AS OrdreTri, 
          DWH_SQC_LOTS.Diff_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Diff_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Diff_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Diff_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Diff_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Diff_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Diff_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Diff_Qte_Manq LABEL='' AS Manque, 
          /* RejetCasse */
            (SUM(DWH_SQC_LOTS.Diff_Rej_Op_Casse, DWH_SQC_LOTS.Diff_Rej_Eq_Casse)) AS RejetCasse, 
          DWH_SQC_LOTS.Diff_Rej_Op_Asp LABEL='' AS RejetAspect, 
          DWH_SQC_LOTS.Diff_Rej_Op_Ebr LABEL='' AS RejetAutre, 
          DWH_SQC_LOTS.Diff_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Diff_Qte_Entr LABEL='' AS DiffQteEntree, 
          DWH_SQC_LOTS.Diff_Qte_Sort LABEL='' AS DiffQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Diff_Date_Poste <> . AND DWH_SQC_LOTS.Groupe = 'non' AND intck('month', 
           datepart(DWH_SQC_LOTS.Diff_Date_Poste), date()) <= &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données  Diff". --- */

/* --- Début du code de "Données  Desox". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_DESOX);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_DESOX AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('04. Desoxydation') AS Etape, 
          /* OrdreTri */
            (4) AS OrdreTri, 
          DWH_SQC_LOTS.Desox_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Desox_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Desox_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Desox_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Desox_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Desox_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Desox_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Desox_Qte_Manq LABEL='' AS Manque, 
          /* RejetCasse */
            (SUM(DWH_SQC_LOTS.Desox_Rej_Op_Casse, DWH_SQC_LOTS.Desox_Rej_Eq_Casse)) AS RejetCasse, 
          DWH_SQC_LOTS.Desox_Rej_Op_Asp LABEL='' AS RejetAspect, 
          DWH_SQC_LOTS.Desox_Rej_Op_Ebr LABEL='' AS RejetAutre, 
          DWH_SQC_LOTS.Desox_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Desox_Qte_Entr LABEL='' AS DesoxQteEntree, 
          DWH_SQC_LOTS.Desox_Qte_Sort LABEL='' AS DesoxQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Desox_Date_Poste <> . AND DWH_SQC_LOTS.Groupe = 'non' AND intck('month', 
           datepart(DWH_SQC_LOTS.Desox_Date_Poste), date()) <= &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données  Desox". --- */

/* --- Début du code de "Données  Pecvd". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_PECVD);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_PECVD AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('05. Pecvd') AS Etape, 
          /* OrdreTri */
            (5) AS OrdreTri, 
          DWH_SQC_LOTS.Pecvd_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Pecvd_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Pecvd_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Pecvd_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Pecvd_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Pecvd_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Pecvd_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Pecvd_Qte_Manq LABEL='' AS Manque, 
          /* RejetCasse */
            (SUM(DWH_SQC_LOTS.Pecvd_Rej_Op_Casse, DWH_SQC_LOTS.Pecvd_Rej_Eq_Casse)) AS RejetCasse, 
          /* RejetAspect */
            (SUM(DWH_SQC_LOTS.Pecvd_Rej_Op_Asp, DWH_SQC_LOTS.Pecvd_Rej_Eq_B_, DWH_SQC_LOTS.Pecvd_Rej_Eq_B, 
            DWH_SQC_LOTS.Pecvd_Rej_Eq_C)) AS RejetAspect, 
          /* RejetAutre */
            (DWH_SQC_LOTS.Pecvd_Rej_Op_Ebr) AS RejetAutre, 
          DWH_SQC_LOTS.Pecvd_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Pecvd_Qte_Entr LABEL='' AS PecvdQteEntree, 
          DWH_SQC_LOTS.Pecvd_Qte_Sort LABEL='' AS PecvdQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Pecvd_Date_Poste <> . AND DWH_SQC_LOTS.Groupe = 'non' AND intck('month', 
           datepart(DWH_SQC_LOTS.Pecvd_Date_Poste), date()) <= &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données  Pecvd". --- */

/* --- Début du code de "Données  Seri". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_SERI);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_SERI AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('06. Sérigraphie') AS Etape, 
          /* OrdreTri */
            (6) AS OrdreTri, 
          DWH_SQC_LOTS.Seri_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Seri_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Seri_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Seri_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Seri_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Seri_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Seri_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Serig_Qte_Manq LABEL='' AS Manque, 
          /* RejetChar */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Chgt_Ebr, DWH_SQC_LOTS.Seri_Rej_Chgt_Asp, DWH_SQC_LOTS.Seri_Rej_Chgt_Casse)) AS 
            RejetChar, 
          /* RejetStation1 */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Station_1_Ebr, DWH_SQC_LOTS.Seri_Rej_Station_1_Asp, 
            DWH_SQC_LOTS.Seri_Rej_Station_1_Casse, DWH_SQC_LOTS.Seri_Rej_Eq_Vision1,  DWH_SQC_LOTS.Seri_Rej_Eq_Manq1)) 
            AS RejetStation1, 
          /* RejetStation2 */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Station_2_Ebr, DWH_SQC_LOTS.Seri_Rej_Station_2_Asp, 
             DWH_SQC_LOTS.Seri_Rej_Station_2_Casse, DWH_SQC_LOTS.Seri_Rej_Eq_Vision2, DWH_SQC_LOTS.Seri_Rej_Eq_Manq2)) 
            AS RejetStation2, 
          /* RejetStation3 */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Station_3_Ebr, DWH_SQC_LOTS.Seri_Rej_Station_3_Asp, 
            DWH_SQC_LOTS.Seri_Rej_Station_3_Casse, DWH_SQC_LOTS.Seri_Rej_Eq_Vision3,  DWH_SQC_LOTS.Seri_Rej_Eq_Manq3)) 
            AS RejetStation3, 
          /* RejetStation4 */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Station_4_Ebr, DWH_SQC_LOTS.Seri_Rej_Station_4_Asp, 
            DWH_SQC_LOTS.Seri_Rej_Station_4_Casse)) AS RejetStation4, 
          /* RejetDechar */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Dechgt_Ebr, DWH_SQC_LOTS.Seri_Rej_Dechgt_Asp, 
            DWH_SQC_LOTS.Seri_Rej_Dechgt_Casse)) AS RejetDechar, 
          /* RejetOperateur */
            (SUM(DWH_SQC_LOTS.Seri_Rej_Op_Ebr, DWH_SQC_LOTS.Seri_Rej_Op_Asp, DWH_SQC_LOTS.Seri_Rej_Op_Casse, 
            DWH_SQC_LOTS.Seri_Rej_Op_GradeB)) AS RejetOperateur, 
          DWH_SQC_LOTS.Seri_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Seri_Qte_Entr LABEL='' AS SeriQteEntree, 
          DWH_SQC_LOTS.Seri_Qte_Sort LABEL='' AS SeriQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Seri_Date_Poste <> . AND intck('month', datepart(DWH_SQC_LOTS.Seri_Date_Poste), date()) <= 
           &Historique_nb_mois;
QUIT;
/* --- Fin du code de "Données  Seri". --- */

/* --- Début du code de "Données  Tri ". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_TRI);

PROC SQL;
   CREATE VIEW WORK.EXT_LOTS_TRI AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Lot LABEL='', 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          DWH_SQC_LOTS.Format, 
          /* Etape */
            ('07. Tri') AS Etape, 
          /* OrdreTri */
            (7) AS OrdreTri, 
          DWH_SQC_LOTS.Tri_Date_Poste LABEL='' AS Date, 
          DWH_SQC_LOTS.Tri_Equipement LABEL='' AS Equipement, 
          DWH_SQC_LOTS.Tri_Poste LABEL='' AS Poste, 
          DWH_SQC_LOTS.Tri_Equipe LABEL='' AS Equipe, 
          DWH_SQC_LOTS.Tri_Qte_Entr LABEL='' AS QteEntree, 
          DWH_SQC_LOTS.Tri_Qte_Sort LABEL='' AS QteSortie, 
          DWH_SQC_LOTS.Tri_Rej_Total LABEL='' AS Rejet, 
          DWH_SQC_LOTS.Tri_Qte_Manq LABEL='' AS Manque, 
          /* RejetCasse */
            (SUM(DWH_SQC_LOTS.Tri_Rej_Op_Casse, DWH_SQC_LOTS.Tri_Rej_Ep_Casse)) AS RejetCasse, 
          /* RejetAspect */
            (SUM(DWH_SQC_LOTS.Tri_Rej_Op_Asp, DWH_SQC_LOTS.Tri_Rej_Op_GradeB)) AS RejetAspect, 
          /* Rejet Micro-crack - Ajout 16/09/2014 */
			 DWH_SQC_LOTS.Tri_Rej_Eq_Meca_MC As RejetMicroCrack,
			 DWH_SQC_LOTS.Tri_Rej_Op_Ebr LABEL='' AS RejetAutre, 
          DWH_SQC_LOTS.Tri_Obs LABEL='' AS Observations, 
          DWH_SQC_LOTS.DateHeureSAS, 
          DWH_SQC_LOTS.Tri_Qte_Entr LABEL='' AS TriQteEntree, 
          DWH_SQC_LOTS.Tri_Qte_Sort LABEL='' AS TriQteSortie
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Tri_Date_Poste <> . AND intck('month', datepart(DWH_SQC_LOTS.Tri_Date_Poste), date()) <= 
           &Historique_nb_mois
      ORDER BY DWH_SQC_LOTS.Tri_Date_Poste DESC,
               DWH_SQC_LOTS.Lot;
QUIT;
/* --- Fin du code de "Données  Tri ". --- */

/* --- Début du code de "Données Stock av Textu". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_TEXTU);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_TEXTU AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ("02. Texturisation") AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Mep_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'MeP - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Textu". --- */

/* --- Début du code de "Données Stock av Diff". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_DIFF);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_DIFF AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ("03. Diffusion") AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Textu_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'Textu - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Diff". --- */

/* --- Début du code de "Données Stock av Desox". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_DESOX);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_DESOX AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ('04. Desoxydation') AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Diff_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'Diffu - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Desox". --- */

/* --- Début du code de "Données Stock av Pecvd". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_PECVD);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_PECVD AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ('05. Pecvd') AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Diff_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'Desox - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Pecvd". --- */

/* --- Début du code de "Données Stock av Seri". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_SERI);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_SERI AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ('06. Sérigraphie') AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Pecvd_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'Pecvd - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Seri". --- */

/* --- Début du code de "Données Stock av Tri". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_TRI);

PROC SQL;
   CREATE VIEW WORK.EXT_STOCK_AV_TRI AS 
   SELECT DWH_SQC_LOTS.Societe, 
          DWH_SQC_LOTS.Format, 
          DWH_SQC_LOTS.Materiau, 
		  DWH_SQC_LOTS.Fournisseur,
          /* Etape */
            ('07. Tri') AS Etape, 
          /* Stock */
            (SUM(DWH_SQC_LOTS.Seri_Qte_Sort)) AS Stock
      FROM DS_DWH.DWH_SQC_LOTS DWH_SQC_LOTS
      WHERE DWH_SQC_LOTS.Statut = 'Serig - Terminé S'
      GROUP BY DWH_SQC_LOTS.Societe,
               DWH_SQC_LOTS.Format,
               DWH_SQC_LOTS.Materiau,
			   DWH_SQC_LOTS.Fournisseur;
QUIT;
/* --- Fin du code de "Données Stock av Tri". --- */

/* --- Début du code de "Ajouter une table". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_ETAPE);
PROC SQL;
CREATE TABLE WORK.EXT_STOCK_AV_ETAPE AS 
SELECT * FROM WORK.EXT_STOCK_AV_TEXTU
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_DIFF
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_DESOX
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_PECVD
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_SERI
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_TRI
;
Quit;

/* --- Fin du code de "Ajouter une table". --- */

/* --- Début du code de "Code Poste". --- */
data work.Poste_courant;

	format Date ddmmyy8.;
	format Date_000000 datetime22.3; /* Format de date les jointure avec les datetime de SQL Server. */
	format Poste $5.;
	
	Date = date();
	Date_000000 = dhms(Date(), 0, 0, 0); 

	if weekday(Date) in (2 ,3, 4, 5, 6) then do;
		if time() >= '21:00't then do;
			Poste = 'N';
			Poste_ordre_tri = 3;
			output;
			end;
			else do;
			if time() >= '13:00't then do;
				Poste = 'S';
				Poste_ordre_tri = 2;
				output;
				end;
				else do;
				if time() >= '5:00't then do;
					Poste = 'M';
					Poste_ordre_tri = 1;
					output;
				end;	
			end;
		end;
	end;
	else do;	
		if time() >= '5:00't then do;
			Poste = 'WE M';
			Poste_ordre_tri = 4;
			output;
			end;
			else do;
			if time() >= '17:00't then do;
				Poste = 'WE N';
				Poste_ordre_tri = 5;
				output;
			end;
		end;
	end;

run;
/* --- Fin du code de "Code Poste". --- */

/* --- Début du code de "Requête pour EXT_STOCK_AV_ETAPE". --- */
%_eg_conditional_dropds(WORK.EXT_STOCK_AV_ETAPE_2);

PROC SQL;
   CREATE TABLE WORK.EXT_STOCK_AV_ETAPE_2 AS 
   SELECT POSTE_COURANT.Date_000000 AS Date, 
          POSTE_COURANT.Poste, 
          POSTE_COURANT.Poste_ordre_tri, 
          EXT_STOCK_AV_ETAPE.Societe, 
          EXT_STOCK_AV_ETAPE.Format, 
          EXT_STOCK_AV_ETAPE.Materiau, 
		  EXT_STOCK_AV_ETAPE.Fournisseur,
          /* Lot */
            ('STOCK AVANT') AS Lot, 
          EXT_STOCK_AV_ETAPE.Etape, 
          EXT_STOCK_AV_ETAPE.Stock AS QteStock
      FROM WORK.EXT_STOCK_AV_ETAPE EXT_STOCK_AV_ETAPE,WORK.POSTE_COURANT POSTE_COURANT;
QUIT;
/* --- Fin du code de "Requête pour EXT_STOCK_AV_ETAPE". --- */

/* --- Début du code de "Ajouter une table". --- */
%_eg_conditional_dropds(WORK.EXT_LOTS_ETAPES);
PROC SQL;
CREATE TABLE WORK.EXT_LOTS_ETAPES AS 
SELECT * FROM WORK.EXT_LOTS_MEP
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_DESOX
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_DIFF
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_PECVD
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_SERI
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_TEXTU
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_LOTS_TRI
 OUTER UNION CORR 
SELECT * FROM WORK.EXT_STOCK_AV_ETAPE_2
;
Quit;

/* --- Fin du code de "Ajouter une table". --- */

/* --- Début du code de "Mise en forme". --- */
%_eg_conditional_dropds(WORK.SORTIE);

PROC SQL;
   CREATE TABLE WORK.SORTIE AS 
   SELECT PLANNING_TYPE_SI.Societe FORMAT=$20. AS Societe, 
          EXT_LOTS_ETAPES.Lot FORMAT=$50., 
          PLANNING_TYPE_SI.Type_silicium FORMAT=$20. AS TypeSilicium, 
		  EXT_LOTS_ETAPES.Fournisseur AS Fournisseur,
          EXT_LOTS_ETAPES.Format FORMAT=12. LABEL='' AS Format, 
          PLANNING_TYPE_SI.Etape FORMAT=$50. AS Etape, 
          /* Date */
            (dhms(PLANNING_TYPE_SI.Date_poste, 0,0,0)
            ) FORMAT=datetime22.3 LABEL="Date" AS Date, 
          /* Annee */
            (YEAR(PLANNING_TYPE_SI.Date_poste)) AS Annee, 
          /* Trimestre */
            (PUT(YEAR(PLANNING_TYPE_SI.Date_poste), 4.)||'Q'||PUT(QTR(PLANNING_TYPE_SI.Date_poste), 1.)) FORMAT=$6. AS 
            Trimestre, 
          /* Mois */
            (PUT(YEAR(PLANNING_TYPE_SI.Date_poste), 4.)||'M'||PUT(MONTH(PLANNING_TYPE_SI.Date_poste), z2.)) FORMAT=$7. 
            AS Mois, 
          /* Semaine */
            (PUT(YEAR(PLANNING_TYPE_SI.Date_poste), 4.)||'S'||PUT(WEEK(PLANNING_TYPE_SI.Date_poste, 'V'), z2.)) 
            FORMAT=$7. AS Semaine, 
          EXT_LOTS_ETAPES.Equipement FORMAT=$50., 
          PLANNING_TYPE_SI.Poste FORMAT=$5., 
          PLANNING_TYPE_SI.Poste_ordre_tri AS PosteOrdreTri, 
          EXT_LOTS_ETAPES.Equipe, 
          EXT_LOTS_ETAPES.Observations FORMAT=$255., 
          EXT_LOTS_ETAPES.QteStock, 
          EXT_LOTS_ETAPES.QteEntree, 
          EXT_LOTS_ETAPES.QteSortie, 
          EXT_LOTS_ETAPES.Rejet, 
          EXT_LOTS_ETAPES.Manque, 
          EXT_LOTS_ETAPES.RejetCasse, 
          EXT_LOTS_ETAPES.RejetAspect, 
          EXT_LOTS_ETAPES.RejetAutre, 
          EXT_LOTS_ETAPES.RejetChar, 
          EXT_LOTS_ETAPES.RejetStation1, 
          EXT_LOTS_ETAPES.RejetStation2, 
          EXT_LOTS_ETAPES.RejetStation3, 
          EXT_LOTS_ETAPES.RejetStation4, 
          EXT_LOTS_ETAPES.RejetDechar, 
          EXT_LOTS_ETAPES.RejetOperateur, 
			 EXT_LOTS_ETAPES.RejetMicroCrack,
          EXT_LOTS_ETAPES.MepQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.MepQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.TextuQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.TextuQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.DiffQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.DiffQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.DesoxQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.DesoxQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.PecvdQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.PecvdQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.SeriQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.SeriQteSortie FORMAT=12., 
          EXT_LOTS_ETAPES.TriQteEntree FORMAT=12., 
          EXT_LOTS_ETAPES.TriQteSortie FORMAT=12., 
          /* DateHeureSAS */
            (MIN(EXT_LOTS_ETAPES.DateHeureSAS)) FORMAT=DATETIME22.3 LABEL="Date Heure SAS" AS DateHeureSAS
      FROM WORK.PLANNING_TYPE_SI PLANNING_TYPE_SI
           LEFT JOIN WORK.EXT_LOTS_ETAPES EXT_LOTS_ETAPES ON (PLANNING_TYPE_SI.Poste = EXT_LOTS_ETAPES.Poste) 
				AND  (PLANNING_TYPE_SI.Type_silicium = EXT_LOTS_ETAPES.Materiau) 
            AND (PLANNING_TYPE_SI.Societe = EXT_LOTS_ETAPES.Societe) AND (PLANNING_TYPE_SI.Date_poste_000000 = EXT_LOTS_ETAPES.Date) AND 
          (PLANNING_TYPE_SI.Etape = EXT_LOTS_ETAPES.Etape)
      ORDER BY PLANNING_TYPE_SI.Date_poste_000000 DESC,
               PLANNING_TYPE_SI.Poste_ordre_tri DESC,
               PLANNING_TYPE_SI.Etape;
QUIT;
/* --- Fin du code de "Mise en forme". --- */

* Début du code EG généré (ne pas modifier cette ligne);
;*';*";*/;quit;/*
%STPEND;*

* Fin du code EG généré (ne pas modifier cette ligne);
%rcSet(&syserr); 
%rcSet(&sqlrc); 


/**  Step end app stockée **/
/*---- Fin du code écrit par l'utilisateur  ----*/ 

/*==========================================================================* 
 * Etape :                   Chargeur de tables           A51VJW1Q.BV00068A * 
 * Transformation :          Chargeur de tables (Version 2.1)               * 
 * Description :                                                            * 
 *                                                                          * 
 * Table source :            Ecrit par l'utilisateur -    A51VJW1Q.BS0002LE * 
 *                            work.SORTIE                                   * 
 * Table cible :             DTM_PRO_TBO_PVA -            A51VJW1Q.BH0000HX * 
 *                            DTM_PRO.DTM_PRO_TBO_PVA                       * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV00068A);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

%let SYSLAST = %nrquote(work.SORTIE); 

%let SYS_SQL_IP_SPEEDO = Y;
%let SYS_SQL_MAPPUTTO = sas_put;
%let SYS_SQLREDUCEPUT = DBMS;
%global etls_sql_pushDown;
%let etls_sql_pushDown = -1;
option DBIDIRECTEXEC;

%global etls_tableExist;
%global etls_numIndex;
%global etls_lastTable;
%let etls_tableExist = -1; 
%let etls_numIndex = -1; 
%let etls_lastTable = &SYSLAST; 

/*---- Define load data macro  ----*/ 

/* --------------------------------------------------------------
   Load Technique Selection: Replace - EntireTable
   Constraint and index action selections: 'ASIS','ASIS','ASIS','ASIS'
   Additional options selections... 
      Set unmapped to missing on updates: false 
   -------------------------------------------------------------- */
%macro etls_loader;

   %let etls_tableOptions = ;
   
   /* Determine if the target table exists  */ 
   %let etls_tableExist = %eval(%sysfunc(exist(DTM_PRO.DTM_PRO_TBO_PVA, DATA)) or 
         %sysfunc(exist(DTM_PRO.DTM_PRO_TBO_PVA, VIEW))); 
   
   %if &etls_tableExist %then 
   %do;/* table exists  */ 
      %let etls_hasPreExistingConstraint=0; 
      
      proc datasets lib = work nolist nowarn memtype = (data view);
         delete etls_commands etls_commands_F;
      quit;
      
      %let etls_otherTablesReferToThisTable=0;
      
      %macro etls_CIContents(table=,workTableOut=,inDSOptions=);
         %put NOTE: Building table listing Constraints and Indexes for: &table;
         proc datasets lib=work nolist; delete &workTableOut; quit;
         proc contents data=&table&inDSOptions out2=&workTableOut noprint; run;
         
         data &workTableOut;
            length name $60 type $20 icown idxUnique idxNoMiss $3 recreate $600;
            set &workTableOut;
            type=upcase(type);
            if type eq 'REFERENTIAL' then
            do;
               put "WARNING%QUOTE(:) La table cible est référencée par les contraintes"
                    " d'une autre table : " ref;
               call symput('etls_otherTablesReferToThisTable','1');
               delete;
            end;
            if type='INDEX' and ICOwn eq 'YES' then delete;
         run;
         %rcSet(&syserr); 
         
      %mend etls_CIContents;
      
      %etls_CIContents(table=DTM_PRO.DTM_PRO_TBO_PVA, workTableOut=etls_commands, inDSOptions=);
      
      %if &etls_otherTablesReferToThisTable %then 
         %put WARNING%QUOTE(:) Replacing entire table will fail. Consider an alternate load technique or revising constraints.; 
      %else 
      %do; /* okay - remove foreign keys  */ 
      
         data etls_commands_F; 
            set etls_commands; 
            if upcase(type)="FOREIGN KEY" then 
            do; 
               command='ic delete '||trim(name)||';';
               output etls_commands_F; 
            end; 
         run; 
         
         %put %str(NOTE: Removing foreign keys before dropping table...);
         data _null_;
            set etls_commands_F;
            %rcSet(&syserr); 
            
      %end; /* okay - remove foreign keys  */ 
      
      proc datasets lib = work nolist nowarn memtype = (data view);
         delete etls_commands etls_commands_F;
      quit;
      
      /*---- Drop a table  ----*/ 
      %put %str(NOTE: Dropping table ...);
      proc datasets lib = DTM_PRO nolist nowarn memtype = (data view);
         delete DTM_PRO_TBO_PVA;
      quit;
      
      %rcSet(&syserr); 
      
      %let etls_tableExist = 0;
      
   %end; /* table exists  */ 
   
   /*---- Create a new table  ----*/ 
   %if (&etls_tableExist eq 0) %then 
   %do;  /* if table does not exist  */ 
   
      %put %str(NOTE: Creating table ...);
      
      data DTM_PRO.DTM_PRO_TBO_PVA;
         attrib Societe length = $20
            format = $20.
            informat = $20.
            label = 'Societe'; 
         attrib Lot length = $50
            format = $50.
            informat = $50.
            label = 'Lot'; 
         attrib TypeSilicium length = $20
            format = $20.
            informat = $20.
            label = 'TypeSilicium'; 
         attrib Format length = 8
            format = 12.
            informat = 12.
            label = 'Format'; 
         attrib Fournisseur length = $50
            format = $50.
            informat = $50.
            label = 'Fournisseur'; 
         attrib Etape length = $50
            format = $50.
            informat = $50.
            label = 'Etape'; 
         attrib Date length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Date'; 
         attrib Annee length = 8
            label = 'Annee'; 
         attrib Trimestre length = $6
            format = $6.
            informat = $6.
            label = 'Trimestre'; 
         attrib Mois length = $7
            format = $7.
            informat = $7.
            label = 'Mois'; 
         attrib Semaine length = $7
            format = $7.
            informat = $7.
            label = 'Semaine'; 
         attrib Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Equipement'; 
         attrib Poste length = $5
            format = $5.
            informat = $5.
            label = 'Poste'; 
         attrib PosteOrdreTri length = 8
            label = 'PosteOrdreTri'; 
         attrib Equipe length = 8
            label = 'Equipe'; 
         attrib Observations length = $255
            format = $255.
            informat = $255.
            label = 'Observations'; 
         attrib QteStock length = 8
            label = 'QteStock'; 
         attrib QteEntree length = 8
            label = 'QteEntree'; 
         attrib QteSortie length = 8
            label = 'QteSortie'; 
         attrib Rejet length = 8
            label = 'Rejet'; 
         attrib Manque length = 8
            label = 'Manque'; 
         attrib RejetCasse length = 8
            label = 'RejetCasse'; 
         attrib RejetAspect length = 8
            label = 'RejetAspect'; 
         attrib RejetAutre length = 8
            label = 'RejetAutre'; 
         attrib RejetChar length = 8
            label = 'RejetChar'; 
         attrib RejetStation1 length = 8
            label = 'RejetStation1'; 
         attrib RejetStation2 length = 8
            label = 'RejetStation2'; 
         attrib RejetStation3 length = 8
            label = 'RejetStation3'; 
         attrib RejetStation4 length = 8
            label = 'RejetStation4'; 
         attrib RejetDechar length = 8
            label = 'RejetDechar'; 
         attrib RejetOperateur length = 8
            label = 'RejetOperateur'; 
         attrib RejetMicroCrack length = 8
            label = 'RejetMicroCrack'; 
         attrib MepQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'MepQteEntree'; 
         attrib MepQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'MepQteSortie'; 
         attrib TextuQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'TextuQteEntree'; 
         attrib TextuQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'TextuQteSortie'; 
         attrib DiffQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'DiffQteEntree'; 
         attrib DiffQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'DiffQteSortie'; 
         attrib DesoxQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'DesoxQteEntree'; 
         attrib DesoxQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'DesoxQteSortie'; 
         attrib PecvdQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'PecvdQteEntree'; 
         attrib PecvdQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'PecvdQteSortie'; 
         attrib SeriQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'SeriQteEntree'; 
         attrib SeriQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'SeriQteSortie'; 
         attrib TriQteEntree length = 8
            format = 12.
            informat = 12.
            label = 'TriQteEntree'; 
         attrib TriQteSortie length = 8
            format = 12.
            informat = 12.
            label = 'TriQteSortie'; 
         attrib DateHeureSAS length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'DateHeureSAS'; 
         call missing(of _all_);
         stop;
      run;
      
      %rcSet(&syserr); 
      
   %end;  /* if table does not exist  */ 
   
   /*---- Append  ----*/ 
   %put %str(NOTE: Appending data ...);
   
   proc append base = DTM_PRO.DTM_PRO_TBO_PVA 
      data = &etls_lastTable (&etls_tableOptions)  force ; 
    run; 
   
   %rcSet(&syserr); 
   
%mend etls_loader;
%etls_loader;



/**  Step end Chargeur de tables **/

/*==========================================================================* 
 * Etape :                   Chargeur de tables           A51VJW1Q.BV00068B * 
 * Transformation :          Chargeur de tables (Version 2.1)               * 
 * Description :                                                            * 
 *                                                                          * 
 * Table source :            VUE_METIER_MESURES -         A51VJW1Q.BH0000HH * 
 *                            DS_SQC.VUE_METIER_MESURES                     * 
 * Table cible :             CARTE_CONTROLE -             A51VJW1Q.BH0000K7 * 
 *                            DTM_PRO.CARTE_CONTROLE                        * 
 *==========================================================================*
 *                                                                          * 
 * Rien ne sera généré pour ce processus car l'option "Exclure la           * 
 *  transformation de l'exécution" est sélectionnée.                        * 
 *                                                                          * 
 *==========================================================================*/ 

/*==========================================================================* 
 * Etape :                   Ecrit par l'utilisateur      A51VJW1Q.BV000691 * 
 * Transformation :          Ecrit par l'utilisateur                        * 
 * Description :                                                            * 
 *                                                                          * 
 * Table cible :             Ecrit par l'utilisateur -    A51VJW1Q.BS0002M5 * 
 *                            work.W6H9QJPR                                 * 
 *                                                                          * 
 * Ecrit par l'utilisateur : CodeSource                                     * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV000691);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

%let _INPUT_count = 0;
%let _OUTPUT_count = 1;
%let _OUTPUT = work.W6H9QJPR;
%let _OUTPUT_connect = ;
%let _OUTPUT_engine = ;
%let _OUTPUT_memtype = DATA;
%let _OUTPUT_options = %nrquote();
%let _OUTPUT_alter = %nrquote();
%let _OUTPUT_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0002M5%(WorkTable%));
%let _OUTPUT_type = 1;
%let _OUTPUT_label = %nrquote();
/* Liste des colonnes cibles à conserver  */ 
%let _OUTPUT_keep = Soci_t_ Produit Equipement Carte_de_contr_le Mesure_Type 
        Mesure_Date_Poste Mesure_Date_Heure Mesure_Date Mesure_Jour 
        Mesure_Heure Mesure_Op_rateur Mesure_Equipe Mesure_Poste 
        Mesure_Observation Valeur_Minimale_D_rogation Valeur_Minimale_Critique 
        Valeur_mesur_e Valeur_Maximale_Critique Valeur_Maximale_D_rogation 
        D_rogation_Code D_rogation_Date_D_but D_rogation_Date_Fin 
        D_rogation_Commentaire;
%let _OUTPUT_col_count = 23;
%let _OUTPUT_col0_name = Soci_t_;
%let _OUTPUT_col0_table = work.W6H9QJPR;
%let _OUTPUT_col0_length = 11;
%let _OUTPUT_col0_type = $;
%let _OUTPUT_col0_format = $11.;
%let _OUTPUT_col0_informat = $11.;
%let _OUTPUT_col0_label = %nrquote(Société);
%let _OUTPUT_col0_exp = ;
%let _OUTPUT_col0_input_count = 0;
%let _OUTPUT_col1_name = Produit;
%let _OUTPUT_col1_table = work.W6H9QJPR;
%let _OUTPUT_col1_length = 255;
%let _OUTPUT_col1_type = $;
%let _OUTPUT_col1_format = $255.;
%let _OUTPUT_col1_informat = $255.;
%let _OUTPUT_col1_label = %nrquote(Produit);
%let _OUTPUT_col1_exp = ;
%let _OUTPUT_col1_input_count = 0;
%let _OUTPUT_col2_name = Equipement;
%let _OUTPUT_col2_table = work.W6H9QJPR;
%let _OUTPUT_col2_length = 50;
%let _OUTPUT_col2_type = $;
%let _OUTPUT_col2_format = $50.;
%let _OUTPUT_col2_informat = $50.;
%let _OUTPUT_col2_label = %nrquote(Equipement);
%let _OUTPUT_col2_exp = ;
%let _OUTPUT_col2_input_count = 0;
%let _OUTPUT_col3_name = Carte_de_contr_le;
%let _OUTPUT_col3_table = work.W6H9QJPR;
%let _OUTPUT_col3_length = 255;
%let _OUTPUT_col3_type = $;
%let _OUTPUT_col3_format = $255.;
%let _OUTPUT_col3_informat = $255.;
%let _OUTPUT_col3_label = %nrquote(Carte de contrôle);
%let _OUTPUT_col3_exp = ;
%let _OUTPUT_col3_input_count = 0;
%let _OUTPUT_col4_name = Mesure_Type;
%let _OUTPUT_col4_table = work.W6H9QJPR;
%let _OUTPUT_col4_length = 255;
%let _OUTPUT_col4_type = $;
%let _OUTPUT_col4_format = $255.;
%let _OUTPUT_col4_informat = $255.;
%let _OUTPUT_col4_label = %nrquote(Mesure Type);
%let _OUTPUT_col4_exp = ;
%let _OUTPUT_col4_input_count = 0;
%let _OUTPUT_col5_name = Mesure_Date_Poste;
%let _OUTPUT_col5_table = work.W6H9QJPR;
%let _OUTPUT_col5_length = 8;
%let _OUTPUT_col5_type = ;
%let _OUTPUT_col5_format = DATETIME22.3;
%let _OUTPUT_col5_informat = DATETIME22.3;
%let _OUTPUT_col5_label = %nrquote(Mesure Date Poste);
%let _OUTPUT_col5_exp = ;
%let _OUTPUT_col5_input_count = 0;
%let _OUTPUT_col6_name = Mesure_Date_Heure;
%let _OUTPUT_col6_table = work.W6H9QJPR;
%let _OUTPUT_col6_length = 8;
%let _OUTPUT_col6_type = ;
%let _OUTPUT_col6_format = DATETIME22.3;
%let _OUTPUT_col6_informat = DATETIME22.3;
%let _OUTPUT_col6_label = %nrquote(Mesure Date Heure);
%let _OUTPUT_col6_exp = ;
%let _OUTPUT_col6_input_count = 0;
%let _OUTPUT_col7_name = Mesure_Date;
%let _OUTPUT_col7_table = work.W6H9QJPR;
%let _OUTPUT_col7_length = 8;
%let _OUTPUT_col7_type = ;
%let _OUTPUT_col7_format = DATETIME22.3;
%let _OUTPUT_col7_informat = DATETIME22.3;
%let _OUTPUT_col7_label = %nrquote(Mesure Date);
%let _OUTPUT_col7_exp = ;
%let _OUTPUT_col7_input_count = 0;
%let _OUTPUT_col8_name = Mesure_Jour;
%let _OUTPUT_col8_table = work.W6H9QJPR;
%let _OUTPUT_col8_length = 30;
%let _OUTPUT_col8_type = $;
%let _OUTPUT_col8_format = $30.;
%let _OUTPUT_col8_informat = $30.;
%let _OUTPUT_col8_label = %nrquote(Mesure Jour);
%let _OUTPUT_col8_exp = ;
%let _OUTPUT_col8_input_count = 0;
%let _OUTPUT_col9_name = Mesure_Heure;
%let _OUTPUT_col9_table = work.W6H9QJPR;
%let _OUTPUT_col9_length = 8;
%let _OUTPUT_col9_type = ;
%let _OUTPUT_col9_format = DATETIME22.3;
%let _OUTPUT_col9_informat = DATETIME22.3;
%let _OUTPUT_col9_label = %nrquote(Mesure Heure);
%let _OUTPUT_col9_exp = ;
%let _OUTPUT_col9_input_count = 0;
%let _OUTPUT_col10_name = Mesure_Op_rateur;
%let _OUTPUT_col10_table = work.W6H9QJPR;
%let _OUTPUT_col10_length = 5;
%let _OUTPUT_col10_type = $;
%let _OUTPUT_col10_format = $5.;
%let _OUTPUT_col10_informat = $5.;
%let _OUTPUT_col10_label = %nrquote(Mesure Opérateur);
%let _OUTPUT_col10_exp = ;
%let _OUTPUT_col10_input_count = 0;
%let _OUTPUT_col11_name = Mesure_Equipe;
%let _OUTPUT_col11_table = work.W6H9QJPR;
%let _OUTPUT_col11_length = 10;
%let _OUTPUT_col11_type = $;
%let _OUTPUT_col11_format = $10.;
%let _OUTPUT_col11_informat = $10.;
%let _OUTPUT_col11_label = %nrquote(Mesure Equipe);
%let _OUTPUT_col11_exp = ;
%let _OUTPUT_col11_input_count = 0;
%let _OUTPUT_col12_name = Mesure_Poste;
%let _OUTPUT_col12_table = work.W6H9QJPR;
%let _OUTPUT_col12_length = 10;
%let _OUTPUT_col12_type = $;
%let _OUTPUT_col12_format = $10.;
%let _OUTPUT_col12_informat = $10.;
%let _OUTPUT_col12_label = %nrquote(Mesure Poste);
%let _OUTPUT_col12_exp = ;
%let _OUTPUT_col12_input_count = 0;
%let _OUTPUT_col13_name = Mesure_Observation;
%let _OUTPUT_col13_table = work.W6H9QJPR;
%let _OUTPUT_col13_length = 1024;
%let _OUTPUT_col13_type = $;
%let _OUTPUT_col13_format = $1024.;
%let _OUTPUT_col13_informat = $1024.;
%let _OUTPUT_col13_label = %nrquote(Mesure Observation);
%let _OUTPUT_col13_exp = ;
%let _OUTPUT_col13_input_count = 0;
%let _OUTPUT_col14_name = Valeur_Minimale_D_rogation;
%let _OUTPUT_col14_table = work.W6H9QJPR;
%let _OUTPUT_col14_length = 8;
%let _OUTPUT_col14_type = ;
%let _OUTPUT_col14_format = ;
%let _OUTPUT_col14_informat = ;
%let _OUTPUT_col14_label = %nrquote(Valeur Minimale Dérogation);
%let _OUTPUT_col14_exp = ;
%let _OUTPUT_col14_input_count = 0;
%let _OUTPUT_col15_name = Valeur_Minimale_Critique;
%let _OUTPUT_col15_table = work.W6H9QJPR;
%let _OUTPUT_col15_length = 8;
%let _OUTPUT_col15_type = ;
%let _OUTPUT_col15_format = ;
%let _OUTPUT_col15_informat = ;
%let _OUTPUT_col15_label = %nrquote(Valeur Minimale Critique);
%let _OUTPUT_col15_exp = ;
%let _OUTPUT_col15_input_count = 0;
%let _OUTPUT_col16_name = Valeur_mesur_e;
%let _OUTPUT_col16_table = work.W6H9QJPR;
%let _OUTPUT_col16_length = 8;
%let _OUTPUT_col16_type = ;
%let _OUTPUT_col16_format = ;
%let _OUTPUT_col16_informat = ;
%let _OUTPUT_col16_label = %nrquote(Valeur mesurée);
%let _OUTPUT_col16_exp = ;
%let _OUTPUT_col16_input_count = 0;
%let _OUTPUT_col17_name = Valeur_Maximale_Critique;
%let _OUTPUT_col17_table = work.W6H9QJPR;
%let _OUTPUT_col17_length = 8;
%let _OUTPUT_col17_type = ;
%let _OUTPUT_col17_format = ;
%let _OUTPUT_col17_informat = ;
%let _OUTPUT_col17_label = %nrquote(Valeur Maximale Critique);
%let _OUTPUT_col17_exp = ;
%let _OUTPUT_col17_input_count = 0;
%let _OUTPUT_col18_name = Valeur_Maximale_D_rogation;
%let _OUTPUT_col18_table = work.W6H9QJPR;
%let _OUTPUT_col18_length = 8;
%let _OUTPUT_col18_type = ;
%let _OUTPUT_col18_format = ;
%let _OUTPUT_col18_informat = ;
%let _OUTPUT_col18_label = %nrquote(Valeur Maximale Dérogation);
%let _OUTPUT_col18_exp = ;
%let _OUTPUT_col18_input_count = 0;
%let _OUTPUT_col19_name = D_rogation_Code;
%let _OUTPUT_col19_table = work.W6H9QJPR;
%let _OUTPUT_col19_length = 20;
%let _OUTPUT_col19_type = $;
%let _OUTPUT_col19_format = $20.;
%let _OUTPUT_col19_informat = $20.;
%let _OUTPUT_col19_label = %nrquote(Dérogation Code);
%let _OUTPUT_col19_exp = ;
%let _OUTPUT_col19_input_count = 0;
%let _OUTPUT_col20_name = D_rogation_Date_D_but;
%let _OUTPUT_col20_table = work.W6H9QJPR;
%let _OUTPUT_col20_length = 8;
%let _OUTPUT_col20_type = ;
%let _OUTPUT_col20_format = DATETIME22.3;
%let _OUTPUT_col20_informat = DATETIME22.3;
%let _OUTPUT_col20_label = %nrquote(Dérogation Date Début);
%let _OUTPUT_col20_exp = ;
%let _OUTPUT_col20_input_count = 0;
%let _OUTPUT_col21_name = D_rogation_Date_Fin;
%let _OUTPUT_col21_table = work.W6H9QJPR;
%let _OUTPUT_col21_length = 8;
%let _OUTPUT_col21_type = ;
%let _OUTPUT_col21_format = DATETIME22.3;
%let _OUTPUT_col21_informat = DATETIME22.3;
%let _OUTPUT_col21_label = %nrquote(Dérogation Date Fin);
%let _OUTPUT_col21_exp = ;
%let _OUTPUT_col21_input_count = 0;
%let _OUTPUT_col22_name = D_rogation_Commentaire;
%let _OUTPUT_col22_table = work.W6H9QJPR;
%let _OUTPUT_col22_length = 1024;
%let _OUTPUT_col22_type = $;
%let _OUTPUT_col22_format = $1024.;
%let _OUTPUT_col22_informat = $1024.;
%let _OUTPUT_col22_label = %nrquote(Dérogation Commentaire);
%let _OUTPUT_col22_exp = ;
%let _OUTPUT_col22_input_count = 0;

%let _OUTPUT1 = work.W6H9QJPR;
%let _OUTPUT1_connect = ;
%let _OUTPUT1_engine = ;
%let _OUTPUT1_memtype = DATA;
%let _OUTPUT1_options = %nrquote();
%let _OUTPUT1_alter = %nrquote();
%let _OUTPUT1_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0002M5%(WorkTable%));
%let _OUTPUT1_type = 1;
%let _OUTPUT1_label = %nrquote();
/* Liste des colonnes cibles à conserver  */ 
%let _OUTPUT1_keep = Soci_t_ Produit Equipement Carte_de_contr_le Mesure_Type 
        Mesure_Date_Poste Mesure_Date_Heure Mesure_Date Mesure_Jour 
        Mesure_Heure Mesure_Op_rateur Mesure_Equipe Mesure_Poste 
        Mesure_Observation Valeur_Minimale_D_rogation Valeur_Minimale_Critique 
        Valeur_mesur_e Valeur_Maximale_Critique Valeur_Maximale_D_rogation 
        D_rogation_Code D_rogation_Date_D_but D_rogation_Date_Fin 
        D_rogation_Commentaire;
%let _OUTPUT1_col_count = 23;
%let _OUTPUT1_col0_name = Soci_t_;
%let _OUTPUT1_col0_table = work.W6H9QJPR;
%let _OUTPUT1_col0_length = 11;
%let _OUTPUT1_col0_type = $;
%let _OUTPUT1_col0_format = $11.;
%let _OUTPUT1_col0_informat = $11.;
%let _OUTPUT1_col0_label = %nrquote(Société);
%let _OUTPUT1_col0_exp = ;
%let _OUTPUT1_col0_input_count = 0;
%let _OUTPUT1_col1_name = Produit;
%let _OUTPUT1_col1_table = work.W6H9QJPR;
%let _OUTPUT1_col1_length = 255;
%let _OUTPUT1_col1_type = $;
%let _OUTPUT1_col1_format = $255.;
%let _OUTPUT1_col1_informat = $255.;
%let _OUTPUT1_col1_label = %nrquote(Produit);
%let _OUTPUT1_col1_exp = ;
%let _OUTPUT1_col1_input_count = 0;
%let _OUTPUT1_col2_name = Equipement;
%let _OUTPUT1_col2_table = work.W6H9QJPR;
%let _OUTPUT1_col2_length = 50;
%let _OUTPUT1_col2_type = $;
%let _OUTPUT1_col2_format = $50.;
%let _OUTPUT1_col2_informat = $50.;
%let _OUTPUT1_col2_label = %nrquote(Equipement);
%let _OUTPUT1_col2_exp = ;
%let _OUTPUT1_col2_input_count = 0;
%let _OUTPUT1_col3_name = Carte_de_contr_le;
%let _OUTPUT1_col3_table = work.W6H9QJPR;
%let _OUTPUT1_col3_length = 255;
%let _OUTPUT1_col3_type = $;
%let _OUTPUT1_col3_format = $255.;
%let _OUTPUT1_col3_informat = $255.;
%let _OUTPUT1_col3_label = %nrquote(Carte de contrôle);
%let _OUTPUT1_col3_exp = ;
%let _OUTPUT1_col3_input_count = 0;
%let _OUTPUT1_col4_name = Mesure_Type;
%let _OUTPUT1_col4_table = work.W6H9QJPR;
%let _OUTPUT1_col4_length = 255;
%let _OUTPUT1_col4_type = $;
%let _OUTPUT1_col4_format = $255.;
%let _OUTPUT1_col4_informat = $255.;
%let _OUTPUT1_col4_label = %nrquote(Mesure Type);
%let _OUTPUT1_col4_exp = ;
%let _OUTPUT1_col4_input_count = 0;
%let _OUTPUT1_col5_name = Mesure_Date_Poste;
%let _OUTPUT1_col5_table = work.W6H9QJPR;
%let _OUTPUT1_col5_length = 8;
%let _OUTPUT1_col5_type = ;
%let _OUTPUT1_col5_format = DATETIME22.3;
%let _OUTPUT1_col5_informat = DATETIME22.3;
%let _OUTPUT1_col5_label = %nrquote(Mesure Date Poste);
%let _OUTPUT1_col5_exp = ;
%let _OUTPUT1_col5_input_count = 0;
%let _OUTPUT1_col6_name = Mesure_Date_Heure;
%let _OUTPUT1_col6_table = work.W6H9QJPR;
%let _OUTPUT1_col6_length = 8;
%let _OUTPUT1_col6_type = ;
%let _OUTPUT1_col6_format = DATETIME22.3;
%let _OUTPUT1_col6_informat = DATETIME22.3;
%let _OUTPUT1_col6_label = %nrquote(Mesure Date Heure);
%let _OUTPUT1_col6_exp = ;
%let _OUTPUT1_col6_input_count = 0;
%let _OUTPUT1_col7_name = Mesure_Date;
%let _OUTPUT1_col7_table = work.W6H9QJPR;
%let _OUTPUT1_col7_length = 8;
%let _OUTPUT1_col7_type = ;
%let _OUTPUT1_col7_format = DATETIME22.3;
%let _OUTPUT1_col7_informat = DATETIME22.3;
%let _OUTPUT1_col7_label = %nrquote(Mesure Date);
%let _OUTPUT1_col7_exp = ;
%let _OUTPUT1_col7_input_count = 0;
%let _OUTPUT1_col8_name = Mesure_Jour;
%let _OUTPUT1_col8_table = work.W6H9QJPR;
%let _OUTPUT1_col8_length = 30;
%let _OUTPUT1_col8_type = $;
%let _OUTPUT1_col8_format = $30.;
%let _OUTPUT1_col8_informat = $30.;
%let _OUTPUT1_col8_label = %nrquote(Mesure Jour);
%let _OUTPUT1_col8_exp = ;
%let _OUTPUT1_col8_input_count = 0;
%let _OUTPUT1_col9_name = Mesure_Heure;
%let _OUTPUT1_col9_table = work.W6H9QJPR;
%let _OUTPUT1_col9_length = 8;
%let _OUTPUT1_col9_type = ;
%let _OUTPUT1_col9_format = DATETIME22.3;
%let _OUTPUT1_col9_informat = DATETIME22.3;
%let _OUTPUT1_col9_label = %nrquote(Mesure Heure);
%let _OUTPUT1_col9_exp = ;
%let _OUTPUT1_col9_input_count = 0;
%let _OUTPUT1_col10_name = Mesure_Op_rateur;
%let _OUTPUT1_col10_table = work.W6H9QJPR;
%let _OUTPUT1_col10_length = 5;
%let _OUTPUT1_col10_type = $;
%let _OUTPUT1_col10_format = $5.;
%let _OUTPUT1_col10_informat = $5.;
%let _OUTPUT1_col10_label = %nrquote(Mesure Opérateur);
%let _OUTPUT1_col10_exp = ;
%let _OUTPUT1_col10_input_count = 0;
%let _OUTPUT1_col11_name = Mesure_Equipe;
%let _OUTPUT1_col11_table = work.W6H9QJPR;
%let _OUTPUT1_col11_length = 10;
%let _OUTPUT1_col11_type = $;
%let _OUTPUT1_col11_format = $10.;
%let _OUTPUT1_col11_informat = $10.;
%let _OUTPUT1_col11_label = %nrquote(Mesure Equipe);
%let _OUTPUT1_col11_exp = ;
%let _OUTPUT1_col11_input_count = 0;
%let _OUTPUT1_col12_name = Mesure_Poste;
%let _OUTPUT1_col12_table = work.W6H9QJPR;
%let _OUTPUT1_col12_length = 10;
%let _OUTPUT1_col12_type = $;
%let _OUTPUT1_col12_format = $10.;
%let _OUTPUT1_col12_informat = $10.;
%let _OUTPUT1_col12_label = %nrquote(Mesure Poste);
%let _OUTPUT1_col12_exp = ;
%let _OUTPUT1_col12_input_count = 0;
%let _OUTPUT1_col13_name = Mesure_Observation;
%let _OUTPUT1_col13_table = work.W6H9QJPR;
%let _OUTPUT1_col13_length = 1024;
%let _OUTPUT1_col13_type = $;
%let _OUTPUT1_col13_format = $1024.;
%let _OUTPUT1_col13_informat = $1024.;
%let _OUTPUT1_col13_label = %nrquote(Mesure Observation);
%let _OUTPUT1_col13_exp = ;
%let _OUTPUT1_col13_input_count = 0;
%let _OUTPUT1_col14_name = Valeur_Minimale_D_rogation;
%let _OUTPUT1_col14_table = work.W6H9QJPR;
%let _OUTPUT1_col14_length = 8;
%let _OUTPUT1_col14_type = ;
%let _OUTPUT1_col14_format = ;
%let _OUTPUT1_col14_informat = ;
%let _OUTPUT1_col14_label = %nrquote(Valeur Minimale Dérogation);
%let _OUTPUT1_col14_exp = ;
%let _OUTPUT1_col14_input_count = 0;
%let _OUTPUT1_col15_name = Valeur_Minimale_Critique;
%let _OUTPUT1_col15_table = work.W6H9QJPR;
%let _OUTPUT1_col15_length = 8;
%let _OUTPUT1_col15_type = ;
%let _OUTPUT1_col15_format = ;
%let _OUTPUT1_col15_informat = ;
%let _OUTPUT1_col15_label = %nrquote(Valeur Minimale Critique);
%let _OUTPUT1_col15_exp = ;
%let _OUTPUT1_col15_input_count = 0;
%let _OUTPUT1_col16_name = Valeur_mesur_e;
%let _OUTPUT1_col16_table = work.W6H9QJPR;
%let _OUTPUT1_col16_length = 8;
%let _OUTPUT1_col16_type = ;
%let _OUTPUT1_col16_format = ;
%let _OUTPUT1_col16_informat = ;
%let _OUTPUT1_col16_label = %nrquote(Valeur mesurée);
%let _OUTPUT1_col16_exp = ;
%let _OUTPUT1_col16_input_count = 0;
%let _OUTPUT1_col17_name = Valeur_Maximale_Critique;
%let _OUTPUT1_col17_table = work.W6H9QJPR;
%let _OUTPUT1_col17_length = 8;
%let _OUTPUT1_col17_type = ;
%let _OUTPUT1_col17_format = ;
%let _OUTPUT1_col17_informat = ;
%let _OUTPUT1_col17_label = %nrquote(Valeur Maximale Critique);
%let _OUTPUT1_col17_exp = ;
%let _OUTPUT1_col17_input_count = 0;
%let _OUTPUT1_col18_name = Valeur_Maximale_D_rogation;
%let _OUTPUT1_col18_table = work.W6H9QJPR;
%let _OUTPUT1_col18_length = 8;
%let _OUTPUT1_col18_type = ;
%let _OUTPUT1_col18_format = ;
%let _OUTPUT1_col18_informat = ;
%let _OUTPUT1_col18_label = %nrquote(Valeur Maximale Dérogation);
%let _OUTPUT1_col18_exp = ;
%let _OUTPUT1_col18_input_count = 0;
%let _OUTPUT1_col19_name = D_rogation_Code;
%let _OUTPUT1_col19_table = work.W6H9QJPR;
%let _OUTPUT1_col19_length = 20;
%let _OUTPUT1_col19_type = $;
%let _OUTPUT1_col19_format = $20.;
%let _OUTPUT1_col19_informat = $20.;
%let _OUTPUT1_col19_label = %nrquote(Dérogation Code);
%let _OUTPUT1_col19_exp = ;
%let _OUTPUT1_col19_input_count = 0;
%let _OUTPUT1_col20_name = D_rogation_Date_D_but;
%let _OUTPUT1_col20_table = work.W6H9QJPR;
%let _OUTPUT1_col20_length = 8;
%let _OUTPUT1_col20_type = ;
%let _OUTPUT1_col20_format = DATETIME22.3;
%let _OUTPUT1_col20_informat = DATETIME22.3;
%let _OUTPUT1_col20_label = %nrquote(Dérogation Date Début);
%let _OUTPUT1_col20_exp = ;
%let _OUTPUT1_col20_input_count = 0;
%let _OUTPUT1_col21_name = D_rogation_Date_Fin;
%let _OUTPUT1_col21_table = work.W6H9QJPR;
%let _OUTPUT1_col21_length = 8;
%let _OUTPUT1_col21_type = ;
%let _OUTPUT1_col21_format = DATETIME22.3;
%let _OUTPUT1_col21_informat = DATETIME22.3;
%let _OUTPUT1_col21_label = %nrquote(Dérogation Date Fin);
%let _OUTPUT1_col21_exp = ;
%let _OUTPUT1_col21_input_count = 0;
%let _OUTPUT1_col22_name = D_rogation_Commentaire;
%let _OUTPUT1_col22_table = work.W6H9QJPR;
%let _OUTPUT1_col22_length = 1024;
%let _OUTPUT1_col22_type = $;
%let _OUTPUT1_col22_format = $1024.;
%let _OUTPUT1_col22_informat = $1024.;
%let _OUTPUT1_col22_label = %nrquote(Dérogation Commentaire);
%let _OUTPUT1_col22_exp = ;
%let _OUTPUT1_col22_input_count = 0;

/*---- Début du code écrit par l'utilisateur  ----*/ 

PROC SQL;
CREATE TABLE WORK.W6H9QJPR
AS
SELECT VMM.* FROM DS_SQC.VUE_METIER_MESURES AS VMM
WHERE VMM.Mesure_Date_Heure > (SELECT MAX(CC.Mesure_Date_Heure) FROM DTM_PRO.CARTE_CONTROLE AS CC);
RUN:

/*---- Fin du code écrit par l'utilisateur  ----*/ 

%rcSet(&syserr); 
%rcSet(&sqlrc); 


/**  Step end Ecrit par l'utilisateur **/

/*==========================================================================* 
 * Etape :                   Chargeur de tables           A51VJW1Q.BV000692 * 
 * Transformation :          Chargeur de tables (Version 2.1)               * 
 * Description :                                                            * 
 *                                                                          * 
 * Table source :            Ecrit par l'utilisateur -    A51VJW1Q.BS0002M5 * 
 *                            work.W6H9QJPR                                 * 
 * Table cible :             CARTE_CONTROLE -             A51VJW1Q.BH0000K7 * 
 *                            DTM_PRO.CARTE_CONTROLE                        * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV000692);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

%let SYSLAST = %nrquote(work.W6H9QJPR); 

%let SYS_SQL_IP_SPEEDO = Y;
%let SYS_SQL_MAPPUTTO = sas_put;
%let SYS_SQLREDUCEPUT = DBMS;
%global etls_sql_pushDown;
%let etls_sql_pushDown = -1;
option DBIDIRECTEXEC;

%global etls_tableExist;
%global etls_numIndex;
%global etls_lastTable;
%let etls_tableExist = -1; 
%let etls_numIndex = -1; 
%let etls_lastTable = &SYSLAST; 

/*---- Define load data macro  ----*/ 

/* --------------------------------------------------------------
   Load Technique Selection: AppendToExisting - AppendProc
   Constraint and index action selections: 'ASIS','ASIS','ASIS','ASIS'
   Additional options selections... 
      Set unmapped to missing on updates: false 
   -------------------------------------------------------------- */
%macro etls_loader;

   %let etls_tableOptions = ;
   
   /* Determine if the target table exists  */ 
   %let etls_tableExist = %eval(%sysfunc(exist(DTM_PRO.CARTE_CONTROLE, DATA)) or 
         %sysfunc(exist(DTM_PRO.CARTE_CONTROLE, VIEW))); 
   
   /*---- Create a new table  ----*/ 
   %if (&etls_tableExist eq 0) %then 
   %do;  /* if table does not exist  */ 
   
      %put %str(NOTE: Creating table ...);
      
      data DTM_PRO.CARTE_CONTROLE;
         attrib Soci_t_ length = $11
            format = $11.
            informat = $11.
            label = 'Société'; 
         attrib Produit length = $255
            format = $255.
            informat = $255.
            label = 'Produit'; 
         attrib Equipement length = $50
            format = $50.
            informat = $50.
            label = 'Equipement'; 
         attrib Carte_de_contr_le length = $255
            format = $255.
            informat = $255.
            label = 'Carte de contrôle'; 
         attrib Mesure_Type length = $255
            format = $255.
            informat = $255.
            label = 'Mesure Type'; 
         attrib Mesure_Date_Poste length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mesure Date Poste'; 
         attrib Mesure_Date_Heure length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mesure Date Heure'; 
         attrib Mesure_Date length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mesure Date'; 
         attrib Mesure_Jour length = $30
            format = $30.
            informat = $30.
            label = 'Mesure Jour'; 
         attrib Mesure_Heure length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Mesure Heure'; 
         attrib Mesure_Op_rateur length = $5
            format = $5.
            informat = $5.
            label = 'Mesure Opérateur'; 
         attrib Mesure_Equipe length = $10
            format = $10.
            informat = $10.
            label = 'Mesure Equipe'; 
         attrib Mesure_Poste length = $10
            format = $10.
            informat = $10.
            label = 'Mesure Poste'; 
         attrib Mesure_Observation length = $1024
            format = $1024.
            informat = $1024.
            label = 'Mesure Observation'; 
         attrib Valeur_Minimale_D_rogation length = 8
            label = 'Valeur Minimale Dérogation'; 
         attrib Valeur_Minimale_Critique length = 8
            label = 'Valeur Minimale Critique'; 
         attrib Valeur_mesur_e length = 8
            label = 'Valeur mesurée'; 
         attrib Valeur_Maximale_Critique length = 8
            label = 'Valeur Maximale Critique'; 
         attrib Valeur_Maximale_D_rogation length = 8
            label = 'Valeur Maximale Dérogation'; 
         attrib D_rogation_Code length = $20
            format = $20.
            informat = $20.
            label = 'Dérogation Code'; 
         attrib D_rogation_Date_D_but length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Dérogation Date Début'; 
         attrib D_rogation_Date_Fin length = 8
            format = DATETIME22.3
            informat = DATETIME22.3
            label = 'Dérogation Date Fin'; 
         attrib D_rogation_Commentaire length = $1024
            format = $1024.
            informat = $1024.
            label = 'Dérogation Commentaire'; 
         call missing(of _all_);
         stop;
      run;
      
      %rcSet(&syserr); 
      
   %end;  /* if table does not exist  */ 
   
   /*---- Append  ----*/ 
   %put %str(NOTE: Appending data ...);
   
   proc append base = DTM_PRO.CARTE_CONTROLE 
      data = &etls_lastTable (&etls_tableOptions)  force ; 
    run; 
   
   %rcSet(&syserr); 
   
%mend etls_loader;
%etls_loader;



/**  Step end Chargeur de tables **/

/*==========================================================================* 
 * Etape :                   Mise à jour TDB Lots Classe  A51VJW1Q.BV000716 * 
 *                            Ligne                                         * 
 * Transformation :          Ecrit par l'utilisateur                        * 
 * Description :                                                            * 
 *                                                                          * 
 * Table cible :             Ecrit par l'utilisateur -    A51VJW1Q.BS0003E6 * 
 *                            work.WN6TWVDG                                 * 
 *                                                                          * 
 * Ecrit par l'utilisateur : CodeSource                                     * 
 *==========================================================================*/ 

%let transformID = %quote(A51VJW1Q.BV000716);
%let trans_rc = 0;
%let etls_stepStartTime = %sysfunc(datetime(), datetime20.); 

%let _INPUT_count = 0;
%let _OUTPUT_count = 1;
%let _OUTPUT = work.WN6TWVDG;
%let _OUTPUT_connect = ;
%let _OUTPUT_engine = ;
%let _OUTPUT_memtype = DATA;
%let _OUTPUT_options = %nrquote();
%let _OUTPUT_alter = %nrquote();
%let _OUTPUT_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0003E6%(WorkTable%));
%let _OUTPUT_type = 1;
%let _OUTPUT_label = %nrquote();
%let _OUTPUT_col_count = 0;

%let _OUTPUT1 = work.WN6TWVDG;
%let _OUTPUT1_connect = ;
%let _OUTPUT1_engine = ;
%let _OUTPUT1_memtype = DATA;
%let _OUTPUT1_options = %nrquote();
%let _OUTPUT1_alter = %nrquote();
%let _OUTPUT1_path = %nrquote(/Ecrit par l%'utilisateur_A51VJW1Q.BS0003E6%(WorkTable%));
%let _OUTPUT1_type = 1;
%let _OUTPUT1_label = %nrquote();
%let _OUTPUT1_col_count = 0;

/*---- Début du code écrit par l'utilisateur  ----*/ 

LIBNAME DS_SQC ODBC  DATASRC=SQC  SCHEMA=dbo  USER=sassql  PASSWORD="{SAS002}3625302A43996237206B48FF5188832F3A71A582" ;

PROC SQL;
CREATE TABLE WORK.V_LOTS_SYNTHESE1  AS
SELECT    
		  t1.Lot,
	      t1.Fournisseur as Fournisseur,           
          t1.Societe as Societe, 
          t1.'Desox Equipement'n as Desox_Equipement, 
          t1.Materiau as Materiau, 
          t1.'Seri Equipement'n as Seri_Equipement, 
          t1.'Tri Date Heure Sort'n as Tri_Date_Heure_Sort, 
          t1.'Tri Date Poste'n as Tri_Date_Poste,
		  t1.'Tri Poste'n as Tri_Poste,

		t1.'Tri Qte Entr'n AS Tri_Qte_Entr,
		t1.'Tri Qte Sort'n AS Tri_Qte_Sort,
		t1.'Tri Rej Total'n AS Tri_Rej_Total,
		t1.'Tri Qte Ecart'n AS Tri_Qte_Ecart,
		t1.'Tri Qte M'n AS Tri_Qte_M,
		t1.'Tri Qte Eme'n AS Tri_Qte_Eme,
		t1.'Tri Qte Rsh'n AS Tri_Qte_Rsh,
		t1.'Tri Qte Idk'n AS Tri_Qte_Idk,
		t1.'Tri Qte Div'n AS Tri_Qte_Div,
		t1.'Tri Qte L-16_4'n AS Tri_Qte_L16_4,
		t1.'Tri Qte L-16_6'n AS Tri_Qte_L16_6,
		t1.'Tri Qte L-16_8'n AS Tri_Qte_L16_8,
		t1.'Tri Qte L-17_2'n AS Tri_Qte_L17_2,
		t1.'Tri Qte L-17_4'n AS Tri_Qte_L17_4,
		t1.'Tri Qte L-17_6'n AS Tri_Qte_L17_6,
		t1.'Tri Qte L-17_8'n AS Tri_Qte_L17_8,
		t1.'Tri Qte L-18_2'n AS Tri_Qte_L18_2,
		t1.'Tri Qte L-18_4'n AS Tri_Qte_L18_4,
		t1.'Tri Qte L-18_6'n AS Tri_Qte_L18_6,
		t1.'Tri Qte L-18_8'n AS Tri_Qte_L18_8,
		t1.'Tri Qte L-16_0'n AS Tri_Qte_L16_0,
		t1.'Tri Qte 16_0'n AS Tri_Qte_16_0,
		t1.'Tri Qte 16_2'n AS Tri_Qte_16_2,
		t1.'Tri Qte 16_4'n AS Tri_Qte_16_4,
		t1.'Tri Qte 16_6'n AS Tri_Qte_16_6,
		t1.'Tri Qte 16_8'n AS Tri_Qte_16_8,
		t1.'Tri Qte L-17_0'n AS Tri_Qte_L17_0,
		t1.'Tri Qte 17_0'n AS Tri_Qte_17_0,
		t1.'Tri Qte 17_2'n AS Tri_Qte_17_2,
		t1.'Tri Qte 17_4'n AS Tri_Qte_17_4,
		t1.'Tri Qte 17_6'n AS Tri_Qte_17_6,
		t1.'Tri Qte 17_8'n AS Tri_Qte_17_8,
		t1.'Tri Qte L-18_0'n AS Tri_Qte_L18_0,
		t1.'Tri Qte 18_0'n AS Tri_Qte_18_0,
		t1.'Tri Qte 18_2'n AS Tri_Qte_18_2,
		t1.'Tri Qte 18_4'n AS Tri_Qte_18_4,
		t1.'Tri Qte 18_6'n AS Tri_Qte_18_6,
		t1.'Tri Qte 18_8'n AS Tri_Qte_18_8,
		t1.'Tri Qte 19_0'n AS Tri_Qte_19_0,
		t1.'Tri Qte 19_2'n AS Tri_Qte_19_2,
		t1.'Tri Qte 19_4'n AS Tri_Qte_19_4,
		t1.'Tri Qte 19_6'n AS Tri_Qte_19_6,
		t1.'Tri Qte 19_8'n AS Tri_Qte_19_8,
		t1.'Tri Qte 20_0'n AS Tri_Qte_20_0,
		t1.'Tri Qte 20_2'n AS Tri_Qte_20_2,
		t1.'Tri Qte 20_4'n AS Tri_Qte_20_4,
		t1.'Tri Qte 20_6'n AS Tri_Qte_20_6

FROM
			DS_SQC.V_LOTS AS T1
			Where (datepart(T1.'Tri Date Poste'n) >= INTNX('day',date(),-60) 
			      AND (T1.'Tri Date Heure Sort'n Is Not Missing));     
RUN;

PROC SORT
	DATA=WORK.V_LOTS_SYNTHESE1
	OUT=WORK.SORTTEMPTABLESORTED
	;
	BY Lot;
RUN;

PROC TRANSPOSE DATA=WORK.SORTTEMPTABLESORTED
	OUT=WORK.LISTE_LOT_CLASSE (LABEL="LISTE_LOT_CLASSE")
	PREFIX=Quantite
	NAME=Source
	LABEL='Libelle'n;

	BY Lot Fournisseur Societe Materiau Desox_Equipement Seri_Equipement Tri_Poste Tri_Date_Heure_Sort Tri_Date_Poste;
    VAR Tri_Qte_Entr Tri_Qte_Sort Tri_Rej_Total Tri_Qte_Ecart Tri_Qte_M Tri_Qte_Eme Tri_Qte_Rsh Tri_Qte_Idk Tri_Qte_Div Tri_Qte_L16_4 Tri_Qte_L16_6 Tri_Qte_L16_8 
        Tri_Qte_L17_2 Tri_Qte_L17_4 Tri_Qte_L17_6 Tri_Qte_L17_8 Tri_Qte_L18_2 Tri_Qte_L18_4 Tri_Qte_L18_6 Tri_Qte_L18_8 Tri_Qte_L16_0 Tri_Qte_16_0 Tri_Qte_16_2 
        Tri_Qte_16_4 Tri_Qte_16_6 Tri_Qte_16_8 Tri_Qte_L17_0 Tri_Qte_17_0 Tri_Qte_17_2 Tri_Qte_17_4 Tri_Qte_17_6 Tri_Qte_17_8 Tri_Qte_L18_0 Tri_Qte_18_0 
        Tri_Qte_18_2 Tri_Qte_18_4 Tri_Qte_18_6 Tri_Qte_18_8 Tri_Qte_19_0 Tri_Qte_19_2 Tri_Qte_19_4 Tri_Qte_19_6 Tri_Qte_19_8 Tri_Qte_20_0 Tri_Qte_20_2 Tri_Qte_20_4 Tri_Qte_20_6;
RUN;
QUIT;

PROC SQL;
CREATE TABLE WORK.TDB_V_LOTS_CLASSE_LIGNE
AS 
SELECT 
	   Datetime() AS Date_Actualisation Format DateTime23.,
	   t1.Lot as Lot,
	   t1.Source as Classe,
	   t1.Quantite1 as Quantite,

          t1.Fournisseur, 
          t1.Societe, 
          t1.Materiau, 
		  t1.Desox_Equipement, 
          t1.Seri_Equipement, 
		  t1.Tri_Poste, 
          t1.Tri_Date_Heure_Sort, 
          t1.Tri_Date_Poste        

		  FROM 
		  		WORK.LISTE_LOT_CLASSE AS t1
				WHERE t1.Quantite1 >0;
RUN;

DATA DTM_PRO.TDB_V_LOTS_CLASSE_LIGNE;
SET WORK.TDB_V_LOTS_CLASSE_LIGNE;
RUN;


/*---- Fin du code écrit par l'utilisateur  ----*/ 

%rcSet(&syserr); 
%rcSet(&sqlrc); 


/**  Step end Mise à jour TDB Lots Classe Ligne **/

%let etls_endTime = %sysfunc(datetime(),datetime.);

/*---- Début du code de post-traitement  ----*/ 

%let JOB_NAME=%nrquote(JOB_DTM_PRO_PVA_TBO_DELTA);
%include "&COM\1_programmes\Automatisation_delta.sas";
/*---- Fin du code de post-traitement  ----*/ 

%rcSet(&syserr); 
%rcSet(&sqlrc); 

