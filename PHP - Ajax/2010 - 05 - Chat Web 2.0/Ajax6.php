<?php
include('Fonctions.php');

//------------- On détermine l'en tête de la réponse qui va être renvoyée par la requête asynchrone
//------------- On spécifie que la réponse renvoyée sera au format HTML
header('Content-type: text/html; charset=iso-8859-1'); 

//------------- Si la méthode de la requête est de type GET, on se contente de comparer le n° du dernier message affiché
//------------- et celui du dernier message inséré
//------------- S'ils sont différents on renvoie la valeur 2, et on enregistre le nombre de message à extraire
//------------- dans la variable de session $_SESSION['dernier']
//------------- Sinon on renvoie la valeur 1
if($_SERVER['REQUEST_METHOD']=='GET') {if(compare()) {echo'1';}
				       if(!compare()) {$_SESSION['dernier']=lecture('TellMeMore')-lecture($_SESSION['pseudo']);
						       enregistre($_SESSION['pseudo'],lecture('TellMeMore'));
						       echo'2';}}

//------------- Si la méthode de la requête est de type POST, on insère les données envoyées dans la table des messages envoyés
//------------- Puis, on enregistre le nombre de message à extraire dans la variable de session $_SESSION['dernier']
//------------- et on renvoie la valeur 2, qui entraînera l'envoi d'une nouvelle requête asynchrone
if($_SERVER['REQUEST_METHOD']=='POST') {inser_mess(@$_POST['mess']);
					$_SESSION['dernier']=lecture('TellMeMore')-lecture($_SESSION['pseudo']);
					enregistre($_SESSION['pseudo'],lecture('TellMeMore'));
					echo'2';}
?>

		