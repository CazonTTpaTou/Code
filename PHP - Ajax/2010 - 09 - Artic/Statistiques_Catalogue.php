<?php

//$_SESSION['Operation']=0;
$_SESSION['Message']='';

print '<div class="princ">';

	print'<span class="libelle">';
	print '<a href="Intro.php?Operation=57&Stats=catalogues&Fournisseur=0" >';
	print '<input type="button" value="Classement hors pros" />';
	print '</a>';
	//print'</span>';

	//print'<span class="libelle">';
	print '<a href="Intro.php?Operation=57&Stats=catalogues&Fournisseur=1" >';
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

print'<span class="libelle">';
print '<label>Choix du catalogue à analyser : </label>';
print'</span>';
print '<br/>';
print '<br/>';

$req0='select * from catalogue;';
$success=mysql_query($req0,$connectID) or die ("Impossible d'accéder aux données");

print '<ul>';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	print'<li><a href="'.$_SESSION['Adresse'].$row['num_cat'].'" >'.$row['num_cat'].' - '.$row['nom'].' du '.$row['date_debut'].' au '.$row['date_fin'].'</a></li>';
	}
print '</ul>';
					
print'</div>';

?>