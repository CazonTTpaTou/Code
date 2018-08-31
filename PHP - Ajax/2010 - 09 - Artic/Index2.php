<?php 
	include("Fonctions.php");
	
      //------- On d�sactive les avertissements qui s'affichent lorsque les identifiants de connexion sont incorrects
      error_reporting(E_ALL^E_WARNING);

     //-------Lorsque le formulaire de connexion a �t� valid�, on effectue les v�rifications
     if ((@$_POST['submitted'])&&(!isset($_GET['inscription']))) {

	//--------Cr�ation d'un tableau qui contiendra chaque erreur de saisie � chaque ligne
	$Erreur_msg=array();

	//--------D�finition du cas d'erreur n�0: le formulaire est vide
	if (EstVide($_POST['Nom'],$_POST['MDP'])==1) {$Erreur_msg[]="Le formulaire est vide !!!";}

	//--------D�finition du cas d'erreur n�1: le nom n'est pas renseign�
	if ($_POST['Nom']=='') {$Erreur_msg[]="Nom d'utilisateur non renseign� !!!";}
	    else {$user=$_POST['Nom'];}

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP']=='') {$Erreur_msg[]="Le mot de passe n'a pas �t� saisi!!!";}
	    else {$password=$_POST['MDP'];}

	//--------D�finition du cas d'erreur n�3: l'identifiant n'existe pas
	if (Verif_pseudo($_POST['Nom'],$_POST['MDP'])==0) {$Erreur_msg[]="Le pseudo n'existe pas - Enregistrez vous !!!";}

	//--------D�finition du cas d'erreur n�4: le mot de passe est incorrect
	if (Verif_pseudo($_POST['Nom'],$_POST['MDP'])==1) {$Erreur_msg[]="Le mot de passe est incorrect - Recommencez !!!";}	

	//--------V�rification que les identifiants rentr�s sont bien d�j� enregistr�s dans la table utilisateurs
	if (!$Erreur_msg) {
		if (Verif_pseudo($_POST['Nom'],$_POST['MDP'])==2) {header('location: Discussion.php');}}
	}

 //-------Lorsque le formulaire de connexion a �t� valid�, on effectue les v�rifications
     if ((@$_POST['submitted2'])&&(isset($_GET['inscription']))) {
		
		if(nouveau(@$_POST['Nom'],@$_POST['MDP'],@$_POST['Ville'])==1) {print'OK';header('location: Discussion.php');}
			else {$Erreur_msg[]="Le pseudo existe d�j� - Entrez un nouveau nom !!!";}
		}	

	 ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

	<link rel="stylesheet" type="text/css" href="Presentation.css" ></link>
	<script src="Func.js" type="text/javascript"></script>  

	<title>Page de connexion</title>

</head>

<body onload='init()'>


<h1 class="title">Bienvenue sur Tellmemore.com</h1>
<div class="encadrons">

<?php
if(!isset($_GET['inscription']))

{print'<h2 class="subtitle">Veuillez rentrer vos identifiants de connexion</h2>';

print'<div class="menus1">';
print '<form id="auto_off" action ="'.$_SERVER['PHP_SELF'].'" method = "POST">';
	print'<span class="label">';
	print'<label for="Pseudo" >Nom Utilisateur:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input id ="c3" name="Nom" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';
	print'<span class="label">';
	print'<label for="M" >Mot de Passe:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input type="password" name="MDP" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';
	print'<span class="button">';
	print'<input type="submit" name="submitted" value="Valider">';
	print'</span>';
print'</form>';
print'</div>';}

else {

print'<h2 class="subtitle">Veuillez remplir le formulaire d\'inscription</h2>';

print'<div class="menus1">';
print'<form onsubmit="return verif(this);" action ="'.$_SERVER['PHP_SELF'].'?inscription=1" method = "POST">';
print'<span class="label">';
	print'<label for="Nom" >Votre pseudo:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input id ="c1" name="Nom" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';

	print'<span class="label">';
	print'<label for="M" >Votre mot de Passe:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input type="password" name="MDP" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';

	print'<span class="label">';
	print'<label for="M2" >Confirmez le mot de passe:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input type="password" name="MDP2" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';

print'<label for="Nom" >Votre ville:</label>';
	print'</span>';
	print'<span class="formw">';
	print'<input id ="c2" name="Ville" value="" size=20 type="text">';
	print'</span>';
	print'<br/><br/>';

	print'<span class="button">';
	print'<input type="submit" name="submitted2" value="Valider">';
	print'</span>';
print'</form>';
print'</div>';}
?>

<div class="nouveau">
<span class="nouveau1">Nouvel utilisateur</span>
<br/>
<span class="nouveau2">--      Veuillez cliquer sur l'image     --</span>
</div>


<?php print '<a href="'.$_SERVER['PHP_SELF'].'?inscription=1">'?>
<div class="image-accueil">
<img  alt="image accueil" src="image5.bmp">
</div>
</a>


<?php 

	//-------Si le tableau des messages d'erreur n'est pas vide, c'est qu'il y a un probl�me
	if (isset($Erreur_msg) && ($Erreur_msg)) {
	
		//-------Impression �cran des diff�rents message d'erreur sous forme de liste � puce
		if(isset($_GET['inscription'])) {print'<div class="ereur">';}
			else{print'<div class="erreur">';}
		echo '<ul>'; 
		  foreach ($Erreur_msg as $err) { 
	 	  echo "<li>".$err."</li>\n";
		  }
		echo "</ul>\n"; 
		echo '</div>';
  
	} ?>
</div>

<marquee scrollamount=5 class="filet">
En cas de perte de vos identifiants, veuillez contacter l'administrateur � l'adresse e-mail suivante: Webmaster@tellmemore.fr
</marquee>

</body>

</html>

