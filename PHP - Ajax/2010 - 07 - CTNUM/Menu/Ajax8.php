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
		$Code[]= 'Ligne Livre n� '.$_SESSION['N_Lig_com'].' : -------------------------------------------------------------------------------------------------------------------------------------';
		$Code[]='</span>';

		$Code[]= '<br/>';
		$Code[]= '<br/>';
		
		//------------ Edition du libell� du champ quantit� livre
			$Code[]= '<span class="libelle">';
			$Code[]= '<label>Num�ro d\'ISBN : </label></span>';


		//------------ Edition du champ n� livre en s�lection pr�-remplie
		 //$Code[]= '<span class="champs">';
		 $Code[]='<span id="'.$id.'" class="champs" >';
		 
		 	$sqli="select numero,titre,ISBN from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");

			//----- d�but de la liste d�roulante
			$Code[]='<select name="'.$product.'" size ="1">';

			$Code[]='<option value ="" name="none">Choisissez un ISBN</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			$selec="";

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			$Code[]='<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['ISBN'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste d�roulante
			$Code[]='</select>';
		$Code[]= '</span>';

		$Code[]='<br/>';
		$Code[]='<br/>';



		//------------ Edition du libell� du champ quantit� livre
			$Code[]='<span class="libelle">';
			$Code[]= '<label>Nombre de livre : </label></span>';
						
		//------------ Edition du champ quantit� livre en s�lection pr�-remplie
		 	$Code[]= '<span class="champs">';

			//----- d�but de la liste d�roulante
			$Code[]='<select name="'.$quantite.'" size ="1">';

			$Code[]='<option value ="" name="none">Quantit�</option>';

			$a=-1;
			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($a<=100) {
			
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
				$selec="";

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				$Code[]='<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste d�roulante
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