# Script permettant la création d'une liste dans un site SharePoint
# à partir d'un modèle de liste stocké dans la galerie des modèles de liste
#
# Auteur : Eric Wyss
# Version : 1.1


# Variables permettant de préciser la liste à créer
$url = "http://intranet.photowatt.local"
$listName = "Demande de badges"
$listTemplateName = "Demande de badge"

# Charger le module PowerShell SharePoint si nécessaire
$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

# Créer la liste
$spSite = Get-SPSite $url
$spWeb = Get-SPWeb $url
$listTemplates = $spSite.GetCustomListTemplates($spWeb)

$spWeb.Lists.Add($listName, "", $listTemplates[$listTemplateName])