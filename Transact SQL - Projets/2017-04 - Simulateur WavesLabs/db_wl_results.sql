--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

-- Started on 2017-04-19 15:04:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2142 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 16582)
-- Name: recipesettings; Type: TABLE; Schema: public; Owner: usr_wavelabs_admin
--

CREATE TABLE recipesettings (
    id bigint NOT NULL,
    "RecipeActivationTime" timestamp without time zone,
    "RecipeActivationTime_utc" timestamp without time zone,
    "RecipeName" character varying,
    "RecipeHash" character varying,
    "RecipeStepCount" integer,
    "StepNum" integer,
    "StepName" character varying,
    "StepType" character varying,
    "StartVoltage" double precision,
    "EndVoltage" double precision,
    "MeasurementTime" double precision,
    "SampleCount" integer,
    "PreMeasurementDelay" double precision,
    "MinSettlingTime" double precision,
    "IntensityCorrection" character varying,
    "TemperatureCorrection" character varying,
    "CurrentAmplifier" character varying,
    "VoltageAmplifier" character varying,
    "LightMode" character varying,
    "IntensityControl" character varying,
    "SetIntensity" double precision,
    "SpectrumType" character varying,
    "SpectrumName" character varying,
    "IntensityPercentage" double precision,
    "SunsVoc_StartIntensity" double precision,
    "SunsVoc_EndIntensity" double precision,
    "J01_2diodes_Mode" integer,
    "J02_2diodes_Mode" integer,
    "N1_2diodes_Mode" integer,
    "N2_2diodes_Mode" integer,
    "Rp_2diodes_Mode" integer,
    "EL_Voltage" double precision,
    "EL_ExposureTime" double precision,
    "IR_Voltage" double precision,
    "IR_BrightFrameInterval" double precision,
    "IR_VoltageOff" character varying,
    "LineRes" double precision,
    "Grid_DacVoltage" integer,
    "Grid_FrontSlope" double precision,
    "Grid_FrontOffset" double precision,
    "Grid_RearSlope" double precision,
    "Grid_RearOffset" double precision,
    "CellTypeName" character varying,
    "CellTypeHash" character varying,
    "BaseDoping" character varying,
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
    "TemperatureSensor" character varying,
    "PyrometerOffset" double precision,
    "ClassificationName" character varying,
    "ClassificationHash" character varying,
    "CalibrationDate_IV" character varying,
    "CalibrationComment_IV" character varying,
    "CalibrationDate_Intensity" timestamp without time zone,
    "CalibrationDate_Spectrum" timestamp without time zone,
    "SpectraRecordDate" timestamp without time zone,
    "VersionGUI_Long" character varying,
    "SerNum_IV" character varying,
    "FirmwareVersion_IV" character varying,
    "FirmwareInfo_IV" character varying,
    "FpgaVersion_IV" character varying,
    "SerNum_LE" character varying,
    "FirmwareVersion_LE" character varying,
    "FirmwareInfo_LE" character varying,
    "FpgaVersion_LE" character varying
);


ALTER TABLE recipesettings OWNER TO usr_wavelabs_admin;

--
-- TOC entry 185 (class 1259 OID 16580)
-- Name: recipesettings_id_seq; Type: SEQUENCE; Schema: public; Owner: usr_wavelabs_admin
--

CREATE SEQUENCE recipesettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recipesettings_id_seq OWNER TO usr_wavelabs_admin;

--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 185
-- Name: recipesettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: usr_wavelabs_admin
--

ALTER SEQUENCE recipesettings_id_seq OWNED BY recipesettings.id;


--
-- TOC entry 188 (class 1259 OID 16622)
-- Name: results; Type: TABLE; Schema: public; Owner: usr_wavelabs_admin
--

