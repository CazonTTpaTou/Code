<?php
include('Fonctions.php');
		//------------- On détermine l'en tête de la réponse qui va être renvoyée par la requête asynchrone
		//------------- On spécifie que la réponse renvoyée sera au format XML
		header("HTTP/1.1 200 OK");
		header('Content-type: text/xml; charset=iso-8859-1'); 
	//------------- Début des données au format XML
	print'<?xml version="1.0" encoding="ISO-8859-1"?>';
	//------------- Lit le nombre de message insérés dans la BDD dans le fichier TellMeMore.txt
	$i=lecture('TellMeMore');
	//------------- On détermine le nombre de message à afficher en soustrayant le numéro du dernier
	//------------- au n° du dernier message inséré dans la BDD du chat 
	$a=$i-$_SESSION['dernier'];
	$connectID=Connexion();
	//------------- Requête extrayant les messages non encore affichés par le navigateur client
	$sql="select num_message,message,heure,pseudo from messages m inner join utilisateurs u on m.num_auteur = u.numero where m.num_message <= ".$i." and m.num_message > ".$a." order by m.num_message asc;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	
	//------------- Début de la conversion des données extraites au format XML
	print'<Messages>';
	while($ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC)) {
		print'<Message>';
		print'<Numero>'.$ligne['num_message'].' . </Numero>';
		print'<Auteur>'.$ligne['pseudo'].' a écrit le </Auteur>';
		print'<Heure>'.$ligne['heure'].' : </Heure>';
		print'<Texte>'.$ligne['message'].'</Texte>';
		print'</Message>';
		}
	print'</Messages>';
	?>