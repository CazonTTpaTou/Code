<?php

//session_start();
echo'<div class="mention1">';

//----- Affichage de l'op�ration en cours choisie par l'utilisateur
echo'<span class="profil-title">'.substr($_SESSION['Operation'],0,21).'</span>';
echo'<br/>';

//----- Affichage du nom de l'utilisateur
echo'<span class="profil-title">Utilisateur: </span>';
echo'<span class="profil-answer">'.$_SESSION['Utilisateur'].'</span>';
echo'<br/>';

//echo'<span class="profil-title">Poste: </span>';
//echo'<span class="profil-answer">'.$_SESSION['Poste'].'</span>';
//echo'<br/>';

//----- Affichage de la fonction de l'utilisateur (qui d�termine ses droits et donc son menu)
echo'<span class="profil-title">Fonction: </span>';
echo'<span class="profil-answer">'.$_SESSION['Droits'].'</span>';
echo'<br/>';

//----- Affichage d'un lien de d�connexion qui renvoie � la page d'accueil d'identification
echo'<a href="../Index1.php" class="dex" >D�connexion</a>';

echo'</div>';
?>