<?php

//----- Premier d�marrage de la session pour l'utilisateur
//session_start();

//----- A partir de l'URL de la page charg�e, on initialise la variable de session de la requ�te choisie par l'utilisateur
if(isset($_GET['Operation'])) {$_SESSION['Operation']=$_GET['Operation'];}


?>