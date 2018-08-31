' *** Start of script for flow vdb_DATAMART_TRAC_CEL_TRIEES_1464888068018 ***

' Define constants needed for accessing files
Const ForReading = 1, ForWriting = 2, ForAppending = 8

flowStatus = 0

scriptFilename = "E:\Donnees_SAS\DTM_PRO\Archives\Scripts\Replication_DTM.vbs"

' Update date and time variable
curDateTime = Now()

' Create timestamp used in naming the status file
timeStamp = Left("0000", 4 - Len(Year(curDateTime))) & Year(curDateTime) & Left("00", 2 - Len(Month(curDateTime))) & Month(curDateTime) & Left("00", 2 - Len(Day(curDateTime))) & Day(curDateTime) & Left("00", 2 - Len(Hour(curDateTime))) & Hour(curDateTime) & Left("00", 2 - Len(Minute(curDateTime))) & Minute(curDateTime) & Left("00", 2 - Len(Second(curDateTime))) & Second(curDateTime)

statusFilename = "E:\Donnees_SAS\DTM_PRO\Logs\" & timeStamp & "_Replication_DTM_status.log"

' Initialize references to FileSystem and Shell objects
Set fileSys = Wscript.CreateObject("Scripting.FileSystemObject")
Set shell = Wscript.CreateObject("Wscript.Shell")

' Open status file
Set statusFile = fileSys.OpenTextFile(statusFilename, ForWriting, True)

' *** Start of flow ***

' Log start of flow to status file
statusFile.WriteLine("Flow STARTING...")

' *** No Dependencies ***

' *** Begin Job Event ***

' Update date and time variables
curDateTime = Now()
curDate = Left("00", 2 - Len(Month(curDateTime))) & Month(curDateTime) & "/" & Left("00", 2 - Len(Day(curDateTime))) & Day(curDateTime) & "/" & Left("0000", 4 - Len(Year(curDateTime))) & Year(curDateTime)
curTime = Left("00", 2 - Len(Hour(curDateTime))) & Hour(curDateTime) & ":" & Left("00", 2 - Len(Minute(curDateTime))) & Minute(curDateTime) & ":" & Left("00", 2 - Len(Second(curDateTime))) & Second(curDateTime)

' Log start of job to status file
statusFile.WriteLine("Job vdb_Replication_DTM STARTING " & curDate & " " & curTime)

' Enable error handling
On Error Resume Next

' Execute job
errorLevel = shell.Run("C:\SAS\EBIserver\Lev1\SASApp\BatchServer\sasbatch.bat -log E:\Donnees_SAS\DTM_PRO\Logs\Replication_DTM_#Y.#m.#d_#H.#M.#s.log -print E:\Donnees_SAS\DTM_PRO\Logs\Replication_DTM.lst -batch -noterminal -logparm ""rollover=session""  -sysin E:\Donnees_SAS\DTM_PRO\Archives\Scripts\Replication_DTM.sas", , True)

If Err.Number <> 0 Then
  status_A5967C5U_BR0000Z5 = Err.Number
  Err.Clear
Else
  status_A5967C5U_BR0000Z5 = errorLevel
End If

' Disable error handling
On Error Goto 0

' Update date and time variables
curDateTime = Now()
curDate = Left("00", 2 - Len(Month(curDateTime))) & Month(curDateTime) & "/" & Left("00", 2 - Len(Day(curDateTime))) & Day(curDateTime) & "/" & Left("0000", 4 - Len(Year(curDateTime))) & Year(curDateTime)
curTime = Left("00", 2 - Len(Hour(curDateTime))) & Hour(curDateTime) & ":" & Left("00", 2 - Len(Minute(curDateTime))) & Minute(curDateTime) & ":" & Left("00", 2 - Len(Second(curDateTime))) & Second(curDateTime)

' Log completion of job and exit code to status file
statusFile.WriteLine("Job vdb_Replication_DTM COMPLETE " & curDate & " " & curTime & " status=" & status_A5967C5U_BR0000Z5 & ".")

' Set flag indicating that job has executed
exec_A5967C5U_BR0000Z5 = True

' Update flow exit code
If flowStatus = 0 Then
  flowStatus = status_A5967C5U_BR0000Z5
End If

' *** End Job Event ***

' Update date and time variables
curDateTime = Now()
curDate = Left("00", 2 - Len(Month(curDateTime))) & Month(curDateTime) & "/" & Left("00", 2 - Len(Day(curDateTime))) & Day(curDateTime) & "/" & Left("0000", 4 - Len(Year(curDateTime))) & Year(curDateTime)
curTime = Left("00", 2 - Len(Hour(curDateTime))) & Hour(curDateTime) & ":" & Left("00", 2 - Len(Minute(curDateTime))) & Minute(curDateTime) & ":" & Left("00", 2 - Len(Second(curDateTime))) & Second(curDateTime)

' Log completion of flow and exit code to status file
statusFile.WriteLine("Flow vdb_Replication_DTM COMPLETE COMPLETE " & curDate & " " & curTime & " status=" & flowStatus & ".")

' Close status file
statusFile.Close

' Exit flow and return status
Wscript.Quit(flowStatus)

' *** End of script for flow vdb_Replication_DTM ***
