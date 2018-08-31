<?php
$_SESSION['N_Lig_com']=0;
$_SESSION['URL']='';
if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {$_SESSION['URL']='&Modification=1';}

print '<div class="princi">';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=8&Livre='.$_GET['Livre'].$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les auteurs" />';
print'</span>';

print'<span class="champs">';
print'<input type="button" name="valid" value="Rajouter une ligne Auteur" onClick="Ajoute_auteur();" />';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=19&Livre='.$_GET['Livre'].'" >';
print '<input type="button" value="Créer une fiche Auteur" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<br/>';
print '<br/>';

$connectID=Connexion();

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$req="select * from auteurs,liv_aut where auteurs.id_auteur=liv_aut.id_auteur and id_livre=".$_GET['Livre']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);
		
		$i=1;

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

			
	
		print'<span class="libelle" >';
		echo 'Ligne Auteur n° '.$i.' : -------------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libellé du champ quantité livre
			print '<span class="libelle">';
			print '<label>Nom de l\'auteur : </label></span>';


		//------------ Edition du champ n° livre en sélection pré-remplie
		 print '<span class="champs">';
		 $product='P_num_'.$i;
		 
		 	$sqli="select id_auteur,nom,prenom from auteurs order by nom,prenom asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

			//----- début de la liste déroulante
			print'<select name="'.$product.'" size ="1">';

			print'<option value ="" name="none">Choisissez un auteur</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			if($Choice['id_auteur']==$row['id_auteur']) {$selec="selected";}
				else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['id_auteur'].'" '.$selec.' >'.$Choice['nom'].' - '.$Choice['prenom']. '</option>';}
			
			//----- fin de la liste déroulante
			print'</select>';
		print '</span>';

		print'<br/>';
		print'<br/>';

			print'</select>';
			print '</span>';
			print '<input type="hidden" name="num_ligne'.$i.'" value="'.$row['num_ligne'].'" />';
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

print'</div>';}


else {

$i=1;
	
		print'<span class="libelle" >';
		echo 'Ligne Auteur n° '.$i.' : -------------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libellé du champ quantité livre
			print '<span class="libelle">';
			print '<label>Nom de l\'auteur : </label></span>';


		//------------ Edition du champ n° livre en sélection pré-remplie
		 print '<span class="champs">';
		 $product='P_num_'.$i;
		 
		 	$sqli="select id_auteur,nom,prenom from auteurs order by nom,prenom asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

			//----- début de la liste déroulante
			print'<select name="'.$product.'" size ="1">';

			print'<option value ="" name="none">Choisissez un auteur</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			$selec="";

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['id_auteur'].'" '.$selec.' >'.$Choice['nom'].' - '.$Choice['prenom']. '</option>';}
			
			//----- fin de la liste déroulante
			print'</select>';
		print '</span>';

		print'<br/>';
		print'<br/>';


			$i++;

mysql_close($connectID);

$_SESSION['N_Lig_com']=$i-1;
$_SESSION['Lig_sup']=0;

//print 'Ligne: '.$_SESSION['N_Lig_com'];

print'<br/>';

print'<div id="Lig_sup0">';

print'</div>';

print'</form>';

print'</div>';}


print'</div>';

?>



