# Script PowerShell permettant de mettre à jour le champ Titre lorsque celui-ci n'est pas bien renseigné
# dans les documents Word, Excel et PowerPoint

# On considère qu'un Titre n'est pas bien renseigné quand il est vide ou lorsqu'il ne contient qu'un seul caractère
# ou lorsqu'il correspond à un élément du fichier noise.txt

# Version 1.1
# Mis à jour le 30/06/2015
# Mis à jour par Eric Wyss (06 87 32 22 43)

$noisePath = "C:\Scripts\noise.txt"
$noiseArray = gc $noisePath


Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

function Update-Title($WebUrl) 
{ 
$spWeb = Get-SPWeb $WebUrl
Write-Host "Checking " $spWeb.Title " for documents with invalid titles" 
foreach ($list in $spWeb.Lists) 
{ 
if($list.BaseType -eq "DocumentLibrary" -and $list.RootFolder.Url -notlike "_*" -and $list.RootFolder.Url -notlike "SitePages*") 
{ 
foreach($item in $list.Items) 
{ 
$title = $item["Title"]
$name = $item.Name
if ($item.Name.ToLower().EndsWith(".docx") -or $item.Name.ToLower().EndsWith(".doc") -or $item.Name.ToLower().EndsWith(".xlsx") -or $item.Name.ToLower().EndsWith(".xls") -or $item.Name.ToLower().EndsWith(".pptx") -or $item.Name.ToLower().EndsWith(".ppt"))
{
if ($item.Name.ToLower().EndsWith(".docx") -or $item.Name.ToLower().EndsWith(".xlsx") -or $item.Name.ToLower().EndsWith(".pptx")) 
    {$name = $name.Substring(0,$name.length-5);}
if ($item.Name.ToLower().EndsWith(".doc") -or $item.Name.ToLower().EndsWith(".xls") -or $item.Name.ToLower().EndsWith(".ppt")) 
    {$name = $name.Substring(0,$name.length-4);}

$noiseFound = $false
if ($title.length -ne 0)
{
forEach($w in $noiseArray)
{
if ($title.CompareTo($w) -eq 0) {$noiseFound = $true}
}
}

if ((($title.length -eq 0) -or ($title.length -eq 1) -or ($noiseFound)) -and ($item.File.CheckOutStatus -eq "None"))
{
$item.File.CheckOut();
$item["Title"] = $name
$item.update()
$item.File.CheckIn("Title updated by script");
Write-Host "Title" $title "replaced by" $name
#Write-Host "CheckOutStatus" $item.File.CheckOutStatus
}}}}}
}



Update-Title "http://intranet.photowatt.local/Qualite"
