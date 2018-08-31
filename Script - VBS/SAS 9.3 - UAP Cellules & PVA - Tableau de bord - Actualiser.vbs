Option Explicit
Dim excel
Dim workbook
Dim AddinObj
Dim strErrorMsg
strErrorMsg = ""

Call DoWork

' Write the log to disk
Call WriteLogFile  ' (Comment out this line if you don't want a log file to be written.)

Set AddinObj = Nothing

' Close the workbook
workbook.Close
set workbook = Nothing

' Shut down Microsoft Excel
excel.Quit
set excel = Nothing

Sub DoWork()
	On Error Resume Next

	'----
	' Start up Microsoft Excel
	'----
	Set excel = CreateObject("Excel.Application")
	If CheckError("CreateObject") = True Then
		Exit Sub
	End If
	
	excel.DisplayAlerts = False

	'-----
	' open the workbook
	'-----
	Dim collection
	Set collection = excel.Workbooks
	Set workbook = collection.Open("\\office\Bases_de_donnees\Reporting\SAS 9.3\UAP Cellules & PVA - Tableau de bord.xlsx")
	Set collection = Nothing
	If CheckError("Workbooks.Open") = True Then
		Exit Sub
	End If

    '-----
    ' wait for 10 seconds, this should allow the Add-In plenty of time to load in Office
    '-----
    Wscript.sleep 10000

	'-----
	' get ahold of the SAS Addin COM object
	'-----
	Dim SASAddin
	Set SASAddin = excel.COMAddIns("SAS.ExcelAddIn")
	Set AddinObj = SASAddin.Object
	Set SASAddin = Nothing

	'-----
	' refresh the workbook
	'-----
	AddinObj.Refresh( workbook )
	If CheckError("Addin.Refresh") = True Then
		Exit Sub
	End If
	
	'-----
	' Save the newly refreshed workbook
	'-----
	Wscript.sleep 10000
	workbook.Save
	If CheckError("workbook.Save") = True Then
		Exit Sub
	End If
	
	

End Sub

Sub WriteLogFile()
	Dim fileName
	Dim dateTime
	
	dateTime = Replace( FormatDateTime(Now(), vbShortDate), "/", "-" ) + " " + Replace( FormatDateTime(Now(), vbShortTime), ":", "" )
	
	filename = "C:\Documents and Settings\All Users\Bureau\vbs\logs\SAS 9.3 - UAP Cellules & PVA - Tableau de bord - Actualiser " + dateTime + ".txt"
	
	Dim fsObj
	Dim log
	Set fsObj = CreateObject("Scripting.FileSystemObject")
	Set log = fsObj.CreateTextFile(filename, True)
	
	If strErrorMsg <> "" then
		log.WriteLine( strErrorMsg )
		log.WriteBlankLines(2)
	End If
	
	If AddinObj.Log <> "" Then
		log.Write( AddinObj.Log )
	End If
End Sub

Function CheckError(fnName)
	CheckError = False

	Dim errNum

	If Err.Number <> 0 Then
		strErrorMsg = "Error #" & Hex(Err.Number) & vbCrLf & "In Function " & fnName & vbCrLf & Err.Description
		'MsgBox strErrorMsg  'Uncomment this line if you want to be notified via MessageBox of Errors in the script.
		CheckError = True
	End If

End Function

