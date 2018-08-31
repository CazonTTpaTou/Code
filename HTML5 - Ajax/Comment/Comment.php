<?php 
	$c=$_SERVER['HTTP_USER_AGENT'];

	if(preg_match('/MSIE/i',$c)) {$flag=1;}
	if(preg_match('/Firefox/i',$c)) {$flag=2;}
	if(preg_match('/Chrome/i',$c)) {$flag=3;}

switch($flag) {
		case '1':print'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';break;
		default:break;}
	
?>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<link rel="stylesheet" type="text/css" href="/Comment/presentation.css"></link>	
	<title>Message</title>

	<script language=javascript>
	function verif() {
	if(document.getElementById("email").value == "" ||
		document.getElementById("nom").value == "" ||
		document.getElementById("message").value == "")
			{ alert("Attention - Un des champs obligatoires n'est pas rempli !!! ");
			return false;}
	else
			return true;
	}

	function blinker(id)
	{
  	      elm = document.getElementById(id);
  	      setTimeout(function() {setInterval(function () {elm.style.visibility="visible";},1000);},500);
  	      setInterval(function () {elm.style.visibility="hidden";},1000);
	}

	</script>

</head>
<body>

<div class="mention">
<div class="societes"><span class="societ">► ENVOI D'UN MESSAGE ◄</span></div>
<div class="societe" ><a href="/index.html" title="Retour au CV..." class="sous-societe" > ▼ Retour au CV ▼ </a></div>

<div class="image"><img  alt="image société" src="./Picture/Fleches_G.JPG" /></div>
<div class="image2"><img  alt="image société" src="./Picture/Fleches_D.JPG" /></div>

</div>

<div class="formu">

<form method='post' name='envoi' action='/Comment/Comment_Send.php' onsubmit='return verif();'>

<div class='formi'>
<h1><span class='titref'>Enregistrer vos coordonnées : </span></h1>
<input type='hidden' name='numero' value='1'>

<label for='noms'><span class="intitule">Choisir la civilité : </span></label>
<span class="Champs">
<select name="civilite" >
<option value="Monsieur">Monsieur</option>
<option value="Madame">Madame</option>
<option value="Mademoiselle">Mademoiselle</option>
</select>					
</span>
<br/><br/>

<label for='noms'><span class="intitule"> Votre nom :</span><span class="titref"> * </span></label>
<span class="Champs"><input type='text'name='nom' id='nom' size='25'></span>
<br/><br/>
<label for='noms'><span class="intitule">Votre prénom : </span></label>
<span class="Champs"><input type='text'name='prenom' id='prenom' size='25'></span>

<br/><br/>

<label for='noms'><span class="intitule">Votre entreprise : </span></label>
<span class="Champs"><input type='text'name='entreprise' id='entreprise' size='25'></span>
<br/><br/>

<label for='noms'><span class="intitule">Votre e-mail :</span><span class="titref"> * </span></label>
<span class="Champs"><input type='text'name='email' id='email' size='25'></span>
<br/><br/>

<label for='noms'><span class="intitule">Votre n° de téléphone : </span></label>
<span class="Champs"><input type='text'name='telephone' id='telephone' size='25' onKeypress='if(event.which < 45 || event.which > 57) return false;'>
</span>
<br/><br/>

</div>

<div class="formo">
<h1><span class='titref'>Rédiger le message à envoyer : </span></h1>
<?php 
	$c=$_SERVER['HTTP_USER_AGENT'];

	if(preg_match('/MSIE/i',$c)) {$flag=1;}
	if(preg_match('/Firefox/i',$c)) {$flag=2;}
	if(preg_match('/Chrome/i',$c)) {$flag=3;}

switch($flag) {
		case '1':print'<TEXTAREA rows="12" cols="40" name="message" id="message"></TEXTAREA>';break;
		case '2':print'<TEXTAREA rows="11" cols="55" name="message" id="message"></TEXTAREA>';break;
		case '3':print'<TEXTAREA rows="12" cols="60" name="message" id="message"></TEXTAREA>';break;
	        default:print'<TEXTAREA rows="11" cols="55" name="message" id="message"></TEXTAREA>';break;}
	
?>

</br>
</br>

</div>

<div class="forma">
<INPUT name="valide" border="0" src="./Picture/Envoi.jpeg" type="image" Value="submit" align="middle" > 
</div>

</form>
</div>


</div>

</body>
</html>