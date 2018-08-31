<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script src="fonctions_JS.js" type="text/javascript"></script>   

<link rel="stylesheet" type="text/css" href="presentation.css">
</link>
<title>Essai</title>

</head>

<body>

<?php include("Operation.php"); ?>
<?php include("Bannière.php"); ?>
<?php include("Profil.php"); ?>
<?php include("Choix.php"); ?>

<div class="formu">

<?php if(!(@$_POST['submited'])) {

	if(@$_GET['Operation']=='Accueil') {$_SESSION['Operation']='Accueil';
	                                    echo'<h1 class="remarque">'.$_SESSION['Message'].'</h1>';}
	if(isset($_GET['id'])) {include('Form_Content.php');}
	   else{
		switch(@$_SESSION['Requ']) {
			case 'Insertion':include('Form_Content.php');break;
			case 'Suppression':include('Consultation.php');break;
			case 'Modification':include('Consultation.php');break;
			case 'Consultation':include('Consultation.php');break;
			case 'Statistiques':include('Consultation.php');break;
			default:echo'<h1 class="remarque">'.$_SESSION['Message'].'</h1>';}}} ?>

<?php if(@$_POST['submited']) {include("Fab_requete.php");
			       include("Verif_Droit.php");}?>

</body>
</html>