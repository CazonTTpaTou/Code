<?php

$intitule[0]="N�";
$intitule[1]="Date";
$intitule[2]="Civilit�";
$intitule[3]="Nom du contact";
$intitule[4]="Pr�nom";
$intitule[5]="Entreprise";
$intitule[6]="E-mail";
$intitule[7]="T�l�phone";
$intitule[8]="-";

print '<br/>';
print '<br/>';

	$hosturl='fabien.monnery.sql.free.fr';
	$user='fabien.monnery';
	$password='crocodil';
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("fabien_monnery",$connectID);
	//mysql_query("SET NAMES UTF8"); 
	

	//$hosturl='localhost';
	//$user='root';
	//$password='';
	//$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	//mysql_select_db("cv_site",$connectID);
	//mysql_query("SET NAMES UTF8"); 

$req="select numero,date,civilite,nom,prenom,entreprise,email,telephone from message order by date desc ;";
//echo $req;
$success=mysql_query($req,$connectID) or die ("impossible d'acc�der aux donn�es9");

mysql_close($connectID);
$ligne=0;
$last="";

$Code[]='</br>';
$Code[]='<div class="tableaux">';
$Code[]='</br>';
$Code[]='<table id="tableau" border=1px  cellpadding=2px class="messages_paragraphe" >';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';$img='OK_I.JPG';}
	else {$couleur=' class="fond2" ';$img='OK.JPG';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($intitule as $value) {$Code[]='<td id="'.$value.'" class="entete">'.$value.'</td>';}
	       }
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
	foreach($row as $value) {
		if($colonne==0) {$identifiant=$value;}
		if($colonne==1) {$newDate = date("d-m-Y",strtotime($value));$value=$newDate;}
		if($value=='') {$value=" - ";}
		$Code[]='<td'.$couleur.'>'.stripslashes($value).'</td>';
		++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.' onclick="message('.$identifiant.');"><img src="'.$img.'" ></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table></div>';
$Code[]='<div id="message" class="messages"></div>';

$s='';

if ($ligne==0) {$Code[]='Aucune donn�e ne correspond � votre recherche...';}
	
foreach($Code as $value) {echo $value;}


?>