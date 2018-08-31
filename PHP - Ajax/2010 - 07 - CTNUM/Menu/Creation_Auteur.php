<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='Operation=11';

$nom='';
$prenom='';
$biographie='facultatif';
$naissance='facultatif';
$mort='facultatif';
$photo='facultatif';

if((isset($_GET['Auteur'])!=0) || (isset($_GET['Auteur'])!='')) {

	$_SESSION['URL']='Operation=12&Auteur='.$_GET['Auteur'];
	$req="select * from auteurs where id_auteur=".$_GET['Auteur']." ;";

	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

			$prenom=$row['prenom'];
			$nom=$row['nom'];

			if($row['naissance']!='') {$naissance=$row['naissance'];}
				else {$naissance='facultatif';}

			if($row['biographie']!='') {$biographie=$row['biographie'];}
				else {$biographie='facultatif';}
							
			if($row['mort']!='') {$mort=$row['mort'];}
				else {$mort='facultatif';}

			if($row['photo']!='') {$photo=$row['photo'];}
				else {$photo='facultatif';}

		}}

if(isset($_GET['Livre'])) {$_SESSION['Adresse']='?Operation=15&Livre='.$_GET['Livre'];}
	else{$_SESSION['Adresse']='?Operation=0';}

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php'.$_SESSION['Adresse'].'" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=20" >';
print '<input type="button" value="Modifier un Auteur" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return filtre_auteur(\'nom_id\',\'prenom_id\');" action="'.$_SERVER['PHP_SELF'].'?'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Nom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="nom_id" value="'.$nom.'" name="Nom" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prénom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="prenom_id" value="'.$prenom.'" name="Prenom" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de naissance :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="champ_id" value="'.$naissance.'" name="date_n"  onFocus="eff(this.id)" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" / >';
print '<label> - Format de date: aaaa-mm-jj</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de décès :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="champ_id2" value="'.$mort.'" name="date_d"  onFocus="eff(this.id)" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" / >';
print '<label> - Format de date: aaaa-mm-jj</label>';
print'</span>';
print '<br/>';
print '<br/>';


print'<span class="libelle">';
print '<label>Biographie de l\'auteur :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<textarea name="biographie"  rows="4" cols="100" id="champ_id3" onFocus="eff(this.id)">';
print $biographie;
print'</textarea>';
print'</span>';
print'<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Nom du fichier image :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="'.$photo.'" name="image" id="champ_id4"  onFocus="eff(this.id)" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer Fiche Auteur" />';
print'</span>';

print '</form>';
print '</div>';

?>


