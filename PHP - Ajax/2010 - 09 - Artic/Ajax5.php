<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

if($_POST['Client']!='') {$clause.="and numero=".$_POST['Client'];}

if($_POST['Client']=='') 
	{echo 'Veuillez choisir un numéro client !!!';}

else{
$sq="select qualite,nom,prenom,adresse_2,code_postal,ville from clients where numero>0 ".$clause." ;";

//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$colonne=0;
print 'Référence Client sélectionné : ';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

foreach($row as $value) {$colonne++;
		         print $value;
			 print ' - ';}
			}

if(!($colonne)) {print 'Le numéro rentré est incorrect - Recommencez SVP !!! ';}}

?>