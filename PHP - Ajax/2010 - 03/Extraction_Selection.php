<?php

include("Connexion.php");

//----- si l'oprération en cours est une consultation ou une suppression, on ne veut pas que les champs pré-remplis
//----- du formulaire puissent être modifiés, alors on leur adjoint la valeur d'attribut disabled qui les rendent inaccessibles à la modification
if(($_SESSION['Requ']=='Consultation') || ($_SESSION['Requ']=='Suppression')) {$accesss="disabled";}
			else{$accesss="";}

//----- en fonction du champ, on détermine la table sur laquelle on va effectuer la requête et les champs d'où l'on va extraire les données de notre liste déroulante
switch($key) {
	case 'id_article':$cle='reference';$cle2='nom';$table='articles';break;
	case 'id_client':$cle='numero';$cle2='nom';$table='clients';break;}

//----- on construit la requête qui va nous permettre d'obtenir les lignes de notre liste déroulante
$sqli="select distinct ".$cle.",".$cle2." from ".$table." order by ".$cle." asc;";

$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

//----- début de la liste déroulante
print'<select name="'.$key.'" size ="1">';

//----- si le formulaire n'est pas pré-rempli, alors on insère une première ligne vierge
if(!isset($_GET['id'])) {print'<option value ="" name="none">Choisissez un identifiant</option>';}

	//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
	while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			if (($_SESSION['Requ']!='Insertion') && ($Choice[$cle]==$Valeur)) {$selec='selected';}
 				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice[$cle].'" '.$selec.' '.$accesss.' >'.$Choice[$cle].'  '.$Choice[$cle2].'</option>';}

//----- fin de la liste déroulante
print'</select>';

?>

