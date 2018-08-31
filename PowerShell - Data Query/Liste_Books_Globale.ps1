$Path = 'E:\Books'
$Destination = 'C:\Users\monne\Desktop\Liste Books Global'

$File = $Destination + '\Liste Books Globale.txt'

If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{    
    $Directory = $Path + '\' + $Repertoire

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse  | Format-Table -Property @{Label='--------------------------------- Titre du livre --------------------------------- ';Expression={$_.Name}}, @{Label='------------ Repertoire ------------ ';Expression={$Repertoire}}|  out-file -FilePath $File -Append
}






    




     