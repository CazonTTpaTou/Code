#Set-ExecutionPolicy Unrestricted

$Path = 'C:\Users\fmonnery\Cloud Drive\Books\IT'
$Destination = 'C:\Users\fmonnery\Desktop\Books'

foreach ($Repertoire in Get-ChildItem -Path $Path -Director) 

    {$UnderPath = $Path + "\" + $Repertoire
     #Write-Host $UnderPath

     foreach ($file in Get-ChildItem -Path $UnderPath -File -Include *.pdf,*.azw3,*.epub,*.mobi -Recurse)
              {
               Copy-Item -Path $file  -destination $destination
               }}

     #Get-ChildItem -Path $UnderPath -File -Include *.avi,*.mkv,*.mp4,*.mpg,*.wmv -Recurse  | Format-Table -Property @{Label='-------- Nom fichier';Expression={$_.Name}},@{Label='--------  Répertoire origine';Expression={$Repertoire}} |  out-file -FilePath $Destination -Append}
     


    



    
     