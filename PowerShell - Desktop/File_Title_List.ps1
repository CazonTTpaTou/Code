$Path = 'F:\Movies\Average - 2018 - 1'
$Destination = 'C:\Users\monne\Desktop\'

$File = $Destination + '\Liste_Movie_Globale_2.txt'

If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

$Directory = $Path 

Get-ChildItem -Path $Directory -File -Include *.avi,*.mkv,*.mp4,*.mpg,*.wmv -Recurse  | Where-Object { $_.length -gt 100000000 } | Format-Table -Property @{Label='-------------------------- Nom fichier --------------------------- ';Expression={$_.Name}}|  out-file -FilePath $File -Append

  
  
  
  
     