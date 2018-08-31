<?php
include('Fonctions.php');

//------------- On d�termine l'en t�te de la r�ponse qui va �tre renvoy�e par la requ�te asynchrone
//------------- On sp�cifie que la r�ponse renvoy�e sera au format HTML
header('Content-type: text/html; charset=iso-8859-1'); 

//------------- Si la m�thode de la requ�te est de type GET, on se contente de comparer le n� du dernier message affich�
//------------- et celui du dernier message ins�r�
//------------- S'ils sont diff�rents on renvoie la valeur 2, et on enregistre le nombre de message � extraire
//------------- dans la variable de session $_SESSION['dernier']
//------------- Sinon on renvoie la valeur 1
if($_SERVER['REQUEST_METHOD']=='GET') {if(compare()) {echo'1';}
				       if(!compare()) {$_SESSION['dernier']=lecture('TellMeMore')-lecture($_SESSION['pseudo']);
						       enregistre($_SESSION['pseudo'],lecture('TellMeMore'));
						       echo'2';}}

//------------- Si la m�thode de la requ�te est de type POST, on ins�re les donn�es envoy�es dans la table des messages envoy�s
//------------- Puis, on enregistre le nombre de message � extraire dans la variable de session $_SESSION['dernier']
//------------- et on renvoie la valeur 2, qui entra�nera l'envoi d'une nouvelle requ�te asynchrone
if($_SERVER['REQUEST_METHOD']=='POST') {inser_mess(@$_POST['mess']);
					$_SESSION['dernier']=lecture('TellMeMore')-lecture($_SESSION['pseudo']);
					enregistre($_SESSION['pseudo'],lecture('TellMeMore'));
					echo'2';}
?>

		