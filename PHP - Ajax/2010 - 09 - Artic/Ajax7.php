<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$colonne=0;

//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

if($_POST['Client']!='') {$clause.="and numero_com=".$_POST['Client'];
			  $_SESSION['URL']='&Commande='.$_POST['Client'];}

if($_POST['Client']=='') 
	{echo 'Veuillez choisir un numéro de commande !!!';}

else{
$sq="select * from commande where numero_com>0 ".$clause." ;";

//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");
mysql_close($connectID);

$Code[]='Aperçu du numéro de commande sélectionné : ';

$Code[]='<ol>';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

foreach($row as $key => $value) {$colonne++;
			         $Code[]='<a href="Intro.php?Operation=66'.$_SESSION['URL'].'" ><li>'.$key.' : '.$value.'</li></a>';
				 }
$Code[]='</ol>';
			}
foreach($Code as $value) {echo $value;}
}

if(!($colonne)) {print 'Le numéro rentré est incorrect - Recommencez SVP !!! ';}




?>