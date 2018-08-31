<?php

//session_start();

//----- D�termination de la commande qui va �tre recherch�e dans la base de droits utilisateur
switch($_SESSION['Requ']) {
	case 'Suppression':$Commande='DELETE';break;
	case 'Modification':$Commande='UPDATE';break;
	case 'Insertion':$Commande='INSERT';break;
	case 'Consultation':$Commande='SELECT';break;}

include("Connexion.php");

//----- Construction de la requ�te qui va v�rifier qu'il existe bien une ligne contenant
//----- Et le nom de l'utilisateur Et le nom de la commande
//----- Si c'est le cas, alors l'utilisateur a bien les droits pour effectuer la requ�te souhait�e
$droit="select * from information_schema.table_privileges where table_name='".$_SESSION['Tab']."'";
$droit.=" and privilege_type='".$Commande."' and grantee like ".$id.";";

echo $requete;
$auth=mysql_query($droit,$connectID) or die ("Impossible d'acc�der aux donn�es");
mysql_close($connectID);

if($auth) {include("Connexion.php");

	   //----- Si l'utilisateur a bien les droits requis on ex�cute la req�te constuite pr�c�demment
	   $success = mysql_query($requete,$connectID) or die ("Impossible d'acc�der aux donn�es2");
	
	   //----- Si la requ�te r�ussit, on enregistre un message de succ�s dans la variable de session message
	   if ($success) {$_SESSION['Message']='Votre requ�te '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a r�ussi !!!';}
	     
	      //----- Sinon, on enregistre un message d'�chec de la requ�te effectu�e
	      else {$_SESSION['Message']='Votre requ�te '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a �chou� !!!';} 
	 
	    }

	//----- Si l'utilisateur ne dispose pas des droits requis, on l'avertit de la situation
	//----- Dans l'absolu, cela ne peut pas arriver puisque l'utilisateur a acc�s � un menu construit 
	//----- � partir des commandes sur lesquelles il poss�de des droits utilisateur
	//----- de ce fait, il n'a pas acc�s aux commandes qui ne lui sont pas autoris�es...
	else {$_SESSION['Message']='Vous ne poss�dez pas les droits n�cessaires pour la '.$_SESSION['Requ'];
              $_SESSION['Message'].= ' des donn�es de la table '.$_SESSION['Tab'];
	      }

//----- Fermeture de la connexion et retour � la page d'accueil de l'application
$_SESSION['Operation']="Accueil";
mysql_close($connectID);
header('Location: '.$_SERVER['PHP_SELF'].'?Operation=Accueil');

?>




