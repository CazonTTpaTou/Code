<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Accueil</title>

<script language=javascript>
	function verif() {
		if(document.getElementById("name").value == "")
			{ alert("Un des champs n'est pas rempli !");
				return false;}
		else return true;}
</script>

</head>
<body>

<h1>Bienvenue sur l'application Bibliothèque</h1>
<br/>
<br/>
<form method='post' name="intro" action='Controle?operation=0' onsubmit='return verif();'>
<input type="hidden" name="numero" value="0">
<input type="hidden" name="navigateur" value="">
<label for="noms"> Votre nom :</label> 
<input type='text'name='nom' id="name"> 
<br/><br/>
<input type='submit' value="Envoyer"><br/>
<script type="text/javascript">
 document.intro.navigateur.value = navigator.userAgent;
</script>

</form>

</body>
</html>