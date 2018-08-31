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

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=25" method="POST">';

print'<span class="libelle">';
print '<label>Titre du journal :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Nom_Cat" value=""  / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nombre d\'envoi :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Nb_envoi" value="" onkeypress="numbers(event);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nombre de pages:</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Nb_pages" value="" onkeypress="numbers(event);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de début de période du numéro du journal :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
Extraction('Jour','jour','01','num','','','');
Extraction('Mois','mois','01','num','titre','','');
Extraction('Annee','annee','1','titre','','','');
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Begin" id="_id" value="" onFocus="datest(this.id);" onBlur="Datim(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de fin de période du numéro du journal :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
Extraction('Jour2','jour','01','num','','','');
Extraction('Mois2','mois','01','num','titre','','');
Extraction('Annee2','annee','1','titre','','','');
print'</span>';
print'<span class="champs">';
print '<input type="text" name="End" id="2_id" value="" onFocus="datest(this.id);" onBlur="Datim(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer Catalogue"  />';
print'</span>';

print'</form>';
print'</div>';

?>