CREATE TABLE results (
    id bigint NOT NULL,
    "RunID" character varying,
    "TimeStamp_Flash" timestamp without time zone,
    "TimeStamp_Flash_utc" timestamp without time zone,
    "WaferID_Manu" character varying,
    "WaferID_Auto" character varying,
    "Comment" character varying,
    "RecipeName" character varying,
    "RecipeHash" character varying,
    "RecipeActivationTime" timestamp without time zone,
    "RecipeActivationTime_utc" timestamp without time zone,
    "StepNum" integer,
    "StepName" character varying,
    "StepCount" integer,
    "StepNum_light" integer,
    "StepNum_dark" integer,
    "StepNum_light50" integer,
    "StepNum_sunsvoc" integer,
    "StepNum_ir" integer,
    "StepNum_el" integer,
    "StepNum_lightreverse" integer,
    "StepNum_gridres" integer,
    "Class" character varying,
    "Bin" integer,
    "MatchingClassifierLine" integer,
    "Voc" double precision,
    "Isc" double precision,
    "Pmpp" double precision,
    "FF" double precision,
    "Eta" double precision,
    "Rs" double precision,
    "Rp" double precision,
    "Vmpp" double precision,
    "Impp" double precision,
    "Iat_Vlight1" double precision,
    "Iat_Vlight2" double precision,
    "Iat_Vlight3" double precision,
    "Idk_6" double precision,
    "Idk_10" double precision,
    "Idk_12" double precision,
    "Idk_13" double precision,
    "Idk_Vmin" double precision,
    "Idk_Imax" double precision,
    "Iat_Vdark1" double precision,
    "Iat_Vdark2" double precision,
    "Iat_Vdark3" double precision,
    "pVoc" double precision,
    "pIsc" double precision,
    "pFF" double precision,
    "pEta" double precision,
    "pImpp" double precision,
    "pVmpp" double precision,
    "EL_AvgVoltage" double precision,
    "EL_AvgCurrent" double precision,
    "EL_EnergyInput" double precision,
    "EL_DefectArea" integer,
    "EL_CountCracks" integer,
    "EL_CountScratches" integer,
    "EL_CountDarkAreas" integer,
    "EL_CountFingers" integer,
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
    "ErrorCode_TS" integer,
    "ErrorCode_LE" integer,
    "ErrorCode_IV" integer,
    "ErrorCode_IR" integer,
    "ErrorCode_EL" integer,
    "ErrorCode_CS" integer,
    "ErrorCode_AS" integer,
    "ErrorCode_PY" integer,
    "Temp_Cell" double precision,
    "Temp_Pyrometer" double precision,
    "Temp_PyroAverage" double precision,
    "Temp_Spectro" double precision,
    "Temp_Chiller" double precision,
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
    "Range_1100_1200" double precision
);


ALTER TABLE results OWNER TO usr_wavelabs_admin;

--
-- TOC entry 187 (class 1259 OID 16620)
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: usr_wavelabs_admin
--

CREATE SEQUENCE results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE results_id_seq OWNER TO usr_wavelabs_admin;

--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 187
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: usr_wavelabs_admin
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- TOC entry 2009 (class 2604 OID 16585)
-- Name: recipesettings id; Type: DEFAULT; Schema: public; Owner: usr_wavelabs_admin
--

ALTER TABLE ONLY recipesettings ALTER COLUMN id SET DEFAULT nextval('recipesettings_id_seq'::regclass);


--
-- TOC entry 2010 (class 2604 OID 16625)
-- Name: results id; Type: DEFAULT; Schema: public; Owner: usr_wavelabs_admin
--

ALTER TABLE ONLY results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- TOC entry 2133 (class 0 OID 16582)
-- Dependencies: 186
-- Data for Name: recipesettings; Type: TABLE DATA; Schema: public; Owner: usr_wavelabs_admin
--

