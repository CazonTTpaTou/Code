$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

$hostUrl = "http://intranet.photowatt.local"
$relSiteUrl = "/supplychain/DA/"
$webRelListUrl = "lists/Demande%20Achats"
$ListName = "Demande Achats"

$path = "C:\Users\SP_INSTALL\Desktop\Export.csv"
$delimiter = ";"

Write-Host "URL du site " + ($hostUrl + $relSiteUrl)
Write-Host "URL de la liste " + ($relSiteUrl + $webRelListUrl)

$MyWeb = ($hostUrl + $relSiteUrl)

$spWeb = get-spWeb $MyWeb
$spList = $spWeb.Lists[$ListName]
$MyItems = $spList.Items

$ListItemCollection = @()
$List = ""
$i=0
$MyItems | foreach {  

foreach($Field in $_.Fields)
						{if($i -lt 2) {write-host "Nom du champ : " + $Field.InternalName + " Valeur du champ : " + $_[$Field.InternalName]
						               $List += $Field.InternalName + ";"}							 							
						}
						$i++
}

#$List | Export-CSV -Delimiter "$delimiter" -path $path -encoding "unicode" -notype -force 

Write-host $List

$spWeb.Dispose()


