<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<link rel="stylesheet" type="text/css" href="/Comment/presentation.css"></link>	
	<title>Message</title>

	<script language=javascript>
	function verif() {
	if(document.getElementById("email").value == "" ||
		document.getElementById("nom").value == "" ||
		document.getElementById("message").value == "")
			{ alert("Attention - Un des champs obligatoires n'est pas rempli !!! ");
			return false;}
	else
			return true;
	}

	function blinker(id)
	{
  	      elm = document.getElementById(id);
  	      setTimeout(function() {setInterval(function () {elm.style.visibility="visible";},1000);},500);
  	      setInterval(function () {elm.style.visibility="hidden";},1000);
	}

	</script>

</head>
<body>

<div class="mention">
<div class="societes"><span class="societ">► ENVOI D'UN MESSAGE ◄</span></div>
<div class="societe" ><a href="/index.html" title="Retour au CV..." class="sous-societe" > ▼ Retour au CV ▼ </a></div>

<div class="image"><img  alt="image société" src="./Picture/Fleches_G.JPG" /></div>
<div class="image2"><img  alt="image société" src="./Picture/Fleches_D.JPG" /></div>

</div>

<div class="formu">

<?php 
	
	$hosturl='fabien.monnery.sql.free.fr';
	$user='fabien.monnery';
	$password='crocodil';
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("fabien_monnery",$connectID);
	mysql_query("SET NAMES UTF8"); 
	
	$a=$_POST['civilite'];
	$b=$_POST['nom'];
	$c=$_POST['prenom'];
	$d=$_POST['entreprise'];
	$e=$_POST['email'];
	$f=$_POST['telephone'];
	$g=$_POST['message'];
	
	$avertissement=$a." ".$b." ".$c." - Votre message a bien été envoyé !!!";
	$avertissement_b="Une réponse vous sera adressée dans les plus brefs délais...";

	$avertissementw="Attention - Une erreur est survenue - Le message n'a pas été envoyé !!!";
	$avertissement_bw="Veuillez refaire une tentative ultérieurement...";		

	$a="'".addslashes($a)."',";
	$b="'".addslashes($b)."',";
	$c="'".addslashes($c)."',";
	$d="'".addslashes($d)."',";
	$e="'".addslashes($e)."',";
	$f="'".addslashes($f)."',";
	$g="'".addslashes($g)."'";	

	$valeur=$a.$b.$c.$d.$e.$f.$g;
	$sq="SET character_set_client = utf8;";
	$sql="insert into message (civilite,nom,prenom,entreprise,email,telephone,message) values(".$valeur.");";
	$sqls=$sql;
	//print $sqls;

	$mysql_result = mysql_query($sqls,$connectID) or die("Impossible d'insérer les données");
	
	if($mysql_result) 
		{print'<div class="avertissement_1">'.$avertissement.'</br>';
		 print'<p style="text-align:center"><img src="/Comment/Picture/Valide.JPG" /></p></div>';
		 print'</br><div id="cligne" class="avertissement_2">'.$avertissement_b.'<script type="text/javascript">blinker("cligne");</script></div>';}
	   else
		{print'<div class="avertissement_1">'.$avertissementw.'</div></br>';
		 print'<p style="text-align:center"><img src="/Comment/Picture/Faux.JPG" /></p></div>';
		 print'</br><div id="cligne" class="avertissement_2">'.$avertissement_bw.'<script type="text/javascript">blinker("cligne");</script></div>';}

	
?>

</div>

</body>
</html>