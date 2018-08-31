<?php
//$_SESSION['Operation']=0;
$_SESSION['Message']='';

if(($_SESSION['Operation']==21) || ($_GET['Operation']==21)) {$_SESSION['Lien']='Modifier';
			                                      $_SESSION['Adresse']='Intro.php?Operation=14&Modification=1&Livre=';}

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';


print'<span class="champs">';
print'<input type="button" name="valid" value="Rechercher" onClick="livre();" />';
print'</span>';
print '<br/>';
print '<br/>';


//print '<form onsubmit="return commande(this);" method="POST">';

print'<span class="libelle">';
print '<label>ISBN :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Client" id="C_client" value="inconnu"  onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prix du livre :</label>';
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
print '<label>Titre :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="D_deb" id="champD" value="inconnu" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';

print '<span class="libelle">';
print '<label>Auteur :</label>';
print '</span>';
print '<span class="champs">';
print '<input type="text" name="D_fin" id="champF" value="inconnu"  onFocus="eff(this.id);" / >';
print '</span>';
print '<br/>';
print '<br/>';

print '<br/>';
print '<br/>';
print '<br/>';
print '</div>';


print '<div id="Liste_C" class="ListeC" >';
print'</div>';

?>