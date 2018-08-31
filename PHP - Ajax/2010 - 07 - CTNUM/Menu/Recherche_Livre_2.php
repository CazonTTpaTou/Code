<?php

			$periode[]='NO';
			$sujet[]='NO';
			$lieu[]='NO';
			$genre[]='NO';
			$rubrique[]='NO';

print '<div class="princ">';

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=13" method="POST">';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Lancer la recherche" />';
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<input type=radio name="operande_P" value="OR" >OU';
print '<input type=radio name="Operande_P" value="AND" Checked >ET';
print '<label> - Critère de recherche sur la période : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Periode[]','periode','num','titre',$periode);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<input type=radio name="operande_S" value="OR" >OU';
print '<input type=radio name="Operande_S" value="AND" Checked >ET';
print '<label> - Critère de recherche sur le sujet : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Sujet[]','sujet','num','titre',$sujet);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<input type=radio name="operande_L" value="OR" >OU';
print '<input type=radio name="Operande_L" value="AND" Checked >ET';
print '<label> - Critère de recherche sur le lieu : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Lieu[]','lieu','num','titre',$lieu);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<input type=radio name="operande_G" value="OR" >OU';
print '<input type=radio name="Operande_G" value="AND" Checked >ET';
print '<label> - Critère de recherche sur le genre : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Genre[]','genre','num','titre',$genre);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<input type=radio name="operande_R" value="OR" >OU';
print '<input type=radio name="Operande_R" value="AND" Checked >ET';
print '<label> - Critère de recherche sur la rubrique : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Rubrique[]','rubrique','num','titre',$rubrique);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Clé de tri à appliquer : </label>';
print '<input type=radio name="Ordre" value="desc" >Ordre décroissant';
print '<input type=radio name="Ordre" value="asc" checked >Ordre croissant';
print '</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type=radio name="Tri" value="li.isbn" >ISBN';
print '<input type=radio name="Tri" value="ecriv" checked >Auteur';
print '<input type=radio name="Tri" value="li.titre" >Titre';
print '<input type=radio name="Tri" value="li.prix" >Prix';
print '<input type=radio name="Tri" value="li.editeur" >Editeur';
print '</span>';
print '<br/>';
print '<br/>';

print '</form>';


print '</div>';

?>