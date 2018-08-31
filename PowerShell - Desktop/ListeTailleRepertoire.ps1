$Path = 'E:\Books'
$Destination = 'C:\Users\monne\Desktop\'

$Suffixe = '.txt'
$nameFile = $Destination + 'File_Lenghts' + $Suffixe

If (Test-Path $nameFile)
       {
	    Remove-Item $nameFile
        }

cd $Path

ls -Force | 
    Add-Member -Force -Passthru -Type ScriptProperty -Name Length -Value {ls $this -Recurse -Force | Measure -Sum Length | Select -Expand Sum } | 
                Sort-Object Length -Descending | 
                            Format-Table @{label="---------Name---------";Expression={$_.Name}}, 
                                         @{label="TotalSize (MB)";expression={[Math]::Truncate($_.Length / 1MB)};width=14} |
                                                out-file -FilePath $nameFile -Append


