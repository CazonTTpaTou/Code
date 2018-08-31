# Déploiement vers l'extranet - Partie 1
# Ce script s'exécute sur le serveur SharePoint Intranet

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

$siteURLsource = "http://intranet.photowatt.local"
$partage = "\\SRV-SP-SQL-EXT\Data" 

$c1 = $Error.Count
Backup-SPSite $siteURLsource  -Path ($partage + "\Sauvegarde.bak") -Force
$c2 = $Error.Count


exit $c2-$c1