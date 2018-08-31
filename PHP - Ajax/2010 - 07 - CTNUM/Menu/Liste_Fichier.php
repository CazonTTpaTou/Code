<?php

print '<div class="princ_livre" >';

	print'<span class="libelle">';
	print '<a href="Intro.php?Operation=0" >';
	print '<input type="button" value="Retour Page Principale" />';
	print '</a>';
	print'</span>';
	print '<br/>';
	print '<br/>';

	     print '<span class="libelle" >';
	     print '<label>Fichiers de routage (classement chronologique) : </label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';

$serverPath =$_SERVER['DOCUMENT_ROOT'];  
$folderPath = "/CTNUM/Menu/Fichiers/"; 
$fullPath = $serverPath.$folderPath;

//echo $fullPath;

$folder=dir($fullPath);

$navArray = array();

while($thisItem=$folder->read()) {

	$printThis = 1;

	$folderItem=$fullPath.$thisItem;

				  $foundDot=(strpos($thisItem,".",0));
				  if($foundDot===0) $printThis=0;
				  $foundDot=(strpos($thisItem,"_",0));
				  if($foundDot===0) $printThis=0;

				  if($printThis) {$thisItemDisplay = str_replace("_"," ",$thisItem);
						  $thisItemDisplay = preg_replace('/^[0-9]+/',"",$thisItemDisplay);
						  $thisItemDisplay = ucfirst($thisItemDisplay);
						  $navArray[$thisItemDisplay]=$thisItem;}}

asort($navArray);
print"<ul>\n";

foreach ($navArray as $name=>$value) {
	print '<li><a href="'.$folderPath.$value.'" TARGET="_blank">'.$name."</a>";
	$adresse="Compression.php?Fichier=Fichiers/".$value;
	//echo $adresse;
	print '<span class="champs">';
	print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
	print '</span>';
	print'</li>';}

	print "</ul>";
	$folder->close();
	

print '</div>';

?>