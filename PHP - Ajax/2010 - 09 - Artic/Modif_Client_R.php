<?php
$connectID=Connexion();
$date=date("Y-m-j");

if($_POST['telephone']=='facultatif') {$b='';}
	else {$b=$_POST['telephone'];}

if($_POST['e_mail']=='facultatif') {$c='';}
	else {$c=$_POST['e_mail'];}

$a="qualite='".trim(addslashes($_POST['Qualite']))."',";
$a.="nom='".trim(addslashes($_POST['Nom']))."',";
$a.="prenom='".trim(addslashes($_POST['Prenom']))."',";
$a.="adresse_1='".trim(addslashes($_POST['Ad_comp']))."',";
$a.="adresse_2='".trim(addslashes($_POST['ad_princ']))."',";
$a.="code_postal='".trim($_POST['Code_Postal'])."',";
$a.="ville='".trim(addslashes($_POST['Ville']))."',";
$a.="npai='".$_POST['etat']."',";
$a.="date_etat='".$date."',";
$a.="telephone='".trim(addslashes($b))."',";
$a.="e_mail='".trim(addslashes($c))."'";

$req="UPDATE clients SET ".$a." WHERE numero=".$_GET['Client']." ;";

echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
mysql_close($connectID);

if($success) {
	      $_SESSION['Message']='La fiche client N° '.$_GET['Client'].' a été modifiée !!!';
	      
	      header('Location:Intro.php?Operation=66&Client='.$_GET['Client']);}

	else {$_SESSION['Message']='Echec - La fiche client n° '.$_GET['Client'].'n\'a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');}

?>




