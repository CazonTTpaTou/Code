/* ------------------------------------------------------------- */
/* CREATION DES TABLES DE MESURES                                */
/* ------------------------------------------------------------- */

/* Utilisation de la base INLINE_CELL_DB */
USE [CELL_INLINE_DB] 
GO

/* ---------------------------------------------------------------- */
/* REINITIALISATION DE LA BASE DE DONNEES    		      			*/
/* ---------------------------------------------------------------- */

IF OBJECT_ID('dbo.WAFER_TRI', 'U') IS NOT NULL 
	DROP TABLE [dbo].[WAFER_TRI]	
IF OBJECT_ID('dbo.WAFER_TRI_LOT', 'U') IS NOT NULL 
	DROP TABLE [dbo].[WAFER_TRI_LOT]	
IF OBJECT_ID('dbo.WAFER_WAV', 'U') IS NOT NULL 
	DROP TABLE [dbo].[WAFER_WAV]	
IF OBJECT_ID('dbo.RECIPE_WAV', 'U') IS NOT NULL 
	DROP TABLE [dbo].[RECIPE_WAV]	
IF OBJECT_ID('dbo.TP_STATUT_WAFER_WAV_DETAIL', 'U') IS NOT NULL 
	DROP TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL]	
IF OBJECT_ID('dbo.TP_STATUT_WAFER_WAV', 'U') IS NOT NULL 
	DROP TABLE [dbo].[TP_STATUT_WAFER_WAV]	
IF OBJECT_ID('dbo.TD_Production_Classes', 'U') IS NOT NULL 
	DROP TABLE [dbo].[TD_Production_Classes]	
IF OBJECT_ID('dbo.TD_Production_Classes_Groupes', 'U') IS NOT NULL 
	DROP TABLE [dbo].[TD_Production_Classes_Groupes]	
