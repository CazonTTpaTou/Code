<?php

$_SESSION['Adresse']='Intro.php?Operation=32&Livraison=';
$_SESSION['Lien']='Modifier';

print'<div class="princ">';

$req0="select l.numero_com,l.date,l.catalogue,c.nom,c.ville from livraison as l,clients as c where l.numero_client=c.numero;"; 

//echo $req0;
$success=mysql_query($req0,$connectID) or die ("impossible d'accéder aux données9");

mysql_close($connectID);
$ligne=0;
$last="";
$Code[]="<h1> Liste des livraisons : </h1>";
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

foreach($Code as $value) {echo $value;}

print'</div>';

?>
