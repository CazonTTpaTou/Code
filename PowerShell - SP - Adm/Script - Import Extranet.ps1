---------------------------------------------------------------------------------------------------------------
Sauvegarder une collection de site
---------------------------------------------------------------------------------------------------------------

stsadm -o backup -url http://intranet.photowatt.local -filename \\srv-sp-rec\Temp$\Sauvegarde.dat

---------------------------------------------------------------------------------------------------------------
Supprimer une collection de site
---------------------------------------------------------------------------------------------------------------

stsadm -o restore -url http://intranetpp.photowatt.local:6666 -filename \\srv-sp-rec\Temp$\Sauvegarde.dat -overwrite

---------------------------------------------------------------------------------------------------------------
Supprimer des sites
---------------------------------------------------------------------------------------------------------------

remove-spweb http://srv-sp-rec:6666/HSE -confirm:$false

remove-spweb http://srv-sp-rec:6666/CHSCT -confirm:$false

remove-spweb http://srv-sp-rec:6666/RH -confirm:$false

remove-spweb http://srv-sp-rec:6666/Communication/CR%20Production -confirm:$false

remove-spweb http://srv-sp-rec:6666/Communication/Managers -confirm:$false

---------------------------------------------------------------------------------------------------------------
Supprimer des bibliothèques
---------------------------------------------------------------------------------------------------------------

$web = Get-SPWeb http://srv-sp-rec.photowatt.local:6666/Communication/
$library = $web.lists["Managers"]
$library.Delete()

---------------------------------------------------------------------------------------------------------------
Supprimer des autorisations
---------------------------------------------------------------------------------------------------------------

$web = Get-SPWeb -Identity http://sp2010:90
$PermissionLevel=$web.RoleDefinitions
$PermissionLevel.Delete("Contribute")

$caml='<Where> <Lt> <FieldRef Name="Publication Extranet" /><Value>False</Value> </Lt> </Where> ' 

---------------------------------------------------------------------------------------------------------------
Supprimer des éléments de liste
---------------------------------------------------------------------------------------------------------------

[System.reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
$web = Get-SPWeb "http://srv-sp-rec.photowatt.local:6666/"
$list = $web.Lists["Accueil - News Texte"]
$spFieldType = [Microsoft.SharePoint.SPFieldType]::Boolean      
$caml='<Where> <Eq> <FieldRef Name="Publication Extranet"/><Value Type="Yes/No">1</Value></Eq>' -f $spFieldType
$query=new-object Microsoft.SharePoint.SPQuery
$query.Query=$caml
$col=$list.GetItems($query)
Write-Host $col.Count
$col | % {$list.GetItemById($_.Id).Delete()}
$web.Dispose()

