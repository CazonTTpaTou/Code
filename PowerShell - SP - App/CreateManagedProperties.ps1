# Ce script permet de créer des propriétés gérées
# Pré-requis : L'application de service doit avoir été peélablement créée
#
# Auteur : Eric Wyss, pour le compte de la société PHOTOWATT
# Date de création : 2/06/2015
# Version 0.9

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell

function Create-ManagedProperty ($searchServiceApplication, $cat, $managedPropertyName, $managedPropertyType, $crawledPropertyName)
# Type : 1=Text, 2=Integer, 3=Decimal, 4=DateTime, 5=YesNo, 6=Binary, 7=Double
{
  $cp = Get-SPEnterpriseSearchMetadataCrawledProperty -SearchApplication $searchapp -name $crawledPropertyName -Category $cat -ea silentlycontinue
  if ($cp)
  {
    # Check whether managed property already exists
    $mp = Get-SPEnterpriseSearchMetadataManagedProperty -SearchApplication $searchapp -Identity $managedPropertyName -ea silentlycontinue
    if ($mp)
    {
      Write-Host -f yellow "La propriété gérée " $managedPropertyName " existe déjà"
    }
    else
    {
	New-SPEnterpriseSearchMetadataManagedProperty -SearchApplication $searchApp -Name $managedPropertyName -Type $managedPropertyType
	$mp = Get-SPEnterpriseSearchMetadataManagedProperty -SearchApplication $searchapp -Identity $managedPropertyName -ea silentlycontinue
	New-SPEnterpriseSearchMetadataMapping -SearchApplication $searchApp -ManagedProperty $mp -CrawledProperty $cp
        $mp.Searchable = $true
        $mp.Queryable = $true
        $mp.Sortable = $true
        $mp.Retrievable = $true
	$mp.Refinable = $true
	$mp.update()
    }
  }
  else
  {
    Write-Host -f yellow "La propriété indexée " $crawledPropertyName " n'existe pas"
  }
}

$searchApp = Get-SPEnterpriseSearchServiceApplication
$cat = Get-SPEnterpriseSearchMetadataCategory –SearchApplication $searchapp –Identity "SharePoint"

Create-ManagedProperty $searchApp $cat "SecteurParent" 1 "ows_Secteur_x0020_parent"
Create-ManagedProperty $searchApp $cat "ZoneApplication" 1 "ows_Zone_x0020_d'application"




