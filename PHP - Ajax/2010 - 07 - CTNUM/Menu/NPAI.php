<?php

print '<div class="princ">';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=23" method="POST">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print'<input type="submit" name="submited" value="Enregistrer les NPAI"/>';
print'</span>';

print '<br/>';
print '<br/>';
			
print'<span class="libelle">';
print '<label>Liste des numéros clients reçus en NPAI (séparation des numéros par des points) - ex: 123.45.1089 </label>';
print'</span>';
print '<br/>';
print '<span class="libelle">';
print '<input type="text" name="NPAI" size=100 id="npai_id" value="" onkeypress="return numbers_dec(event);" />';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type=radio name="etat" value="NPAI" checked >NPAI';
print '<input type=radio name="etat" value="Refuse"  >Refusé';
print '<input type=radio name="etat" value="DCD"  >Décédé';
print '</span>';
print '<br/>';
print '<br/>';



print'</form>';
print'</div>';

print '<div id="Liste_C" class="ListeC" >';
print'</div>';

?>