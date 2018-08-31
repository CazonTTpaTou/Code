$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

[reflection.assembly]::LoadWithPartialName("System.Data")

$path = "C:\Users\SP_INSTALL\Desktop\Export.xlsx"

$hostUrl = "http://intranet.photowatt.local"
$relSiteUrl = "/supplychain/DA/"
# Url de la liste relativement au SPWeb (Pour une liste non-documentaire ce serait  $webRelListUrl = "Lists/alice")
# $webRelListUrl = "Demande Achats"
$webRelListUrl = "lists/Demande%20Achats"

# On definit l'url du SPWeb en entier
# Puis pour ItemUrl, l'url relative de la liste par rapport au hostname (la signification de "/" en debut de chaine)
Write-Host "URL du site " + ($hostUrl + $relSiteUrl)
Write-Host "URL de la liste " + ($relSiteUrl + $webRelListUrl)

Export-SPWeb ($hostUrl + $relSiteUrl) -Path $path -ItemUrl ($relSiteUrl + $webRelListUrl)

