# Script permettant de supprimer une colonne de bibliothèque 
# Attention : Si cette colonne contient des informations, celles-ci seront également supprimées

# Auteur : Eric Wyss, pour le compte de la société Photowatt
# Date de création : 10/03/2016
# Version 1.0

$url = "http://intranet.photowatt.local/informatique"
$docLibName = "Plan actions SI"
$fieldName = "Domaines"

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

$w = get-spweb $url 
$doclib = $w.lists[$docLibName]
$field = $doclib.Fields[$fieldName]

# check if it's a ReadOnly field.
# if so, reset it
if ($field.ReadOnlyField)
{
  $field.ReadOnlyField = $false
  $field.Update()
}

# check if it's a Hidden field.
#if so, reset it
if ($field.Hidden)
{
    $field.Hidden = $false
    $field.Update()
}

# check if the AllowDeletion property is set to false.
# if so, reset it to true
if (($field.AllowDeletion -eq $null) -or (!$field.AllowDeletion))
{
    $field.AllowDeletion = $true
    $field.Update()
}

# check the sealed property
if ($field.Sealed)
{
    $field.Sealed = $false
    $field.Update()
}

# check the FromBaseType property
if ($field.FromBaseType)
{
    $field.FromBaseType = $false
    $field.Update()
} 

# finally, remove the field
$field.Delete()
$field.ParentList.Update()
