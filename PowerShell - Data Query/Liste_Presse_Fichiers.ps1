$Path = 'E:\Articles - Presse\Presse PDF'
$Destination = 'C:\Users\monne\Desktop\Liste Presse'

$Title = 'Liste Presse PDF'
$File = $Destination + '\' + $Title + '.txt'

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Path -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Titre Article --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File







    




     