<?php 

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=14" method="POST">';

print'<span class="libelle">';
print '<label>Mots recherchés :</label>';
print'</span>';
print '<br/>';
print'<span class="libelle">';
print '<input type="text" name="Liste" id="C_client" value="inconnu" size="100" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Sélectionner les tables dans lesquelles vous souhaitez rechercher les mots saisis :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';

print '<input type="Checkbox" name="Mots[]" value="1" Checked >Recherche dans les mots clés';
print '<input type="Checkbox" name="Mots[]" value="2"  >Recherche dans les commentaires de livre';
print '<input type="Checkbox" name="Mots[]" value="4"  >Recherche dans les biographies d\'auteur';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Lancer la recherche" />';
print'</span>';

print '</form>';
print'</div>';

?>