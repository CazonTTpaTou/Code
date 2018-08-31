$Path = 'C:\Users\monne\Dropbox\Videos'
$Destination = 'C:\Users\monne\Desktop\Liste Videos'

$Title = 'Liste Videos'
$File = $Destination + '\' + $Title + '.txt'

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Path -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Titre vidéo --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File







    




     