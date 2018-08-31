<?php 

session_start();

//------------ Fonction qui permet de connecter l'utilisateur � la BDD CTNUM

function Connexion() {
	$hosturl='localhost';
	$user=$_SESSION['Utilisateur'];
	$password=$_SESSION['Passe'];
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("difedit_com_livres",$connectID);
	return $connectID;}

      //------- On d�sactive les avertissements qui s'affichent lorsque les identifiants de connexion sont incorrects
      error_reporting(E_ALL^E_WARNING);

	//include('Fonc.php');

     //-------Lorsque le formulaire de connexion a �t� valid�, on effectue les v�rifications
     if (@$_POST['submitted']) {

	//--------Cr�ation d'un tableau qui contiendra chaque erreur de saisie � chaque ligne
	$Erreur_msg=array();

	//--------D�finition du cas d'erreur n�1: le nom n'est pas renseign�
	if ($_POST['Nom']=='') {$Erreur_msg[]="Nom d'utilisateur non renseign� !!!";}
	    else {$user=$_POST['Nom'];}

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP']=='') {$Erreur_msg[]="Le mot de passe n'a pas �t� saisi!!!";}
	    else {$password=$_POST['MDP'];}

	//--------Variable qui contient le nom de la machine � partir de laquelle l'utilisateur se connecte
	//--------Cette variable est d�finie par d�faut � localhost, mais dans la pratique, elle serait initialis�e
	//--------avec la valeur de l'adresse IP de la machine �tablissant une connexion avec l'interface
	$hosturl='hostingmysql139';
	$Operating="Accueil";

	//--------V�rification que les identifiants rentr�s permettent bien une connexion � Mysql
	if (!$Erreur_msg) {$connectID = mysql_connect($hosturl, $user, $password);}

	//--------Si la connexion est impossible, ajout d'un message d'erreur au tableau Erreur_msg
	if ((!isset($connectID)) || (!$connectID)) {$Erreur_msg[]="Identifiant ou mot de passe incorrect!!!";}

	//--------Si la connexion a pu �tre �tablie, initialisation des variables de session avec les identifiants de l'utilisateur
	if ((isset($connectID)) && ($connectID)) {
					         $_SESSION['Utilisateur'] = $_POST["Nom"];
						 $_SESSION['Passe'] = $_POST["MDP"];
	                                         $_SESSION['Poste'] = $hosturl;
					         $_SESSION['Operation']=$Operating;
					         $_SESSION['Message']='Choisissez une op�ration SVP';

						 //Droits();
						 //echo 'Droits:'.$_SESSION['Nb_droits'];
						 //Renvoi vers la page principale de l'application
						 header('location: Intro.php?Operation=0');
						}
	} ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

	<link rel="stylesheet" type="text/css" href="Presentation1.css" ></link>

	<title>Page de connexion</title>

</head>

<body>


<h1 class="title">DROITE LIGNE MAGAZINE</h1>
<div class="encadrons">
<h2 class="subtitle">Veuillez rentrer vos identifiants de connexion</h2>

<div class="menus1">
<form action ="<?php $_SERVER['PHP_SELF'] ?>" method = "POST">
	<span class="label">
	<label for="Nom" >Nom Utilisateur:</label>
	</span>
	<span class="formw">
	<input name="Nom" value="" size=20 type="text">
	</span>
	<br/><br/>
	<span class="label">
	<label for="M" >Mot de Passe:</label>
	</span>
	<span class="formw">
	<input type="password" name="MDP" value="" size=20 type="text">
	</span>
	<br/><br/>
	<span class="button">
	<input type="submit" name="submitted" value="Valider">
	</span>
</form>
</div>
</div>

<div class="image-accueil">
<img  alt="image accueil" src="abc.jpg" />
</div>

<?php 

	//-------Si le tableau des messages d'erreur n'est pas vide, c'est qu'il y a un probl�me
	if (isset($Erreur_msg) && ($Erreur_msg)) {
	
		//-------Impression �cran des diff�rents message d'erreur sous forme de liste � puce
		print'<div class="erreur">';
		echo '<ul>'; 
		  foreach ($Erreur_msg as $err) { 
	 	  echo "<li>".$err."</li>\n";
		  }
		echo "</ul>\n"; 
		echo '</div>';
  
	} ?>

<marquee scrollamount=5 class="filet">
En cas de perte de vos identifiants, veuillez contacter l'administrateur du site...
</marquee>

</body>

</html>

