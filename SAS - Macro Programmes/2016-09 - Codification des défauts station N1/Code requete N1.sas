/** QUERY **/ 
options validvarname=any validmemname=extend;

/* Register Table Macro */
%macro registertable( REPOSITORY=Foundation, REPOSID=, LIBRARY=, TABLE=, FOLDER=, TABLEID=, PREFIX= );

/* Mask special characters */

   %let REPOSITORY=%superq(REPOSITORY);
   %let LIBRARY   =%superq(LIBRARY);
   %let FOLDER    =%superq(FOLDER);
   %let TABLE     =%superq(TABLE);

   %let REPOSARG=%str(REPNAME="&REPOSITORY.");
   %if ("&REPOSID." ne "") %THEN %LET REPOSARG=%str(REPID="&REPOSID.");

   %if ("&TABLEID." ne "") %THEN %LET SELECTOBJ=%str(&TABLEID.);
   %else                         %LET SELECTOBJ=&TABLE.;

   %if ("&FOLDER." ne "") %THEN
      %PUT INFO: Registering &FOLDER./&SELECTOBJ. to &LIBRARY. library.;
   %else
      %PUT INFO: Registering &SELECTOBJ. to &LIBRARY. library.;

   proc metalib;
      omr (
         library="&LIBRARY." 
         %str(&REPOSARG.) 
          ); 
      %if ("&TABLEID." eq "") %THEN %DO;
         %if ("&FOLDER." ne "") %THEN %DO;
            folder="&FOLDER.";
         %end;
      %end;
      %if ("&PREFIX." ne "") %THEN %DO;
         prefix="&PREFIX.";
      %end;
      select ("&SELECTOBJ."); 
   run; 
   quit;

%mend;

option DBIDIRECTEXEC;

/* Drop existing table */

