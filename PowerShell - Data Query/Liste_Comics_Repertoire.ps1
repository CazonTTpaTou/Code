$Path = 'E:\Bandes dessinées'
$Destination = 'C:\Users\monne\Desktop\Liste BD Repertoire'

$File = $Destination + '\Liste Comics Global.txt'

If (Test-Path $File)
    {Remove-Item $File}

If (-Not(Test-Path $File))
    {out-file -FilePath $File}

Get-ChildItem -Path $Path -Director  | Format-Table -Property @{Label='--------------------------------- Titre du comics --------------------------------- ';Expression={$_.Name}} |  out-file -FilePath $File -Append






    




     