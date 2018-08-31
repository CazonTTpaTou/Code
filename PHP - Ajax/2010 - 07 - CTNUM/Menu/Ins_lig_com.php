<?php

print '<div class="formi">';
print '<form onsubmit="action="'.$_SERVER['PHP_SELF'].'?Operation=Inser_lig_com" method="POST">';

print'<span class="libelle">';
print '<label>Numéro Commande: </label></span>';

print '<span class="champs">';
print '<input type="text" readonly value='.$_SESSION['Last_Insert'].' />';
print '</span>';

print'<br/>';
print'<br/>';
print'<br/>';

//---------- Edition des boutons formulaire de validation

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'<span class="champs">';
print'<input type="reset" name="reseted" value="Effacer" />';
print'</span>';

//---------- Saut de ligne esthétique

print'<br/>';
print'<br/>';
print'<br/>';

$connectID=Connexion();

for ($i=1;;$i++) {
		 //------------ Edition du libellé n° de ligne
		 print'<span class="lig_com">';
		 print'-------------------      Ligne Livre n° '.$i.' : ';
		 print'</span>';

		 print'<span class="lig_com2">';
		 print'Ligne Livre n° '.$i.' :     ----------------------';
		 print'</span>';

		 print'<br/>';
		 print'<br/>';
		 
		 //------------ Edition du libellé du champ n° livre
		 //print'<span class="libelle">';
		 //print '<label>Code Livre: </label></span>';
		 
		//------------ Edition du champ n° livre en sélection pré-remplie
		 print '<span class="champs">';
		 	$sqli="select numero,titre from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

			//----- début de la liste déroulante
			print'<select name="numero'.$i.'" size ="1">';

			print'<option value ="" name="none">Choisissez un code livre</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			if (($_SESSION['Requ']=='Modification')) {$selec='selected';}
 				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['numero'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste déroulante
			print'</select>';
		print '</span>';
		
		//print'<br/>';

		//------------ Edition du libellé du champ quantité livre
			//print'<span class="libelle">';
			//print '<label>Nombre de livre : </label></span>';
						
		//------------ Edition du champ quantité livre en sélection pré-remplie
		 	print '<span class="champs">';

			//----- début de la liste déroulante
			print'<select name="quantite'.$i.'" size ="1">';

			print'<option value ="" name="none">Quantité</option>';

			$a=0;
			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($a<=100) {
			
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
				if ($_SESSION['Requ']=='Modification') {$selec='selected';}
 				else {$selec="";}

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				print'<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste déroulante
			print'</select>';
			print '</span>';

			print '<br/>';
			print '<br/>';
			if($i==15) {break;}
			}


mysql_close($connectID);

?>



