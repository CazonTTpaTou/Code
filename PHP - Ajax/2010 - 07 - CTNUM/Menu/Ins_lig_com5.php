<?php

$connectID=Connexion();



$req="select * from ligne_commande where numero_com=".$_GET['id']." ;";

$result = mysql_query($req,$connectID) or die("Impossible d'acc�der aux donn�es");
$i=1;
	while($ligne = mysql_fetch_array($result,MYSQL_ASSOC)) {

		$nu=$ligne['numero_livre'];
		$qu=$ligne['quantite'];

		print'<span class="lig_com" >';
		echo 'Ligne Livre n� '.$i.' : -----------------------';
		print'</span>';

		print'<span class="lig_com2">';
		 print'Ligne Livre n� '.$i.'-----------------------';
		 print'</span>';
		
		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libell� du champ quantit� livre
			print'<span class="libelle">';
			print '<label>Num�ro d\'ISBN : </label></span>';


		//------------ Edition du champ n� livre en s�lection pr�-remplie
		 print '<span class="champs">';
		 	$sqli="select numero,titre,isbn from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");

			//----- d�but de la liste d�roulante
			print'<select name="numero'.$i.'" size ="1">';

			print'<option value ="" name="none">Choisissez un code livre</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			if (($_SESSION['Requ']=='Modification') && ($Choice['numero']==$nu)) {$selec='selected';}
 				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['isbn'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste d�roulante
			print'</select>';
		print '</span>';
		
		print'<br/>';
		print'<br/>';


		//------------ Edition du libell� du champ quantit� livre
			print'<span class="libelle">';
			print '<label>Nombre de livre : </label></span>';
						
		//------------ Edition du champ quantit� livre en s�lection pr�-remplie
		 	print '<span class="champs">';

			//----- d�but de la liste d�roulante
			print'<select name="quantite'.$i.'" size ="1">';

			print'<option value ="" name="none">Quantit�</option>';

			$a=-1;
			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($a<=100) {
			
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
				if (($_SESSION['Requ']=='Modification') && ($a==$qu)) {$selec='selected';}
 				else {$selec="";}

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				print'<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste d�roulante
			print'</select>';
			print '</span>';

			print '<br/>';
			print '<br/>';

			$i++;}

mysql_close($connectID);

$_SESSION['N_Lig_com']=$i-1;
print'<br/>';


?>



