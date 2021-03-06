# Déploiement vers l'extranet - Partie 2
# Ce script s'exécute sur le serveur SharePoint Extranet

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

$siteURLdestination = "http://extranet.photowatt.local"
$CustomMasterUrl = "/_catalogs/masterpage/extranet_mp.master" 
$partage = "\\SRV-SP-SQL-EXT\Data" 


function Using-Culture (
    [System.Globalization.CultureInfo]   $culture = (throw "USAGE: Using-Culture -Culture culture -Script {…}"),
    [ScriptBlock] $script = (throw "USAGE: Using-Culture -Culture culture -Script {…}"))
    {
      $OldCulture = [Threading.Thread]::CurrentThread.CurrentCulture
      $OldUICulture = [Threading.Thread]::CurrentThread.CurrentUICulture
          try {
                  [Threading.Thread]::CurrentThread.CurrentCulture = $culture
                  [Threading.Thread]::CurrentThread.CurrentUICulture = $culture
                  Invoke-Command $script
          }
          finally {
                  [Threading.Thread]::CurrentThread.CurrentCulture = $OldCulture
                  [Threading.Thread]::CurrentThread.CurrentUICulture = $OldUICulture
          }
 }


$c1 = $Error.Count
# Restauration du contenu sauvegardé
Restore-SPSite $siteURLdestination -Path ($partage + "\Sauvegarde.bak") -force -confirm:$false

# Mise à jour du titre du site racine
$web = get-spweb $siteURLdestination
Using-Culture fr-fr { $web.title = "Extranet"; $web.Update() }

# Suppression de certains sites
Remove-SPWeb ($siteURLdestination + "/IG/Calendrier") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/IG") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/HSE") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/RH") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/CHSCT") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/Informatique") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/Qualite") -confirm:$false
Remove-SPWeb ($siteURLdestination + "/SupplyChain") -confirm:$false

# Suppression de certaines listes
$web = get-spweb ($siteURLdestination + "/Communication")
$library = $web.lists["CR Production"]
$library.Delete()
$library = $web.lists["Managers"]
$library.Delete()

# Application de la page maître Extranet à chaque site de la collection
$site = get-spsite $siteURLdestination
Foreach ($web in $site.AllWebs)
{
$web.CustomMasterUrl = $CustomMasterUrl
$web.MasterUrl = $CustomMasterUrl
$web.Update()
}

# Passage de la collection de sites en lecture uniquement
# Set-SPSite -Identity $siteURLdestination -LockState "ReadOnly"

# Réindexation du contenu Extranet
$searchapp = Get-SPEnterpriseSearchServiceApplication "Application de service de recherche 1"
$contentsource = Get-SPEnterpriseSearchCrawlContentSource -SearchApplication $searchapp -Identity "Sites Sharepoint locaux"
$contentSource.StartFullCrawl()


# Suppression du fichier .bak si pas d'erreur
$c2 = $Error.Count
#if ($c1 -eq $c2) {
#    Remove-Item ($partage + "\Sauvegarde.bak")
#    }

exit $c2-$c1