IF OBJECT_ID('dbo.TD_Production_Classes_Types', 'U') IS NOT NULL 
	DROP TABLE [dbo].[TD_Production_Classes_Types]	

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES_TYPES                         	 */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[TD_Production_Classes_Types](
	[IdTypeClasse] 											[INT] 				NOT NULL,
	[Libelle] 												[NVARCHAR](30) 		NULL,
	[Description] 											[NVARCHAR](255)		NULL,
	[Rejets] 												[INT] 				NULL,
	[Actif] 												[INT] 				NULL,
	[Rang] 													[INT] 				NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES_GROUPES                         */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[TD_Production_Classes_Groupes](
	[IdGroupeClasse]										[INT] 				NOT NULL,
	[IdTypeClasse] 											[INT] 				NULL,
	[IdEquipement] 											[INT] 				NULL,
	[Libelle] 												[NVARCHAR](30) 		NULL,
	[Description] 											[NVARCHAR](255)		NULL,
	[Actif] 												[INT] 				NULL,
	[Rang] 													[INT] 				NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TD_PRODUCTION_CLASSES                         		 */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[TD_Production_Classes](
	[IdClasse] 												[INT] 				NOT NULL,
	[IdGroupeClasse] 										[INT] 				NULL,
	[Libelle] 												[NVARCHAR](10) 		NULL,
	[Description] 											[NVARCHAR](255) 	NULL,
	[Actif] 												[INT] 				NULL,
	[Rang] 													[INT] 				NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV                                   */
/* ------------------------------------------------------------- */

CREATE TABLE [dbo].[TP_STATUT_WAFER_WAV](
	[IdStatutWafer] 										[INT] 				NOT NULL,
	[IdStatutOrigine] 										[INT] 				NULL,
	[IdTypeStatut]											[INT] 				NULL,
	[Libelle] 												[NVARCHAR](100)		NULL,
	[Observations] 											[NVARCHAR](255) 	NULL,
	[Actif] 												[INT] 				NULL,
	[Rang] 													[INT] 				NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : TP_STATUT_WAFER_WAV_DETAIL                            */
/* ------------------------------------------------------------- */

CREATE TABLE [dbo].[TP_STATUT_WAFER_WAV_DETAIL](
	[RejetBin] 												[INT] 				NOT NULL,
	[IdStatutWafer] 										[INT] 				NULL,
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : RECIPE_WAV                                            */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[RECIPE_WAV](
	[IdRecord] 												[INT] 				IDENTITY(1,1) NOT NULL,
	[IdEquipement]               	                        [INT]				NULL,
    [RecipeName]                                            [NVARCHAR] (255)	NULL,
    [RecipeHash]                                            [NVARCHAR] (255)	NULL,
    [RecipeActivationTime]                                  [DATETIME]			NULL,
    [RecipeActivationTime_utc]                              [DATETIME]			NULL,
    [RecipeStepCount]                                       [INT]				NULL,
    [StepNum]                                               [INT]				NULL,
    [StepName]                                              [NVARCHAR] (255)	NULL,
    [StepType]                                              [NVARCHAR] (255)	NULL,
    [StartVoltage]                                          [FLOAT] 			NULL,
    [EndVoltage]                                            [FLOAT] 			NULL,
    [MeasurementTime]                                       [FLOAT] 			NULL,
    [SampleCount]                                           [INT]				NULL,
    [PreMeasurementDelay]                                   [FLOAT] 			NULL,
    [MinSettlingTime]                                       [INT]				NULL,
    [IntensityCorrection]                                   [NVARCHAR] (255)	NULL,
    [TemperatureCorrection]                                 [NVARCHAR] (255)	NULL,
    [CurrentAmplifier]                                      [NVARCHAR] (255)	NULL,
    [VoltageAmplifier]                                      [NVARCHAR] (255)	NULL,
    [LightMode]                                             [NVARCHAR] (255)	NULL,
    [IntensityControl]                                      [NVARCHAR] (255)	NULL,
    [SetIntensity]                                          [NVARCHAR] (255)	NULL,
    [SpectrumType]                                          [NVARCHAR] (255)	NULL,
    [SpectrumName]                                          [NVARCHAR] (255)	NULL,
    [IntensityPercentage]                                   [FLOAT] 			NULL,
    [SunsVoc_StartIntensity]                                [FLOAT] 			NULL,
    [SunsVoc_EndIntensity]                                  [FLOAT] 			NULL,
    [J01_2diodes_Mode]                                      [INT]				NULL,
    [J02_2diodes_Mode]                                      [INT]				NULL,
    [N1_2diodes_Mode]                                       [INT]				NULL,
    [N2_2diodes_Mode]                                       [INT]				NULL,
    [Rp_2diodes_Mode]                                       [INT]				NULL,
    [EL_Voltage]                                            [FLOAT] 			NULL,
    [EL_ExposureTime]                                       [FLOAT] 			NULL,
    [IR_Voltage]                                            [FLOAT] 			NULL,
    [IR_BrightFrameInterval]                                [FLOAT] 			NULL,
    [IR_VoltageOff]                                         [NVARCHAR] (255)	NULL,
    [LineRes]                                               [FLOAT] 			NULL,
    [Grid_DacVoltage]                                       [INT]				NULL,
    [Grid_FrontSlope]                                       [FLOAT] 			NULL,
    [Grid_FrontOffset]                                      [FLOAT] 			NULL,
    [Grid_RearSlope]                                        [FLOAT] 			NULL,
    [Grid_RearOffset]                                       [FLOAT] 			NULL,
    [CellTypeName]                                          [NVARCHAR] (255)	NULL,
    [CellTypeHash]                                          [NVARCHAR] (255)	NULL,
    [BaseDoping]                                            [NVARCHAR] (255)	NULL,
    [Area]                                                  [FLOAT] 			NULL,
    [Alpha]                                                 [FLOAT] 			NULL,
    [Beta]                                                  [FLOAT] 			NULL,
    [Kappa]                                                 [FLOAT] 			NULL,
    [Vlight1]                                               [FLOAT] 			NULL,
    [Vlight2]                                               [FLOAT] 			NULL,
    [Vlight3]                                               [FLOAT] 			NULL,
    [Vdark1]                                                [FLOAT] 			NULL,
    [Vdark2]                                                [FLOAT] 			NULL,
    [Vdark3]                                               	[FLOAT] 			NULL,
    [RpStartVoltage]                                        [FLOAT] 			NULL,
    [RpEndVoltage]                                          [FLOAT] 			NULL,
    [VrevMin_CurrentLimit]                                  [FLOAT] 			NULL,
    [TemperatureSensor]                                     [NVARCHAR] (255)	NULL,
    [PyrometerOffset]                                       [FLOAT] 			NULL,
    [ClassificationName]                                    [NVARCHAR] (255)	NULL,
    [ClassificationHash]                                    [NVARCHAR] (255)	NULL,
    [CalibrationDate_IV]                                    [NVARCHAR] (255)	NULL,
    [CalibrationComment_IV]                                 [NVARCHAR] (255)	NULL,
    [CalibrationDate_Intensity]                             [DATETIME]			NULL,
    [CalibrationDate_Spectrum]                              [DATETIME]			NULL,
    [SpectraRecordDate]                                     [DATETIME]			NULL,
    [VersionGUI_Long]                                       [NVARCHAR] (255)	NULL,
    [SerNum_IV]                                             [NVARCHAR] (255)	NULL,
    [FirmwareVersion_IV]                                    [NVARCHAR] (255)	NULL,
    [FirmwareInfo_IV]                                       [NVARCHAR] (255)	NULL,
    [FpgaVersion_IV]                                        [NVARCHAR] (255)	NULL,
    [SerNum_LE]                                             [NVARCHAR] (255)	NULL,
    [FirmwareVersion_LE]                                    [NVARCHAR] (255)	NULL,
    [FirmwareInfo_LE]                                       [NVARCHAR] (255)	NULL,
    [FpgaVersion_LE]                                        [NVARCHAR] (255)	NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_WAV                                             */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[WAFER_WAV](
	[IdRecord] 												[INT] 				IDENTITY(1,1) NOT NULL,
	[IdEquipement]               	                        [INT]				NULL,
    [RunID]                                                 [NVARCHAR] (255)	NULL,
    [TimeStamp_Flash]                                       [DATETIME]			NULL,
    [TimeStamp_Flash_utc]                                   [DATETIME]			NULL,
    [LotId]                                          		[NVARCHAR] (9)		NULL,
    [WaferEqID]                                        		[NVARCHAR] (2)		NULL,
    [WaferNr]                                        		[NVARCHAR] (5)		NULL,
    [WaferID_Manu]                                          [NVARCHAR] (255)	NULL,
    [WaferID_Auto]                                          [NVARCHAR] (255)	NULL,
    [Comment]                                               [NVARCHAR] (255)	NULL,
    [RecipeName]                                            [NVARCHAR] (255)	NULL,
    [RecipeHash]                                            [NVARCHAR] (255)	NULL,
    [RecipeActivationTime]                                  [DATETIME]			NULL,
    [RecipeActivationTime_utc]                              [DATETIME]			NULL,
    [StepNum]                                               [INT]				NULL,
    [StepName]                                              [NVARCHAR] (255)	NULL,
    [Class]                                                 [NVARCHAR] (255)	NULL,
    [Bin]                                                   [INT]				NULL,
    [MatchingClassifierLine]                                [INT]				NULL,
    [Voc]                                                   [FLOAT] 			NULL,
    [Isc]                                                   [FLOAT] 			NULL,
    [Pmpp]                                                  [FLOAT] 			NULL,
    [FF]                                                    [FLOAT] 			NULL,
    [Eta]                                                   [FLOAT] 			NULL,
    [Rs]                                                    [FLOAT] 			NULL,
    [Rp]                                                    [FLOAT] 			NULL,
    [Vmpp]                                                  [FLOAT] 			NULL,
    [Impp]                                                  [FLOAT] 			NULL,
    [Iat_Vlight1]                                           [FLOAT] 			NULL,
    [Iat_Vlight2]                                           [FLOAT] 			NULL,
    [Iat_Vlight3]                                           [FLOAT] 			NULL,
    [Idk_6]                                                 [FLOAT] 			NULL,
    [Idk_10]                                                [FLOAT] 			NULL,
    [Idk_12]                                                [FLOAT] 			NULL,
    [Idk_13]                                                [FLOAT] 			NULL,
    [Idk_Vmin]                                              [FLOAT] 			NULL,
    [Idk_Imax]                                              [FLOAT] 			NULL,
    [Iat_Vdark1]                                            [FLOAT] 			NULL,
    [Iat_Vdark2]                                            [FLOAT] 			NULL,
    [Iat_Vdark3]                                            [FLOAT] 			NULL,
    [pVoc]                                                  [FLOAT] 			NULL,
    [pIsc]                                                  [FLOAT] 			NULL,
    [pFF]                                                   [FLOAT] 			NULL,
    [pEta]                                                  [FLOAT] 			NULL,
    [pImpp]                                                 [FLOAT] 			NULL,
    [pVmpp]                                                 [FLOAT] 			NULL,
    [EL_AvgVoltage]                                         [FLOAT] 			NULL,
    [EL_AvgCurrent]                                         [FLOAT] 			NULL,
    [EL_EnergyInput]                                        [FLOAT] 			NULL,
    [EL_DefectArea]                                         [INT] 				NULL,
    [EL_CountCracks]                                        [INT] 				NULL,
    [EL_CountScratches]                                     [INT] 				NULL,
    [EL_CountDarkAreas]                                     [INT] 				NULL,
    [EL_CountFingers]                                       [INT] 				NULL,
    [IR_AvgVoltage]                                         [FLOAT] 			NULL,
    [IR_AvgCurrent]                                         [FLOAT] 			NULL,
    [IR_EnergyInput]                                        [FLOAT] 			NULL,
    [IR_EnergyValue]                                        [FLOAT] 			NULL,
    [IR_MatShunt]                                           [FLOAT] 			NULL,
    [IR_NormShunt]                                          [FLOAT] 			NULL,
    [IR_QShunt]                                             [FLOAT] 			NULL,
    [IR_AvgGray]                                            [FLOAT] 			NULL,
    [IR_MaxGray]                                            [FLOAT] 			NULL,
    [IR_MinGray]                                            [FLOAT] 			NULL,
    [IR_StdDevGray]                                         [FLOAT] 			NULL,
    [IR_VarGray]                                            [FLOAT] 			NULL,
    [IR_DefectArea]                                         [INT] 				NULL,
    [IR_MaxPtot]                                            [FLOAT] 			NULL,
    [J0_Voc]                                                [FLOAT] 			NULL,
    [Ideal_FF]                                              [FLOAT] 			NULL,
    [Rs_FF]                                                 [FLOAT] 			NULL,
    [Rs_Dark_LightDark]                                     [FLOAT] 			NULL,
    [Rs_Light_LightDark]                                    [FLOAT] 			NULL,
    [N_Light_Voc]                                           [FLOAT] 			NULL,
    [N_Light_Vmpp]                                          [FLOAT] 			NULL,
    [N_SunsVoc_Voc]                                         [FLOAT] 			NULL,
    [N_SunsVoc_Vmpp]                                        [FLOAT] 			NULL,
    [Fit_2diodes_SunsVoc]                                   [INT] 				NULL,
    [J01_2diodes_SunsVoc]                                   [FLOAT] 			NULL,
    [J02_2diodes_SunsVoc]                                   [FLOAT] 			NULL,
    [N1_2diodes_SunsVoc]                                    [FLOAT] 			NULL,
    [N2_2diodes_SunsVoc]                                    [FLOAT] 			NULL,
    [Rp_2diodes_SunsVoc]                                    [FLOAT] 			NULL,
    [Grid_Front1]                                           [FLOAT] 			NULL,
    [Grid_Front2]                                           [FLOAT] 			NULL,
    [Grid_Front3]                                           [FLOAT] 			NULL,
    [Grid_Front4]                                           [FLOAT] 			NULL,
    [Grid_Front5]                                           [FLOAT] 			NULL,
    [Grid_Front6]                                           [FLOAT] 			NULL,
    [Grid_Front7]                                           [FLOAT] 			NULL,
    [Grid_Front8]                                           [FLOAT] 			NULL,
    [Grid_Rear1]                                            [FLOAT] 			NULL,
    [Grid_Rear2]                                            [FLOAT] 			NULL,
    [Grid_Rear3]                                            [FLOAT] 			NULL,
    [Grid_Rear4]                                            [FLOAT] 			NULL,
    [Grid_Rear5]                                            [FLOAT] 			NULL,
    [Grid_Rear6]                                            [FLOAT] 			NULL,
    [Grid_Rear7]                                            [FLOAT] 			NULL,
    [Grid_Rear8]                                            [FLOAT] 			NULL,
    [ErrorCode_TS]                                          [INT] 				NULL,
    [ErrorCode_LE]                                          [INT] 				NULL,
    [ErrorCode_IV]                                          [INT] 				NULL,
    [ErrorCode_IR]                                          [INT] 				NULL,
    [ErrorCode_EL]                                          [INT] 				NULL,
    [ErrorCode_CS]                                          [INT] 				NULL,
    [ErrorCode_AS]                                          [INT] 				NULL,
    [ErrorCode_PY]                                          [INT] 				NULL,
    [Temp_Cell]                                             [FLOAT] 			NULL,
    [Temp_Pyrometer]                                        [FLOAT] 			NULL,
    [Temp_PyroAverage]                                      [FLOAT] 			NULL,
    [Temp_Spectro]                                          [FLOAT] 			NULL,
    [Temp_Chiller]                                          [FLOAT] 			NULL,
    [Intensity_25C]                                         [FLOAT] 			NULL,
    [Irradiance_400_1100]                                   [FLOAT] 			NULL,
    [Irradiance_300_1200]                                   [FLOAT] 			NULL,
    [Range_300_400]                                         [FLOAT] 			NULL,
    [Range_400_500]                                         [FLOAT] 			NULL,
    [Range_500_600]                                         [FLOAT] 			NULL,
    [Range_600_700]                                         [FLOAT] 			NULL,
    [Range_700_800]                                         [FLOAT] 			NULL,
    [Range_800_900]                                         [FLOAT] 			NULL,
    [Range_900_1100]                                        [FLOAT] 			NULL,
    [Range_1100_1200]                                       [FLOAT] 			NULL
) ON [PRIMARY]
GO

/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI                                             */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[WAFER_TRI](
	[IdRecord] 												[INT] IDENTITY(1,1) NOT NULL,
	[IdEquipement] 											[INT] 				NULL,
	[LotId] 												[NVARCHAR](9) 		NULL,
	[WaferEqID] 											[NVARCHAR](2) 		NULL,
	[WaferNr] 												[NVARCHAR](5) 		NULL,
	[LotWaferID] 											[NVARCHAR](255) 	NULL,
	[Horodatage]											[DATETIME2](7) 		NULL,
	[Voie] 													[INT] 				NULL,
	[FormatCellule] 										[INT] 				NULL,
	[HorodatageCreationBoite]								[DATETIME2](7) 		NULL,
	[NumeroLotBoite]										[NVARCHAR](9) 		NULL,
	[NumeroCelluleBoite]									[INT] 				NULL,
	[ClasseFinale] 											[NVARCHAR](4) 		NULL,
	[IdClasseVisionP] 										[INT] 				NULL,
	[ClasseVisionP] 										[NVARCHAR](4) 		NULL,
	[IdClasseVisionN] 										[INT] 				NULL,
	[ClasseVisionN] 										[NVARCHAR](4) 		NULL,
	[IdClasseFlasheur] 										[INT] 				NULL,
	[ClasseFlasheur] 										[NVARCHAR](4) 		NULL,
	[IdClasseElectrolum] 									[INT] 				NULL,
	[ClasseElectrolum] 										[NVARCHAR](4) 		NULL
) ON [PRIMARY]
GO


/* ------------------------------------------------------------- */
/* TABLE : WAFER_TRI_LOT                                         */
/* ------------------------------------------------------------- */
CREATE TABLE [dbo].[WAFER_TRI_LOT](
	[IdRecord] 												[INT] IDENTITY(1,1) NOT NULL,
	[IdEquipement] 											[INT] 				NULL,
	[LotId] 												[NVARCHAR](9) 		NULL,
	[HorodatageCreationBoite]								[DATETIME2](7) 		NULL,
	[HorodatageFermetureBoite]								[DATETIME2](7) 		NULL,
	[NombreCellulesEntrees]									[INT] 				NULL,
	[NombreCellulesSorties]									[INT] 				NULL
) ON [PRIMARY]
GO