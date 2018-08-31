<?php

//session_start();
echo'<div class="mention1">';

//----- Affichage de l'opération en cours choisie par l'utilisateur
echo'<span class="profil-title">'.$_SESSION['Operation'].'</span>';
echo'<br/>';
echo'<br/>';

//----- Affichage du nom de l'utilisateur
echo'<span class="profil-title">Utilisateur: </span>';
echo'<span class="profil-answer">'.$_SESSION['Utilisateur'].'</span>';
echo'<br/>';

//echo'<span class="profil-title">Poste: </span>';
//echo'<span class="profil-answer">'.$_SESSION['Poste'].'</span>';
//echo'<br/>';

//----- Affichage de la fonction de l'utilisateur (qui détermine ses droits et donc son menu)
echo'<span class="profil-title">Fonction: </span>';
echo'<span class="profil-answer">'.$_SESSION['Droits'].'</span>';
echo'<br/>';
echo'<br/>';

//----- Affichage d'un lien de déconnexion qui renvoie à la page d'accueil d'identification
echo'<a href="Index.php" class="dex" >Déconnexion</a>';

echo'</div>';
?>



