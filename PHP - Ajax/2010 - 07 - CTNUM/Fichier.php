<?php

$serverPath =$_SERVER['DOCUMENT_ROOT'];  
$folderPath = "/"; 
$fullPath = $serverPath.$folderPath;

$folder=dir($fullPath);

$navArray = array();

while($thisItem=$folder->read()) {

	$printThis = 1;

	$folderItem=$fullPath.$thisItem;

	if (is_dir($folderItem)) {$foundDot=(strpos($thisItem,".",0));
				  if($foundDot===0) $printThis=0;
				  $foundDot=(strpos($thisItem,"_",0));
				  if($foundDot===0) $printThis=0;

				  if($printThis) {$thisItemDisplay = str_replace("_"," ",$thisItem);
						  $thisItemDisplay = preg_replace('/^[0-9]+/',"",$thisItemDisplay);
						  $thisItemDisplay = ucfirst($thisItemDisplay);
						  $navArray[$thisItemDisplay]=$thisItem;}}}

asort($navArray);
print"<ul>\n";

foreach ($navArray as $name=>$value) {
	print '<li><a href="'.$folderPath.$value.'">'.$name."</a></li>";}
	
	print "</ul>";
	$folder->close();
	
?>

