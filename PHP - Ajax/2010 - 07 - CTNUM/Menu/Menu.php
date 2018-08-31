<? error_reporting(E_ALL^E_WARNING);?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script src="fonctions_JS.js" type="text/javascript"></script>   

<link rel="stylesheet" type="text/css" href="présentation2.css">
</link>
<title>CTNUM</title>

</head>

<body>

<?php include('Fonc.php');?>
<?php Opération(); ?>
<?php include("Bannière.php"); ?>
<?php include("Profil.php");?>

<div class="formu">

<?php if(!(@$_POST['submited'])) {

	if(@$_GET['Operation']=='Accueil') {$_SESSION['Operation']='Accueil';
	                                    echo'<h1 class="remarque">'.$_SESSION['Message'].'</h1>';}

	if(@$_GET['Operation']=='Insertion-Ligne_commande') {include('Ins_lig_com3.php');}

	else {
	if(isset($_GET['id']) && @$_GET['Operation']!='Insertion-Ligne_commande') {include('Form_Content.php');}
	   else{
		switch(@$_SESSION['Requ']) {
			case 'Insertion':include('Form_Content.php');break;
			case 'Suppression':include('Consultation.php');break;
			case 'Modification':include('Consultation.php');break;
			case 'Consultation':include('Consultation.php');break;
			default:echo'<h1 class="remarque">'.$_SESSION['Message'].'</h1>';}}}} ?>

<?php if(@$_POST['submited']) {
	if (@$_GET['Operation']=='Insertion-Ligne_commande') {include('Ins_lig_com4.php');}
	else {if ((@$_GET['Operation']=='Modification') && (@$_GET['Table']=='commande')) {include('Ins_lig_com6.php');}
	  else {include("Fab_requete.php");
	      include("Verif_Droit.php");}}}

?>
</div>

<?php include('Choix_C.php');?>


</body>
</html>

