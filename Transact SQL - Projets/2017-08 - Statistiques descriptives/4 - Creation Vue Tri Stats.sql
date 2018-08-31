USE [SQC_DB]
GO

/****** Object:  View [dbo].[VUE_TRI_STAT]    Script Date: 31/08/2017 13:20:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VUE_TRI_STAT]
AS
SELECT 
       dbo.T_LOT.IdAtelierInitial AS IdAtelier
     , CASE dbo.T_LOT.IdAtelierInitial WHEN 1 THEN 'PW' WHEN 2 THEN 'PVA' ELSE '?' END AS Atelier
     , dbo.TL_TRI_STAT.[N°Fic], dbo.TL_TRI_STAT.DateCreat, dbo.TL_TRI_STAT.DateHeure_min, dbo.TL_TRI_STAT.DateHeure_max
	 , dbo.TL_TRI_STAT.Run_, dbo.TL_TRI_STAT.Wafer, dbo.TL_TRI_STAT.Retri
	 , dbo.TL_TRI_STAT.Voc_med, dbo.TL_TRI_STAT.Voc_moy, dbo.TL_TRI_STAT.Voc_ect, dbo.TL_TRI_STAT.Voc_min, dbo.TL_TRI_STAT.Voc_max
	 , dbo.TL_TRI_STAT.Isc_med, dbo.TL_TRI_STAT.Isc_moy, dbo.TL_TRI_STAT.Isc_ect, dbo.TL_TRI_STAT.Isc_min, dbo.TL_TRI_STAT.Isc_max
	 , dbo.TL_TRI_STAT.Vmax_med, dbo.TL_TRI_STAT.Vmax_moy, dbo.TL_TRI_STAT.Vmax_ect, dbo.TL_TRI_STAT.Vmax_min, dbo.TL_TRI_STAT.Vmax_max
	 , dbo.TL_TRI_STAT.Imax_med, dbo.TL_TRI_STAT.Imax_moy, dbo.TL_TRI_STAT.Imax_ect, dbo.TL_TRI_STAT.Imax_min, dbo.TL_TRI_STAT.Imax_max
	 , dbo.TL_TRI_STAT.Pmax_med, dbo.TL_TRI_STAT.Pmax_moy, dbo.TL_TRI_STAT.Pmax_ect, dbo.TL_TRI_STAT.Pmax_min, dbo.TL_TRI_STAT.Pmax_max
	 , dbo.TL_TRI_STAT.FF_med, dbo.TL_TRI_STAT.FF_moy, dbo.TL_TRI_STAT.FF_ect, dbo.TL_TRI_STAT.FF_min, dbo.TL_TRI_STAT.FF_max
	 , dbo.TL_TRI_STAT.Rend_med, dbo.TL_TRI_STAT.Rend_moy, dbo.TL_TRI_STAT.Rend_ect, dbo.TL_TRI_STAT.Rend_min, dbo.TL_TRI_STAT.Rend_max
	 , dbo.TL_TRI_STAT.Rs_med, dbo.TL_TRI_STAT.Rs_moy, dbo.TL_TRI_STAT.Rs_ect, dbo.TL_TRI_STAT.Rs_min, dbo.TL_TRI_STAT.Rs_max
	 , dbo.TL_TRI_STAT.Rsh_med, dbo.TL_TRI_STAT.Rsh_moy, dbo.TL_TRI_STAT.Rsh_ect, dbo.TL_TRI_STAT.Rsh_min, dbo.TL_TRI_STAT.Rsh_max
	 , dbo.TL_TRI_STAT.I@Vref_med, dbo.TL_TRI_STAT.I@Vref_moy, dbo.TL_TRI_STAT.I@Vref_ect, dbo.TL_TRI_STAT.I@Vref_min, dbo.TL_TRI_STAT.I@Vref_max
	 , dbo.TL_TRI_STAT.Irrad_med, dbo.TL_TRI_STAT.Irrad_moy, dbo.TL_TRI_STAT.Irrad_ect, dbo.TL_TRI_STAT.Irrad_min, dbo.TL_TRI_STAT.Irrad_max
	 , dbo.TL_TRI_STAT.IrrDev_med, dbo.TL_TRI_STAT.IrrDev_moy, dbo.TL_TRI_STAT.IrrDev_ect, dbo.TL_TRI_STAT.IrrDev_min, dbo.TL_TRI_STAT.IrrDev_max
	 , dbo.TL_TRI_STAT.[T°mon_med], dbo.TL_TRI_STAT.[T°mon_moy], dbo.TL_TRI_STAT.[T°mon_ect], dbo.TL_TRI_STAT.[T°mon_min], dbo.TL_TRI_STAT.[T°mon_max]
	 , dbo.TL_TRI_STAT.[T°cell_med], dbo.TL_TRI_STAT.[T°cell_moy], dbo.TL_TRI_STAT.[T°cell_ect], dbo.TL_TRI_STAT.[T°cell_min], dbo.TL_TRI_STAT.[T°cell_max] 
     , dbo.TL_TRI_STAT.CoeffI_med, dbo.TL_TRI_STAT.CoeffI_moy, dbo.TL_TRI_STAT.CoeffI_ect, dbo.TL_TRI_STAT.CoeffI_min, dbo.TL_TRI_STAT.CoeffI_max
	 , dbo.TL_TRI_STAT.CoeffV_med, dbo.TL_TRI_STAT.CoeffV_moy, dbo.TL_TRI_STAT.CoeffV_ect, dbo.TL_TRI_STAT.CoeffV_min, dbo.TL_TRI_STAT.CoeffV_max
	 , dbo.TL_TRI_STAT.CoeffP_med, dbo.TL_TRI_STAT.CoeffP_moy, dbo.TL_TRI_STAT.CoeffP_ect, dbo.TL_TRI_STAT.CoeffP_min, dbo.TL_TRI_STAT.CoeffP_max
	 , dbo.TL_TRI_STAT.IDK_med, dbo.TL_TRI_STAT.IDK_moy, dbo.TL_TRI_STAT.IDK_ect, dbo.TL_TRI_STAT.IDK_min, dbo.TL_TRI_STAT.IDK_max
	 , dbo.TL__FIC.NomFic, dbo.TL__FIC.DateFic 
     , dbo.TL_TRI_STAT.Voc_ect / NULLIF (dbo.TL_TRI_STAT.Voc_moy, 0) AS Voc_ectr
	 , dbo.TL_TRI_STAT.Isc_ect / NULLIF (dbo.TL_TRI_STAT.Isc_moy, 0) AS Isc_ectr 
     , dbo.TL_TRI_STAT.Vmax_ect / NULLIF (dbo.TL_TRI_STAT.Vmax_moy, 0) AS Vmax_ectr 
     , dbo.TL_TRI_STAT.Imax_ect / NULLIF (dbo.TL_TRI_STAT.Imax_moy, 0) AS Imax_ectr 
     , dbo.TL_TRI_STAT.Pmax_ect / NULLIF (dbo.TL_TRI_STAT.Pmax_moy, 0) AS Pmax_ectr
	 , dbo.TL_TRI_STAT.FF_ect / NULLIF (dbo.TL_TRI_STAT.FF_moy, 0) AS FF_ectr
     , dbo.TL_TRI_STAT.Rend_ect / NULLIF (dbo.TL_TRI_STAT.Rend_moy, 0) AS Rend_ectr 
     , dbo.TL_TRI_STAT.Rs_ect / NULLIF (dbo.TL_TRI_STAT.Rs_moy, 0) AS Rs_ectr
	 , dbo.TL_TRI_STAT.Rsh_ect / NULLIF (dbo.TL_TRI_STAT.Rsh_moy, 0) AS Rsh_ectr
     , dbo.TL_TRI_STAT.I@Vref_ect / NULLIF (dbo.TL_TRI_STAT.I@Vref_moy, 0) AS I@Vref_ectr 
     , dbo.TL_TRI_STAT.Irrad_ect / NULLIF (dbo.TL_TRI_STAT.Irrad_moy, 0) AS Irrad_ectr 
     , dbo.TL_TRI_STAT.IrrDev_ect / NULLIF (dbo.TL_TRI_STAT.IrrDev_moy, 0) AS IrrDev_ectr 
     , dbo.TL_TRI_STAT.[T°mon_ect] / NULLIF (dbo.TL_TRI_STAT.[T°mon_moy], 0) AS [T°mon_ectr] 
     , dbo.TL_TRI_STAT.[T°cell_ect] / NULLIF (dbo.TL_TRI_STAT.[T°cell_moy], 0) AS [T°cell_ectr] 
     , dbo.TL_TRI_STAT.CoeffI_ect / NULLIF (dbo.TL_TRI_STAT.CoeffI_moy, 0) AS CoeffI_ectr 
     , dbo.TL_TRI_STAT.CoeffV_ect / NULLIF (dbo.TL_TRI_STAT.CoeffV_moy, 0) AS CoeffV_ectr 
     , dbo.TL_TRI_STAT.CoeffP_ect / NULLIF (dbo.TL_TRI_STAT.CoeffP_moy, 0) AS CoeffP_ectr 
     , dbo.TL_TRI_STAT.IDK_ect / NULLIF (dbo.TL_TRI_STAT.IDK_moy, 0) AS IDK_ectr 
     , dbo.TL_TRI_STAT.Voc_max - dbo.TL_TRI_STAT.Voc_min AS Voc_ampl
	 , dbo.TL_TRI_STAT.Isc_max - dbo.TL_TRI_STAT.Isc_min AS Isc_ampl 
     , dbo.TL_TRI_STAT.Vmax_max - dbo.TL_TRI_STAT.Vmax_min AS Vmax_ampl
	 , dbo.TL_TRI_STAT.Imax_max - dbo.TL_TRI_STAT.Imax_min AS Imax_ampl
     , dbo.TL_TRI_STAT.Pmax_max - dbo.TL_TRI_STAT.Pmax_min AS Pmax_ampl
	 , dbo.TL_TRI_STAT.FF_max - dbo.TL_TRI_STAT.FF_min AS FF_ampl 
     , dbo.TL_TRI_STAT.Rend_max - dbo.TL_TRI_STAT.Rend_min AS Rend_ampl
	 , dbo.TL_TRI_STAT.Rs_max - dbo.TL_TRI_STAT.Rs_min AS Rs_ampl 
     , dbo.TL_TRI_STAT.Rsh_max - dbo.TL_TRI_STAT.Rsh_min AS Rsh_ampl
	 , dbo.TL_TRI_STAT.I@Vref_max - dbo.TL_TRI_STAT.I@Vref_min AS I@Vref_ampl
     , dbo.TL_TRI_STAT.Irrad_max - dbo.TL_TRI_STAT.Irrad_min AS Irrad_ampl 
     , dbo.TL_TRI_STAT.IrrDev_max - dbo.TL_TRI_STAT.IrrDev_min AS IrrDev_ampl 
     , dbo.TL_TRI_STAT.[T°mon_max] - dbo.TL_TRI_STAT.[T°mon_min] AS [T°mon_ampl] 
     , dbo.TL_TRI_STAT.[T°cell_max] - dbo.TL_TRI_STAT.[T°cell_min] AS [T°cell_ampl] 
     , dbo.TL_TRI_STAT.CoeffI_max - dbo.TL_TRI_STAT.CoeffI_min AS CoeffI_ampl 
     , dbo.TL_TRI_STAT.CoeffV_max - dbo.TL_TRI_STAT.CoeffV_min AS CoeffV_ampl 
     , dbo.TL_TRI_STAT.CoeffP_max - dbo.TL_TRI_STAT.CoeffP_min AS CoeffP_ampl
     , dbo.TL_TRI_STAT.IDK_max - dbo.TL_TRI_STAT.IDK_min AS IDK_ampl
	 , dbo.T_LOT.Lot, dbo.T_LOT.IdLot
FROM   dbo.TL_TRI_STAT INNER JOIN
       dbo.TL__FIC ON dbo.TL_TRI_STAT.[N°Fic] = dbo.TL__FIC.[N°Fic] LEFT OUTER JOIN
       dbo.T_LOT ON dbo.TL__FIC.IdLot = dbo.T_LOT.IdLot

	   WHERE T_Lot.IdMachineTri <> 95


GO


