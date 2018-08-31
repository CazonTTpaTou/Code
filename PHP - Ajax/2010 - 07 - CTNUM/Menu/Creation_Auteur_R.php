<?php

$connectID=Connexion();

if(addslashes($_POST['date_n'])=='facultatif') {$date_n="''";}
	else {$date_n="'".trim($_POST['date_n'])."'";}
if(addslashes($_POST['date_d'])=='facultatif') {$date_d="''";}
	else {$date_d="'".trim($_POST['date_d'])."'";}
if(addslashes($_POST['biographie'])=='facultatif') {$biographie="''";}
	else {$biographie="'".trim(addslashes($_POST['biographie']))."'";}
if(addslashes($_POST['image'])=='facultatif') {$image="''";}
	else {$image="'".trim(addslashes($_POST['image']))."'";}


$a="'".trim(addslashes($_POST['Prenom']))."',";
$a.="'".trim(addslashes($_POST['Nom']))."',";
$a.="'".trim(addslashes($_POST['Prenom']))." - ".trim(addslashes($_POST['Nom']))."',";
$a.=$date_n.",";
$a.=$date_d.",";
$a.=$biographie.",";
$a.=$image.")";

$req="insert into auteurs (prenom,nom,auteur,naissance,mort,biographie,photo) values (".$a." ;";

echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
mysql_close($connectID);

if($success) {
	      $_SESSION['Message']='La fiche Auteur '.trim($_POST['Prenom']).' - '.trim($_POST['Nom']).' a été créée !!!';
	      $adresse=$_SESSION['Adresse'];
	      header('Location:'.$adresse);
		}

	else {$_SESSION['Message']='Echec - La fiche Auteur n\' a pas été créée !!!';
	      header('Location:Intro.php?Operation=0');}

?>

