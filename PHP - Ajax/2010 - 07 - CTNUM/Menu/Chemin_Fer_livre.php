<?php

$page=$_GET['Page'];
$catalogue=$_GET['Catalogue'];
$modif='';

$connectID=Connexion();

//$_SESSION['Nb_pages']=$_GET['Nb_pages'];

$req="select num_rub from chemin_fer where chemin_fer.num_page=".$page." ;";
//echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
	$numero=$row['num_rub'];}


if(isset($_GET['Modification'])) {
	
	$modif='&Modification=1';
	$req="select count(*) as number from chemin_fer_livre where num_page =".$_GET['Page']." and num_cat=".$_GET['Catalogue']." ;";
	//echo $req;
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$numero=$row['number'];}}

$_SESSION['Nombre_de_livre']=$numero;


print '<div class="princ_livre" >';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=27&Catalogue='.$_GET['Catalogue'].'&Page='.$_GET['Page'].$modif.'" method="POST">';

$i=1;

print'<span class="libelle">';
print '<label>Page n° '.$page.' du catalogue n° '.$_GET['Catalogue'].' :</label>';
print'</span>';
print'<br/>';
print'<br/>';

//$product='Rub_'.$page;
//print '<input type="hidden" name="'.$product.'" value="'.$numero.'" / >'

print'<span class="libelle">';
print '<label>Choisissez les livres: </label>';
print'</span>';

print '<br/>';
print '<br/>';

while($i<=$numero) {

	print'<span class="libelle" >';
		echo 'Livre n° '.$i.' : -------------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';

		//------------ Edition du libellé du champ n° livre
			print'<span class="libelle">';
			//print '<label>Nombre de livre : </label></span>';

			print '<input type="text" value="Saisie manuelle de l\' ISBN" id="'.$i.'" size="45" name="Douchette'.$i.'" onFocus="eff(this.id);" onBlur="Deroules(this.id);" / >';
			print '</span>';
			echo '<br/>';
			echo '<br/>';	

		//------------ Edition du libellé du champ n° livre		
		 $product='P_num_'.$i;
		 $id='P_num_id'.$i;
		 $co='Comm'.$i;
		 $com='1000_'.$i;
		 $bouton='bou_'.$i;
		 $menu='Menu'.$i;
		 $meni='Meni'.$i;
		 $button='Bout'.$i;
		 
		 	$sqli="select numero,titre,ISBN from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");
			print'<span id="'.$id.'" class="libelle" >';
			//----- début de la liste déroulante
			print'<select name="'.$product.'"  id="'.$meni.'" size ="1"  >';

			print'<option value ="" name="none">Choisissez un ISBN</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			$selec="";

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			print'<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['ISBN'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste déroulante
			print'</select>';
			print'</span>';

			print '<br/>';
			print '<br/>';
			//------------ Edition du libellé du commentaire n° livre
			
			print'<span id="'.$com.'" class="libelle" >';
			print'<select name="'.$co.'"  size ="1" id="'.$menu.'"  >';
			print'<option value ="" name="none">Choix du commentaire</option>';
			print'</select>';
			print '</span>';
			
			print '<span  class="champs" >';
			print '<input type="button" id="'.$button.'" value="Commentaires" onclick="Commentaires_R(this.id);"" />';
			print '<input type="button" id="'.$bouton.'" value="Aperçu" onclick="aperco(this.id);" />';
			print '</span>';
			print '<br/>';
			print '<br/>';
			
			$i++;}

print'<br/>';
print'<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer la page n° '.$page.'"  />';
print'</span>';

mysql_close($connectID);

print'</form>';
print'</div>';

?>