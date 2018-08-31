<?php
//$req="select li.numero,sum(lr.quantite) as reassort,(li.stock+reassort) as real_stock from livres as li inner join ligne_reassortiment as lr on li.numero=lr.numero_livre inner join reassortiment as rea on rea.numero=lr.numero_com where rea.etat<2 ans real_stock<0 ;",

$req0="select li.numero,li.stock,sum(lr.quantite) as reassort,(li.stock+sum(lr.quantite)) as real_stock from livres as li inner join ligne_reassortiment as lr on li.numero=lr.numero_livre inner join reassortiment as rea on rea.numero=lr.numero_com where rea.etat<2 and rea.fournisseur=".$_GET['Fournisseur']." group by li.numero having real_stock <0 ";
$req1="union select  li.numero,li.stock,0,li.stock as real_stock from livres as li,four_edit as fo where li.numero not in (select numero_livre from ligne_reassortiment) and li.stock<0 and fo.num_four=".$_GET['Fournisseur']." and fo.nom_edit=li.editeur order by real_stock;";
$req=$req0.$req1;
//echo $req;

$success=mysql_query($req,$connectID) or die ("impossible d'accéder aux données9");

$connectID=Connexion();

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$rea=(-1)*$row['real_stock'];
	$req="insert into ligne_reassortiment (numero_com,numero_livre,quantite) values (";
	$req.=$_GET['Reassortiment'].",".$row['numero'].",".$rea.");";
	//echo $req;
	mysql_query($req,$connectID) or die("Impossible d'accéder aux données");}
	
mysql_close($connectID);

$adresse='Intro.php?Operation=37';
header('Location: '.$adresse);

?>