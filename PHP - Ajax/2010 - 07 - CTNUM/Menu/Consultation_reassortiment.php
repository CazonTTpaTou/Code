<?php

$_SESSION['Lien']='Consulter';
$Adresse='PDF_tab.php?Reassortiment=';
$Adresse_M='PDF_tab.php?Mail=1&Reassortiment=';

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

$connectID=Connexion();

$req="select r.numero,f.nom,r.date,l.nom as livraison,r.etat from reassortiment as r inner join clients as f on r.fournisseur=f.numero inner join ad_livraison as l on l.numero_l=r.livraison order by r.numero desc;";
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
if($row['etat']== 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">PDF</td>';
		$Code[]='<td class="entete">E-mail</td>';}
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
	foreach($row as $key => $value) {if($colonne==0) {$identifiant=$value;}
			if($key!='etat') {$value=$value;}
				else {switch($value) {case '0':$value='En attente';break;
						      case '1':$value='Demande envoy�e';break;
						      case '2':$value='R�assortiment sold�';break;}}
			 $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.'><a href="'.$Adresse.$identifiant.'" target="_blank" >G�n�rer PDF</a></td>';
$Code[]='<td'.$couleur.'><a href="'.$Adresse_M.$identifiant.'" target="_blank" >Envoyer Mail</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donn�e ne correspond � votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>R�sultat: '.$ligne.' proposition'.$s.' trouv�e'.$s.' : </p>';
	}
//------- On �dite la succession de commandes html du tableau tri� que nous avons stock� dans le tableau code, 
//------- pour qu'elle soient lisible par la m�thode responseText et ex�cutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

print'</div>';

?>