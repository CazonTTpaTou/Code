<?php

//----- Premier d�marrage de la session pour l'utilisateur
session_start();

//----- A partir de l'URL de la page charg�e, on initialise la variable de session de la requ�te choisie par l'utilisateur
if(isset($_GET['Operation'])) {$_SESSION['Requ']=$_GET['Operation'];}

//----- A partir de l'URL de la page charg�e, on initialise la variable de session de la table choisie par l'utilisateur
if(isset($_GET['Table'])) {$_SESSION['Tab']=$_GET['Table'];}

//----- Si la variable Table n'est pas d�fini dans l'URL, on initialise la variable de session de la table au vide
if(!(isset($_GET['Table']))) {$_SESSION['Tab']='';}

//----- On d�termine la variable de session Op�ration qui s'affichera dans le profil Utilisateur
if(isset($_GET['Operation']) && isset($_GET['Table'])) {$_SESSION['Operation']=$_SESSION['Requ']." - ".$_SESSION['Tab'];} 
	else{$_SESSION['Operation']=$_SESSION['Requ'];}

?>


