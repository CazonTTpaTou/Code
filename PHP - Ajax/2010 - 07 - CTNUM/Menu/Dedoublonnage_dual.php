<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';
$saisie='NO';

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=33" method="POST">';

print '<span class="libelle">';
print '<label>Auto d�doublonnage de fichier:</label>';
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Choisir le fichier � d�doublonner:</label>';
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
$req="select distinct fichiers from clients where fichiers is not null;"; 
$saisie='NO';
cocher_RR($req,'Fichier','clients','fichiers','fichiers',$saisie);
print '</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Lancer le d�doublonnage"  />';
print'</span>';

print'</form>';
print'</div>';

?>