<?php

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=26&Livre=';

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=30" >';
print '<input type="button" value="R�assortiment" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

$req="select numero,isbn,titre,sous_titre,editeur,prix,stock from livres order by stock asc;";
//echo $req;
$success=mysql_query($req,$connectID) or die ("impossible d'acc�der aux donn�es9");

mysql_close($connectID);
$ligne=0;
$last="";
$Code[]="<h1> Liste des propositions (cliquer sur l'en t�te de colonne pour trier): </h1>";
$Code[]='<br/>';
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">Op�ration</td>';}
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
	foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donn�e ne correspond � votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>R�sultat: '.$ligne.' proposition'.$s.' trouv�e'.$s.' (cliquer sur l\'en t�te de colonne pour trier): </p>';
	}
//------- On �dite la succession de commandes html du tableau tri� que nous avons stock� dans le tableau code, 
//------- pour qu'elle soient lisible par la m�thode responseText et ex�cutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

print'</div>';

?>