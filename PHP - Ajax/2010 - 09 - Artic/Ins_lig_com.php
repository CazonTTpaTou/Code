<?php

print '<div class="formi">';
print '<form onsubmit="action="'.$_SERVER['PHP_SELF'].'?Operation=Inser_lig_com" method="POST">';

print'<span class="libelle">';
print '<label>Num�ro Commande: </label></span>';

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

//---------- Saut de ligne esth�tique

print'<br/>';
print'<br/>';
print'<br/>';

$connectID=Connexion();

for ($i=1;;$i++) {
		 //------------ Edition du libell� n� de ligne
		 print'<span class="lig_com">';
		 print'-------------------      Ligne Livre n� '.$i.' : ';
		 print'</span>';

		 print'<span class="lig_com2">';
		 print'Ligne Livre n� '.$i.' :     ----------------------';
		 print'</span>';

		 print'<br/>';
		 print'<br/>';
		 
		 //------------ Edition du libell� du champ n� livre
		 //print'<span class="libelle">';
		 //print '<label>Code Livre: </label></span>';
		 
		//------------ Edition du champ n� livre en s�lection pr�-remplie
		 print '<span class="champs">';
		 	$sqli="select numero,titre from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");

			//----- d�but de la liste d�roulante
			print'<select name="numero'.$i.'" size ="1">';

			print'<option value ="" name="none">Choisissez un code livre</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			if (($_SESSION['Requ']=='Modification')) {$selec='selected';}
 				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['numero'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste d�roulante
			print'</select>';
		print '</span>';
		
		//print'<br/>';

		//------------ Edition du libell� du champ quantit� livre
			//print'<span class="libelle">';
			//print '<label>Nombre de livre : </label></span>';
						
		//------------ Edition du champ quantit� livre en s�lection pr�-remplie
		 	print '<span class="champs">';

			//----- d�but de la liste d�roulante
			print'<select name="quantite'.$i.'" size ="1">';

			print'<option value ="" name="none">Quantit�</option>';

			$a=0;
			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($a<=100) {
			
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
				if ($_SESSION['Requ']=='Modification') {$selec='selected';}
 				else {$selec="";}

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				print'<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste d�roulante
			print'</select>';
			print '</span>';

			print '<br/>';
			print '<br/>';
			if($i==15) {break;}
			}


mysql_close($connectID);

?>



