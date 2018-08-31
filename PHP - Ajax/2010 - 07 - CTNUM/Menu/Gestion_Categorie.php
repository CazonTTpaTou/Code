<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=28" >';
print '<input type="button" value="Modifier des attributs" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=15" method="POST">';

print'<span class="libelle">';
print '<label>Gestion des périodes :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Rajouter une période :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Periode" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des sujets :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Rajouter un sujet :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Sujet" / >';
print'</span>';
print '<br/>';
print'<br/>';


print'<span class="libelle">';
print '<label>Gestion des lieux :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Rajouter un lieu :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Lieu" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des genres :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Rajouter un genre :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Genre" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des rubriques :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Rajouter une rubrique :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Rubrique" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>


