# Script de sauvegarde de la ferme SharePoint Photowatt
# doit s'exécuter sous l'identité Photowatt\sp_farm avec le niveau de privilège d'administrateur

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home


$spbackupPath = "\\cifs-fas2240\Backups\SQLPhotowatt\Sharepoint" 		# Répertoire de stockage
$days = 31							# Nombre de jours de backup conservés
$smtp = "smtp.photowatt.com"
$to = ("monitoring@photowatt.com","F.MONNERY@photowatt.com","ericwy@servicesplusweb.onmicrosoft.com")	# Destinataires de l'email
#$to = ("ericwy@servicesplusweb.onmicrosoft.com")
$from = "intranet@photowatt.com"
$spbrtoc = $spbackupPath+"\spbrtoc.xml"



$c1 = $Error.Count
Backup-SPFarm -BackupMethod Differential -Directory $spbackupPath
$c2 = $Error.Count

if ($c2 -eq $c1)
{
$sub = "Succes de la sauvegarde incrementale de la ferme SharePoint de production"

# Importer le fichier SharePoint Backup report
[xml]$sp = gc $spbrtoc

# Trouver les anciens backups dans spbrtoc.xml
#$old = $sp.SPBackupRestoreHistory.SPHistoryObject | Where-Object { $_.SPStartTime -le ((get-date).adddays(-$days)) }
#if ($old -eq $Null)
#	{ Write-Host "Aucune sauvegarde antérieure à "$days" jour(s) n'a été trouvée dans spbrtoc.xml" }
#else
#	{
#	# Supprimer les anciens backups du fichier SharePoint backup report
#	$old | ForEach-Object {$sp.SPBackupRestoreHistory.RemoveChild($_) }
#	# Supprimer les dossiers physiques dans lesquels les anciens backups sont stockés
#	$old | ForEach-Object { Remove-Item $_.SPBackupDirectory -Recurse }
#	# Sauvegarder le nouveau fichier SharePoint backup report
#	$sp.Save($spbrtoc)
#	Write-Host "Les entrées de plus de "$days" jour(s) ont été supprimées de spbrtoc.xml"
#	}
}
else
{
$sub = "Echec de la sauvegarde incrementale de la ferme SharePoint de production"
}

# Envoi du résultat par email
$anonUsername = "anonymous"
$anonPassword = ConvertTo-SecureString -String "anonymous" -AsPlainText -Force
$anonCredentials = New-Object System.Management.Automation.PSCredential($anonUsername,$anonPassword)

send-MailMessage -SmtpServer $smtp -To $to -Subject $sub -Body $sub -From $from -credential $anonCredentials
exit $c2-$c1


