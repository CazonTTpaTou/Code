Wscript.sleep 360000
strComputer = "."
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colListOfServices = objWMIService.ExecQuery("Select * from Win32_Service Where State = 'Stopped' and StartMode = 'Auto'")

For i = 1 to 10
  For Each objService in colListOfServices
      objService.StartService()
  Next
  Wscript.sleep 50000
Next