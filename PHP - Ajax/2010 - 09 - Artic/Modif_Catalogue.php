<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=28" method="POST">';

print'<span class="libelle">';
print '<label>Titre du catalogue :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Catalogue','catalogue','NO','num_cat','nom','','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Accéder au Catalogue"  />';
print'</span>';

print'</form>';
print'</div>';

?>