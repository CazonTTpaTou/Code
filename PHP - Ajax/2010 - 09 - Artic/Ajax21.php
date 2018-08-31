<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$numero=-1;
//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;
//$op=signe($_POST['Operateur']);

$clause.="num_ligne=".$_POST['num']."; ";

$sq="select commentaire from commentaires where ".$clause." ;";
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();

$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$numero=$row['commentaire'];}

echo $numero;

?>