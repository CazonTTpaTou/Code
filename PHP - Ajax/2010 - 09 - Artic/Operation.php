<?php

//----- Premier démarrage de la session pour l'utilisateur
//session_start();

//----- A partir de l'URL de la page chargée, on initialise la variable de session de la requête choisie par l'utilisateur
if(isset($_GET['Operation'])) {$_SESSION['Operation']=$_GET['Operation'];}


?>