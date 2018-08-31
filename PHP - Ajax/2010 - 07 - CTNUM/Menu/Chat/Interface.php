<?php echo'<div class="mention" >';

//-----Affichage de la bannière de la page principal avec titre, mention, logo de l'entreprise

echo'<span class="societe">TellMeMore.com</span>';
echo'<span class="sous-societe">Le Chat qui vous rendra félin !!!</span>';
echo'<br/>';

echo'<span class="image">';
echo'<img  alt="image société" src="n78fs9qa.gif" />';
echo'</span>';
echo'</div>';
?>

<?php

//session_start();
echo'<div class="mention1">';

//----- Affichage du nom de l'utilisateur
echo'<span class="profil-title">Pseudo de l\'utilisateur: </span>';
echo'<span class="profil-answer">'.@$_SESSION['pseudo'].'</span>';
echo'<br/>';

//----- Affichage de l'heure du dernier message affiché
echo'<span class="profil-title">Heure dernier message: </span>';
echo'<span id="heure" class="profil-answer"> - </span>';
echo'<br/>';


//----- Affichage du nombre total de messages postés 
echo'<span class="profil-title">Nombre messages envoyés: </span>';
echo'<span id="compteur" class="profil-answer">0</span>';
echo'<br/>';

//----- Affichage d'un lien de déconnexion qui renvoie à la page d'accueil d'identification
echo'<a href="Index.php" class="dex" onclick="quit();" >Déconnexion</a>';

echo'</div>';

//---- Nouvelle section logique de mise en page: Le formulaire d'envoi du message
echo'<div class="choix1">';
echo'<form onsubmit="requete(\'false\');combiens();return false;" id="msg" action ="'.$_SERVER['PHP_SELF'].'" method = "POST">';
echo'<label class="menu" >Votre message :</label>';

echo'<br/>';
	//------------- dimensionne la balise Textarea en fonction du navigateur
	if (navig()=='Firefox') {echo'<textarea id="Messenger" name="Message" rows=11 COLS=50 class="menub"></textarea>';}
	if (navig()=='Internet Explorer') {echo'<textarea id="Messenger" name="Message"  rows=12 COLS=39 class="menub"></textarea>';}
		echo'<br/>';
	print'<br/>';
	echo'<input type="submit" name="messager" value="Envoyer" class="menuc" >';
	echo'<input type="reset" name="effacer" value="Effacer" class="menud" >';
	echo'</form>';
echo'</div>';
?>