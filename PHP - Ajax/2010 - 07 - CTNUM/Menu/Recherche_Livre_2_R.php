<?php

$per[]='';
$suj[]='';
$lie[]='';
$gen[]='';
$rub[]='';

$connectID=Connexion();

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=26&Livre=';

print '<div class="princ" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=22" >';
print '<input type="button" value="Retour à la page de recherche" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

if(isset($_POST['Periode'])) {$per=$_POST['Periode'];}
$clause_P='';
foreach($per as $value) {if($value!='') {$clause_P.=$_POST['Operande_P']." liv_periode.id_cat=".$value." ";}}
if($clause_P!='') {$clause_P=" UNION SELECT id_livre from liv_periode where id_livre>0 ".$clause_P;}

if(isset($_POST['Sujet'])) {$suj=$_POST['Sujet'];}
$clause_S='';
foreach($suj as $value) {if($value!='') {$clause_S.=$_POST['Operande_S']." liv_sujet.id_cat=".$value." ";}}
if($clause_S!='') {$clause_S=" UNION SELECT id_livre from liv_sujet where id_livre>0 ".$clause_S;}

if(isset($_POST['Lieu'])) {$lie=$_POST['Lieu'];}
$clause_L='';
foreach($lie as $value) {if($value!='') {$clause_L.=$_POST['Operande_L']." liv_lieu.id_cat=".$value." ";}}
if($clause_L!='') {$clause_L=" UNION SELECT id_livre from liv_lieu where id_livre>0 ".$clause_L;}

if(isset($_POST['Genre'])) {$gen=$_POST['Genre'];}
$clause_G='';
foreach($gen as $value) {if($value!='') {$clause_G.=$_POST['Operande_G']." liv_genre.id_cat=".$value." ";}}
if($clause_G!='') {$clause_G=" UNION SELECT id_livre from liv_genre where id_livre>0 ".$clause_G;}

if(isset($_POST['Rubrique'])) {$rub=$_POST['Rubrique'];}
$clause_R='';
foreach($rub as $value) {if($value!='') {$clause_R.=$_POST['Operande_R']." liv_rubrique.id_cat=".$value." ";}}
if($clause_R!='') {$clause_R=" UNION SELECT id_livre from liv_rubrique where id_livre>0 ".$clause_R;}

$clause_T=' order by '.$_POST['Tri'].' '.$_POST['Ordre'].' ';

if(($clause_P=='') && ($clause_S=='') && ($clause_L=='') && ($clause_G=='') && ($clause_R=='')) {echo 'Vous devez renseigner au moins un critère de recherche';} 

else {

$req1="select li.numero,li.isbn,group_concat(aut.auteur) as ecriv,li.titre,li.sous_titre,li.prix,li.editeur from livres as li,liv_aut as au,auteurs as aut where li.numero=au.id_livre and au.id_auteur=aut.id_auteur and li.numero ";
$req2="select id_livre from liv_periode where liv_periode.id_cat>0 ".$clause_P.$clause_S.$clause_L.$clause_G.$clause_R;
$req3=$req1." in (".$req2.") ".$clause_T." ;";
//echo $req3;

$success=mysql_query($req3,$connectID) or die ("impossible d'accéder aux données9");

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