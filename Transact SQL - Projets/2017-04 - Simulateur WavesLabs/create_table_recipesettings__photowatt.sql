-- Table: "recipesettings"

-- DROP TABLE "recipesettings";

CREATE TABLE public."recipesettings"
(
   id bigserial, 
   "RecipeActivationTime" timestamp without time zone,
   "RecipeActivationTime_utc" timestamp without time zone,
   
-- Recipe Definition
   "RecipeName" varchar,
   "RecipeHash" varchar,
   "RecipeStepCount" integer,
   "StepNum" integer,
   "StepName" varchar,
   "StepType" varchar,

-- Generic Steps settings
   "StartVoltage" double precision, 
   "EndVoltage" double precision, 
   "MeasurementTime" double precision, 
   "SampleCount" integer, 
   "PreMeasurementDelay" double precision,
   "MinSettlingTime" double precision, 
   "IntensityCorrection" varchar,
   "TemperatureCorrection" varchar,
   "CurrentAmplifier" varchar,
   "VoltageAmplifier" varchar,
   
-- Light Settings   
   "LightMode" varchar,
   "IntensityControl" varchar,
   "SetIntensity" double precision,
   "SpectrumType" varchar,
   "SpectrumName" varchar,
   "IntensityPercentage" double precision,

-- SunsVoc
   "SunsVoc_StartIntensity" double precision,
   "SunsVoc_EndIntensity" double precision,   
   "J01_2diodes_Mode" integer,
   "J02_2diodes_Mode" integer,
   "N1_2diodes_Mode" integer,
   "N2_2diodes_Mode" integer,
   "Rp_2diodes_Mode" integer,
   
-- EL 
   "EL_Voltage" double precision, 
   "EL_ExposureTime" double precision, 
   
-- IR   
   "IR_Voltage" double precision, 
   "IR_BrightFrameInterval" double precision,    
   "IR_VoltageOff" varchar,   
   
-- Contacting Unit  
   "LineRes" double precision, 
   "Grid_DacVoltage" integer,
   
   "Grid_FrontSlope" double precision, 
   "Grid_FrontOffset" double precision, 
   "Grid_RearSlope" double precision, 
   "Grid_RearOffset" double precision,   

-- Cell Definition
   "CellTypeName" varchar,
   "CellTypeHash" varchar,
   "BaseDoping" varchar,
   "Area" double precision,
   
   "Alpha" double precision, 
   "Beta" double precision, 
   "Kappa" double precision,

   "Vlight1" double precision, 
   "Vlight2" double precision, 
   "Vlight3" double precision,   
   "Vdark1" double precision, 
   "Vdark2" double precision, 
   "Vdark3" double precision,  

   "RpStartVoltage" double precision, 
   "RpEndVoltage" double precision,   
   "VrevMin_CurrentLimit" double precision,
   
   "TemperatureSensor" varchar, 
   "PyrometerOffset" double precision,   

-- Classification   
   "ClassificationName" varchar,
   "ClassificationHash" varchar,   
   
-- Calibrations   
   "CalibrationDate_IV" varchar,
   "CalibrationComment_IV" varchar,
   "CalibrationDate_Intensity" timestamp without time zone,   
   "CalibrationDate_Spectrum" timestamp without time zone,   
   "SpectraRecordDate" timestamp without time zone,   
   
-- System Identification   
   "VersionGUI_Long" varchar,
   "SerNum_IV" varchar,
   "FirmwareVersion_IV" varchar,
   "FirmwareInfo_IV" varchar,   
   "FpgaVersion_IV" varchar,    
   "SerNum_LE" varchar,
   "FirmwareVersion_LE" varchar,
   "FirmwareInfo_LE" varchar,
   "FpgaVersion_LE" varchar,
    
   PRIMARY KEY (id) USING INDEX TABLESPACE pg_default
) 
WITH (
  OIDS = FALSE
)

TABLESPACE pg_default;
ALTER TABLE public."recipesettings"
  OWNER TO usr_wavelabs_admin;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE public."recipesettings" TO GROUP grp_public_write;
GRANT SELECT ON TABLE public."recipesettings" TO GROUP grp_public_read;

-- change automatically created sequence
GRANT SELECT, USAGE ON TABLE "recipesettings_id_seq" TO grp_public_read;
GRANT SELECT, USAGE ON TABLE "recipesettings_id_seq" TO grp_public_write;


