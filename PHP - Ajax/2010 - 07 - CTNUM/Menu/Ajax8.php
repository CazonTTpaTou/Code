<?php

include("Fonct.php");

//session_start();

header('Content-type: text/html; charset=iso-8859-1'); 

$connectID=Connexion();
$_SESSION['N_Lig_com']++;
$_SESSION['Lig_sup']++;
$product='P_num_'.$_SESSION['N_Lig_com'];
$quantite='quantite'.$_SESSION['N_Lig_com'];
$id='P_num_id'.$_SESSION['N_Lig_com'];
$douc='Douc_id'.$_SESSION['N_Lig_com'];
$douch='Douchette'.$_SESSION['N_Lig_com'];

$Code[]='<span class="libelle" >';
		$Code[]= 'Ligne Livre n° '.$_SESSION['N_Lig_com'].' : -------------------------------------------------------------------------------------------------------------------------------------';
		$Code[]='</span>';

		$Code[]= '<br/>';
		$Code[]= '<br/>';
		
		//------------ Edition du libellé du champ quantité livre
			$Code[]= '<span class="libelle">';
			$Code[]= '<label>Numéro d\'ISBN : </label></span>';


		//------------ Edition du champ n° livre en sélection pré-remplie
		 //$Code[]= '<span class="champs">';
		 $Code[]='<span id="'.$id.'" class="champs" >';
		 
		 	$sqli="select numero,titre,ISBN from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

			//----- début de la liste déroulante
			$Code[]='<select name="'.$product.'" size ="1">';

			$Code[]='<option value ="" name="none">Choisissez un ISBN</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			$selec="";

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			$Code[]='<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['ISBN'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste déroulante
			$Code[]='</select>';
		$Code[]= '</span>';

		$Code[]='<br/>';
		$Code[]='<br/>';



		//------------ Edition du libellé du champ quantité livre
			$Code[]='<span class="libelle">';
			$Code[]= '<label>Nombre de livre : </label></span>';
						
		//------------ Edition du champ quantité livre en sélection pré-remplie
		 	$Code[]= '<span class="champs">';

			//----- début de la liste déroulante
			$Code[]='<select name="'.$quantite.'" size ="1">';

			$Code[]='<option value ="" name="none">Quantité</option>';

			$a=-1;
			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($a<=100) {
			
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
				$selec="";

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				$Code[]='<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste déroulante
			$Code[]= '</select>';
			$Code[]= '</span>';
			$Code[]= '<span class="champs">';
			$Code[]= '<input type="text" value="Saisie manuelle de l\' ISBN" id="'.$douc.'" size="45" name="'.$douch.'" onFocus="eff(this.id);" onBlur="Deroule(this.id)" / >';
			$Code[]= '</span>';
			$Code[]= '<br/>';
			$Code[]= '<br/>';

$Code[]='<div id="'.$_POST['Section'].'" >';			
$Code[]='</div>';

foreach($Code as $value) {echo $value;}

mysql_close($connectID);


?>