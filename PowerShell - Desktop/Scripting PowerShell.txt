################# Les bases #############################################

# Liste des services stoppés
Get-Service | Where-Object {$_.Status -eq 'Stopped'}
Get-Service | Where-Object -Property Status -EQ -Value Stopped

# Liste Alias
Get-Alias

# Blocs de scripts
& { Get-Service }

# Processus consommant plus de 15Mo
Get-Process | Where-Object {$_.WorkingSet -gt 15000000}

# Processus consommant plus de 15Mo
Get-Process | Where-Object {$_.CPU -gt 2000}

# Export service
Get-Service | Where-Object {$_.Status -eq 'Running'} | Out-File -FilePath ./ListeService.txt

# Importer Liste service 
Import-Csv -Path .\ListeCSV.csv

################# Les objets #############################################

# Utilisation objets
$var = "PowerShell"
$var | Get-Member
$var.ToUpper()

# Sélectionner parmi un jeu d'objets
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
Write-Host '##############################'
Get-Process | Sort-Object -Property CPU -Descending | Select-Object -Last 10

# Extraire le contenu d'une propriété
Get-Process -Name powershell_ise | Select-Object -Property ProcessName, Modules

# Extraire le contenu étendu d'une propriété
#Get-Process -Name powershell_ise | Select-Object -ExpandProperty Modules | Select-Object -Property ModuleName

# Trier les objets en ordre croissant
 Get-Process | Sort-Object -Property WS 

# Trier les objets en ordre décroissant
 Get-Process | Sort-Object -Property WS -Descending

# Eliminer les doublons
1,2,3,4,5,1,2,3 | Sort-Object -Unique

# Effectuer des comparaisons
$BaseReference = Get-Process | Select-Object -First 15
$BaseDifference = Get-Process | Select-Object -First 10
Compare-Object -ReferenceObject $BaseReference -DifferenceObject $BaseDifference 

# Lister attributs processeur
$local=Get-WmiObject -Class Win32_Processor -ComputerName DESKTOP-0SJ80TE
$local | gm

# Réaliser une itération
1,2,3 | ForEach-Object -Begin {Write-Host "Début du traitement..."} -Process {$_ * 3} -End {Write-Host "Fin de traitement"}
"Windows Powershell" | ForEach-Object -MemberName 'Split' -ArgumentList ' '

# Créer des objets
$Objet = New-Object -TypeName PSCustomObject
$Objet | Add-Member -NotePropertyName Prénom -NotePropertyValue 'Kais'
$Objet | Add-Member -NotePropertyName Nom -NotePropertyValue 'Aris'

################# Mise en forme des données #############################################

# Liste des formats Powershell
Get-ChildItem $PSHOME\*format*

# Afficher données sous forme de tableau
Get-Process | Format-Table -Property ProcessName, CPU
Get-Process | Format-Table -Property ProcessName, CPU -AutoSize

# Propriétés personnalisées
Get-Process | Format-Table -Property @{Label='Nom du processus';Expression={$_.ProcessName}}, @{Label='Temps processeur';Expression={$_.CPU}}

# Afficher les données sous forme de liste
 Get-WmiObject -Class Win32_Processor | Format-List -Property *

# Personnaliser affichage - hiérarchie d'objets
Get-Item C:\PerfLogs | Format-Custom -Depth 1

# Afficher les colonnes complètes
Get-Service | Format-Wide -Property Name -Column 1

################# Les variables #############################################

# Liste des variables d'environnement
cd Env:
Get-ChildItem

################# Les fonctions #############################################

function add-Env {
    $Environnement = $args[0]
    Write-Host "Votre environnement est Windows $Environnement."
}

add-Env 'PowerShell'

function Script:Get-HardDisk
{
    param([int]$Drivetype)
    begin {
        Write-Host "Le bloc s'exécute en premier..."
        }
    process {
        Get-WmiObject -Class Win32_LogicalDisk -Filter "Drivetype='$Drivetype'"
        }
    end {
        Write-Host "Le bloc s'exécute en dernier..."
        }
}

#Get-HardDisk -Drivetype 3
Get-HardDisk 3

################# Infrastructure WMI - CIM #############################################

Get-WmiObject -Class Win32_Processor | Get-Member

Get-CimClass -ClassName Win32_LogicalDisk

################# Services #############################################

# Lister les services
Get-Service | Where-Object {$_.Status -eq 'Running'}

################# Lister les logs #############################################

# Lister les 10 derniers fichiers logs
Get-EventLog -LogName 'Windows Powershell' -Newest 10 | Format-List

################# La base de registre #############################################

# Liste des fournisseurs
Get-PSProvider

# Liste des lecteurs (drives)
Get-PSDrive

# Lecteur de la base de registre
Get-PSDrive -PSProvider Registry

# Base de registre HKEY_CURRENT_USER
cd hkcu:
cd .\Software
ls

# Chercher des occurences de clés
Get-ChildItem -Path . -Include *Windows* -Recurse

################# Les objets COM #############################################

# Instancier le script Shell
$ComObject = New-Object -ComObject 'WScript.Shell'
$ComObject | Get-Member
$ComObject.CurrentDirectory

# Lancer le bloc note
$ComObject.Exec("notepad")

# Ouvrir une page Web
$ie = New-Object -com "InternetExplorer.application"
$ie.navigate("www.microsoft.com")
$ie.visible = $true

# S'authentifier sur GMail
$url ='http://gmail.com'
$username = "monnery.fabien@gmail.com"
$password = 'Crocodile_76'
$ie = new-object -com internetexplorer.application
$ie.Navigate($url)
$ie.Visible = $true
$ie.Document.getElementByID("email").value = $username
$ie.Document.getElementByID("Passwd").value = $password
$ie.Document.getElementById("signin").Click()

# Mapper un lecteur réseau
$netmap = new-object -comobject "Wscript.Network"
$netmap.MapNetworkDrive('Z','\\srv-sas')
$netmap.RemoveNetworkDrive('Z')

# Manipuler les fichiers
$Fso = New-Object -ComObject "Scripting.FileSystemObject"
$Wfso = $Fso.CreateTextFile("Devops.txt")
$Wfso.WriteLine("This is PowerShell !!")

$GetFile = $Fso.OpenTextFile("Devops.txt")
$GetFile.ReadAll()
$GetFile.Close()

################# Les expressions régulières #############################################

select-string -Path $pshome\en-US\*.txt -Pattern 'operators'

#####################################################################################





