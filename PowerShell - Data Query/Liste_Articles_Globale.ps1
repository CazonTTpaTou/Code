$Path = 'C:\Users\monne\Dropbox\Articles'
$Destination = 'C:\Users\monne\Desktop\'

$File = $Destination + '\Liste_Articles_Globale.txt'

If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{    
    $Directory = $Path + '\' + $Repertoire

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}}, @{Label='---------- Repertoire ---------- ';Expression={$Repertoire}}|  out-file -FilePath $File -Append
}






    




     