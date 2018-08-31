$Path = 'F:\Video'
$Destination = 'C:\Users\monne\Desktop\Liste Videos Category'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse  |  Format-Table -Property @{Label='-------------------------- Titre video --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     