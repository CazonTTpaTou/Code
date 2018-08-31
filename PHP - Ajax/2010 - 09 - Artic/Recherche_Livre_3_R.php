<?php

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=26&Livre=';

print '<div class="princ" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=24" >';
print '<input type="button" value="Retour à la page de recherche" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

$liste="'".trim(addslashes($_POST['Liste']))."'";



$req1="select distinct id_livre from mots_cles where match(mots) against(".$liste.") ";
$req2="select distinct id_livre from commentaires where match(commentaire) against(".$liste.") ";
$req3="select distinct id_livre from liv_aut where id_auteur in(select id_auteur from auteurs where match(biographie) against(".$liste.")) ";

$mot=$_POST['Mots'];
$i=0;
foreach($mot as $value) {$i+=$value;}
if($i==0) {echo 'Vous n\'avez rentré aucun critère de recherche. Recommencez !!! ';}

else {

switch($i) {
	case '1': $sql="(".$req1." ) ";break;
	case '2': $sql="(".$req2." ) ";break;
	case '3': $sql="(".$req1." UNION ".$req2." ) ";break;
	case '4': $sql="(".$req3." ) ";break;
	case '5': $sql="(".$req1." UNION ".$req3." ) ";break;
	case '6': $sql="(".$req2." UNION ".$req3." ) ";break;
	case '7': $sql="(".$req1." UNION ".$req2." UNION ".$req3." ) ";break;}

$req0="select li.numero,li.isbn,group_concat(aut.auteur) as ecriv,li.titre,li.sous_titre,li.prix,li.editeur from livres as li,liv_aut as au,auteurs as aut where li.numero=au.id_livre and au.id_auteur=aut.id_auteur and li.numero ";	

$req=$req0." in ".$sql." group by li.numero ;";
//echo $req;
$success=mysql_query($req,$connectID) or die ("impossible d'accéder aux données9");

mysql_close($connectID);
$ligne=0;
$last="";
$Code[]="<h1> Liste des propositions : </h1>";
$Code[]='<br/>';
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">Opération</td>';}
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donnée ne correspond à votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>Résultat: '.$ligne.' proposition'.$s.' trouvée'.$s.' </p>';
	}
//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}}

print'</div>';

?>