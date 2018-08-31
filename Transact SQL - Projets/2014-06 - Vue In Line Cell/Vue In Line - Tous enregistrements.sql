USE [CELL_INLINE_DB]
GO

/****** Object:  View [dbo].[V_IN_LINE_TOUS_ENREGISTREMENTS]    Script Date: 12/03/2014 13:38:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[V_IN_LINE_TOUS_ENREGISTREMENTS]
AS

SELECT

			 E02.DateTime AS [SINA_LOADER-DateTime]
			,E02.IdEquipement AS [SINA_LOADER-IdEquipement]
			,E02.Lane AS [SINA_LOADER-Lane]
			,E02.LotId AS [SINA_LOADER-LotId]
			,E02.LotWaferID AS [SINA_LOADER-LotWaferID]
			,E02.Reason AS [SINA_LOADER-Reason]
			,E02.TrayID AS [SINA_LOADER-TrayID]
			,E02.TraySlotID AS [SINA_LOADER-TraySlotID]
			
			,E03.DateTime AS [SINA_UNLOADER-DateTime]
			,E03.IdEquipement AS [SINA_UNLOADER-IdEquipement]
			,E03.Lane AS [SINA_UNLOADER-Lane]
			,E03.LotId AS [SINA_UNLOADER-LotId]
			,E03.LotWaferID AS [SINA_UNLOADER-LotWaferID]
			,E03.Quality_Result_Inspection AS [SINA_UNLOADER-Quality_Result_Ins]
			,E03.Reason AS [SINA_UNLOADER-Reason]
			,E03.TrayID AS [SINA_UNLOADER-TrayID]
			,E03.TraySlotID AS [SINA_UNLOADER-TraySlotID]
			,E03.WaferEqID AS [SINA_UNLOADER-WaferEqID]
			
			,E04.Color_Result AS [ICOS_BE-Color_Result]
			,E04.Contour_Result AS [ICOS_BE-Contour_Result]
			,E04.Geometry_Result AS [ICOS_BE-Geometry_Result]
			,E04.IdEquipement AS [ICOS_BE-IdEquipement]
			,E04.LotId AS [ICOS_BE-LotId]
			,E04.LotWaferID AS [ICOS_BE-LotWaferID]
			,E04.Presence_Result AS [ICOS_BE-Presence_Result]
			,E04.Quality_Result_Classification AS [ICOS_BE-Quality_Result_Classific]
			,E04.Quality_Result_Inspection AS [ICOS_BE-Quality_Result_Inspectio]
			,E04.Surface_Result AS [ICOS_BE-Surface_Result]
			,E04.TimeStamp AS [ICOS_BE-TimeStamp]
			,E04.WaferEqID AS [ICOS_BE-WaferEqID]
			
			,E01.CarrierID AS [PRINT_LINE_LOADER-CarrierID]
			,E01.CarrierSlotID AS [PRINT_LINE_LOADER-CarrierSlotID]
			,E01.DateTime AS [PRINT_LINE_LOADER-DateTime]
			,E01.IdEquipement AS [PRINT_LINE_LOADER-IdEquipement]
			,E01.Lane AS [PRINT_LINE_LOADER-Lane]
			,E01.LotId AS [PRINT_LINE_LOADER-LotId]
			,E01.LotWaferID AS [PRINT_LINE_LOADER-LotWaferID]
			,E01.Reason AS [PRINT_LINE_LOADER-Reason]
			,E01.WaferEqID AS [PRINT_LINE_LOADER-WaferEqID]
			
			,E06N1.DATEHEURE AS [DUBUIT_N1-DATEHEURE]
			,E06N1.DATEHEURE_SERI AS [DUBUIT_N1-DATEHEURE_SERI]
			,E06N1.IdEquipement AS [DUBUIT_N1-IdEquipement]
			,E06N1.LotId AS [DUBUIT_N1-LotId]
			,E06N1.LOTWAFERID AS [DUBUIT_N1-LOTWAFERID]
			,E06N1.PERDU AS [DUBUIT_N1-PERDU]
			,E06N1.PRINTING_SLOT AS [DUBUIT_N1-PRINTING_SLOT]
			,E06N1.REJET_BIN AS [DUBUIT_N1-REJET_BIN]
			,E06N1.REJET_OFR AS [DUBUIT_N1-REJET_OFR]
			,E06N1.RESULTAT_INSPECTION_QUALITE AS [DUBUIT_N1-RESULTAT_INSPECTION_QU]
			,E06N1.WaferEqID AS [DUBUIT_N1-WaferEqID]
			
			,E06P1.DATEHEURE AS [DUBUIT_P1-DATEHEURE]
			,E06P1.DATEHEURE_SERI AS [DUBUIT_P1-DATEHEURE_SERI]
			,E06P1.IdEquipement AS [DUBUIT_P1-IdEquipement]
			,E06P1.LotId AS [DUBUIT_P1-LotId]
			,E06P1.LOTWAFERID AS [DUBUIT_P1-LOTWAFERID]
			,E06P1.PERDU AS [DUBUIT_P1-PERDU]
			,E06P1.PRINTING_SLOT AS [DUBUIT_P1-PRINTING_SLOT]
			,E06P1.REJET_BIN AS [DUBUIT_P1-REJET_BIN]
			,E06P1.REJET_OFR AS [DUBUIT_P1-REJET_OFR]
			,E06P1.RESULTAT_INSPECTION_QUALITE AS [DUBUIT_P1-RESULTAT_INSPECTION_QU]
			,E06P1.WaferEqID AS [DUBUIT_P1-WaferEqID]
			
			,E06P2.DATEHEURE AS [DUBUIT_P2-DATEHEURE]
			,E06P2.DATEHEURE_SERI AS [DUBUIT_P2-DATEHEURE_SERI]
			,E06P2.IdEquipement AS [DUBUIT_P2-IdEquipement]
			,E06P2.LotId AS [DUBUIT_P2-LotId]
			,E06P2.LOTWAFERID AS [DUBUIT_P2-LOTWAFERID]
			,E06P2.PERDU AS [DUBUIT_P2-PERDU]
			,E06P2.PRINTING_SLOT AS [DUBUIT_P2-PRINTING_SLOT]
			,E06P2.REJET_BIN AS [DUBUIT_P2-REJET_BIN]
			,E06P2.REJET_OFR AS [DUBUIT_P2-REJET_OFR]
			,E06P2.RESULTAT_INSPECTION_QUALITE AS [DUBUIT_P2-RESULTAT_INSPECTION_QU]
			,E06P2.WaferEqID AS [DUBUIT_P2-WaferEqID]
			
			,E07.Back_Print_Result AS [ICOS_PI_P1-Back_Print_Result]
			,E07.Contour_Result AS [ICOS_PI_P1-Contour_Result]
			,E07.Geometry_Result AS [ICOS_PI_P1-Geometry_Result]
			,E07.IdEquipement AS [ICOS_PI_P1-IdEquipement]
			,E07.LotId AS [ICOS_PI_P1-LotId]
			,E07.LotWaferID AS [ICOS_PI_P1-LotWaferID]
			,E07.Presence_Result AS [ICOS_PI_P1-Presence_Result]
			,E07.Quality_Result AS [ICOS_PI_P1-Quality_Result]
			,E07.Quality_Result_Inspection AS [ICOS_PI_P1-Quality_Result_Inspec]
			,E07.Surface_Result AS [ICOS_PI_P1-Surface_Result]
			,E07.TimeStamp AS [ICOS_PI_P1-TimeStamp]
			,E07.WaferEqID AS [ICOS_PI_P1-WaferEqID]
			
			,E08.Back_Print_Result AS [ICOS_PI_P2-Back_Print_Result]
			,E08.Contour_Result AS [ICOS_PI_P2-Contour_Result]
			,E08.Geometry_Result AS [ICOS_PI_P2-Geometry_Result]
			,E08.IdEquipement AS [ICOS_PI_P2-IdEquipement]
			,E08.LotId AS [ICOS_PI_P2-LotId]
			,E08.LotWaferID AS [ICOS_PI_P2-LotWaferID]
			,E08.Presence_Result AS [ICOS_PI_P2-Presence_Result]
			,E08.Quality_Result AS [ICOS_PI_P2-Quality_Result]
			,E08.Quality_Result_Inspection AS [ICOS_PI_P2-Quality_Result_Inspec]
			,E08.Surface_Result AS [ICOS_PI_P2-Surface_Result]
			,E08.TimeStamp AS [ICOS_PI_P2-TimeStamp]
			,E08.WaferEqID AS [ICOS_PI_P2-WaferEqID]
			
			,E09.Contour_Result AS [ICOS_PI_N1-Contour_Result]
			,E09.Front_Print_Result AS [ICOS_PI_N1-Front_Print_Result]
			,E09.Geometry_Result AS [ICOS_PI_N1-Geometry_Result]
			,E09.IdEquipement AS [ICOS_PI_N1-IdEquipement]
			,E09.LotId AS [ICOS_PI_N1-LotId]
			,E09.LotWaferID AS [ICOS_PI_N1-LotWaferID]
			,E09.Presence_Result AS [ICOS_PI_N1-Presence_Result]
			,E09.Quality_Result_Classification AS [ICOS_PI_N1-Quality_Result_Classi]
			,E09.Quality_Result_Inspection AS [ICOS_PI_N1-Quality_Result_Inspec]
			,E09.Surface_Result AS [ICOS_PI_N1-Surface_Result]
			,E09.TimeStamp AS [ICOS_PI_N1-TimeStamp]
			,E09.WaferEqID AS [ICOS_PI_N1-WaferEqID]
			
			,E10.Date AS [DESPATCH_CUISSON-Date]
			,E10.IdEquipement AS [DESPATCH_CUISSON-IdEquipement (*]
			,E10.Line AS [DESPATCH_CUISSON-Line (*)]
			,E10.LotId AS [DESPATCH_CUISSON-LotId]
			,E10.LotWaferID AS [DESPATCH_CUISSON-LotWaferID]
			,E10.Statut AS [DESPATCH_CUISSON-Statut]
			,E10.WaferEqID AS [DESPATCH_CUISSON-WaferEqID]
			
			,E11.Date AS [DESPATCH_SCHILLER-Date]
			,E11.IdEquipement AS [DESPATCH_SCHILLER-IdEquipement]
			,E11.Line AS [DESPATCH_SCHILLER-Line (*)]
			,E11.LotId AS [DESPATCH_SCHILLER-LotId]
			,E11.LotWaferID AS [DESPATCH_SCHILLER-LotWaferID]
			,E11.Statut AS [DESPATCH_SCHILLER-Statut]
			,E11.WaferEqID AS [DESPATCH_SCHILLER-WaferEqID]
			,E12.deadtime AS [TRI_BERGER-deadtime]
			,E12.IdEquipement AS [TRI_BERGER-IdEquipement]
			,E12.LotId AS [TRI_BERGER-LotId]
			,E12.measurementtime AS [TRI_BERGER-measurementtime]
			,E12.WaferEqID AS [TRI_BERGER-WaferEqID]
			,E12.WaferID AS [TRI_BERGER-WaferID]
			
			,E14.Color_Result AS [ICOS_FSPI-Color_Result]
			,E14.Contour_Result AS [ICOS_FSPI-Contour_Result]
			,E14.Front_Print_Result AS [ICOS_FSPI-Front_Print_Result]
			,E14.Geometry_Result AS [ICOS_FSPI-Geometry_Result]
			,E14.IdEquipement AS [ICOS_FSPI-IdEquipement]
			,E14.LotId AS [ICOS_FSPI-LotId]
			,E14.LotWaferID AS [ICOS_FSPI-LotWaferID]
			,E14.Presence_Result AS [ICOS_FSPI-Presence_Result]
			,E14.Quality_Result_Classification AS [ICOS_FSPI-Quality_Result_Classif]
			,E14.Quality_Result_Inspection AS [ICOS_FSPI-Quality_Result_Inspect]
			,E14.Surface_Result AS [ICOS_FSPI-Surface_Result]
			,E14.TimeStamp AS [ICOS_FSPI-TimeStamp]
			,E14.WaferEqID AS [ICOS_FSPI-WaferEqID]
			
			,E15.Back_Print_Result AS [ICOS_BSPI-Back_Print_Result]
			,E15.Contour_Result AS [ICOS_BSPI-Contour_Result]
			,E15.Geometry_Result AS [ICOS_BSPI-Geometry_Result]
			,E15.IdEquipement AS [ICOS_BSPI-IdEquipement]
			,E15.LotId AS [ICOS_BSPI-LotId]
			,E15.LotWaferID AS [ICOS_BSPI-LotWaferID]
			,E15.Presence_Result AS [ICOS_BSPI-Presence_Result]
			,E15.Quality_Result AS [ICOS_BSPI-Quality_Result]
			,E15.Quality_Result_Inspection AS [ICOS_BSPI-Quality_Result_Classif]
			,E15.Surface_Result AS [ICOS_BSPI-Surface_Result]
			,E15.TimeStamp AS [ICOS_BSPI-TimeStamp]
			,E15.WaferEqID AS [ICOS_BSPI-WaferEqID]


		FROM
	
			dbo.WAFER_PLL AS E01
			
				FULL OUTER JOIN dbo.WAFER_SNL AS E02
				ON E01.LotWaferID = E02.LotWaferID
			
				FULL OUTER JOIN dbo.WAFER_SNU AS E03
				ON E01.LotWaferID = E03.LotWaferID
				
				FULL OUTER JOIN dbo.ICOS_BLUE_EYE AS E04
				ON E01.LotWaferID = E04.LotWaferID
				
				FULL OUTER JOIN dbo.WAFER_PP1 AS E06P1
				ON E01.LotWaferID = E06P1.LotWaferID
				
				FULL OUTER JOIN dbo.WAFER_PP2 AS E06P2
				ON E01.LotWaferID = E06P2.LotWaferID
				
				FULL OUTER JOIN dbo.WAFER_PN1 AS E06N1
				ON E01.LotWaferID = E06N1.LotWaferID
				
				FULL OUTER JOIN dbo.ICOS_BSPI_P1 AS E07
				ON E01.LotWaferID = E07.LotWaferID
				
				FULL OUTER JOIN dbo.ICOS_BSPI_P2 AS E08
				ON E01.LotWaferID = E08.LotWaferID
				
				FULL OUTER JOIN dbo.ICOS_FSPI_N1 AS E09
				ON E01.LotWaferID = E09.LotWaferID
				
				FULL OUTER JOIN dbo.DESPATCH_FIRING AS E10
				ON E01.LotWaferID = E10.LotWaferID
				
				FULL OUTER JOIN dbo.WAFER_DES AS E11
				ON E01.LotWaferID = E11.LotWaferID
				
				FULL OUTER JOIN dbo.BERGER_Results AS E12
				ON E01.LotWaferID = E12.WaferID
				
				FULL OUTER JOIN dbo.ICOS_FSCC AS E14
				ON E01.LotWaferID = E14.LotWaferID
				
				FULL OUTER JOIN dbo.ICOS_BSCC AS E15
				ON E01.LotWaferID = E15.LotWaferID
	







GO

