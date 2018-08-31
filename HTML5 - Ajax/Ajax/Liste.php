<?php

if(isset($_POST['tri'])) {header('Content-type: text/html; charset=iso-8859-1');
			  $order=$_POST['tri'];
			  }

	else {$order='ordre';
	      $Code[]='</br>';
	      $Code[]='</br>';
	      $Code[]='</br>';	
	      $Code[]='<div id="tab" class="tableaux">';      
	      }

$intitule['numero']="Numéro";
$intitule['libelle']="Libellé de l'expérience professionnelle";
$intitule['code']="Code";
$intitule['ordre']="Détail ";

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

$req="select numero,libelle,code from experiences order by ".$order." asc ;";
//echo $req;
$success=mysql_query($req,$connectID) or die ("impossible d'accéder aux données9");

mysql_close($connectID);
$ligne=0;
$last="";

$Code[]='</br>';
$Code[]='<table id="tableau" border=1px  cellpadding=2px class="messages_paragraphe" >';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';$img='OK_I.JPG';}
	else {$couleur=' class="fond2" ';$img='OK.JPG';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($intitule as $key => $value) 
			{$Code[]='<td id="'.$key.'" class="entete" onclick="tri(this.id)" >'.$value.'</td>';}
	       }
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $key => $value) {
		if($colonne==0) {$identifiant=$value;}
		$Code[]='<td'.$couleur.' >'.stripslashes($value).'</td>';
		++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.' onclick="message('.$identifiant.');"><img src="'.$img.'" ></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
if(!isset($_POST['tri'])) {$Code[]='</div>';}

$s='';

if ($ligne==0) {$Code[]='Aucune donnée ne correspond à votre recherche...';}
	
foreach($Code as $value) {echo $value;}


?>