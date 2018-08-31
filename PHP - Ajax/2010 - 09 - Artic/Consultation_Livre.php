<?php

$connectID=Connexion();

print '<div class="princ_livre">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au Menu principal" />';
print '</a>';

print '<a href="Intro.php?Operation=23" >';
print '<input type="button" value="Retour à la recherche" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<h1>Fiche Produit du livre n°'.$_GET['Livre'].'</h1>';
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Caractéristiques du livre : </label></span>';
print '<br/>';
print '<br/>';

$req="select isbn,titre,sous_titre,pages,editeur,stock,nb_livre as ventes from livres where numero=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID);

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	foreach($row as $key => $value) {
		if($value=='') {$value='Non renseigné';}
		print'<span class="libelle"><label>'.$key.' : '.$value.'</label></span><br/><br/>';}}

$req="select image from livres where numero=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID);

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	if($row['image']!='') {print'<img  alt="image livre" src="Image/'.$row['image'].'" />';}
		else {print'<span class="libelle"><label>Pas d\'image disponible</label></span><br/><br/>';}}

print '---------------------------------------------------------------------------------------------------------------';
print '<br/>';
print '<span class="libelle">';
print '<label>Auteurs du livre : </label></span>';
print '<br/>';
print '<br/>';

$req="select * from auteurs where id_auteur in (select id_auteur from liv_aut where id_livre=".$_GET['Livre'].") ; ";
$success=mysql_query($req,$connectID);

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	foreach($row as $key => $value) {
		$imprim=1;
		if(($key=='photo') && ($value!='')) {print'<img  alt="image auteur" src="Image/'.$value.'" />';$imprim=0;}
		if($value=='') {$value='Non renseigné';}
		if($key=='biographie') {print'<span class="libelle"><label>'.$key.': </label><br/><textarea cols="100" rows="5" >'.$value.'</textarea></span><br/><br/>';$imprim=0;}
		if($imprim==1) {print'<span class="libelle"><label>'.$key.' : '.$value.'</label></span><br/><br/>';}}

print '---------------------------------------------------------------------------------------------------------------';
print '<br/>';
print '<br/>';}
		
print '<span class="libelle">';
print '<label>Historique des prix : </label></span>';
print '<br/>';
print '<br/>';

$req="select * from prix where id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID);
$p=0;
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$p++;
	print'<span class="libelle"><label>Prix n° '.$p.' : '.$row['prix'].' € </label></span><br/>';
	print'<span class="libelle"><label>Date de début d\'application du prix : '.$row['d_begin'].'</label></span><br/>';
	if($row['d_end']=='2100-07-01') {$fin='Prix en cours d\'aplication';} else {$fin=$row['d_end'];}
	print'<span class="libelle"><label>Date de fin d\'application du prix : '.$fin.'</label></span><br/>';
	print '<br/><br/>';}
			
print '---------------------------------------------------------------------------------------------------------------';
print'<br/><br/>';
print '<span class="libelle">';
print '<label>Commentaires associés au livre : </label></span>';
print '<br/>';
print '<br/>';

$req="select ru.titre as rubrique,co.commentaire as resume  from commentaires as co,rubrique as ru where co.id_cat=ru.num and co.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID);

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print'<span class="libelle"><label>Commentaires de la rubrique '.$row['rubrique'].' : </label></span><br/>';
	print'<span class="libelle"><textarea cols="100" rows="5" >'.$row['resume'].'</textarea></span><br/>';
	print '<br/><br/>';}

print '---------------------------------------------------------------------------------------------------------------';
print'<br/><br/>';
print '<span class="libelle">';
print '<label>Classifications du livre : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle"><label>Période: ';

$req="select pe.titre from liv_periode as li,periode as pe where li.id_cat=pe.num and li.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print $row['titre'].' - ';}

print'</label></span><br/><br/>';

print'<span class="libelle"><label>Sujet: ';

$req="select pe.titre from liv_sujet as li,sujet as pe where li.id_cat=pe.num and li.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print $row['titre'].' - ';}

print'</label></span><br/><br/>';

print'<span class="libelle"><label>Lieu: ';

$req="select pe.titre from liv_lieu as li,lieu as pe where li.id_cat=pe.num and li.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print $row['titre'].' - ';}

print'</label></span><br/><br/>';

print'<span class="libelle"><label>Genre: ';

$req="select pe.titre from liv_genre as li,genre as pe where li.id_cat=pe.num and li.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print $row['titre'].' - ';}

print'</label></span><br/><br/>';

print'<span class="libelle"><label>Rubrique: ';

$req="select pe.titre from liv_rubrique as li,rubrique as pe where li.id_cat=pe.num and li.id_livre=".$_GET['Livre']." ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	print $row['titre'].' - ';}

print'</label></span><br/><br/>';

print '</div>';

mysql_close($connectID);

?>