%vdb_dt(LANDING2.DATA_ICOS_FSPI_N1);
proc sql noprint;

    create table DATA_ICOS_FSPI_N1 AS SELECT
        V_ICOS_FSPI_N1_DEFAUTS.Calibration_slot1_IVC14000D4SQ length=8 format=32.5 AS Calibration_slot1_IVC14000D4SQ,
        V_ICOS_FSPI_N1_DEFAUTS.Calibration_timestamp_slot1 length=255 format=$255. AS Calibration_timestamp_slot1,
        V_ICOS_FSPI_N1_DEFAUTS.Contour_Result length=50 format=$50. AS Contour_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_Offset_Top_Left_Result length=50 format=$50. AS FP_Edge_Offset_Top_Left_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_Offset_Top_Left_Value length=8 format=32.5 AS FP_Edge_Offset_Top_Left_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Bot_Left_Result length=50 format=$50. AS FP_Edge_offset_Bot_Left_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Bot_Left_Value length=8 format=32.5 AS FP_Edge_offset_Bot_Left_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Bot_Right_Result length=50 format=$50. AS FP_Edge_offset_Bot_Right_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Bot_Right_Value length=8 format=32.5 AS FP_Edge_offset_Bot_Right_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Left_Bot_Result length=50 format=$50. AS FP_Edge_offset_Left_Bot_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Left_Bot_Value length=8 format=32.5 AS FP_Edge_offset_Left_Bot_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Left_Top_Result length=50 format=$50. AS FP_Edge_offset_Left_Top_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Left_Top_Value length=8 format=32.5 AS FP_Edge_offset_Left_Top_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Right_Bot_Result length=50 format=$50. AS FP_Edge_offset_Right_Bot_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Right_Bot_Value length=8 format=32.5 AS FP_Edge_offset_Right_Bot_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Right_Top_Result length=50 format=$50. AS FP_Edge_offset_Right_Top_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Right_Top_Value length=8 format=32.5 AS FP_Edge_offset_Right_Top_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Top_Right_Result length=50 format=$50. AS FP_Edge_offset_Top_Right_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Edge_offset_Top_Right_Value length=8 format=32.5 AS FP_Edge_offset_Top_Right_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_Length_Longest_Screen_Result length=50 format=$50. AS FPI_Length_Longest_Screen_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_Number_Screen_Result length=50 format=$50. AS FPI_Number_Screen_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_Total_Length_Screen_Result length=50 format=$50. AS FPI_Total_Length_Screen_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_length_longest_screen_Value length=8 format=32.5 AS FPI_length_longest_screen_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_number_screen_Value length=8 format=32.5 AS FPI_number_screen_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FPI_total_length_screen_Value length=8 format=32.5 AS FPI_total_length_screen_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Max_Nb_Screen_Result length=50 format=$50. AS FP_Knots_Max_Nb_Screen_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Max_Nb_Screen_Value length=8 format=32.5 AS FP_Knots_Max_Nb_Screen_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Maximum_Length_Result length=50 format=$50. AS FP_Knots_Maximum_Length_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Maximum_Length_Value length=8 format=32.5 AS FP_Knots_Maximum_Length_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Maximum_Width_Result length=50 format=$50. AS FP_Knots_Maximum_Width_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Knots_Maximum_Width_Value length=8 format=32.5 AS FP_Knots_Maximum_Width_Value,
        V_ICOS_FSPI_N1_DEFAUTS.Front_Print_Result length=50 format=$50. AS Front_Print_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_Rotation_Result length=50 format=$50. AS FP_Screen_Rotation_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_Translation_Y_Result length=50 format=$50. AS FP_Screen_Translation_Y_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_rotation_Value length=8 format=32.5 AS FP_Screen_rotation_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_translation_X_Value length=8 format=32.5 AS FP_Screen_translation_X_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_translation_X_Result length=50 format=$50. AS FP_Screen_translation_X_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Screen_translation_Y_Value length=8 format=32.5 AS FP_Screen_translation_Y_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Screen_Result length=50 format=$50. AS FP_Thickenings_Max_Screen_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Screen_Value length=8 format=32.5 AS FP_Thickenings_Max_Screen_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Width_Result length=50 format=$50. AS FP_Thickenings_Max_Width_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Width_Value length=8 format=32.5 AS FP_Thickenings_Max_Width_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Length_Result length=50 format=$50. AS FP_Thickenings_Max_Length_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Thickenings_Max_Length_Value length=8 format=32.5 AS FP_Thickenings_Max_Length_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Average_Finger_Result length=50 format=$50. AS FP_Width_Average_Finger_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Bus_Local_Min_Result length=50 format=$50. AS FP_Width_Bus_Local_Min_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Bus_Local_Min_Value length=8 format=32.5 AS FP_Width_Bus_Local_Min_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Thickest_Finger_Result length=50 format=$50. AS FP_Width_Thickest_Finger_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Thinnest_Bus_Bar_Result length=50 format=$50. AS FP_Width_Thinnest_Bus_Bar_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Thinnest_Bus_Bar_Value length=8 format=32.5 AS FP_Width_Thinnest_Bus_Bar_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_Thinnest_Finger_Result length=50 format=$50. AS FP_Width_Thinnest_Finger_Result,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_average_finger_Value length=8 format=32.5 AS FP_Width_average_finger_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_thickest_finger_Value length=8 format=32.5 AS FP_Width_thickest_finger_Value,
        V_ICOS_FSPI_N1_DEFAUTS.FP_Width_thinnest_finger_Value length=8 format=32.5 AS FP_Width_thinnest_finger_Value,
        V_ICOS_FSPI_N1_DEFAUTS.Geometry_Result length=50 format=$50. AS Geometry_Result,
        V_ICOS_FSPI_N1_DEFAUTS.IdEquipement length=8 format=11. AS IdEquipement,
        V_ICOS_FSPI_N1_DEFAUTS.IdRecord length=8 format=11. AS IdRecord,
        V_ICOS_FSPI_N1_DEFAUTS.LotId length=9 format=$9. AS LotId,
        V_ICOS_FSPI_N1_DEFAUTS.LotWaferID length=255 format=$255. AS LotWaferID,
        V_ICOS_FSPI_N1_DEFAUTS.Presence_Result length=50 format=$50. AS Presence_Result,
        V_ICOS_FSPI_N1_DEFAUTS.Product_Name length=255 format=$255. AS Product_Name,
        V_ICOS_FSPI_N1_DEFAUTS.Quality_Result_Classification length=50 format=$50. AS Quality_Result_Classification,
        V_ICOS_FSPI_N1_DEFAUTS.Quality_Result_Inspection length=50 format=$50. AS Quality_Result_Inspection,
        V_ICOS_FSPI_N1_DEFAUTS.Surface_Result length=50 format=$50. AS Surface_Result,
        V_ICOS_FSPI_N1_DEFAUTS.Surface_Def_Area_Busbars_Result length=50 format=$50. AS Surface_Def_Area_Busbars_Result,
        V_ICOS_FSPI_N1_DEFAUTS.Surface_Def_Area_Busbars_Value length=8 format=32.5 AS Surface_Def_Area_Busbars_Value,
        V_ICOS_FSPI_N1_DEFAUTS.Surface_Def_Area_Wafer_Result length=50 format=$50. AS Surface_Def_Area_Wafer_Result,
        V_ICOS_FSPI_N1_DEFAUTS.Surface_Def_Area_Wafer_Value length=8 format=32.5 AS Surface_Def_Area_Wafer_Value,
        V_ICOS_FSPI_N1_DEFAUTS.TimeStamp length=8 format=DATETIME22.3 AS TimeStamp,
        V_ICOS_FSPI_N1_DEFAUTS.WaferEqID length=2 format=$2. AS WaferEqID,
        V_ICOS_FSPI_N1_DEFAUTS.WaferNr length=5 format=$5. AS WaferNr,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OTL length=8 format=$8. AS Defaut_FPE_OTL,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OBL length=8 format=$8. AS Defaut_FPE_OBL,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OBR length=8 format=$8. AS Defaut_FPE_OBR,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OLB length=8 format=$8. AS Defaut_FPE_OLB,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OLT length=8 format=$8. AS Defaut_FPE_OLT,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_ORB length=8 format=$8. AS Defaut_FPE_ORB,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_ORT length=8 format=$8. AS Defaut_FPE_ORT,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPE_OTR length=8 format=$8. AS Defaut_FPE_OTR,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPI_LLS length=8 format=$8. AS Defaut_FPI_LLS,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPI_NS length=7 format=$7. AS Defaut_FPI_NS,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPI_TLS length=8 format=$8. AS Defaut_FPI_TLS,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPK_MNS length=8 format=$8. AS Defaut_FPK_MNS,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPK_ML length=7 format=$7. AS Defaut_FPK_ML,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPK_MW length=7 format=$7. AS Defaut_FPK_MW,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPS_R length=6 format=$6. AS Defaut_FPS_R,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPS_TY length=7 format=$7. AS Defaut_FPS_TY,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPS_TX length=7 format=$7. AS Defaut_FPS_TX,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPT_MN length=7 format=$7. AS Defaut_FPT_MN,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPT_MW length=7 format=$7. AS Defaut_FPT_MW,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPT_ML length=7 format=$7. AS Defaut_FPT_ML,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPW_AF length=7 format=$7. AS Defaut_FPW_AF,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPW_BBLM length=9 format=$9. AS Defaut_FPW_BBLM,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPW_TCF length=8 format=$8. AS Defaut_FPW_TCF,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPW_TBB length=8 format=$8. AS Defaut_FPW_TBB,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_FPW_THF length=8 format=$8. AS Defaut_FPW_THF,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_STDA_FB length=8 format=$8. AS Defaut_STDA_FB,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_STDA_W length=7 format=$7. AS Defaut_STDA_W,
        V_ICOS_FSPI_N1_DEFAUTS.Defaut_Details length=205 format=$205. AS Defaut_Details 
    FROM
        IN_LINE.V_ICOS_FSPI_N1_DEFAUTS V_ICOS_FSPI_N1_DEFAUTS 
    WHERE
        datepart(V_ICOS_FSPI_N1_DEFAUTS.TimeStamp) >= INTNX('month', DATE(), -2) ;
