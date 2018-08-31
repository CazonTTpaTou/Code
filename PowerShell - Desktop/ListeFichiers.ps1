$Path = 'C:\Users\fmonnery\Desktop\Divers\'
$Destination = 'C:\Users\fmonnery\Desktop\Fichiers_SQL.txt'
$Destination2 = 'C:\Users\fmonnery\Desktop\Fichiers_SQ2L.txt'

#Get-ChildItem -Path $Path -File -Include *.sql -Recurse | Format-Table | out-file -FilePath $Destination -Append

Get-ChildItem -Path $Path -File -Include *.sql,*.txt -Recurse | Format-Wide -Property Name  -Column 1 | out-file -FilePath $Destination2


