# Script PowerShell permettant de mettre à jour le champ Titre 
# dans les documents Word, Excel et PowerPoint pour les documents stockés dans le site Qualité

# Version 1.0
# Mis à jour le 15/07/2015
# Mis à jour par Eric Wyss (06 87 32 22 43)

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

function Update-Title($WebUrl) 
{ 
$spWeb = Get-SPWeb $WebUrl
Write-Host "Checking " $spWeb.Title " for documents with titles different from file names" 
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

if (($item.File.CheckOutStatus -eq "None") -and (($item["Title"] -eq $null) -or ($item["Title"].CompareTo($name) -ne 0)))
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
