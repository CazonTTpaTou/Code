<?php

//----- Connexion � la BDD C216_Devoir � partir des identifiants enregistr�s dans les variables de session utilisateur

$user=@$_SESSION['Utilisateur'];  
$hosturl=@$_SESSION['Poste'];
$password=@$_SESSION['Passe'];

$id ='"%'.$user.'%"';

$connectID = mysql_connect($hosturl, $user, $password) or die("Connexion impossible !!!");
mysql_select_db("CTNUM",$connectID);

?>

