<?php
$datab='';
include("Fonct.php");
$connectID=Connexion();

$exp=$_SESSION['Livre_manquant'];

$sql="select li.isbn as isbn,li.titre as titre,li.editeur as editeur,sum(st.manq) as quantite ";
$sql.="from livres as li inner join stock_manquant as st on li.numero=st.prod ";
$sql.="where li.numero in (".$exp.") ";
$sql.="group by li.numero order by li.numero asc;";

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