Set fileSys = Wscript.CreateObject("Scripting.FileSystemObject")
Set shell = Wscript.CreateObject("Wscript.Shell")

errorLevel = shell.Run("D:\SAS\DATAMNGT\pgm\getdata_adhoc.cmd", , True)
