USE [CELL_INLINE_DB]
GO

/****** Object:  View [dbo].[V_WAV_STATISTIQUES]    Script Date: 22/12/2017 10:46:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[V_WAV_STATISTIQUES]
AS

WITH 
FILL_FACTOR AS
(
	SELECT	IdLot, Lignes AS FF_Lignes, Amplitude AS FF_ampl, EcartType AS FF_ect, EcartTypeRelatif AS FF_ectr, 
			Maximum AS FF_max, Mediane AS FF_med, Minimum AS FF_min, Moyenne AS FF_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 1
),
I@VREF AS
(
	SELECT	IdLot, Lignes AS I@Vref_Lignes, Amplitude AS I@Vref_ampl, EcartType AS I@Vref_ect, EcartTypeRelatif AS I@Vref_ectr, 
			Maximum AS I@Vref_max, Mediane AS I@Vref_med, Minimum AS I@Vref_min, Moyenne AS I@Vref_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 2
),
IMAX AS
(
	SELECT	IdLot, Lignes AS Imax_Lignes, Amplitude AS Imax_ampl, EcartType AS Imax_ect, EcartTypeRelatif AS Imax_ectr, 
			Maximum AS Imax_max, Mediane AS Imax_med, Minimum AS Imax_min, Moyenne AS Imax_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 3
),
IRRADIANCE AS
(
	SELECT	IdLot, Lignes AS Irrad_Lignes, Amplitude AS Irrad_ampl, EcartType AS Irrad_ect, EcartTypeRelatif AS Irrad_ectr, 
			Maximum AS Irrad_max, Mediane AS Irrad_med, Minimum AS Irrad_min, Moyenne AS Irrad_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 4
),
ISC AS
(
	SELECT	IdLot, Lignes AS Isc_Lignes, Amplitude AS Isc_ampl, EcartType AS Isc_ect, EcartTypeRelatif AS Isc_ectr, 
			Maximum AS Isc_max, Mediane AS Isc_med, Minimum AS Isc_min, Moyenne AS Isc_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 5
),
PMAX AS
(
	SELECT	IdLot, Lignes AS Pmax_Lignes, Amplitude AS Pmax_ampl, EcartType AS Pmax_ect, EcartTypeRelatif AS Pmax_ectr, 
			Maximum AS Pmax_max, Mediane AS Pmax_med, Minimum AS Pmax_min, Moyenne AS Pmax_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 6
),
RENDEMENT AS
(
	SELECT	IdLot, Lignes AS Rend_Lignes, Amplitude AS Rend_ampl, EcartType AS Rend_ect, EcartTypeRelatif AS Rend_ectr, 
			Maximum AS Rend_max, Mediane AS Rend_med, Minimum AS Rend_min, Moyenne AS Rend_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 7
),
RS AS
(
	SELECT	IdLot, Lignes AS Rs_Lignes, Amplitude AS Rs_ampl, EcartType AS Rs_ect, EcartTypeRelatif AS Rs_ectr, 
			Maximum AS Rs_max, Mediane AS Rs_med, Minimum AS Rs_min, Moyenne AS Rs_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 8
),
TEMPERATURE AS
(
	SELECT	IdLot, Lignes AS [T°cell_Lignes], Amplitude AS [T°cell_ampl], EcartType AS [T°cell_ect], EcartTypeRelatif AS [T°cell_ectr], 
			Maximum AS [T°cell_max], Mediane AS [T°cell_med], Minimum AS [T°cell_min], Moyenne AS [T°cell_moy]
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 9
),
VMAX AS
(
	SELECT	IdLot, Lignes AS Vmax_Lignes, Amplitude AS Vmax_ampl, EcartType AS Vmax_ect, EcartTypeRelatif AS Vmax_ectr, 
			Maximum AS Vmax_max, Mediane AS Vmax_med, Minimum AS Vmax_min, Moyenne AS Vmax_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 10
),
VOC AS
(
	SELECT	IdLot, Lignes AS Voc_Lignes, Amplitude AS Voc_ampl, EcartType AS Voc_ect, EcartTypeRelatif AS Voc_ectr, 
			Maximum AS Voc_max, Mediane AS Voc_med, Minimum AS Voc_min, Moyenne AS Voc_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 11
),
IDK AS
(
	SELECT	IdLot, Lignes AS IDK_Lignes, Amplitude AS IDK_ampl, EcartType AS IDK_ect, EcartTypeRelatif AS IDK_ectr, 
			Maximum AS IDK_max, Mediane AS IDK_med, Minimum AS IDK_min, Moyenne AS IDK_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 12
),
RSH AS
(
	SELECT	IdLot, Lignes AS Rsh_Lignes, Amplitude AS Rsh_ampl, EcartType AS Rsh_ect, EcartTypeRelatif AS Rsh_ectr, 
			Maximum AS Rsh_max, Mediane AS Rsh_med, Minimum AS Rsh_min, Moyenne AS Rsh_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 13
),
LINERES AS
(
	SELECT	IdLot, Lignes AS CoeffP_Lignes, Amplitude AS CoeffP_ampl, EcartType AS CoeffP_ect, EcartTypeRelatif AS CoeffP_ectr, 
			Maximum AS CoeffP_max, Mediane AS CoeffP_med, Minimum AS CoeffP_min, Moyenne AS CoeffP_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 14
),
PYROMETEROFFSET AS
(
	SELECT	IdLot, Lignes AS CoeffV_Lignes, Amplitude AS CoeffV_ampl, EcartType AS CoeffV_ect, EcartTypeRelatif AS CoeffV_ectr, 
			Maximum AS CoeffV_max, Mediane AS CoeffV_med, Minimum AS CoeffV_min, Moyenne AS CoeffV_moy
	FROM	T_STATS_WAV_DETAIL 
	WHERE	IdTypeStat = 15
)
SELECT	NumeroLot AS Lot, NULL AS IdLot, IdAtelier, Atelier, NULL AS [N°Fic], DateCreation AS DateCreat, 
		DateHeureMini AS DateHeure_min, DateHeureMaxi AS DateHeure_max, NULL AS Run_, NULL AS Wafer, NULL AS Retri, NULL AS DateFic, NULL AS NomFic,  
		FF_ampl, FF_ect, FF_ectr, FF_max, FF_med, FF_min, FF_moy,															-- FILL FACTOR (Colonne 'FF')
		I@Vref_ampl, I@Vref_ect, I@Vref_ectr, I@Vref_max, I@Vref_med, I@Vref_min, I@Vref_moy,								-- I@Vref (Colonne 'Iat_Vlight1')
		Imax_ampl, Imax_ect, Imax_ectr, Imax_max, Imax_med, Imax_min, Imax_moy,												-- INTENSITE MAXIMALE (Colonne 'Impp')
		Irrad_ampl, Irrad_ect, Irrad_ectr, Irrad_max, Irrad_med, Irrad_min, Irrad_moy,										-- IRRADIANCE (Colonne 'Irradiance_400_1100')
		Isc_ampl, Isc_ect, Isc_ectr, Isc_max, Isc_med, Isc_min, Isc_moy,													-- ISC (Colonne 'Isc')
		Pmax_ampl, Pmax_ect, Pmax_ectr, Pmax_max, Pmax_med, Pmax_min, Pmax_moy,												-- PUISSANCE MAX (Colonne 'Pmpp')
		Rend_ampl, Rend_ect, Rend_ectr, Rend_max, Rend_med, Rend_min, Rend_moy,												-- RENDEMENT (Colonne 'ETA')
		Rs_ampl, Rs_ect, Rs_ectr, Rs_max, Rs_med, Rs_min, Rs_moy,															-- RENDEMENT (Colonne 'RS')
		[T°cell_ampl], [T°cell_ect], [T°cell_ectr], [T°cell_max], [T°cell_med], [T°cell_min], [T°cell_moy],					-- TEMPERATURE (Colonne 'Temp_Cell')
		Vmax_ampl, Vmax_ect, Vmax_ectr, Vmax_max, Vmax_med, Vmax_min, Vmax_moy,												-- TENSION MAX (Colonne 'VmPP')
		Voc_ampl, Voc_ect, Voc_ectr, Voc_max, Voc_med, Voc_min, Voc_moy,													-- VOC (Colonne 'VOC')
		IDK_ampl, IDK_ect, IDK_ectr, IDK_max, IDK_med, IDK_min, IDK_moy,													-- IDK (Colonne 'IDK_12')
		Rsh_ampl, Rsh_ect, Rsh_ectr, Rsh_max, Rsh_med, Rsh_min, Rsh_moy,													-- RSH (Colonne 'RP')
		CoeffP_ampl, CoeffP_ect, CoeffP_ectr, CoeffP_max, CoeffP_med, CoeffP_min, CoeffP_moy,								-- COEFFICIENT PUISSANCE (Colonne 'LineRes')
		CoeffV_ampl, CoeffV_ect, CoeffV_ectr, CoeffV_max, CoeffV_med, CoeffV_min, CoeffV_moy,								-- COEFFICIENT TENSION (Colonne 'PyrometerOffset')
		NULL AS CoeffI_ampl, NULL AS CoeffI_ect, NULL AS CoeffI_ectr, NULL AS CoeffI_max,									-- COEFFICIENT INTENSITE 
		NULL AS CoeffI_med, NULL AS CoeffI_min, NULL AS CoeffI_moy,															-- >>> Compatibilité avec version antérieure
		NULL AS IrrDev_ampl, NULL AS IrrDev_ect, NULL AS IrrDev_ectr, NULL AS IrrDev_max,									-- IRRADIANCE
		NULL AS IrrDev_med, NULL AS IrrDev_min, NULL AS IrrDev_moy,															-- >>> Compatibilité avec version antérieure
		NULL AS [T°mon_ampl], NULL AS [T°mon_ect], NULL AS [T°mon_ectr], NULL AS [T°mon_max],								-- TEMPERATURE
		NULL AS [T°mon_med], NULL AS [T°mon_min], NULL AS [T°mon_moy]														-- >>> Compatibilité avec version antérieure
FROM	T_STATS_WAV S
		INNER JOIN FILL_FACTOR		S1	ON (S.IdLot = S1.IdLot)
		INNER JOIN I@VREF			S2	ON (S.IdLot = S2.IdLot)
		INNER JOIN IMAX				S3	ON (S.IdLot = S3.IdLot)
		INNER JOIN IRRADIANCE		S4	ON (S.IdLot = S4.IdLot)
		INNER JOIN ISC				S5	ON (S.IdLot = S5.IdLot)
		INNER JOIN PMAX				S6	ON (S.IdLot = S6.IdLot)
		INNER JOIN RENDEMENT		S7	ON (S.IdLot = S7.IdLot)
		INNER JOIN RS				S8	ON (S.IdLot = S8.IdLot)
		INNER JOIN TEMPERATURE		S9	ON (S.IdLot = S9.IdLot)
		INNER JOIN VMAX				S10 ON (S.IdLot = S10.IdLot)
		INNER JOIN VOC				S11 ON (S.IdLot = S11.IdLot)
		INNER JOIN IDK				S12 ON (S.IdLot = S12.IdLot)
		INNER JOIN RSH				S13 ON (S.IdLot = S13.IdLot)
		INNER JOIN LINERES			S14 ON (S.IdLot = S14.IdLot)
		INNER JOIN PYROMETEROFFSET	S15 ON (S.IdLot = S15.IdLot)

GO


