<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$colonne=0;

//session_start();

include("Fonct.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;

if($_POST['Client']!='') {$clause.="and numero_com=".$_POST['Client'];
			  $_SESSION['URL']='&Commande='.$_POST['Client'];}

if($_POST['Client']=='') 
	{echo 'Veuillez choisir un num�ro de commande !!!';}

else{
$sq="select * from commande where numero_com>0 ".$clause." ;";

//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");
mysql_close($connectID);

$Code[]='Aper�u du num�ro de commande s�lectionn� : ';

$Code[]='<ol>';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

foreach($row as $key => $value) {$colonne++;
			         $Code[]='<a href="Intro.php?Operation=66'.$_SESSION['URL'].'" ><li>'.$key.' : '.$value.'</li></a>';
				 }
$Code[]='</ol>';
			}
foreach($Code as $value) {echo $value;}
}

if(!($colonne)) {print 'Le num�ro rentr� est incorrect - Recommencez SVP !!! ';}




?>