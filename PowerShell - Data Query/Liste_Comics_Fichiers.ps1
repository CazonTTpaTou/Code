$Path ='E:\Bandes dessinées'
$Destination = 'C:\Users\monne\Desktop\Liste BD'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{
    $File = $Destination + '\' +$Repertoire + '.txt'
    $Directory = $Path + '\' + $Repertoire

    If (Test-Path $File)
        {Remove-Item $File}

     Get-ChildItem -Path $Directory -File -Include *.* -Recurse  |  Format-Table -Property @{Label='-------------------------- Titre du comics --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File
}






    




     