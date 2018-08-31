Set fileSys = Wscript.CreateObject("Scripting.FileSystemObject")
Set shell = Wscript.CreateObject("Wscript.Shell")

errorLevel = shell.Run("D:\SAS\AD\run.cmd", , True)
