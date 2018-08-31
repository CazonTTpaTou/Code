$Path = 'F:\Sauvegarde\AmazonDrive_2018'
$Destination = 'C:\Users\monne\Desktop\Liste Pictures Category'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse  |  Format-Table -Property @{Label='-------------------------- Titre de la photo --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     