<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$colonne=0;

//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

if($_POST['ISBN']!='') {$clause.="isbn like '".$_POST['ISBN']."' ";}

if($_POST['ISBN']=='') 
	{echo 'Veuillez choisir un numéro de ISBN !!!';}

else{
$sq="select count(*) as doublon from livres where ".$clause." ;";

//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$doub=0;

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

$doub=$row['doublon'];}
			}
if($doub>0)  {	echo 'false';
		//echo 'Votre numéro ISBN n\'est pas unique car il existe déjà dans la BDD !!! Recommencez !!!';
		}
	else {	echo 'true';
		//echo 'Votre numéro ISBN est correct - il n\'est pas encore enregistré dans la BDD !!!';
		}

mysql_close($connectID);


?>