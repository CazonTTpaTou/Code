<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;

if($_POST['Client']!='') {$clause.="and numero=".$_POST['Client'];}

if($_POST['Client']=='') 
	{echo 'Veuillez choisir un num�ro client !!!';}

else{
$sq="select qualite,nom,prenom,adresse_2,code_postal,ville from clients where numero>0 ".$clause." ;";

//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");

$colonne=0;
print 'R�f�rence Client s�lectionn� : ';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

foreach($row as $value) {$colonne++;
		         print $value;
			 print ' - ';}
			}

if(!($colonne)) {print 'Le num�ro rentr� est incorrect - Recommencez SVP !!! ';}}

?>