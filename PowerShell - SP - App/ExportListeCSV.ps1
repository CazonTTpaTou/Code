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

#Array to Hold Result - PSObjects
$ListItemCollection = @()

$MyItems | foreach {  
		$ExportItem = New-Object PSObject 
		
		$ExportItem | Add-Member -MemberType NoteProperty -name "Cree" -value $_["Created"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Acheteur" -value $_["Acheteur"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Demandeur" -value $_["Demandeur"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Devise" -value $_["Devise"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Etat" -value $_["Etat"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "FournNom" -value $_["FournNom"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Gestionnaire" -value $_["Gestionnaire"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Imputation_analytique" -value $_["Imputation_x0020_analytique"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Modifie" -value $_["Modified"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Nature_depense" -value $_["Nature_x0020_depense"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Numero_Compte" -value $_["Numero_x0020_Compte"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Numero_demande" -value $_["Numero_x0020_demande"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "RespDirectionService" -value $_["RespDirectionService"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "RespServiceAffectation" -value $_["RespServiceAffectation"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Service" -value $_["Service"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Service PWT" -value $_["Service_x0020_PWT"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "sTotal" -value $_["sTotal"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsAchat" -value $_["TempsAchat"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsApprobationDir" -value $_["TempsApprobationDir"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsApprobationResp" -value $_["TempsApprobationResp"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsCommande" -value $_["TempsCommande"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsComptable" -value $_["TempsComptable"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "TempsTraitement" -value $_["TempsTraitement"]		

		$ListItemCollection += $ExportItem
}

#					   $ExportItem = New-Object PSObject 
					   #Get Each field
#					   foreach($Field in $_.Fields)
#						{
#							$ExportItem | Add-Member -MemberType NoteProperty -name $Field.InternalName -value $_[$Field.InternalName]  

#						}
						#Add the object with property to an Array
#						$ListItemCollection += $ExportItem
#					}

#Export the result Array to CSV file
$ListItemCollection | Export-CSV -Delimiter "$delimiter" -path $path -encoding "unicode" -force -notype

Write-host "User Information List Exported to $($path) for site $($MyWeb)"

$spWeb.Dispose()
					

					
					
					
					
					
					