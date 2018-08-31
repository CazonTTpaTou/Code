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
        
        $File = $SousDirectory + '\' + $SousRepertoire + '.txt'

        $numberDirectory = $numberDirectory + 1

        If (Test-Path $File)
            {Remove-Item $File}

        Write-Host $File        
        }  
            
}










    




     