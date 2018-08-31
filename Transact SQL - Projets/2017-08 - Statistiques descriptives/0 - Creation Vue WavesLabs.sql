USE [CELL_INLINE_DB];
GO

CREATE VIEW VUE_MESURES_STATS_WAVESLABS
AS
WITH 
--------------------------------------------------------------------------
MEDIANE_FF AS
(SELECT 
LotID,
AVG(FF) AS FF_med
FROM
	(SELECT
	LotID,
	FF,
	Row_Number() OVER (PARTITION BY LotId ORDER BY FF ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY FF DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
MEDIANE_IATVREF AS
(SELECT 
LotID,
AVG(Iat_Vlight1) AS I@Vref_med
FROM
	(SELECT
	LotID,
	Iat_Vlight1,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Iat_Vlight1 ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Iat_Vlight1 DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
MEDIANE_IMPP AS
(SELECT 
LotID,
AVG(IMPP) AS IMPP
FROM
	(SELECT
	LotID,
	IMPP,
	Row_Number() OVER (PARTITION BY LotId ORDER BY IMPP ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY IMPP DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
MEDIANE_IRR AS
(SELECT 
LotID,
AVG(Irradiance_400_1100) AS IRR
FROM
	(SELECT
	LotID,
	Irradiance_400_1100,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Irradiance_400_1100 ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Irradiance_400_1100 DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_ISC AS
(SELECT 
LotID,
AVG(ISC) AS ISC
FROM
	(SELECT
	LotID,
	ISC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY ISC ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY ISC DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_PMPP AS
(SELECT 
LotID,
AVG(PMPP) AS PMPP
FROM
	(SELECT
	LotID,
	PMPP,
	Row_Number() OVER (PARTITION BY LotId ORDER BY PMPP ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY PMPP DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_REND AS
(SELECT 
LotID,
AVG(ETA) AS REND
FROM
	(SELECT
	LotID,
	ETA,
	Row_Number() OVER (PARTITION BY LotId ORDER BY ETA ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY ETA DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_RS AS
(SELECT 
LotID,
AVG(RS) AS RS
FROM
	(SELECT
	LotID,
	RS,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RS ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RS DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_RP AS
(SELECT 
LotID,
AVG(RP) AS RP
FROM
	(SELECT
	LotID,
	RP,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RP ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RP DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_TC AS
(SELECT 
LotID,
AVG(Temp_Cell) AS Temp_Cell
FROM
	(SELECT
	LotID,
	Temp_Cell,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Temp_Cell ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY Temp_Cell DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_VMPP AS
(SELECT 
LotID,
AVG(VmPP) AS VmPP
FROM
	(SELECT
	LotID,
	VmPP,
	Row_Number() OVER (PARTITION BY LotId ORDER BY VmPP ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY VmPP DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_VOC AS
(SELECT 
LotID,
AVG(VOC) AS VOC
FROM
	(SELECT
	LotID,
	VOC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY VOC ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY VOC DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'LIGHT-100' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_IDK AS
(SELECT 
LotID,
AVG(IDK_12) AS IDK_12
FROM
	(SELECT
	LotID,
	IDK_12,
	Row_Number() OVER (PARTITION BY LotId ORDER BY IDK_12 ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY IDK_12 DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'Dark' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
--------------------------------------------------------------------------
MEDIANE_RSH AS
(SELECT 
LotID,
AVG(RP) AS RP
FROM
	(SELECT
	LotID,
	RP,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RP ASC) AS RowASC,
	Row_Number() OVER (PARTITION BY LotId ORDER BY RP DESC) AS RowDESC

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'Dark' AND Coalesce(LotID,'') <>'') AS TB

	WHERE TB.RowASC IN (RowDESC,RowDESC-1,RowDESC+1)
	GROUP BY LotId),
--------------------------------------------------------------------------
DATA_IDK AS
(SELECT
	LotID,
	MAX(IDK_12) - MIN(IDK_12) AS IDK_ampl,
	STDEV(IDK_12) AS IDK_ect,
	STDEV(IDK_12)/AVG(IDK_12)  AS IDK_ectr,
	MAX(IDK_12) AS IDK_max,
	MAX(IDK_12) AS IDK_med,
	MIN(IDK_12) AS IDK_min,
	AVG(IDK_12) AS IDK_moy

	FROM [dbo].[WAFER_WAV] AS WW
	WHERE StepName like 'Dark' AND Coalesce(LotID,'') <>''
	GROUP BY LotID),
--------------------------------------------------------------------------
DATA_RSH AS
(SELECT
	LotID,
	MAX(RP) - MIN(RP) AS Rsh_ampl,
	STDEV(RP) AS Rsh_ect,
	STDEV(RP)/AVG(RP)  AS Rsh_ectr,
	MAX(RP) AS Rsh_max,
	MIN(RP) AS Rsh_min,
	AVG(RP) AS Rsh_moy

	FROM [dbo].[WAFER_WAV] 
	WHERE StepName like 'Dark' AND Coalesce(LotID,'') <>''
	GROUP BY LotID),
---------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
CHRONO AS 
(SELECT 

	RecipeName,
	RecipeHash,
	StepName,
	RecipeActivationTime,
	ROW_NUMBER() OVER (PARTITION BY RecipeHash ORDER BY RecipeActivationTime ASC) AS Num_Increment,
	LineRes,
	PyrometerOffset

	FROM [dbo].[RECIPE_WAV]
	WHERE StepName = 'Light-100'),

MESURES AS
(SELECT 

	P.RecipeName,
	P.RecipeHash,
	P.StepName,
	P.RecipeActivationTime,
	Coalesce(C.RecipeActivationTime,getdate()) AS RecipeActivationEnd,
	P.Num_Increment AS Num1,
	C.Num_Increment AS Num2,
	P.LineRes,
	P.PyrometerOffset
	
		FROM CHRONO AS P
		LEFT OUTER JOIN CHRONO AS C
		ON P.RecipeHash = C.RecipeHash
		AND P.StepName = C.StepName
		AND P.Num_Increment+1 = C.Num_Increment),

ListeLot AS
(SELECT 
	LotID,
	RecipeHash,
	StepName,
	RecipeActivationTime
		
	FROM [dbo].[WAFER_WAV] AS WW
	WHERE coalesce(LotID,'') <>'' AND StepName like 'Light-100'
	GROUP BY LotID,RecipeHash,StepName,RecipeActivationTime),
Data_Recipe AS
(SELECT

	WW.LotID,
	WW.RecipeHash,
	WW.StepName,	
	MES.RecipeActivationTime,
	MES.RecipeActivationEnd,
	MES.LineRes,
	MES.PyrometerOffset
	 
	FROM ListeLot AS WW
	INNER JOIN MESURES AS MES
	
	ON WW.RecipeHash = MES.RecipeHash
	AND WW.StepName = MES.StepName
	AND WW.RecipeActivationTime >= MES.RecipeActivationTime
	AND WW.RecipeActivationTime < MES.RecipeActivationEnd
	
	WHERE coalesce(LotID,'') <>''),

Stats_Recipe AS
(SELECT 
	LotID,
	MAX(WW.LineRes) - MIN(WW.LineRes) AS CoeffP_ampl,
	STDEV(WW.LineRes) AS CoeffP_ect,
	STDEV(LineRes)  AS CoeffP_ectr,
	MAX(WW.LineRes) AS CoeffP_max,
	AVG(WW.LineRes) AS CoeffP_med,
	MIN(WW.LineRes) AS CoeffP_min,
	AVG(WW.LineRes) AS CoeffP_moy,

	MAX(WW.PyrometerOffset) - MIN(WW.PyrometerOffset) AS CoeffV_ampl,
	STDEV(WW.PyrometerOffset) AS CoeffV_ect,
	STDEV(PyrometerOffset)  AS CoeffV_ectr,
	MAX(WW.PyrometerOffset) AS CoeffV_max,
	AVG(WW.PyrometerOffset) AS CoeffV_med,
	MIN(WW.PyrometerOffset) AS CoeffV_min,
	AVG(WW.PyrometerOffset) AS CoeffV_moy

	FROM Data_Recipe AS WW
	GROUP BY LotID)
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
SELECT 

	WW.LotID AS Lot,

	NULL AS IdLot,
	1 AS IdAtelier,
	'PWT' AS Atelier,
	NULL AS [N°Fic],
	NULL AS DateCreat,
	NULL AS DateHeure_min,
	NULL AS DateHeure_max,
	NULL AS Run_,
	NULL AS Wafer,
	NULL AS Retri,
	NULL AS DateFic,
	NULL AS NomFic,

	MAX(WW.FF) - MIN(WW.FF) AS FF_ampl,
	STDEV(WW.FF) AS FF_ect,
	STDEV(FF)/AVG(WW.FF)  AS FF_ectr,
	MAX(WW.FF) AS FF_max,
	MAX(MR.FF_med) AS FF_med,
	MIN(WW.FF) AS FF_min,
	AVG(WW.FF) AS FF_moy,

	MAX(WW.Iat_Vlight1) - MIN(WW.Iat_Vlight1) AS I@Vref_ampl,
	STDEV(WW.Iat_Vlight1) AS I@Vref_ect,
	STDEV(Iat_Vlight1)/AVG(WW.Iat_Vlight1)  AS I@Vref_ectr,
	MAX(WW.Iat_Vlight1) AS I@Vref_max,
	MAX(MI.I@Vref_med) AS I@Vref_med,
	MIN(WW.Iat_Vlight1) AS I@Vref_min,
	AVG(WW.Iat_Vlight1) AS I@Vref_moy,

	MAX(WW.Impp) - MIN(WW.Impp) AS Imax_ampl,
	STDEV(WW.Impp) AS Imax_ect,
	STDEV(WW.Impp)/AVG(WW.Impp)  AS Imax_ectr,
	MAX(WW.Impp) AS Imax_max,
	MAX(MP.IMPP) AS Imax_med,
	MIN(WW.Impp) AS Imax_min,
	AVG(WW.Impp) AS Imax_moy,

	MAX(WW.Irradiance_400_1100) - MIN(WW.Irradiance_400_1100) AS Irrad_ampl,
	STDEV(WW.Irradiance_400_1100) AS Irrad_ect,
	STDEV(Irradiance_400_1100)/AVG(WW.Irradiance_400_1100)  AS Irrad_ectr,
	MAX(WW.Irradiance_400_1100) AS Irrad_max,
	MAX(MIR.IRR) AS Irrad_med,
	MIN(WW.Irradiance_400_1100) AS Irrad_min,
	AVG(WW.Irradiance_400_1100) AS Irrad_moy,

	MAX(WW.ISC) - MIN(WW.ISC) AS Isc_ampl,
	STDEV(WW.ISC) AS Isc_ect,
	STDEV(WW.ISC)/AVG(WW.ISC)  AS Isc_ectr,
	MAX(WW.ISC) AS Isc_max,
	MAX(MIS.ISC) AS Isc_med,
	MIN(WW.ISC) AS Isc_min,
	AVG(WW.ISC) AS Isc_moy,

	MAX(WW.Pmpp) - MIN(WW.Pmpp) AS Pmax_ampl,
	STDEV(WW.Pmpp) AS Pmax_ect,
	STDEV(WW.Pmpp)/AVG(WW.Pmpp)  AS Pmax_ectr,
	MAX(WW.Pmpp) AS Pmax_max,
	MAX(MPM.PMPP) AS Pmax_med,
	MIN(WW.Pmpp) AS Pmax_min,
	AVG(WW.Pmpp) AS Pmax_moy,

	MAX(WW.ETA) - MIN(WW.ETA) AS Rend_ampl,
	STDEV(WW.ETA) AS Rend_ect,
	STDEV(WW.ETA)/AVG(WW.ETA)  AS Rend_ectr,
	MAX(WW.ETA) AS Rend_max,
	MAX(MRE.REND) AS Rend_med,
	MIN(WW.ETA) AS Rend_min,
	AVG(WW.ETA) AS Rend_moy,

	MAX(WW.RS) - MIN(WW.RS) AS Rs_ampl,
	STDEV(WW.RS) AS Rs_ect,
	STDEV(WW.RS)/AVG(WW.RS)  AS Rs_ectr,
	MAX(WW.RS) AS Rs_max,
	MAX(MS.RS) AS Rs_med,
	MIN(WW.RS) AS Rs_min,
	AVG(WW.RS) AS Rs_moy,

	MAX(WW.Temp_Cell) - MIN(WW.Temp_Cell) AS [T°cell_ampl],
	STDEV(WW.Temp_Cell) AS [T°cell_ect],
	STDEV(WW.Temp_Cell)/AVG(WW.Temp_Cell)  AS [T°cell_ectr],
	MAX(WW.Temp_Cell) AS [T°cell_max],
	MAX(TC.Temp_Cell) AS [T°cell_med],
	MIN(WW.Temp_Cell) AS [T°cell_min],
	AVG(WW.Temp_Cell) AS [T°cell_moy],

	MAX(WW.VmPP) - MIN(WW.VmPP) AS Vmax_ampl,
	STDEV(WW.VmPP) AS Vmax_ect,
	STDEV(WW.VmPP)/AVG(WW.VmPP)  AS Vmax_ectr,
	MAX(WW.VmPP) AS Vmax_max,
	MAX(VMP.VmPP) AS Vmax_med,
	MIN(WW.VmPP) AS Vmax_min,
	AVG(WW.VmPP) AS Vmax_moy,

	MAX(WW.VOC) - MIN(WW.VOC) AS Voc_ampl,
	STDEV(WW.VOC) AS Voc_ect,
	STDEV(WW.VOC)/AVG(WW.VOC)  AS Voc_ectr,
	MAX(WW.VOC) AS Voc_max,
	MAX(VOC.VOC) AS Voc_med,
	MIN(WW.VOC) AS Voc_min,
	AVG(WW.VOC) AS Voc_moy,

	MAX(MK.IDK_ampl) AS IDK_ampl,
	MAX(MK.IDK_ect) AS IDK_ect,
	MAX(MK.IDK_ectr) AS IDK_ectr,
	MAX(MK.IDK_max) AS IDK_max,
	MAX(MIDK.IDK_12) AS IDK_med,
	MAX(MK.IDK_min) AS IDK_min,
	MAX(MK.IDK_moy) AS IDK_moy,

	MAX(MSH.Rsh_ampl) AS Rsh_ampl,
	MAX(MSH.Rsh_ect) AS Rsh_ect,
	MAX(MSH.Rsh_ectr) AS Rsh_ectr,
	MAX(MSH.Rsh_max) AS Rsh_max,
	MAX(MRSH.RP) AS Rsh_med,
	MAX(MSH.Rsh_min) AS Rsh_min,
	MAX(MSH.Rsh_moy) AS Rsh_moy,

	MAX(STRE.CoeffP_ampl) AS CoeffP_ampl,
	MAX(STRE.CoeffP_ect) AS CoeffP_ect,
	MAX(STRE.CoeffP_ectr) AS CoeffP_ectr,
	MAX(STRE.CoeffP_max) AS CoeffP_max,
	MAX(STRE.CoeffP_med) AS CoeffP_med,
	MAX(STRE.CoeffP_min) AS CoeffP_min,
	MAX(STRE.CoeffP_moy) AS CoeffP_moy,

	MAX(STRE.CoeffV_ampl) AS CoeffV_ampl,
	MAX(STRE.CoeffV_ect) AS CoeffV_ect,
	MAX(STRE.CoeffV_ectr) AS CoeffV_ectr,
	MAX(STRE.CoeffV_max) AS CoeffV_max,
	MAX(STRE.CoeffV_med) AS CoeffV_med,
	MAX(STRE.CoeffV_min) AS CoeffV_min,
	MAX(STRE.CoeffV_moy) AS CoeffV_moy,

	NULL AS CoeffI_ampl,
	NULL AS CoeffI_ect,
	NULL AS CoeffI_ectr,
	NULL AS CoeffI_max,
	NULL AS CoeffI_med,
	NULL AS CoeffI_min,
	NULL AS CoeffI_moy,

	NULL AS IrrDev_ampl,
	NULL AS IrrDev_ect,
	NULL AS IrrDev_ectr,
	NULL AS IrrDev_max,
	NULL AS IrrDev_med,
	NULL AS IrrDev_min,
	NULL AS IrrDev_moy,

	NULL AS [T°mon_ampl],
	NULL AS [T°mon_ect],
	NULL AS [T°mon_ectr],
	NULL AS [T°mon_max],
	NULL AS [T°mon_med],
	NULL AS [T°mon_min],
	NULL AS [T°mon_moy]

	FROM [dbo].[WAFER_WAV] AS WW

	LEFT OUTER JOIN MEDIANE_FF AS MR
	ON WW.LotID = MR.LotID

	LEFT OUTER JOIN MEDIANE_IATVREF AS MI
	ON WW.LotID = MI.LotID

	LEFT OUTER JOIN MEDIANE_IMPP AS MP
	ON WW.LotID = MP.LotID

	LEFT OUTER JOIN MEDIANE_IRR AS MIR
	ON WW.LotId = MIR.LotId

	LEFT OUTER JOIN MEDIANE_ISC AS MIS
	ON WW.LotId = MIS.LotId

	LEFT OUTER JOIN MEDIANE_PMPP AS MPM
	ON WW.LotID = MPM.LotID

	LEFT OUTER JOIN MEDIANE_REND AS MRE
	ON WW.LotID = MRE.LotId

	LEFT OUTER JOIN MEDIANE_RS AS MS
	ON WW.LotID = MS.LotId

	LEFT OUTER JOIN MEDIANE_RP AS MRP
	ON WW.LotID = MRP.LotId

	LEFT OUTER JOIN MEDIANE_TC AS TC
	ON WW.LotID = TC.LotId

	LEFT OUTER JOIN MEDIANE_VMPP AS VMP
	ON WW.LotID = VMP.LotId

	LEFT OUTER JOIN MEDIANE_VOC AS VOC
	ON WW.LotID = VOC.LotId

	LEFT OUTER JOIN MEDIANE_IDK AS MIDK
	ON WW.LotID = MIDK.LotId

	LEFT OUTER JOIN MEDIANE_RSH AS MRSH
	ON WW.LotID = MRSH.LotId

	LEFT OUTER JOIN DATA_IDK AS MK
	ON WW.LotID = MK.LotId

	LEFT OUTER JOIN DATA_RSH AS MSH
	ON WW.LotID = MSH.LotId

	LEFT OUTER JOIN Stats_Recipe AS STRE
	ON WW.LotID = STRE.LotID

	WHERE WW.StepName like 'LIGHT-100' AND Coalesce(WW.LotID,'') <>''
	GROUP BY WW.LotID


GO








