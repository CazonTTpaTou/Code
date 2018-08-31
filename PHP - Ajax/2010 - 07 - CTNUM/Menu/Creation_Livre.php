<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';

$titre='';
$sous_titre='';
$page='';
$image='';
$prix='';
$isbn='xxx-x-xxxxxx-xx-x';
$editeur='NO';

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$_SESSION['URL']="&Livre=".$_GET['Livre']."&Modification=1";
	$req="select * from livres where numero=".$_GET['Livre']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

			$titre=$row['Titre'];
			$sous_titre=$row['sous_titre'];
			$page=$row['Pages'];
			$image=$row['image'];
			$prix=$row['Prix'];
			$isbn=$row['ISBN'];
			$editeur=$row['editeur'];}}
				

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return filtre_livre(\'nom_id\',\'CP_Client\',\'ville_id\');" action="'.$_SERVER['PHP_SELF'].'?Operation=7'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Titre :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="nom_id" value="'.$titre.'" size="75" name="Titre" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Sous titre :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="'.$sous_titre.'" size="75 name="Sous_titre" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nombre de pages :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="'.$page.'" name="Page" onkeypress="return numbers(event);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nom fichier couverture :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="'.$image.'" size="45" name="Couverture" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prix :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="'.$prix.'" name="Prix" maxlength=6 id="CP_Client" onkeypress="return numbers_dec(event);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>ISBN :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="ville_id" value="'.$isbn.'" name="ISBN" onFocus="eff(this.id);" onBlur="fonc_ISBN();" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Marque (éditeur) :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Editeur','marque',$editeur,'titre','','','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>