$Path = 'C:\Users\monne\Dropbox\Articles'
$Destination = 'C:\Users\monne\Desktop\Liste Articles'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     