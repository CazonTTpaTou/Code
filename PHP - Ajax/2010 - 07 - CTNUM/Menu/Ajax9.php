<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$colonne=0;

//session_start();

include("Fonct.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;

if($_POST['ISBN']!='') {$clause.="isbn like '".$_POST['ISBN']."' ";}

if($_POST['ISBN']=='') 
	{echo 'Veuillez choisir un num�ro de ISBN !!!';}

else{
$sq="select count(*) as doublon from livres where ".$clause." ;";

//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");

$doub=0;

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

$doub=$row['doublon'];}
			}
if($doub>0)  {	echo 'false';
		//echo 'Votre num�ro ISBN n\'est pas unique car il existe d�j� dans la BDD !!! Recommencez !!!';
		}
	else {	echo 'true';
		//echo 'Votre num�ro ISBN est correct - il n\'est pas encore enregistr� dans la BDD !!!';
		}

mysql_close($connectID);


?>