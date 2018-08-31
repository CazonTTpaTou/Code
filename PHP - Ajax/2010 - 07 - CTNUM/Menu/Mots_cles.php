<?php

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$connectID=Connexion();
	$_SESSION['URL']="&Modification=1";

	$connectID=Connexion();

$req="select mots,surplus from mots_cles where id_livre =".$_GET['Livre']." ;";
$succes=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots_ancien=$row['mots'];
				$mots_nouveaux=$row['surplus'];}

mysql_close($connectID);

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=18&Livre='.$_GET['Livre'].$_SESSION['URL'].'" >';
print '<input type="button" value="Ne pas modifier les mots clés" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=10&Livre='.$_GET['Livre'].$_SESSION['URL'].'" method="POST">';

print '<span class="libelle">';
print '<label>Liste des mots clés enregistrés antérieurement: </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<textarea name="mot" rows="5" cols="30" readonly="readonly" >';
print $mots_ancien;
print'</textarea>';
print'</span>';

print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Nouvelle liste de mots clés générés à éventuellement compléter (cette liste écrasera l\'ancienne)  : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<textarea name="mots" rows="5" cols="30" >';
print $mots_nouveaux;
print'</textarea>';
print'</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les nouveaux mots clés" />';
print'</span>';}
	

else {

$connectID=Connexion();

$req="select mots from mots_cles where id_livre =".$_GET['Livre']." ;";
$succes=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots=$row['mots'];}

mysql_close($connectID);

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=18&Livre='.$_GET['Livre'].'" >';
print '<input type="button" value="Ne pas modifier les mots clés" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=10&Livre='.$_GET['Livre'].'" method="POST">';

print '<span class="libelle">';
print '<label>Liste des mots clés déjà enregistrés : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<textarea name="mot" rows="5" cols="30" readonly="readonly" >';
print $mots;
print'</textarea>';
print'</span>';

print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Vous pouvez modifier cette liste de mots clés (ne rentrer que des mots sans article)  : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<textarea name="mots" rows="5" cols="30" >';
print $mots;
print'</textarea>';
print'</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les modifications" />';
print'</span>';}


?>

