<?php

$_SESSION['Message']='Choisissez une opération !!!';

print '<div class="princ">';

print'<span class="libelle">';
print'<label>Menu des différentes requêtes de recherche livre</label>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au Menu principal" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=21" >';
print '<input type="button" value="1 - Recherche classique par titre et auteur" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=23" >';
print '<input type="button" value="2 - Recherche par classification (genre, rubrique)" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=24" >';
print '<input type="button" value="3 - Recherche par mots clés" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=24" >';
print '<input type="button" value="4 - Recherche dans les commentaires" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=24" >';
print '<input type="button" value="5 - Recherche dans les biographies" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=25" >';
print '<input type="button" value="6 - Recherche Générale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print '</div>';
?>

