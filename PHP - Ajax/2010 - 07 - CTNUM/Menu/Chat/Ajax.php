<?php
include('Fonctions.php');
		//------------- On d�termine l'en t�te de la r�ponse qui va �tre renvoy�e par la requ�te asynchrone
		//------------- On sp�cifie que la r�ponse renvoy�e sera au format XML
		header("HTTP/1.1 200 OK");
		header('Content-type: text/xml; charset=iso-8859-1'); 
	//------------- D�but des donn�es au format XML
	print'<?xml version="1.0" encoding="ISO-8859-1"?>';
	//------------- Lit le nombre de message ins�r�s dans la BDD dans le fichier TellMeMore.txt
	$i=lecture('TellMeMore');
	//------------- On d�termine le nombre de message � afficher en soustrayant le num�ro du dernier
	//------------- au n� du dernier message ins�r� dans la BDD du chat 
	$a=$i-$_SESSION['dernier'];
	$connectID=Connexion();
	//------------- Requ�te extrayant les messages non encore affich�s par le navigateur client
	$sql="select num_message,message,heure,pseudo from messages m inner join utilisateurs u on m.num_auteur = u.numero where m.num_message <= ".$i." and m.num_message > ".$a." order by m.num_message asc;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'acc�der aux donn�es");
	
	//------------- D�but de la conversion des donn�es extraites au format XML
	print'<Messages>';
	while($ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC)) {
		print'<Message>';
		print'<Numero>'.$ligne['num_message'].' . </Numero>';
		print'<Auteur>'.$ligne['pseudo'].' a �crit le </Auteur>';
		print'<Heure>'.$ligne['heure'].' : </Heure>';
		print'<Texte>'.$ligne['message'].'</Texte>';
		print'</Message>';
		}
	print'</Messages>';
	?>