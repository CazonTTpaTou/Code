<?php

//----- Connexion à la BDD C216_Devoir à partir des identifiants enregistrés dans les variables de session utilisateur

$user=@$_SESSION['Utilisateur'];  
$hosturl=@$_SESSION['Poste'];
$password=@$_SESSION['Passe'];

$id ='"%'.$user.'%"';

$connectID = mysql_connect($hosturl, $user, $password) or die("Connexion impossible !!!");
mysql_select_db("CTNUM",$connectID);

?>

