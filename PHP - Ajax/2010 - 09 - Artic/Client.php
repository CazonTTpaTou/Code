<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return filtre(\'nom_id\',\'CP_Client\',\'ville_id\');" action="'.$_SERVER['PHP_SELF'].'?Operation=4" method="POST">';

print'<span class="libelle">';
print '<label>Qualité :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Qualite" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="nom_id" name="Nom" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prénom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Prenom" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Numéro de voie :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Num_voie"  / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Type de voie :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Typ_voie" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nom de la voie :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" size="70" name="Nom_voie" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Adresse complémentaire :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" size="70" name="Ad_comp" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Code Postal :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Code_Postal" maxlength=5 id="CP_Client" onkeypress="return numbers(event);" onBlur="CP(this.id);" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Ville :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="ville_id" name="Ville" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Téléphone :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="facultatif" id="telephone_id" name="telephone" maxlength=10 onFocus="eff(this.id);" onkeypress="return numbers(event);" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>E-mail :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="facultatif" id="e_mail_id" name="e_mail" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>

