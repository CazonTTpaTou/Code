<?php
//$_SESSION['Operation']=0;
$_SESSION['Message']='';

$_SESSION['URL']='';
$_SESSION['Lien']='Statistiques';
$_SESSION['Adresse']='Intro.php?Operation=58&Client=';

print '<div class="princ">';

	print'<span class="libelle">';
	print '<a href="Intro.php?Operation=57&Stats=clients&Fournisseur=0" >';
	print '<input type="button" value="Classement hors pros" />';
	print '</a>';
	//print'</span>';

	//print'<span class="libelle">';
	print '<a href="Intro.php?Operation=57&Stats=clients&Fournisseur=1" >';
	print '<input type="button" value="Classement global" />';
	print '</a>';
	print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

//print '<form onsubmit="return client(this);" method="POST">';

print'<span class="libelle">';
print '<label>Nom du client :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Client" id="champC" value="inconnu" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Code Postal :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Code_Postal" id="champP" value="inconnu" maxlength=5  onkeypress="return numbers(event);" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Département :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Departement','departement','NO','numero','departement','','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="button" name="valid" value="Rechercher" onClick="client();" />';
print'</span>';

print '<br/>';
print '<br/>';
print '<br/>';
print '</div>';


print '<div id="Liste_C" class="ListeC" >';
print'</div>';

?>