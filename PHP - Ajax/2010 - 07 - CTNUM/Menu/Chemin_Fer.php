<?php

$_SESSION['Nb_pages']=$_GET['Page'];
$ligne=$_GET['Page'];
$i=1;
//$connectID=Connexion();

print '<div class="princ_livre" >';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=26&Catalogue='.$_GET['Catalogue'].'" method="POST">';

print'<span class="libelle">';
print '<label>Structure de la pagination du catalogue n° '.$_GET['Catalogue'].' :</label>';
print'</span>';
print'<br/>';
print'<br/>';

while($i<=$ligne) {

$nom='Cat'.$i;
print'<span class="libelle">';
print '<label>Nombre de livres sur la page n° '.$i.'</label>';
print'</span>';

print'<span class="champs">';
print '<input type="text" id="nom_id" value="" onkeypress="numbers(event);" name="'.$nom.'" / >';
print'</span>';

print'<br/>';
print'<br/>';
$i++;}

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer Catalogue"  />';
print'</span>';

print'</form>';
print'</div>';

?>