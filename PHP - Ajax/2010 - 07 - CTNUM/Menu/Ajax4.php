<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

if($_POST['Client']!='inconnu') {$clause.="and nom like '".$_POST['Client']."%' ";}
if($_POST['Postal']!='inconnu') {$clause.="and code_Postal like '".$_POST['Postal']."%' ";}
if($_POST['Departement']!='') {$clause.="and left(code_postal,2)=".$_POST['Departement']." ";}
if($_POST['Ordre']!='inconnu') {$clause.=" order by ".$_POST['Ordre']." ";}

if(($_POST['Client']=='inconnu')&& ($_POST['Postal']=='inconnu')&&($_POST['Departement']=='')) 
	{echo '<p>Veuillez choisir au moins un paramètre de sélection !!!</p>';}

else{
$sq="select numero,nom,prenom,adresse_2,code_postal,ville from clients where numero>0 ".$clause." ;";

//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$last="";
$Code[]="<p> Liste des propositions (cliquer sur l'en tête de colonne pour trier): </p/>";
//$Code[]="<br/>";
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="client(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Opération</td>';}

//------- Si il y a un changement de valeur sur la colonne de tri, on insère deux lignes de séparation
//if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
//------- On doit faire attention de bien saisir le nom de la page qui édite le tableau avant son tri, dans le lien
//------- car si on fait appel à la variable serveur Php _self, le lien renverra à cette page qui sert uniquement de tampon
//------- pour l'objet XmlHttpRequest, appelée par la fonction javascript
$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.$_SESSION['URL'].'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donnée ne correspond à votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>Résultat: '.$ligne.' proposition'.$s.' trouvée'.$s.' (cliquer sur l\'en tête de colonne pour trier): </p>';
	}
//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}}

?>