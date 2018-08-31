# Active automatiquement la gestion des versions sur les bibliothèques de documents
# qui ne sont ni Private ni Catalog ni Hidden (garde les 5 dernières versions)


# Script mis à jour le 22/07/2015
# Auteur : Eric Wyss (06 87 32 22 43)

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

$siteURL = "http://intranet.photowatt.local"
$nbrVersions = 5

$site = Get-SPSite($siteURL)

foreach($web in $site.AllWebs) {
 Write-Host "Inspecting " $web.Title -foregroundcolor "yellow"
 foreach ($list in $web.Lists) {
 if(($list.BaseType -eq "DocumentLibrary") -and ($list.IsCatalog -eq $false) -and ($list.IsPrivate -eq $false) -and ($list.Hidden -eq $false)) {
 #Write-Host "Versioning enabled: " $list.EnableVersioning
 #$host.UI.WriteLine()
 #Write-Host "MinorVersioning Enabled: " $list.EnableMinorVersions
 #$host.UI.WriteLine()
 #Write-Host "EnableModeration: " $list.EnableModeration
 #$host.UI.WriteLine()
 #Write-Host "Major Versions: " $list.MajorVersionLimit
 #$host.UI.WriteLine()
 #Write-Host "Minor Versions: " $list.MajorWithMinorVersionsLimit
 #$host.UI.WriteLine()

 if (($list.EnableVersioning -eq $false) -and ($list.EnableMinorVersions -eq $false))
 {
 $list.EnableVersioning = $true
 $list.MajorVersionLimit = $nbrVersions
 $list.Update()
 Write-Host $list.Title " is updated with MajorVersionLimit " $nbrVersions
 #Write-Host $list.Title " will be updated with MajorVersionLimit " $nbrVersions
 }
 }
 }
}

