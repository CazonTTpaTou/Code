$Path = 'G:\Series 2018'
$Destination = 'C:\Users\monne\Desktop\Liste_Musique_Fichiers'



If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{    
    $Directory = $Path + '\' + $Repertoire

    $pathDirectory = $Destination + '\' + $Repertoire
    
    If(!(test-path $pathDirectory))
        {New-Item -ItemType Directory -Force -Path $pathDirectory}

    foreach ($SousRepertoire in Get-ChildItem -Path $Directory -Director)
        {
        $SousDirectory = $Directory + '\' + $SousRepertoire
        $File = $pathDirectory + '\' + $SousRepertoire + '.txt'

        Get-ChildItem -Path $SousDirectory -File -Include *.mp3,*.wma,*.flac,*.mpeg,*.wmv -Recurse | Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}}, @{Label='---------- Repertoire ---------- ';Expression={$SousRepertoire}}|  out-file -FilePath $File -Append
        }     
}






    




     