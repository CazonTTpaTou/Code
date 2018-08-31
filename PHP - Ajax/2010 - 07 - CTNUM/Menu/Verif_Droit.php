<?php
//session_start();

//----- Détermination de la commande qui va être recherchée dans la base de droits utilisateur
switch($_SESSION['Requ']) {
	case 'Suppression':$Commande='DELETE';break;
	case 'Modification':$Commande='UPDATE';break;
	case 'Insertion':$Commande='INSERT';break;
	case 'Consultation':$Commande='SELECT';break;}

include("Connexion.php");

//----- Construction de la requête qui va vérifier qu'il existe bien une ligne contenant
//----- Et le nom de l'utilisateur Et le nom de la commande
//----- Si c'est le cas, alors l'utilisateur a bien les droits pour effectuer la requête souhaitée
$droit="select * from information_schema.table_privileges where table_name='".$_SESSION['Tab']."'";
$droit.=" and privilege_type='".$Commande."' and grantee like ".$id.";";


$auth=mysql_query($droit,$connectID) or die ("Impossible d'accéder aux données");
mysql_close($connectID);

if($auth) {include("Connexion.php");

	   //----- Si l'utilisateur a bien les droits requis on exécute la reqûte constuite précédemment
	   $success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données2");
	
	   //----- Si la requête réussit, on enregistre un message de succès dans la variable de session message
	   if ($success) {$_SESSION['Message']='Votre requête '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a réussi !!!';}
	     
	      //----- Sinon, on enregistre un message d'échec de la requête effectuée
	      else {$_SESSION['Message']='Votre requête '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a échoué !!!';} 
	 
	    }

	//----- Si l'utilisateur ne dispose pas des droits requis, on l'avertit de la situation
	//----- Dans l'absolu, cela ne peut pas arriver puisque l'utilisateur a accès à un menu construit 
	//----- à partir des commandes sur lesquelles il possède des droits utilisateur
	//----- de ce fait, il n'a pas accès aux commandes qui ne lui sont pas autorisées...
	else {$_SESSION['Message']='Vous ne possédez pas les droits nécessaires pour la '.$_SESSION['Requ'];
              $_SESSION['Message'].= ' des données de la table '.$_SESSION['Tab'];
	      }

//----- Fermeture de la connexion et retour à la page d'accueil de l'application
$_SESSION['Operation']="Accueil";
mysql_close($connectID);



//---------------- En cas d'insertion d'une commande, l'application doit basculer sur la saisie des lignes de commande

if ($_SESSION['Tab']=='commande' && $_SESSION['Requ']=='Insertion') {
	$_SESSION['Last_Insert']=Last_Insertion_Com();
	$_SESSION['Requ']='Insertion';
	$_SESSION['Tab']='ligne_commande';
	$_SESSION['Message']='';
	header('Location:Menu.php?Operation=Insertion-Ligne_commande&id='.$_SESSION['Last_Insert']);
	}

else {header('Location:Menu.php?Operation=Accueil');}
?>