INSERT INTO recipesettings VALUES (23, '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 1, '1/2sun', 'voltage_sweep_standard', -3.25, 0.75, 30, 100, 5, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (24, '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 2, '1sun', 'voltage_sweep_standard', -4, 1, 30, 100, 5, 50, 'no', 'yes', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (25, '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 3, 'sunsvoc', 'suns_voc_standard', -1, 1, 30, 200, 5, 50, 'no', 'yes', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, 0, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (26, '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 4, 'dark', 'voltage_sweep_standard', -16, 3, 50, 120, 5, 50, 'no', 'no', 'auto', 'auto', '0', 'no', 150, 'set_led_channels', 'light off', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', NULL, NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (27, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 1, '1sun', 'voltage_sweep_standard', 1, -5.25, 60, 100, 10, 50, 'no', 'yes', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (28, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 2, '0.5 Sun', 'voltage_sweep_standard', 1, -5.25, 60, 100, 10, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (29, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 3, 'Dark I-V', 'voltage_sweep_standard', 1, -5.25, 60, 100, 10, 50, 'no', 'no', 'auto', 'auto', '0', 'no', 150, 'set_led_channels', 'light off', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', NULL, NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (30, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 4, 'EL', 'voltage_sweep_standard', 1, -4, 100, 100, 10, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (31, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 5, 'Suns Voc', 'suns_voc_standard', 1, -4, 60, 100, 10, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, 0, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (32, '2017-04-19 14:56:04.741', '2017-04-19 12:56:04.741', 'WPVS', 'rLEjdn71luY6e3ZF', 6, 6, 'Grid R', 'voltage_sweep_standard', 1, -4, 100, 150, 10, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'WPVS', 'tbcrwTQ9H/Ut69Yy', 'p', 244.31, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -8, -12, -14, -0.10000000000000001, -3, -16, 'ManualInput@Statusline_Laboratory', 0, '', '', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (33, '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 1, '1/2sun', 'voltage_sweep_standard', -3.25, 0.75, 30, 100, 5, 50, 'no', 'no', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (34, '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 2, '1sun', 'voltage_sweep_standard', -4, 1, 30, 100, 5, 50, 'no', 'yes', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (35, '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 3, 'sunsvoc', 'suns_voc_standard', -1, 1, 30, 200, 5, 50, 'no', 'yes', 'auto', 'auto', '0', 'yes', 148.50999999999999, 'set_led_channels', 'AM1.5G', 100, 0, 110, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', '2017-04-18 14:52:55.893', NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');
INSERT INTO recipesettings VALUES (36, '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', 4, 4, 'dark', 'voltage_sweep_standard', -16, 3, 50, 120, 5, 50, 'no', 'no', 'auto', 'auto', '0', 'no', 150, 'set_led_channels', 'light off', 100, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 8191, 1, 0, 1, 0, 'default', 'tWHZqs3KIHWWHPNX', 'p', 243.36000000000001, 0.017999999999999999, -2.2000000000000002, 0, 0.5, 0.40000000000000002, 0.59999999999999998, -6, -12, -14, -2.5, -0.25, -16, 'PyrometerTemperatureRecipeAverage', 0.67800000000000005, 'TestClassification', 'cunZU/p8tRxrUpas', '2013-12-24 17:26:00', 'just an example', NULL, NULL, NULL, 'SinusGUI v2.403 (r6318.26433#32) E=(LE,IV,PY) dbg', 'WL-IV-123456', '0.0.0', 'emulation', 'UK(0)-0.0', 'default', '0.0.0', 'emulation', 'UK(0)-0.0');


--
-- TOC entry 2149 (class 0 OID 0)
-- Dependencies: 185
-- Name: recipesettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: usr_wavelabs_admin
--

SELECT pg_catalog.setval('recipesettings_id_seq', 36, true);


--
-- TOC entry 2135 (class 0 OID 16622)
-- Dependencies: 188
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: usr_wavelabs_admin
--

INSERT INTO results VALUES (5, 'sn18446208900512748507', '2017-04-19 14:54:20.49', '2017-04-19 12:54:20.49', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8288.1779999999999, 0, 8287.5, 0, NULL, 125, 11.214737001479197, 12.613306766123637, 1.3985697646444417, 1.9935813149978545, 1.9698099028418405, 2.3452432510725085, 2.5237811332469406, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (6, 'sn18446208900512748507', '2017-04-19 14:54:20.49', '2017-04-19 12:54:20.49', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1499.2293595868186, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1499.2293595868186, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8288.1779999999999, 0, 8287.5, 0, NULL, 125, 11.621501161644229, 13.020070926288671, 1.3985697646444417, 1.7976349804847653, 1.3537066873044534, 2.8020975170083782, 3.2857405775265809, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (7, 'sn18446208900512748507', '2017-04-19 14:54:20.49', '2017-04-19 12:54:20.49', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1499.2293595868186, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1499.2293595868186, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8288.1779999999999, 0, 8287.5, 0, NULL, 125, 11.03416355979061, 12.432733324435052, 1.3985697646444417, 1.5040418559711102, 1.8367113379347593, 2.2005299201991564, 3.1105590463655313, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (8, 'sn18446208900512748507', '2017-04-19 14:54:20.49', '2017-04-19 12:54:20.49', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8288.1779999999999, 0, 8287.5, 0, NULL, 125, 0.0010260853698730473, 0.0011159588073730473, 8.9873437500000039e-005, 0.00015072614440917966, 0.0001761086324591386, 0.00018898396285207651, 0.00014174541433233968, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (9, 'sn18446208900512748508', '2017-04-19 14:54:22.411', '2017-04-19 12:54:22.411', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8128.6779999999999, 0, 8128, 0, NULL, 125, 11.207283256265827, 12.605853020910269, 1.3985697646444417, 1.9915809466641701, 1.9724626526365008, 2.3446795717686268, 2.5162386858764765, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (10, 'sn18446208900512748508', '2017-04-19 14:54:22.411', '2017-04-19 12:54:22.411', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1462.2585370656946, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1462.2585370656946, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8128.6779999999999, 0, 8128, 0, NULL, 125, 11.629194030324349, 13.027763794968791, 1.3985697646444417, 1.79783136716817, 1.3543085390152814, 2.8098737915801304, 3.2848589332407157, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (11, 'sn18446208900512748508', '2017-04-19 14:54:22.411', '2017-04-19 12:54:22.411', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1462.2585370656946, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1462.2585370656946, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8128.6779999999999, 0, 8128, 0, NULL, 125, 11.043000167153567, 12.441569931798009, 1.3985697646444417, 1.5025406911028485, 1.8371421105233532, 2.2034648985313248, 3.1175310676759889, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (12, 'sn18446208900512748508', '2017-04-19 14:54:22.411', '2017-04-19 12:54:22.411', '', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8128.6779999999999, 0, 8128, 0, NULL, 125, 0.001026138366699219, 0.001116011804199219, 8.9873437500000039e-005, 0.00015052122369063525, 0.00017629490099455182, 0.00018834041057385896, 0.00014246061561986023, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (13, 'sn18446208900512748509', '2017-04-19 14:54:39.031', '2017-04-19 12:54:39.031', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8167.1779999999999, 0, 8166.5, 0, NULL, 125, 11.206335571616219, 12.604905336260661, 1.3985697646444417, 1.9952194966035106, 1.9686439686753288, 2.3445039690241996, 2.5156467379931278, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (14, 'sn18446208900512748509', '2017-04-19 14:54:39.031', '2017-04-19 12:54:39.031', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1471.1825307980378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1471.1825307980378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8167.1779999999999, 0, 8166.5, 0, NULL, 125, 11.629566007933203, 13.028135772577645, 1.3985697646444417, 1.7962868306236135, 1.3538530218254909, 2.806474185754146, 3.2906305704099013, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (15, 'sn18446208900512748509', '2017-04-19 14:54:39.031', '2017-04-19 12:54:39.031', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1471.1825307980378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1471.1825307980378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8167.1779999999999, 0, 8166.5, 0, NULL, 125, 11.039539942926776, 12.438109707571218, 1.3985697646444417, 1.501480018404052, 1.8367204462336451, 2.2016997210388136, 3.1173183579302148, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (16, 'sn18446208900512748509', '2017-04-19 14:54:39.031', '2017-04-19 12:54:39.031', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8167.1779999999999, 0, 8166.5, 0, NULL, 125, 0.0010261849853515628, 0.0011160584228515626, 8.9873437500000039e-005, 0.00015092017035233347, 0.00017601835311086551, 0.00018889893573961763, 0.00014182631032843342, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (17, 'sn18446208900512748510', '2017-04-19 14:54:41.222', '2017-04-19 12:54:41.222', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8191.6779999999999, 0, 8191, 0, NULL, 125, 11.226309905303173, 12.624879669947614, 1.3985697646444417, 1.9962251917896439, 1.9675254522698389, 2.355993052592622, 2.5242448093310164, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (18, 'sn18446208900512748510', '2017-04-19 14:54:41.222', '2017-04-19 12:54:41.222', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1476.8614321996286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1476.8614321996286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8191.6779999999999, 0, 8191, 0, NULL, 125, 11.618783654466808, 13.017353419111249, 1.3985697646444417, 1.7965847295639423, 1.354452879599821, 2.8042072144264303, 3.2812174315565628, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (19, 'sn18446208900512748510', '2017-04-19 14:54:41.222', '2017-04-19 12:54:41.222', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1476.8614321996286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1476.8614321996286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8191.6779999999999, 0, 8191, 0, NULL, 125, 11.050218070507512, 12.448787835151954, 1.3985697646444417, 1.5011239684935016, 1.8382192496158742, 2.2113260194752771, 3.1172274336028076, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (20, 'sn18446208900512748510', '2017-04-19 14:54:41.222', '2017-04-19 12:54:41.222', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8191.6779999999999, 0, 8191, 0, NULL, 125, 0.0010268476196289066, 0.0011167210571289066, 8.9873437500000039e-005, 0.00015080958669562086, 0.0001769055530748869, 0.00018844100679096427, 0.00014217025724712175, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (21, 'sn18446208900512748511', '2017-04-19 14:54:44.858', '2017-04-19 12:54:44.858', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8426.6779999999999, 0, 8426, 0, NULL, 125, 11.19864156264364, 12.597211327288083, 1.3985697646444417, 1.988610518765858, 1.9630424437927081, 2.3470355876333744, 2.5176316131316483, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (22, 'sn18446208900512748511', '2017-04-19 14:54:44.858', '2017-04-19 12:54:44.858', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1531.332552750554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1531.332552750554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8426.6779999999999, 0, 8426, 0, NULL, 125, 11.618855664409203, 13.017425429053645, 1.3985697646444417, 1.7937684468145021, 1.3551554494582927, 2.7998762086867606, 3.2877341601295962, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (23, 'sn18446208900512748511', '2017-04-19 14:54:44.858', '2017-04-19 12:54:44.858', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1531.332552750554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1531.332552750554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8426.6779999999999, 0, 8426, 0, NULL, 125, 11.054719006346108, 12.45328877099055, 1.3985697646444417, 1.5018069667274612, 1.839830627776982, 2.2082743621871468, 3.1224856503344665, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (24, 'sn18446208900512748511', '2017-04-19 14:54:44.858', '2017-04-19 12:54:44.858', 'Test Lot1', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8426.6779999999999, 0, 8426, 0, NULL, 125, 0.0010255382385253909, 0.001115411676025391, 8.9873437500000039e-005, 0.00015054475097656253, 0.00017574305323550578, 0.00018865681184467516, 0.00014207240664833475, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (25, 'sn18446208900512748512', '2017-04-19 14:54:54.719', '2017-04-19 12:54:54.719', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8274.6779999999999, 0, 8274, 0, NULL, 125, 11.206375329211141, 12.604945093855584, 1.3985697646444417, 1.9948806262943335, 1.9626006537326903, 2.3477885694330647, 2.5187840804310011, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (26, 'sn18446208900512748512', '2017-04-19 14:54:54.719', '2017-04-19 12:54:54.719', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1496.1001689426246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1496.1001689426246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8274.6779999999999, 0, 8274, 0, NULL, 125, 11.617844918226307, 13.016414682870749, 1.3985697646444417, 1.7923252537876588, 1.357127875510205, 2.8080904586351547, 3.2779799309732365, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (27, 'sn18446208900512748512', '2017-04-19 14:54:54.719', '2017-04-19 12:54:54.719', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1496.1001689426246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1496.1001689426246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8274.6779999999999, 0, 8274, 0, NULL, 125, 11.047246110492019, 12.445815875136461, 1.3985697646444417, 1.5022093965146066, 1.8372176452463673, 2.2064402488292316, 3.1190574205817612, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (28, 'sn18446208900512748512', '2017-04-19 14:54:54.719', '2017-04-19 12:54:54.719', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8274.6779999999999, 0, 8274, 0, NULL, 125, 0.0010268573608398441, 0.0011167307983398441, 8.9873437500000039e-005, 0.0001508971939890008, 0.00017653953969855058, 0.00018862198325709292, 0.00014227742807488696, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (29, 'sn18446208900512748513', '2017-04-19 14:54:57.456', '2017-04-19 12:54:57.456', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8206.6779999999999, 0, 8206, 0, NULL, 125, 11.213494508454827, 12.61206427309927, 1.3985697646444417, 1.9922495859454372, 1.969072292852083, 2.3459815702568529, 2.5238696600804018, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (30, 'sn18446208900512748513', '2017-04-19 14:54:57.456', '2017-04-19 12:54:57.456', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1480.3383081014533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1480.3383081014533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8206.6779999999999, 0, 8206, 0, NULL, 125, 11.626629434342528, 13.025199198986968, 1.3985697646444417, 1.7951309299592553, 1.3505759436380083, 2.8079974483883365, 3.2906037130368757, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (31, 'sn18446208900512748513', '2017-04-19 14:54:57.456', '2017-04-19 12:54:57.456', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1480.3383081014533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1480.3383081014533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8206.6779999999999, 0, 8206, 0, NULL, 125, 11.034424263033067, 12.432994027677507, 1.3985697646444417, 1.4991837793116098, 1.8366476330702615, 2.2025108076491047, 3.1137606436820384, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (32, 'sn18446208900512748513', '2017-04-19 14:54:57.456', '2017-04-19 12:54:57.456', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8206.6779999999999, 0, 8206, 0, NULL, 125, 0.0010258195739746097, 0.0011156930114746097, 8.9873437500000039e-005, 0.0001506471464458265, 0.00017617476356907898, 0.00018839100373920645, 0.00014208544440018507, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (33, 'sn18446208900512748514', '2017-04-19 14:55:02.824', '2017-04-19 12:55:02.824', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8153.1779999999999, 0, 8152.5, 0, NULL, 125, 11.213528310461113, 12.612098075105555, 1.3985697646444417, 1.994154822143257, 1.9705886074552033, 2.3478975747461828, 2.5185659067964177, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (34, 'sn18446208900512748514', '2017-04-19 14:55:02.824', '2017-04-19 12:55:02.824', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1467.9374399204989, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1467.9374399204989, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8153.1779999999999, 0, 8152.5, 0, NULL, 125, 11.612758191388735, 13.011327956033178, 1.3985697646444417, 1.7901657830478148, 1.3507229138671142, 2.8030362995616267, 3.286511795592129, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (35, 'sn18446208900512748514', '2017-04-19 14:55:02.824', '2017-04-19 12:55:02.824', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1467.9374399204989, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1467.9374399204989, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8153.1779999999999, 0, 8152.5, 0, NULL, 125, 11.044616034981171, 12.443185799625613, 1.3985697646444417, 1.5004509858886419, 1.8395503534712025, 2.2032432382454532, 3.119050058055822, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (36, 'sn18446208900512748514', '2017-04-19 14:55:02.824', '2017-04-19 12:55:02.824', 'Test Lot1', NULL, 'Comment Test 1', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:54:10.633', '2017-04-19 12:54:10.633', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8153.1779999999999, 0, 8152.5, 0, NULL, 125, 0.0010270013916015629, 0.0011168748291015629, 8.9873437500000039e-005, 0.00015117683266087581, 0.00017641443561754733, 0.00018900434506064964, 0.00014188456244217728, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (37, 'sn18446208900512748515', '2017-04-19 14:56:38.351', '2017-04-19 12:56:38.351', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8053.1779999999999, 0, 8052.5, 0, NULL, 125, 11.207330050505945, 12.605899815150387, 1.3985697646444417, 1.99734801113436, 1.963175395316239, 2.3467159707393326, 2.517769273995961, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (38, 'sn18446208900512748515', '2017-04-19 14:56:38.351', '2017-04-19 12:56:38.351', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1444.7582376383252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1444.7582376383252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8053.1779999999999, 0, 8052.5, 0, NULL, 125, 11.619236293710955, 13.017806058355397, 1.3985697646444417, 1.7920981844283144, 1.3499299520553592, 2.8093335039426979, 3.2855532539645322, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (39, 'sn18446208900512748515', '2017-04-19 14:56:38.351', '2017-04-19 12:56:38.351', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1444.7582376383252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1444.7582376383252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8053.1779999999999, 0, 8052.5, 0, NULL, 125, 11.045501129398543, 12.444070894042985, 1.3985697646444417, 1.5006334954595615, 1.8356864330021438, 2.2063020900804617, 3.1205577115363252, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (40, 'sn18446208900512748515', '2017-04-19 14:56:38.351', '2017-04-19 12:56:38.351', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8053.1779999999999, 0, 8052.5, 0, NULL, 125, 0.0010259924804687504, 0.0011158659179687504, 8.9873437500000039e-005, 0.00015105764063784948, 0.00017614351549650496, 0.00018848267709832442, 0.00014178743141575868, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (41, 'sn18446208900512748516', '2017-04-19 14:56:44.063', '2017-04-19 12:56:44.063', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8271.1779999999999, 0, 8270.5, 0, NULL, 125, 11.196687615759529, 12.59525738040397, 1.3985697646444417, 1.9947295511030292, 1.9610877335765078, 2.3359798954379785, 2.5225690363219617, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (42, 'sn18446208900512748516', '2017-04-19 14:56:44.063', '2017-04-19 12:56:44.063', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1495.288895497956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1495.288895497956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8271.1779999999999, 0, 8270.5, 0, NULL, 125, 11.628679952777306, 13.027249717421748, 1.3985697646444417, 1.7972860618763389, 1.3561167909097804, 2.8058029674109424, 3.2871527332601924, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (43, 'sn18446208900512748516', '2017-04-19 14:56:44.063', '2017-04-19 12:56:44.063', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1495.288895497956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1495.288895497956, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8271.1779999999999, 0, 8270.5, 0, NULL, 125, 11.036104472598037, 12.434674237242479, 1.3985697646444417, 1.4974953432413172, 1.83806372135217, 2.2036852324675205, 3.1145387762169783, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (44, 'sn18446208900512748516', '2017-04-19 14:56:44.063', '2017-04-19 12:56:44.063', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8271.1779999999999, 0, 8270.5, 0, NULL, 125, 0.0010264605224609379, 0.0011163339599609377, 8.9873437500000039e-005, 0.00015068314241108144, 0.00017639454104774878, 0.0001885938825105366, 0.00014226774067125825, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (45, 'sn18446208900512748517', '2017-04-19 14:56:49.619', '2017-04-19 12:56:49.619', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8238.1779999999999, 0, 8237.5, 0, NULL, 125, 11.196515109789235, 12.595084874433676, 1.3985697646444417, 1.9918899201589966, 1.9649779896690545, 2.3379539309494537, 2.5193718696916778, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (46, 'sn18446208900512748517', '2017-04-19 14:56:49.619', '2017-04-19 12:56:49.619', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1487.6397591398477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1487.6397591398477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8238.1779999999999, 0, 8237.5, 0, NULL, 125, 11.61111768640199, 13.009687451046432, 1.3985697646444417, 1.7890023177112084, 1.3516485024497955, 2.8017656144556655, 3.2863798524652692, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (47, 'sn18446208900512748517', '2017-04-19 14:56:49.619', '2017-04-19 12:56:49.619', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1487.6397591398477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1487.6397591398477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8238.1779999999999, 0, 8237.5, 0, NULL, 125, 11.049070036924771, 12.447639801569213, 1.3985697646444417, 1.5060441767347057, 1.8355612502590437, 2.2001672046297767, 3.1249760059811926, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (48, 'sn18446208900512748517', '2017-04-19 14:56:49.619', '2017-04-19 12:56:49.619', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8238.1779999999999, 0, 8237.5, 0, NULL, 125, 0.0010253947875976566, 0.0011152682250976566, 8.9873437500000039e-005, 0.00015067326611970601, 0.00017587079772949217, 0.00018857389365748356, 0.00014175561427066206, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (49, 'sn18446208900512748518', '2017-04-19 14:56:55.215', '2017-04-19 12:56:55.215', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8428.6779999999999, 0, 8428, 0, NULL, 125, 11.203604754916336, 12.602174519560776, 1.3985697646444417, 1.9954287306323371, 1.9625771585611995, 2.3393793017666176, 2.5238981646361291, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (50, 'sn18446208900512748518', '2017-04-19 14:56:55.215', '2017-04-19 12:56:55.215', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1531.7961367950079, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1531.7961367950079, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8428.6779999999999, 0, 8428, 0, NULL, 125, 11.629713323468527, 13.028283088112969, 1.3985697646444417, 1.7933200277716979, 1.3511913309282153, 2.8113293630901026, 3.2915512023584599, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (51, 'sn18446208900512748518', '2017-04-19 14:56:55.215', '2017-04-19 12:56:55.215', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1531.7961367950079, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1531.7961367950079, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8428.6779999999999, 0, 8428, 0, NULL, 125, 11.028234418287578, 12.42680418293202, 1.3985697646444417, 1.4967476976115985, 1.8310181838878552, 2.2018880790731821, 3.116259058394891, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (52, 'sn18446208900512748518', '2017-04-19 14:56:55.215', '2017-04-19 12:56:55.215', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8428.6779999999999, 0, 8428, 0, NULL, 125, 0.0010260419982910159, 0.001115915435791016, 8.9873437500000039e-005, 0.0001506195895546361, 0.00017614602596885279, 0.00018883846323113689, 0.00014191670371607734, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (53, 'sn18446208900512748519', '2017-04-19 14:57:00.774', '2017-04-19 12:57:00.774', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8186.6779999999999, 0, 8186, 0, NULL, 125, 11.202785279530774, 12.601355044175216, 1.3985697646444417, 1.9873911696231186, 1.9665018442164268, 2.3465699168358332, 2.5200009495353441, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (54, 'sn18446208900512748519', '2017-04-19 14:57:00.774', '2017-04-19 12:57:00.774', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1475.7024707339733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1475.7024707339733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8186.6779999999999, 0, 8186, 0, NULL, 125, 11.615944275388799, 13.014514040033241, 1.3985697646444417, 1.7922333219753992, 1.3561221708845617, 2.8015686859502291, 3.2836986972585573, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (55, 'sn18446208900512748519', '2017-04-19 14:57:00.774', '2017-04-19 12:57:00.774', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1475.7024707339733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1475.7024707339733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8186.6779999999999, 0, 8186, 0, NULL, 125, 11.036933773976429, 12.435503538620871, 1.3985697646444417, 1.501885258975691, 1.8312307159711123, 2.1988342921290092, 3.1226621075805658, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (56, 'sn18446208900512748519', '2017-04-19 14:57:00.774', '2017-04-19 12:57:00.774', 'Test Lot2', NULL, 'Comment Test 2', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8186.6779999999999, 0, 8186, 0, NULL, 125, 0.0010269379577636721, 0.0011168113952636722, 8.9873437500000039e-005, 0.00015068469174033718, 0.00017626254947060037, 0.00018911246530633222, 0.00014235703542608968, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (57, 'sn18446208900512748520', '2017-04-19 14:57:07.929', '2017-04-19 12:57:07.929', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8399.1779999999999, 0, 8398.5, 0, NULL, 125, 11.211315910220259, 12.609885674864701, 1.3985697646444417, 1.9929878146555753, 1.970143917673177, 2.3483787619426186, 2.517484016628837, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (58, 'sn18446208900512748520', '2017-04-19 14:57:07.929', '2017-04-19 12:57:07.929', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1524.9582725194873, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1524.9582725194873, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8399.1779999999999, 0, 8398.5, 0, NULL, 125, 11.608995817828323, 13.007565582472765, 1.3985697646444417, 1.7922633212211052, 1.3481305718542309, 2.8008139512206509, 3.2854665742122835, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (59, 'sn18446208900512748520', '2017-04-19 14:57:07.929', '2017-04-19 12:57:07.929', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1524.9582725194873, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1524.9582725194873, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8399.1779999999999, 0, 8398.5, 0, NULL, 125, 11.04502606387552, 12.443595828519962, 1.3985697646444417, 1.502972219082005, 1.8430819942731216, 2.2035004972355781, 3.1131499539647636, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (60, 'sn18446208900512748520', '2017-04-19 14:57:07.929', '2017-04-19 12:57:07.929', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8399.1779999999999, 0, 8398.5, 0, NULL, 125, 0.0010267197082519536, 0.0011165931457519536, 8.9873437500000039e-005, 0.00015102898672003499, 0.00017596293479517889, 0.00018886972865054489, 0.000142336842265882, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (61, 'sn18446208900512748521', '2017-04-19 14:57:13.471', '2017-04-19 12:57:13.471', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8209.1779999999999, 0, 8208.5, 0, NULL, 125, 11.21038811173837, 12.60895787638281, 1.3985697646444417, 1.9944295532479099, 1.9693557340400729, 2.3349339236127817, 2.5293475015175528, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (62, 'sn18446208900512748521', '2017-04-19 14:57:13.471', '2017-04-19 12:57:13.471', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1480.9177923773195, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1480.9177923773195, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8209.1779999999999, 0, 8208.5, 0, NULL, 125, 11.633708789138362, 13.032278553782803, 1.3985697646444417, 1.7965168237276847, 1.3590591280748696, 2.8073973296271584, 3.2884141083885972, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (63, 'sn18446208900512748521', '2017-04-19 14:57:13.471', '2017-04-19 12:57:13.471', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1480.9177923773195, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1480.9177923773195, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8209.1779999999999, 0, 8208.5, 0, NULL, 125, 11.048089317777391, 12.446659082421833, 1.3985697646444417, 1.5035663577522516, 1.8369216027357915, 2.208051213959461, 3.1172287440098354, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (64, 'sn18446208900512748521', '2017-04-19 14:57:13.471', '2017-04-19 12:57:13.471', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8209.1779999999999, 0, 8208.5, 0, NULL, 125, 0.0010257980041503908, 0.0011156714416503909, 8.9873437500000039e-005, 0.00015067669902600736, 0.00017573382568359373, 0.00018871129889237251, 0.0001421549647281045, 0.00012839062500000009, 0.00024013059082031275, 0);
INSERT INTO results VALUES (65, 'sn18446208900512748522', '2017-04-19 14:57:19.106', '2017-04-19 12:57:19.106', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 1, '1/2sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 0.60497856725549559, 3.8818004595019246, 1.8574644150016444, 79.094685988717728, 15.265157914214697, NULL, NULL, 0.50959148518227682, 3.6450067730963838, 3.7027561267741191, 3.8619439245577727, 0.50361503846943378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.60497856725549559, 3.8818004595019246, NULL, 15.265157914214697, 3.6450067730963838, 0.50959148518227682, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8395.6779999999999, 0, 8395, 0, NULL, 125, 11.2164286937358, 12.614998458380242, 1.3985697646444417, 1.9957848780628242, 1.9697637303214541, 2.3439859580840006, 2.5245727279474695, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (66, 'sn18446208900512748522', '2017-04-19 14:57:19.106', '2017-04-19 12:57:19.106', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 2, '1sun', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1524.1470005451013, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1524.1470005451013, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8395.6779999999999, 0, 8395, 0, NULL, 125, 11.626679557223529, 13.025249321867971, 1.3985697646444417, 1.7950852376917921, 1.3542686986209833, 2.8154017423326372, 3.2796024792580654, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (67, 'sn18446208900512748522', '2017-04-19 14:57:19.106', '2017-04-19 12:57:19.106', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 3, 'sunsvoc', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, 1524.1470005451013, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1524.1470005451013, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8395.6779999999999, 0, 8395, 0, NULL, 125, 11.029313491164871, 12.427883255809313, 1.3985697646444417, 1.4994379400774294, 1.8302090963995421, 2.1976635103166369, 3.1196815450512108, 2.3820812687292325, 0.00024013059082031275, 0);
INSERT INTO results VALUES (68, 'sn18446208900512748522', '2017-04-19 14:57:19.106', '2017-04-19 12:57:19.106', 'Test Lot2', NULL, '', 'SunsVoc-short', 'rHMN2Dgi6YF66aau', '2017-04-19 14:56:20.974', '2017-04-19 12:56:20.974', 4, 'dark', 4, 1, 4, NULL, 3, NULL, NULL, NULL, NULL, 'Impp_fail', 3, 9, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, 735.44562266072307, NULL, NULL, NULL, NULL, NULL, 0.060916707612864787, 0.22628207218197216, 0.33004095780983028, 0.38653312030094422, -15.717823930404856, 0.61695117482382911, 0.060916707612864787, 0.33004095780983028, 0.44933706296839393, NULL, -0.024567788668743203, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -99, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 0, 0, 8395.6779999999999, 0, 8395, 0, NULL, 125, 0.0010262764831542972, 0.0011161499206542972, 8.9873437500000039e-005, 0.0001508589331375925, 0.00017617576020893298, 0.00018852706090023643, 0.00014219351308722249, 0.00012839062500000009, 0.00024013059082031275, 0);


--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 187
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: usr_wavelabs_admin
--

SELECT pg_catalog.setval('results_id_seq', 68, true);


--
-- TOC entry 2012 (class 2606 OID 16590)
-- Name: recipesettings recipesettings_pkey; Type: CONSTRAINT; Schema: public; Owner: usr_wavelabs_admin
--

ALTER TABLE ONLY recipesettings
    ADD CONSTRAINT recipesettings_pkey PRIMARY KEY (id);


--
-- TOC entry 2014 (class 2606 OID 16630)
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: usr_wavelabs_admin
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 186
-- Name: recipesettings; Type: ACL; Schema: public; Owner: usr_wavelabs_admin
--

GRANT SELECT ON TABLE recipesettings TO grp_public_read;
GRANT SELECT,INSERT,DELETE,TRUNCATE,UPDATE ON TABLE recipesettings TO grp_public_write;


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 185
-- Name: recipesettings_id_seq; Type: ACL; Schema: public; Owner: usr_wavelabs_admin
--

GRANT SELECT,USAGE ON SEQUENCE recipesettings_id_seq TO grp_public_read;
GRANT SELECT,USAGE ON SEQUENCE recipesettings_id_seq TO grp_public_write;


--
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 188
-- Name: results; Type: ACL; Schema: public; Owner: usr_wavelabs_admin
--

GRANT SELECT ON TABLE results TO grp_public_read;
GRANT SELECT,INSERT,DELETE,TRUNCATE,UPDATE ON TABLE results TO grp_public_write;


--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 187
-- Name: results_id_seq; Type: ACL; Schema: public; Owner: usr_wavelabs_admin
--

GRANT SELECT,USAGE ON SEQUENCE results_id_seq TO grp_public_read;
GRANT SELECT,USAGE ON SEQUENCE results_id_seq TO grp_public_write;


-- Completed on 2017-04-19 15:04:10

--
-- PostgreSQL database dump complete
--

