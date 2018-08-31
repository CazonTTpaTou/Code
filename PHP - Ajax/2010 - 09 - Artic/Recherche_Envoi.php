<?php
//$_SESSION['Operation']=0;
$_SESSION['Message']='';

$_SESSION['Lien']='Annuler';
$_SESSION['Adresse']='Intro.php?Operation=45&Expedition=';

print '<div class="princ">';

print'<span class="libelle">';
print'<input type="button" name="valid" value="Rechercher" onClick="expedition();" />';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
//print '<a href="Intro.php?Operation=45" >';
//print '<input type="button" value="Recherche détaillée d\'une commande" />';
//print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

//print '<form onsubmit="return commande(this);" method="POST">';

print'<span class="libelle">';
print '<label>Numéro Commande :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Client" id="C_commande" value="inconnu" onkeypress="return numbers(event);" onBlur="num_co();" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Montant Commande :</label>';
print'</span>';
print'<span class="champs">';

print'<select name="Operateur" id="Operateur_id" size ="1">';
	print'<option value="1" >=</option>';
	print'<option value="2" >></option>';
	print'<option value="3" ><</option>';
	print'<option value="4" >>=</option>';
	print'<option value="5" ><=</option>';
	print'</select>';

print '<input type="text" name="N_Com" id="champP" value="inconnu" onkeypress="return numbers(event);"  onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Intervalle des dates d\'expédition :</label>';
print'<br/>';
//print'<br/>';
print'</span>';
print'<span class="libelle">';
print '<label>Date  début :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="D_deb" id="champD" value="inconnu" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" onFocus="eff(this.id);" / >';
print '<label> - Format de date: aaaa-mm-jj</label>';
print'</span>';
print '<br/>';

print '<span class="libelle">';
print '<label>Date de fin   :</label>';
print '</span>';
print '<span class="champs">';
print '<input type="text" name="D_fin" id="champF" value="inconnu" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" onFocus="eff(this.id);" / >';
print '<label> - Format de date: aaaa-mm-jj</label>';
print '</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
//print'<input type="button" name="valids" value="Rechercher" />';
print'</span>';

print '<br/>';
print '<br/>';
print '<br/>';
print '</div>';


print '<div id="Liste_C" class="ListeC" >';
print'</div>';

?>