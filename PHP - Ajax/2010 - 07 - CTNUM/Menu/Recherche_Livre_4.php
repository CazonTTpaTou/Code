<?php

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print'<input type="button" name="valid" value="Rechercher" onClick="commande();" />';
print'</span>';
print '<br/>';
print '<br/>';

//print '<form onsubmit="return commande(this);" method="POST">';

print'<span class="libelle">';
print '<label>Moteur de recherche :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Client" id="C_client" value="rentrez votre texte"  onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print '<br/>';
print '<br/>';
print '<br/>';
print '</div>';


print '<div id="Liste_C" class="ListeC" >';
print'</div>';


?>

