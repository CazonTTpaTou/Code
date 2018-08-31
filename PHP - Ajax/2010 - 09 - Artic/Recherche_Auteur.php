<?php
//$_SESSION['Operation']=0;
$_SESSION['Message']='';

if(($_SESSION['Operation']==20) || ($_GET['Operation']==20)) {$_SESSION['Lien']='Modifier';
			                                      $_SESSION['Adresse']='Intro.php?Operation=19&Auteur=';}


print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print'<input type="button" name="valid" value="Rechercher" onClick="auteur();" />';
print'</span>';
print '<br/>';
print '<br/>';

//print '<form onsubmit="return commande(this);" method="POST">';

print'<span class="libelle">';
print '<label>Nom Auteur :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Client" id="C_client" value="inconnu"  onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prénom Auteur :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="N_Com" id="champP" value="inconnu"  value="inconnu"  onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Période de vie de l\'auteur - </label>';
print'</span>';

print'<span class="libelle">';
print '<label>Intervalle des dates de recherche :</label>';
print'<br/>';
print'<br/>';
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