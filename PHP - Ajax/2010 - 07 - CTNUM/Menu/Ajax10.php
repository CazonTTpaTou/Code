<?php

include("Fonct.php");

//session_start();

header('Content-type: text/html; charset=iso-8859-1'); 

$connectID=Connexion();
$_SESSION['N_Lig_com']++;
$_SESSION['Lig_sup']++;
$product='P_num_'.$_SESSION['N_Lig_com'];
$quantite='quantite'.$_SESSION['N_Lig_com'];

$Code[]='<span class="libelle" >';
		$Code[]= 'Ligne Auteur n� '.$_SESSION['N_Lig_com'].' : -------------------------------------------------------------------------------------------------------------------------------------';
		$Code[]='</span>';

		$Code[]= '<br/>';
		$Code[]= '<br/>';
		
		//------------ Edition du libell� du champ auteur
			$Code[]= '<span class="libelle">';
			$Code[]= '<label>Nom de l\'auteur : </label></span>';


		//------------ Edition du champ n� livre en s�lection pr�-remplie
		 $Code[]= '<span class="champs">';
		 
		 
		 	$sqli="select id_auteur,nom,prenom from auteurs order by nom,prenom asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");

			//----- d�but de la liste d�roulante
			$Code[]='<select name="'.$product.'" size ="1">';

			$Code[]='<option value ="" name="none">Choisissez un auteur</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			$selec="";

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			$Code[]='<option value="'.$Choice['id_auteur'].'" '.$selec.' >'.$Choice['nom'].' - '.$Choice['prenom']. '</option>';}
			
			//----- fin de la liste d�roulante
			$Code[]='</select>';
		$Code[]= '</span>';

		$Code[]='<br/>';
		$Code[]='<br/>';


$Code[]='<div id="'.$_POST['Section'].'" >';			
$Code[]='</div>';

foreach($Code as $value) {echo $value;}

mysql_close($connectID);


?>