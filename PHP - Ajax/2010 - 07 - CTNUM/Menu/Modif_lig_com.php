<?php

$_SESSION['N_Lig_com']=0;

print '<div class="princi">';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=5&Commande='.$_GET['Commande'].'" method="POST">';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les modifications" />';
print'</span>';

print'<span class="champs">';
print'<input type="button" name="valid" value="Rajouter une ligne de commande" onClick="Ajoute();" />';
print'</span>';
print '<br/>';
print '<br/>';

$connectID=Connexion();

$req="select * from ligne_commande where numero_com=".$_GET['Commande']." ;";

$result = mysql_query($req,$connectID) or die("Impossible d'acc�der aux donn�es");
$i=1;
	while($ligne = mysql_fetch_array($result,MYSQL_ASSOC)) {

		$nu=$ligne['numero_livre'];
		$qu=$ligne['quantite'];

		print'<span class="libelle" >';
		echo 'Ligne Livre n� '.$i.' : -------------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libell� du champ quantit� livre
			print '<span class="libelle">';
			print '<label>Num�ro d\'ISBN : </label></span>';


		//------------ Edition du champ n� livre en s�lection pr�-remplie
		//print '<span class="champs">';
		 $product='P_num_'.$i;
		 $id='P_num_id'.$i;
		 
		 	$sqli="select numero,titre,ISBN from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");
			
			print'<span id="'.$id.'" class="champs" >';
			//----- d�but de la liste d�roulante
			print'<select name="'.$product.'" size ="1">';

			print'<option value ="" name="none">Choisissez un ISBN</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			if ($Choice['numero']==$nu) {$selec='selected';}
 				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['ISBN'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste d�roulante
			print'</select>';
		print '</span>';

		print'<span class="champs">';
		print '<input type="text" value="Saisie manuelle de l\' ISBN" id="Douc_id'.$i.'" size="45" name="Douchette'.$i.'" onFocus="eff(this.id);" onBlur="Deroule(this.id)" / >';
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
				if ($a==$qu) {$selec='selected';}
 				else {$selec="";}

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				print'<option value="'.$a.'" '.$selec.' >'.$a.'</option>';
				}
			
			//----- fin de la liste d�roulante
			print'</select>';
			print '</span>';

			print'<span class="champs">';
			print '<input type="text" value="Saisie manuelle de l\' ISBN" id="Douc_id'.$i.'" size="45" name="Douchette'.$i.'" onFocus="eff(this.id);" onBlur="Deroule(this.id)" / >';
			print '</span>';

			print '<input type="hidden" name="num_ligne'.$i.'" value="'.$ligne['num_ligne'].'" />';
			print '<br/>';
			print '<br/>';

			$i++;}

mysql_close($connectID);

$_SESSION['N_Lig_com']=$i-1;
$_SESSION['Lig_sup']=0;

//print 'Ligne: '.$_SESSION['N_Lig_com'];

print'<br/>';

print'<div id="Lig_sup0">';

print'</div>';

print'</form>';

print'</div>';

?>



