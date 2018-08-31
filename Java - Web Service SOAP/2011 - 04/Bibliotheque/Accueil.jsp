<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="stylesheet" type="text/css" href="presentation.css"></link>	<title>Bibliothèque</title>

	<script language=javascript>
	function verif() {
	if(document.getElementById("title").value == "" ||
		document.getElementById("price").value == "" ||
		document.getElementById("prop").value == "")
			{ alert("Un des champs n'est pas rempli !");
			return false;}
	else
			return true;
	}
	</script>

</head>
<body>

<div class="choix">
<div class="choix2">
<span class="menu">MENU</span>
</div>
</div>

<div class="choix1">
	<ol type="I">
		<li class="menub">Consulter</li>
			<a href="http://localhost:8080/Bibliotheque/Controle?operation=1">Consultation</a>
			<br/>
			<br/>

		<li class="menub">Réserver</li>
			<td><a href="http://localhost:8080/Bibliotheque/Controle?operation=2">Réservation</a>
			<br/>
			<br/>

		<li class="menub">Gérer</li>			
			<td><a href="http://localhost:8080/Bibliotheque/Controle?operation=3">Suppression</a>
			<br/>
			<td><a href="http://localhost:8080/Bibliotheque/Controle?operation=4">Ajout</a>
			<br/>
			<br/>
	</ol>
</div>

<div class="mention">
<span class="societe">BIBLIOTHEQUE</span>
<span class="sous-societe">Oeuvres des artistes</span>
<span class="image"><img  alt="image société" src="images/logo.livres.JPG" /></span>
<span class="image2"><img  alt="image société" src="images/logo.livres.JPG" /></span>
</div>

<div class="mention1">
<div class="mention2">
<span class="profil-title">Opération:<%= request.getAttribute("libelle") %></span><br/>
</div>
<div class="mention3">
<span class="profil-title">Utilisateur:<%= request.getAttribute("utilisateur") %> </span><br/>
</div>
<div class="mention4">
<a href="http://localhost:8080/Bibliotheque/index.jsp" class="dex" >Déconnexion</a>
</div>
</div>

<div class="formu">
<%= request.getAttribute("formulaire") %>
</div>

</body>
</html>