quit;


PROC FORMAT LIB=APFMTLIB;
VALUE PERIODE
1="Jour courant"
2="Hier"
3="Avant hier"
4="Restant semaine"
5="Semaine dernière"
6="Autres jours du mois"
7="Mois précédent"
8="Restant du trimestre"
9="Trimestre précédent"
;
RUN;

data calendar;
length d periode 4.;
format d date9. periode periode.;

d=intnx('quarter',date(),-1,'B');

do while (d le date());

if d=date() then do;
   periode=1;
end;
else do;
   if d=date()-1 then do;
      periode=2;
   end;
   else do;
      if d=date()-2 then do;
         periode=3;
      end;
      else do;
         if d >= intnx('week',date(),0,'B')+1 and d <= intnx('week',date(),0,'E')+1 then do;
            periode=4;
         end;
         else do;
            if d >= intnx('week',date(),-1,'B')+1 and d <= intnx('week',date(),-1,'E')+1 then do; 
               periode=5;
            end;
            else do;
               if d >= intnx('month',date(),0,'B') and d <= intnx('month',date(),0,'E') then do; 
                  periode=6;
               end;
               else do;
                  if d >= intnx('month',date(),-1,'B') and d <= intnx('month',date(),-1,'E') then do; 
                     periode=7;
                  end;
                  else do;
                     if d >= intnx('quarter',date(),0,'B') and d <= intnx('quarter',date(),0,'E') then do; 
                        periode=8;
                     end;
                     else do;
                        if d >= intnx('quarter',date(),-1,'B') and d <= intnx('quarter',date(),-1,'E') then do; 
                           periode=9;
                        end;
                     end;
                  end;
               end;     
            end;
         end;
      end;
   end;
