$web = Get-SPWeb http://intranet.photowatt.local/IG/calendrier
$web.CustomMasterUrl = "/_catalogs/masterpage/seattle.master" 
$web.MasterUrl = "/_catalogs/masterpage/seattle.master" 
$web.Update() 
