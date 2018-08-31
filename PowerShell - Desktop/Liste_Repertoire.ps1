$Path = 'F:\Movies'
$Destination = 'C:\Users\monne\Desktop\Listes_Repertoire'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

    Get-ChildItem -Path $Directory -Director | Format-Table -Property @{Label='-------------------------- Nom Repertoire --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     