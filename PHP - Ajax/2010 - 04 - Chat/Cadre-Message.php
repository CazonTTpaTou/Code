<?php include('Fonctions-c.php');?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

	<link rel="stylesheet" type="text/css" href="Presentation.css" ></link>
	<script src="Func.js" type="text/javascript"></script>  

	<title>Page de connexion</title>

</head>

<body>

<?php

//session_start();

echo'<div class="mention1">';

//----- Affichage du nom de l'utilisateur
echo'<span class="profil-title">Pseudo de l\'utilisateur: </span>';
echo'<span class="profil-answer">'.@$_SESSION['pseudo'].'</span>';
echo'<br/>';

//----- Affichage de la ville de l'utilisateur 
echo'<span class="profil-title">Ville de l\'utilisateur: </span>';
echo'<span class="profil-answer">'.@$_SESSION['ville'].'</span>';
echo'<br/>';


//----- Affichage du nombre de messages
echo'<span class="profil-title">Nombre de messages postés: </span>';
echo'<span class="profil-answer">'.@$_SESSION['nb_mess'].'</span>';
echo'<br/>';

//----- Affichage d'un lien de déconnexion qui renvoie à la page d'accueil d'identification
echo'<a href="Index.php" target="Cadres.php" class="dex" onclick="quit(this);top.close();" >Déconnexion</a>';

echo'</div>';

//---- Nouvelle section logique de mise en page: L'envoi du message
echo'<div class="choix1">';
echo'<form id="msg"  action ="Cadre-Discussion.php" method = "POST" target="chat" >';
echo'<label class="menu" >Votre message :</label>';

//----- On adapte la taille de la balise TextArea à la nature du navigateur utilisé
echo'<br/>';
if (navig()=='Internet Explorer') {echo'<textarea name="Message" rows=12 COLS=39 class="menub"></textarea>';}
	                     else {echo'<textarea name="Message" rows=11 COLS=50 class="menub"></textarea>';}

echo'<br/>';
print'<br/>';

//----- Edition des deux boutons du formulaire
echo'<input type="submit" name="messager" value="Envoyer" class="menuc" >';
echo'<input type="reset" name="effacer" value="Effacer" class="menud" >';
echo'</form>';
echo'</div>';

?>

</body>
</html>