end;

output;
d=d+1;
end;
run;

proc sql noprint;
create table LANDING2.DATA_ICOS_FSPI_N1 as
select t.*,
dhms(datepart(timestamp),0,0,0) length=8 format=DATETIME16. as TIMESTAMP_DATE,
case when IdEquipement = 24 then 'Rouge' ELSE 'Bleue' end length=5 format=$5. as VOIE,
datetime() length=8 format=DATETIME16. AS Date_Actualisation,
c.periode length=4 format=PERIODE. as PERIODE,
catx("-",ifc(Contour_Result In ('break'),'Cont',''),ifc(Front_Print_Result In ('Bad', 'bad'),'FP',''),ifc(Geometry_Result In ('bad'),'Geo',''),ifc(Presence_Result In ('Not Present'),'Pres',''),ifc(Surface_Result In ('bad', 'Bad'),'Surf','')) as DEFAULT_RESULT,
ifn(Contour_Result In ('break'),1,0) as Contour_Result_NB length=3 format=3.,
ifn(Front_Print_Result In ('Bad', 'bad'),1,0) as Front_Print_Result_NB length=3 format=3.,
ifn(Geometry_Result In ('bad'),1,0) as Geometry_Result_NB length=3 format=3.,
ifn(Presence_Result In ('Not Present'),1,0) as Presence_Result_NB length=3 format=3.,
ifn(Quality_Result_Classification In ('Not Present', 'break', 'Bad', 'bad'),1,0) as Quality_Result_NB length=3 format=3.,
ifn(Surface_Result In ('bad', 'Bad'),1,0) as Surface_Result_NB length=3 format=3.
from DATA_ICOS_FSPI_N1 as t,calendar as c
where 
calendar.d=datepart(t.timestamp);
quit;

proc sql noprint;
create table LANDING2.DATA_ICOS_FSPI_N1_INV as
select distinct TIMESTAMP_DATE,
VOIE,Date_Actualisation,PERIODE
from LANDING2.DATA_ICOS_FSPI_N1;
quit;

/* Synchronize table registration */
%registerTable(
     LIBRARY=%nrstr(/PHOTOWATT/Bibliothèques/LANDING_NP)
, REPOSID=%str(A5967C5U)
, TABLEID=%str(A5967C5U.BG00004F)
);
