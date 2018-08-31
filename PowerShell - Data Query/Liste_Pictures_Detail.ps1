$Path = 'E:\AmazonCloudDrive'
$Destination = 'C:\Users\monne\Desktop\Liste Pictures Details'



foreach ($Repertoire in Get-ChildItem -Path $Path -Director)
{    
    $Directory = $Path + '\' + $Repertoire

    $pathDirectory = $Destination + '\' + $Repertoire
    
    If(!(test-path $pathDirectory))
        {New-Item -ItemType Directory -Force -Path $pathDirectory}
    
    $numberDirectory = 0

    foreach ($SousRepertoire in Get-ChildItem -Path $Directory -Director)
        {
        $SousDirectory = $Directory + '\' + $SousRepertoire
        
        $File = $pathDirectory + '\' + $SousRepertoire + '.txt'

        $numberDirectory = $numberDirectory + 1

        If (Test-Path $File)
            {Remove-Item $File}

        If (-Not(Test-Path $File))
            {out-file -FilePath $File}

        Write-Host $File

        Get-ChildItem -Path $SousDirectory -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Nom photo --------------------------- ';Expression={$_.Name}}, @{Label='---------- Repertoire ---------- ';Expression={$SousRepertoire}}|  out-file -FilePath $File -Append
        }  
        
    if ($numberDirectory -eq 0) 
        {
        $File = $pathDirectory + '\' + $Repertoire + '.txt'

        If (Test-Path $File)
            {Remove-Item $File}

        If (-Not(Test-Path $File))
            {out-file -FilePath $File}

        Write-Host $File

        Get-ChildItem -Path $Directory -File -Include *.* -Recurse | Format-Table -Property @{Label='-------------------------- Nom photo --------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File -Append
        }
}








    




     