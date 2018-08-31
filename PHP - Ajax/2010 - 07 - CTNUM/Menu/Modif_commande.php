<?php

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Cas n° 1 : Je ne connais pas le numéro de commande :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=7" >';
print '<input type="button" value="Rechercher une commande" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Cas n° 2 : Je connais le numéro de commande :</label>';
print'</span>';
print '<br/>';
print '<br/>';

//print '<form onsubmit="return commande(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=1'.$_SESSION['URL'].'" method="POST">';
print'<span class="libelle">';
print '<label>Numéro Commande :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="text" name="N_Commande" id="C_commande" value="inconnu" onkeypress="return numbers(event);" onBlur="num_co();" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=66'.$_SESSION['URL'].'" >';
print '<input type="button" value="Modifier la commande" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

//print'</form>';
print'</div>';

print'<div id="Liste_C" class="ListeD" >';
print'</div>';

?>