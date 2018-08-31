<?php

$connectID=Connexion();

if($_POST['date_n']=='facultatif') {$date_n="''";}
	else {$date_n="'".trim(addslashes($_POST['date_n']))."'";}
if($_POST['date_d']=='facultatif') {$date_d="''";}
	else {$date_d="'".trim(addslashes($_POST['date_d']))."'";}
if($_POST['biographie']=='facultatif') {$biographie="''";}
	else {$biographie="'".trim(addslashes($_POST['biographie']))."'";}
if($_POST['image']=='facultatif') {$image="''";}
	else {$image="'".trim(addslashes($_POST['image']))."'";}


$a="prenom='".trim(addslashes($_POST['Prenom']))."',";
$a.="nom='".trim(addslashes($_POST['Nom']))."',";
$a.="auteur='".trim(addslashes($_POST['Prenom']))." - ".trim(addslashes($_POST['Nom']))."',";
$a.="naissance=".$date_n.",";
$a.="mort=".$date_d.",";
$a.="biographie=".$biographie.",";
$a.="photo=".$image."";

$req="update auteurs set ".$a." where id_auteur=".$_GET['Auteur']." ;";

echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
mysql_close($connectID);

if($success) {
	      $_SESSION['Message']='La fiche Auteur '.trim($_POST['Prenom']).' - '.trim($_POST['Nom']).' a été modifiée !!!';
	      $adresse=$_SESSION['Adresse'];
	      header('Location:'.$adresse);
		}

	else {$_SESSION['Message']='Echec - La fiche Auteur n\' a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');}

?>

