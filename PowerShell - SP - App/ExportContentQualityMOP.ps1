$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

$WebURL="http://intranet.photowatt.local/Qualite/"

$Web = Get-SPWeb $WebURL

$ReportFile = "\\srv-sasdev\E\Donnees_SAS_Utilisateur\Purchasing\MOP_ContentLibrary.csv"
$delimiter = ";"

If (Test-Path $ReportFile)
 {
	Remove-Item $ReportFile
 }

$List = Get-SPWeb $WebURL | %{$_.Lists} | ?{$_.ID -eq "A6971183-1007-46FC-9320-2BE0D5E34C65"} 

$MyItems = $List.Items 

#Array to Hold Result - PSObjects
$ListItemCollection = @()

$MyItems | foreach {  
		$ExportItem = New-Object PSObject 
		
				$ExportItem | Add-Member -MemberType NoteProperty -name "ID" -value $_["ID"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Cree" -value $_["Created"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Cree_par" -value $_["Author"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Titre" -value $_["Title"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Version" -value $_["_UIVersionString"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Nom" -value $_["FileLeafRef"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "R" -value $_["Indice"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Date_publication" -value $_["Date1"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Etat_approbation" -value $_["_ModerationStatus"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Type_document" -value $_["Type_x0020_document"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Bandeau_commercial" -value $_["Bandeau_x0020_commercial"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Cible" -value $_["Cible"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Cible_2" -value $_["Cible_x0020_2"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Fonction_document" -value $_["Fonction_x0020_du_x0020_document"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Mode-operatoire" -value $_["Zone_x0020_d_x0027_application"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Modifie" -value $_["Modified"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Modifie_par" -value $_["Editor"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Mot_cle_1" -value $_["Mots_x0020_cl_x00e9_s_x0020_pour_x0020_recherche"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Nature_support" -value $_["Nature_x0020_support"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Notes" -value $_["Notes1"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Reference" -value $_["R_x00e9_f_x00e9_rence"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Responsable" -value $_["Responsable"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Responsable_archivage" -value $_["Responsable_x0020_arch_x002e_"]
				$ExportItem | Add-Member -MemberType NoteProperty -name "Lien_Express" -value $_["Proc_x00e9_dure_x0020__x00e0__x0020_mettre_x0020_en_x0020__x00e9_vidence"]
				
				$ListItemCollection += $ExportItem
				
					   #Get Each field
					   #foreach($Field in $_.Fields)
					   #{
							#$ExportItem | Add-Member -MemberType NoteProperty -name $Field.InternalName -value $_[$Field.InternalName]  
						#}
						#Add the object with property to an Array
						#$ListItemCollection += $ExportItem
					}

#Export the result Array to CSV file
$ListItemCollection | Export-CSV -Delimiter "$delimiter" -path $ReportFile -encoding "unicode" -force -notype

Write-host "User Information List Exported to $($ReportFile) for site $($Web)"
 
$ReportFile = "\\srv-sasdev\E\Donnees_SAS_Utilisateur\Purchasing\PROC_ContentLibrary.csv"
$delimiter = ";"

If (Test-Path $ReportFile)
 {
	Remove-Item $ReportFile
 }

$List = Get-SPWeb $WebURL | %{$_.Lists} | ?{$_.ID -eq "5042EFE0-7F1E-47DC-AD2B-8E2DE4B7CB52"} 

$MyItems = $List.Items 

#Array to Hold Result - PSObjects
$ListItemCollection = @() 
 

$MyItems | foreach {  
		$ExportItem = New-Object PSObject 
	
		$ExportItem | Add-Member -MemberType NoteProperty -name "ID" -value $_["ID"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Cree" -value $_["Created"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Cree_par" -value $_["Author"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Titre" -value $_["Title"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Version" -value $_["_UIVersionString"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Nom" -value $_["FileLeafRef"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "R" -value $_["Indice"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Date_publication" -value $_["Date1"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Etat_approbation" -value $_["_ModerationStatus"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Type_document" -value $_["Type_x0020_document"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Bandeau_commercial" -value $_["Bandeau_x0020_commercial"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Cible" -value $_["Cible"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Cible_2" -value $_["Cible_x0020_2"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Fonction_document" -value $_["Fonction_x0020_du_x0020_document"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Procedure" -value $_["Proc_x00e9_dure"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Modifie" -value $_["Modified"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Modifie_par" -value $_["Editor"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Mot_cle" -value $_["Mots_x0020_cl_x00e9_s_x0020_pour_x0020_recherche"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Nature_support" -value $_["Nature_x0020_support"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Notes" -value $_["Notes1"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Reference" -value $_["R_x00e9_f_x00e9_rence"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Responsable" -value $_["Responsable"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Responsable_archivage" -value $_["Responsable_x0020_arch_x002e_"]
		$ExportItem | Add-Member -MemberType NoteProperty -name "Lien_Express" -value $_["Proc_x00e9_dure_x0020__x00e0__x0020_mettre_x0020_en_x0020__x00e9_vidence"]
        $ExportItem | Add-Member -MemberType NoteProperty -name "Processus" -value $_["Processus_x0020_parent"]

	
		$ListItemCollection += $ExportItem
		}

#Export the result Array to CSV file
$ListItemCollection | Export-CSV -Delimiter "$delimiter" -path $ReportFile -encoding "unicode" -force -notype

Write-host "User Information List Exported to $($ReportFile) for site $($Web)"

