<?php
$datab='';
include("Fonct.php");
$connectID=Connexion();

$exp=$_SESSION['expedition'];

$req1="select li.isbn,li.titre,li.editeur,sum(lig.quantite) as quantite ";
$req1.=" from commande as co inner join ligne_commande as lig on co.numero_com=lig.numero_com ";
$req1.="inner join livres as li on lig.numero_livre=li.numero inner join prix as price on li.numero=price.id_livre ";
$req1.="where co.numero_com in ".$exp." ";
$req1.="group by li.numero order by li.numero asc ;";

//echo $sql;
$file=mysql_query($req1,$connectID) or die("impossible d'accéder aux données");

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