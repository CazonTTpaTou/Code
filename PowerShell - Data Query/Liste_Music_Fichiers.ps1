$Path = 'F:\Series'
$Destination = 'C:\Users\monne\Desktop\Listes_Series'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Directory -File -Include *.avi,*.mkv,*.mp4,*.mpg,*.wmv -Recurse  | Where-Object { $_.length -gt 100000000 } | Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     