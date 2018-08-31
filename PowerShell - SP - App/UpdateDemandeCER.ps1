# Ce script met à jour la liste des demandes d'achat avec les dernières informations à jour
# concernant le numéro de commande et la date de livraison

# Date de création : 26/01/2017
# Version 1.0

# Configuration du fichier de log généré
$timestamp = Get-Date -Format o | foreach {$_ -replace ':', "."}
$timestamp = "MAJ_CER_" + $timestamp
$LogFile = "C:\Logs\CER\$timestamp.log"

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

[reflection.assembly]::LoadWithPartialName("System.Data")

########################################################################################################
# Fonction d'alimentation du fichier log du script

Function LogWrite
{
	Param ([string]$logstring)
    $gd = Get-Date
    $logstring = ($gd.ToString() + " : " + $logstring) 
	Add-Content $LogFile $logstring
}

########################################################################################################
# Cette fonction exécute une requête sur la base SQL pour récupérer le numéro de commande et la date de livraison
# Si la requête réussit, une mise à jour de la demande d'achat est effectuée

function updateDA($da) {
    $numDA = $da["Numero_x0020_demande"]
    
    $numDA = $numDA.Trim()

    $query = "SELECT * FROM VUE_DTM_PUR_LISTE_CER WHERE Num_DA_Numerique like '%" + $numDA + "%'"    
    #Write-Host "CER n° " + $query

    $command.CommandText = $query
    $reader = $command.ExecuteReader()

    $trouve = $false
	
    while ($reader.Read()) {
        
		
        logwrite("--------------------------------------")
		
        $num_DA = $reader["Num_DA_Numerique"]
		$numCDE = $reader["Num_Commande"]
        $dateLIV = $reader["Date_Livraison"]
        $dateCOM = $reader["Date_Commande"]
		$dateLIV_EST = $reader["Date_Livraison_Estim"]
		$Statut = $reader["Statut"]

        $trouve = $true
    }
    $reader.Close()

    if ($trouve) {
		
        $spItem = $spList.GetItemById($da["ID"])		
        
        Write-Host "Mise à jour de la CER n° " + $numDA

        $num = $spItem["NumCommande"]

        if($num -eq $null) {
                
                logwrite("Numero_DA " + $numDA)
                logwrite("Num_Commande " + $numCDE)
	            logwrite("Date_Livraison Estime " + $dateLIV_EST)
                logwrite("Date_Livraison " + $dateLIV)		
                logwrite("Date_Commande " + $dateCOM)
		        logwrite("Statut " + $Statut)

                $spItem["NumCommande"] = $numCDE
                $spItem["Etat"] = 11	
                $spItem["Statut"] = "11 - Commande saisie dans Baan"	
		
                incrementation}

        if($dateLIV.toString().length -lt 6) {Write-Host "Pas de date de livraison pour la CER n° " $numDA  }
                  else {$spItem["DateLivraison"] = $dateLIV}
	
	    if($dateLIV_EST.toString().Length -lt 6) {Write-Host "Pas de date de livraison estimée pour la CER n° " $numDA }
				else {$spItem["DateLivraisonEstim"] = $dateLIV_EST}
        
    $spItem["DateCommande"] = $dateCOM

	$spItem["StatutCommande"] = $Statut
    
	$spItem.Update()

    }

    }

########################################################################################################
# Cette fonction regarde si le numéro de commande ou si la date de livraison sont manquants
# Si c'est la cas, elle demande une mise à jour

function processDA($da) {
    $num = $da["NumCommande"]
    $dateliv = $da["DateLivraison"]
    if ((! $num) -or (! $dateliv)) {
        updateDA $da
    }
}

########################################################################################################
# Cette fonction permet d'incrémenter le compteur des mises à jour effectuées

function incrementation 

    { $global:NbreMAJ++}



# Début du programme principal

$global:NbreMAJ = 0
Write-Host "Connexion à la base de données"

# Connexion à la base SQL des Datamart Achats

$connectionString = "Persist Security Info=False;User ID=sassql;Password=s@s-sql2008;Initial Catalog=DTM;Server=SRV-SASSQL\SASSQLPROD"
$connection = new-object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()
$command = $connection.CreateCommand()

# Connexion au site SharePoint des demandes d'achat

$spWebUrl = "http://intranet.photowatt.local/supplychain/CER/"
$listName = "Demande Achats"

# Appel du traitement sur l'ensemble des demandes d'achat

Write-Host "Revue de la liste des DA"

$spWeb = get-spWeb $spWebUrl
$spList = $spWeb.Lists[$listName]
$spList.Items | ForEach-Object {ProcessDA $_}

Write-Host "--------------------------------------"
Write-Host "Nombre de mise à jour : " + $NbreMAJ

logwrite("Nombre de mise à jour : " + $NbreMAJ)


