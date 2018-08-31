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
print '<a href="Intro.php?Operation=27" >';
print '<input type="button" value="Retour ajout des attributs" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=16" method="POST">';

print'<span class="libelle">';
print '<label>Gestion des périodes :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Modifier une période :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Periode','periode','NO','num','titre','','');
print '<input type="text" name="Periode_M" value="Nouveau nom" id="periode_id" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des sujets:</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Modifier un sujet :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Sujet','sujet','NO','num','titre','','');
print '<input type="text" name="Sujet_M" value="Nouveau nom" id="sujet_id" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des lieux:</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Modifier un lieu :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Lieu','lieu','NO','num','titre','','');
print '<input type="text" name="Lieu_M" value="Nouveau nom" id="lieu_id" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des genres :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Modifier un genre :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Genre','genre','NO','num','titre','','');
print '<input type="text" name="Genre_M" value="Nouveau nom" id="genre_id" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Gestion des rubriques:</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Modifier une rubrique:</label>';
print'</span>';
print'<span class="champs">';
Extraction('Rubrique','rubrique','NO','num','titre','','');
print '<input type="text" name="Rubrique_M" value="Nouveau nom" id="rubrique_id" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Enregistrer les modifications"/>';
print'</span>';

print'</form>';
print'</div>';

?>