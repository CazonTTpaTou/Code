$Path = 'F:\Sauvegarde\AmazonDrive_2018'
$Destination = 'C:\Users\monne\Desktop\Liste Pictures Global'

$File = $Destination + '\Liste Series Global.txt'

If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{    
    $Directory = $Path + '\' + $Repertoire

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Titre Photo --------------------------- ';Expression={$_.Name}}, @{Label='---------- Rubrique ---------- ';Expression={$Repertoire}}|  out-file -FilePath $File -Append
}






    




     