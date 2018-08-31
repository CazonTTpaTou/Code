# Ce script met à jour la liste des demandes d'achat avec les dernières informations à jour
# concernant le numéro de commande et la date de livraison

# Date de création : 26/01/2017
# Version 1.0

$ver = $host | select version
if ($ver.Version.Major -gt 1) {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-Location $home

[reflection.assembly]::LoadWithPartialName("System.Data")

# Cette fonction exécute une requête sur la base SQL pour récupérer le numéro de commande et la date de livraison
# Si la requête réussit, une mise à jour de la demande d'achat est effectuée

function updateDA($da) {
    $numDA = $da["Numero_x0020_demande"]

##    $query = "SELECT * FROM VUE_DTM_PUR_LISTE_DA WHERE Num_DA_Numerique = " + $numDA
$query = "SELECT * FROM VUE_DTM_PUR_LISTE_DA_MOC WHERE Num_DA_Numerique = " + $numDA
    $command.CommandText = $query
    $reader = $command.ExecuteReader()

    $trouve = $false
    while ($reader.Read()) {
        $numCDE = $reader["Num_Commande"]
        $dateLIV = $reader["Date_Livraison"]
        $dateCOM = $reader["Date_Commande"]
		$dateLIV_EST = $reader["Date_Livraison_Estim"]
		$Statut = $reader["Statut"]
        Write-Host "Num_Commande " + $numCDE
		Write-Host "Date_Livraison Estime " + $dateLIV_EST
        Write-Host "Date_Livraison " + $dateLIV		
        Write-Host "Date_Commande " + $dateCOM
		Write-Host "Statut " + $Statut
        $trouve = $true
    }
    $reader.Close()

    if ($trouve) {
        Write-Host "Trouvé"
        $spItem = $spList.GetItemById($da["ID"])
        $spItem["NumCommande"] = $numCDE
        $spItem["DateLivraison"] = $dateLIV
		$spItem["DateLivraisonEstim"] = $dateLIV_EST
        $spItem["DateCommande"] = $dateCOM
		$spItem["StatutCommande"] = $Statut
        $spItem.Update()
    }

    }


# Cette fonction regarde si le numéro de commande ou si la date de livraison sont manquants
# Si c'est la cas, elle demande une mise à jour

function processDA($da) {
    $num = $da["NumCommande"]
    $dateliv = $da["DateLivraison"]
    if ((! $num) -or (! $dateliv)) {
        updateDA $da
        $script:NbreMAJ++
    }
}
$NbreMAJ = 0
Write-Host "Connexion à la base de données"
# Connexion à la base SQL, puis traitement sur l'ensemble des demandes d'achat

$connectionString = "Persist Security Info=False;User ID=sassql;Password=s@s-sql2008;Initial Catalog=DTM;Server=SRV-SASSQL\SASSQLPROD"
$connection = new-object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()
$command = $connection.CreateCommand()

$spWebUrl = "http://intranet.photowatt.local/supplychain/DA/"
$listName = "Demande Achats"

Write-Host "Revue de la liste des DA"

$spWeb = get-spWeb $spWebUrl
$spList = $spWeb.Lists[$listName]
$spList.Items | ForEach-Object {ProcessDA $_}

Write-Host ("Nombre de DA sans commande : {0}" -f $NbreMAJ)
