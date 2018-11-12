$path = "E:\Videos\Movies"
$destination = "E:\OneDrive\Divers\Listes\0 - Liste Globale\Liste Movies Chosen Few"
$nameFile_A = "Global"
$nameFile_B = "French"

$nameFiles = $nameFile_A,$nameFile_B

foreach ($nameFile in $nameFiles) {
    
    $File = $destination + "\" + $nameFile + '.txt'
    $pathFile = $path + '\' + $nameFile

    Get-ChildItem -Path $pathFile -File -Include *.avi,*.mkv,*.mp4,*.mpg,*.wmv -Recurse  | 
                                    Where-Object { $_.length -gt 100000000 } | 
                                    Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}} |  
                                    out-file -FilePath $File
                                    }




