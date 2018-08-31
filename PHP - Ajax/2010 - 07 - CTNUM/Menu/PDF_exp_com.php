<?php
$datab='';
include("Fonct.php");
$connectID=Connexion();

$exp=$_SESSION['expedition'];

$req1="select co.numero_com as numero,concat(cl.nom,' - ',cl.prenom) as nom,cl.adresse_2 as adresse,";
$req1.="concat(cl.code_postal,' - ',cl.ville) as ville ";
$req1.=" from commande as co inner join clients as cl on co.numero_client=cl.numero ";
$req1.="where co.numero_com in ".$exp;
$req1.=" group by co.numero_com order by co.numero_com asc ;";

//echo $sql;
$file=mysql_query($req1,$connectID) or die("impossible d'accéder aux données");

while($row=mysql_fetch_array($file,MYSQL_ASSOC)) {
	$datab='';
	foreach($row as $key => $value) {$datab.=substr($value,0,19).';';}
	$datab.='\n';
	enregistre('Reassort',$datab."\n");
	}
	
mysql_close($connectID);

include("tuto6.php");

$fp=fopen("Reassort.txt","r+");
ftruncate($fp,0);

$adresse='Intro.php?Operation=0';
//header('Location: '.$adresse);
?>