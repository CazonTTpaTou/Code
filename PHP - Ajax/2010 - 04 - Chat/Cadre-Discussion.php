<?php include("Fonctions-c.php");?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Refresh" content="10" />

	<link rel="stylesheet" type="text/css" href="Presentation.css" ></link>
	<script src="Func.js" type="text/javascript"></script>  

	<title>Page de connexion</title>

</head>

<body onload="";>

<?php echo'<div class="mentionc">';

//-----Affichage de la banni�re de la section d'affichage du chat avec les 10 derniers messages post�s par les utilisateurs

echo'<span class="societe">TellMeMore.com</span>';
echo'<span class="sous-societe">Le Chat qui vous rendra f�lin !!!</span>';

echo'<span class="image">';
echo'<img  alt="image soci�t�" src="n78fs9qa.gif" />';
echo'</span>';
echo'</div>';
?>

<?php 

//------- Si le message est envoy� par une m�thode http de type POST, c'est qu'il s'agit d'un nouveau message 
//------- par la biais du formulaire de la page par l'utilisateur du chat.
//-------- On appelle donc la fonction inser_mess pour ins�rer le nouveau message dans la table messages. 

if(@$_POST['messager']) {inser_mess(@$_POST['Message']);} 

//------- Si le message est envoy� par une m�thode http de type GET, c'est qu'il s'agit d'un nouveau message
//------- post� par un autre utilisateur du chat, logg� sur une autre session ou une autre machine.
//------- Dans ce cas, on appelle la fonction the_last_ten qui extraie les 10 derniers messages enregistr�s
//------- dans la table messages, sans ins�rer de nouveau message...

if ($_SERVER['REQUEST_METHOD']=='GET') {the_last_ten();}


?>

</body>
</html>

