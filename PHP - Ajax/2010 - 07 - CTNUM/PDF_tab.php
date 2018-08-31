<?php
$datab='';
include("Fonct.php");
$connectID=Connexion();

$sql="select li.isbn,li.titre,li.editeur,lig.quantite from reassortiment as rea inner join ligne_reassortiment as lig on rea.numero=lig.numero_com inner join livres as li on li.numero=lig.numero_livre where rea.numero=4;";
//echo $sql;
$file=mysql_query($sql,$connectID) or die("impossible d'accéder aux données");

while($row=mysql_fetch_array($file,MYSQL_ASSOC)) {
	$datab='';
	foreach($row as $key => $value) {$datab.=substr($value,0,45).';';}
	$datab.='\n';
	enregistre('Reassort',$datab."\n");
	}
	
mysql_close($connectID);

include("tuto5.php");

$fp=fopen("Reassort.txt","r+");
ftruncate($fp,0);

$adresse='Intro.php?Operation=0';
//header('Location: '.$adresse);
?>