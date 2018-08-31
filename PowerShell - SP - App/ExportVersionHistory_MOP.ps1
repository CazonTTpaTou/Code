$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

function GenerateVersionHistory($List) {
#Check if list exists
 if($List -ne $null)
 {
  #Get all list items
  $ItemsColl = $List.Items

  #Write Report Header
  Add-Content -Path $ReportFile -Value "Item ID, Version, Created at, Created by, Title"

  #Loop through each item
  foreach ($item in $ItemsColl) 
  {
   #Iterate each version
      foreach($version in $item.Versions)
       {
		#Get the version content
		$VersionData = "$($item.id), $($version.VersionLabel), $($version.CreatedBy.User.DisplayName), $($version.Created), $($version['Title'])"

		#Write to report
		Add-Content -Path $ReportFile -Value $VersionData
   }
  }
  Write-Host "Version history has been exported successfully!"
 }
}

$WebURL="http://intranet.photowatt.local/Qualite/"

$Web = Get-SPWeb $WebURL

$ReportFile = "\\srv-sasdev\E\Donnees_SAS_Utilisateur\Purchasing\MOP_VersionHistory.csv"

If (Test-Path $ReportFile)
 {
	Remove-Item $ReportFile
 }

#$libraries = $Web.lists | Where-Object { $_.BaseType -Eq "DocumentLibrary" } 
#$libraries | Format-Table internalname,title,id -AutoSize
#$List = $Web.Lists["Documents"] 

$List = Get-SPWeb $WebURL | %{$_.Lists} | ?{$_.ID -eq "A6971183-1007-46FC-9320-2BE0D5E34C65"} 

GenerateVersionHistory($List) 

$ReportFile = "\\srv-sasdev\E\Donnees_SAS_Utilisateur\Purchasing\PROC_VersionHistory.csv"

If (Test-Path $ReportFile)
 {
	Remove-Item $ReportFile
 }

$List2 = Get-SPWeb $WebURL | %{$_.Lists} | ?{$_.ID -eq "5042EFE0-7F1E-47DC-AD2B-8E2DE4B7CB52"} 

GenerateVersionHistory($List2) 

Write-Host "End of Program !!"

