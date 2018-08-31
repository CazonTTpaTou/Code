<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=54" >';
print '<input type="button" value="Dédoublonnage de fichiers" />';
print '</a>';
//print'</span>';

//print'<span class="champs">';
print '<a href="Intro.php?Operation=53" >';
print '<input type="button" value="Choisir un fichier d\'export existant" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=30" method="POST">';

print'<span class="libelle">';
print '<label>Création d\'un fichier de routage :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nombre d\'adresses du fichier:</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Nb_pages" value="" onkeypress="numbers(event);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Exclure les prospects :</label>';
print '</span>';
print '<span class="champs">';
print '<input type=radio name="excl" value="1" >OUI';
print '<input type=radio name="excl" value="2" Checked >NON';
print '</span>';
print '<br/>';

print '<span class="libelle">';
print '<label>Inclure les clients :</label>';
print '</span>';
print '<span class="champs">';
print '<input type=radio name="client" value="1" Checked >OUI';
print '<input type=radio name="client" value="2" >NON';
print '</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Intégrer les nouveaux prospects :</label>';
print'</span>';
print'<span class="champs">';
print '<input type=radio name="prospect" value="1" Checked >OUI';
print '<input type=radio name="prospect" value="2" >NON';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Activer le dédoublonnages :</label>';
print'</span>';
print'<span class="champs">';
print '<input type=radio name="doublon" value="1" Checked >OUI';
print '<input type=radio name="doublon" value="2" >NON';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Exclure les adresses NPAI :</label>';
print'</span>';
print'<span class="champs">';
print '<input type=radio name="npai" value="1" Checked >OUI';
print '<input type=radio name="npai" value="2" >NON';
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Choisir les fichiers de prospection:</label>';
print '</span>';
print '<br/>';
print '<span class="libelle">';
$req="select distinct fichiers from clients where fichiers not like'prospect%' and fichiers not like 'nouveau%' and fichiers is not null;"; 
$saisie[]='NO';
cocher_R($req,'Fichier[]','clients','fichiers','fichiers',$saisie);
print '</span>';
//print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Catalogue associé :</label>';
print'</span>';
print'<br/>';
print'<span class="libelle">';
Extraction('Catalogue','catalogue','NO','num_cat','nom','','');
print'</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Créer le fichier"  />';
print'</span>';

print'</form>';
print'</div>';

?>