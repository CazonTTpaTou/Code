# Ce script permet d'alimenter des groupes de sécurité SharePoint
# Pré-requis : Les groupes de sécurité doivent avoir été préalablement créés
#
# Auteur : Eric Wyss, pour le compte de la société PHOTOWATT
# Date de mise à jour : 9/06/2015
# Version 1.2

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell

$filepath = "C:\\Temp\\Classeur2.csv"
# Structure du fichier CSV : user login;group name;site name

function AddUserToSecurityGroup ($webName, $userLogin, $groupName)
{
$w = Get-SPWeb -identity $webName

if ($w)
{
$u = $w.EnsureUser($userLogin)
$g = $w.SiteGroups[$groupName]
if ($g)
{
  Set-SPUser -Identity $u -Web $w -Group $g
  Write-Host "L'utilisateur " $userLogin " a été ajouté au groupe " $g
}
else
{
  Write-Host -f yellow "Le groupe " $groupName " n'existe pas"
}
}
else
{
  Write-Host -f yellow "Le site " $webName " n'existe pas"
}
}

# ----------------------------------------------------------------------------------



Import-CSV $filepath -Header userName,groupName,webName -delimiter ";" | Foreach-Object{
   AddUserToSecurityGroup $_.webName $_.userName $_.groupName
}


