-- Table: "results"

-- DROP TABLE "results";

CREATE TABLE public."results"
(
   id bigserial,
   
-- General Information   
   "RunID" varchar, 
   "TimeStamp_Flash" timestamp without time zone,
   "TimeStamp_Flash_utc" timestamp without time zone,
   "WaferID_Manu" varchar,
   "WaferID_Auto" varchar,  
   "Comment" varchar,  
   
-- Recipe Definition   
   "RecipeName" varchar,
   "RecipeHash" varchar,   
   "RecipeActivationTime" timestamp without time zone,   
   "RecipeActivationTime_utc" timestamp without time zone,   
   "StepNum" integer,
   "StepName" varchar,   
   
-- step types
   "StepCount" integer,   
   "StepNum_light" integer,   
   "StepNum_dark" integer,   
   "StepNum_light50" integer,   
   "StepNum_sunsvoc" integer,   
   "StepNum_ir" integer,   
   "StepNum_el" integer,   
   "StepNum_lightreverse" integer,   
   "StepNum_gridres" integer,   
   
-- Classification   
   "Class" varchar,
   "Bin" integer,
   "MatchingClassifierLine" integer,   
   
-- Results   
   "Voc" double precision,    
   "Isc" double precision,    
   "Pmpp" double precision,    
   "FF" double precision,    
   "Eta" double precision,   
   "Rs" double precision,    
   "Rp" double precision,    

-- Light
   "Vmpp" double precision,    
   "Impp" double precision,
   "Iat_Vlight1" double precision, 
   "Iat_Vlight2" double precision,
   "Iat_Vlight3" double precision,    
   
-- Dark   
   "Idk_6" double precision, 
   "Idk_10" double precision, 
   "Idk_12" double precision, 
   "Idk_13" double precision, 
   "Idk_Vmin" double precision, 
   "Idk_Imax" double precision,
   "Iat_Vdark1" double precision,
   "Iat_Vdark2" double precision, 
   "Iat_Vdark3" double precision,   
   
-- SunsVoc
   "pVoc" double precision,
   "pIsc" double precision,
   "pFF" double precision,
   "pEta" double precision,
   "pImpp" double precision,
   "pVmpp" double precision,
      
-- EL
   "EL_AvgVoltage" double precision,
   "EL_AvgCurrent" double precision,
   "EL_EnergyInput" double precision,
   "EL_DefectArea" integer,
   "EL_CountCracks" integer,
   "EL_CountScratches" integer,
   "EL_CountDarkAreas" integer,
   "EL_CountFingers" integer,

-- IR   
   "IR_AvgVoltage" double precision,
   "IR_AvgCurrent" double precision,
   "IR_EnergyInput" double precision,
   "IR_EnergyValue" double precision,
   "IR_MatShunt" double precision,
   "IR_NormShunt" double precision,
   "IR_QShunt" double precision,
   "IR_AvgGray" double precision,
   "IR_MaxGray" double precision,
   "IR_MinGray" double precision,
   "IR_StdDevGray" double precision,
   "IR_VarGray" double precision,
   "IR_DefectArea" integer,   
   "IR_MaxPtot" double precision,
   
-- 2 Diodes Model - ISFH   
   "J0_Voc" double precision,
   "Ideal_FF" double precision,
   "Rs_FF" double precision,
   "Rs_Dark_LightDark" double precision,
   "Rs_Light_LightDark" double precision,
   "N_Light_Voc" double precision,
   "N_Light_Vmpp" double precision,
   "N_SunsVoc_Voc" double precision,
   "N_SunsVoc_Vmpp" double precision,
   "Fit_2diodes_SunsVoc" integer,
   "J01_2diodes_SunsVoc" double precision,
   "J02_2diodes_SunsVoc" double precision,
   "N1_2diodes_SunsVoc" double precision,
   "N2_2diodes_SunsVoc" double precision,
   "Rp_2diodes_SunsVoc" double precision,
   
-- Grid Measurement
  
   "Grid_Front1" double precision,
   "Grid_Front2" double precision,
   "Grid_Front3" double precision,
   "Grid_Front4" double precision,
   "Grid_Front5" double precision,
   "Grid_Front6" double precision,
   "Grid_Front7" double precision,
   "Grid_Front8" double precision,
   "Grid_Rear1" double precision,
   "Grid_Rear2" double precision,
   "Grid_Rear3" double precision,
   "Grid_Rear4" double precision,
   "Grid_Rear5" double precision,
   "Grid_Rear6" double precision,
   "Grid_Rear7" double precision,
   "Grid_Rear8" double precision,

-- Error Codes
   "ErrorCode_TS" integer,
   "ErrorCode_LE" integer,
   "ErrorCode_IV" integer,
   "ErrorCode_IR" integer,
   "ErrorCode_EL" integer,
   "ErrorCode_CS" integer,
   "ErrorCode_AS" integer,
   "ErrorCode_PY" integer,

-- Temperature
   "Temp_Cell" double precision,   
   "Temp_Pyrometer" double precision,   
   "Temp_PyroAverage" double precision,   
   "Temp_Spectro" double precision,   
   "Temp_Chiller" double precision,   
   
-- Irradiance 
   "Intensity@25C" double precision, 
   "Irradiance_400_1100" double precision, 
   "Irradiance_300_1200" double precision, 
   "Range_300_400" double precision, 
   "Range_400_500" double precision, 
   "Range_500_600" double precision, 
   "Range_600_700" double precision, 
   "Range_700_800" double precision, 
   "Range_800_900" double precision, 
   "Range_900_1100" double precision, 
   "Range_1100_1200" double precision, 
   
   PRIMARY KEY (id) USING INDEX TABLESPACE pg_default
) 
WITH (
  OIDS = FALSE
)

TABLESPACE pg_default;
ALTER TABLE public."results"
  OWNER TO usr_wavelabs_admin;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE public."results" TO GROUP grp_public_write;
GRANT SELECT ON TABLE public."results" TO GROUP grp_public_read;

-- change automatically created sequence
GRANT SELECT, USAGE ON TABLE "results_id_seq" TO grp_public_read;
GRANT SELECT, USAGE ON TABLE "results_id_seq" TO grp_public_write;


