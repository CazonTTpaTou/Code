$Files = Get-ChildItem "C:\Downloads\LogFiles\u_ex*.log"
$Files | Foreach-Object { $newName = "W3SVC214_"+$_.Name; Rename-Item $_.FullName $newName }
