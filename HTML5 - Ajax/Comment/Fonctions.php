<?php


//------------ Fonction qui permet de connecter l'utilisateur g�n�rique chat � la BDD C216_devoir3

function Connexion() {
	$hosturl='localhost';
	$user='root';
	$password='';
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("CV_Site",$connectID);
	return $connectID;}

//------------ Fonction qui ins�re une nouvelle ligne dans la table Utilisateurs


function inser_mess() {
	
	$a=$_POST['civilite'];
	$b=$_POST['nom'];
	$c=$_POST['prenom'];
	$d=$_POST['entreprise'];
	$e=$_POST['email'];
	$f=$_POST['telephone'];
	$g=$_POST['message'];

	$avertissement="Le message de ".$a." ".$b." ".$c." a bien �t� enregistr� et envoy� au destinataire !!!";
	$avertissement_b="Une r�ponse vous sera adress�e dans les plus brefs d�lais...";

	$avertissementw="Attention - Une erreur est survenue - Le message n'a pas �t� envoy� !!!";
	$avertissement_bw="Veuillez refaire une tentative ult�rieurement...";		

	$a="'".addslashes($a)."',";
	$b="'".addslashes($b)."',";
	$c="'".addslashes($c)."',";
	$d="'".addslashes($d)."',";
	$e="'".addslashes($e)."',";
	$f="'".addslashes($f)."',";
	$g="'".addslashes($g)."',";

	$valeur=$a.$b.$c.$d.$e.$f.$g;

	$connectID=Connexion();
	$sql="insert into message (civilite,nom,prenom,entreprise,email,telephone,message) values(".$valeur.");";
	print $sql;
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'ins�rer les donn�es");
	
	if($mysql_result) {print'<print'<div class="avertissement_1">'.$avertissement.'</div></br><div class="avertissement_2">'.$avertissement_b.'</div>';}
	else{print'<print'<div class="avertissement_1">'.$avertissementw.'</div></br><div class="avertissement_2">'.$avertissement_bw.'</div>';}

	}

?>