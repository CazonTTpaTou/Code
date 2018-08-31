<?php

$requ3="select id_livre,auteur,titre,prix/1.055 as prix_ht,quant from com where id_commande=".$number." and quant<>0 ;";
$connectID=Connexion();
$selection = mysql_query($requ3,$connectID) or die ("Impossible accéder aux données");

//----- Section logique de style qui positionne le tableau listé retourné par la requête
print'<div class="tableau">';
print '<table id="tableau" border=3px  cellpadding=2px width=100% font-size:20px bordercolor="#000000" align="middle" >';


//----- la variable ligne nous permettra de n'éditer qu'une seule fois le nom des champs en en tête
$ligne=1;

//---- la variable colonne nous permettra d'enregistrer la valeur de l'identifiant qui éditer le lien à chaque début de ligne
$colonne=0;

while($rows = mysql_fetch_array($selection,MYSQL_ASSOC)) {

if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//----- s'il s'agit de la première ligne, on édite les entêtes de colonne
//----- On rajoute une fonction javascript tri() sur clic de l'en tête qui change la clé de tri du tableau
//----- et qui permettra de trier le tableau, sans à avoir recharger la page
if ($ligne==1) {print'<tr font-weight:bold >';
		print'<th>N° Ligne</th>';
		foreach($rows as $key => $value) {print'<th font-weight:bold >'.$key.'</th>';}
		print'<th>Sous total</th>';
		print'</tr>';}	

	$colonne=0;

	//----- en cas de changement de valeur sur la clé tri, on insère des lignes de séparation dans le tableau

	//----- début de la ligne du tableau
	print'<tr>';
	print'<td'.$couleur.'>'.$ligne.'</td>';

	//----- on édite chaque valeur de champ de la ligne de requête dans une cellule séparée du tableau	
	foreach($rows as $key => $value) {

			//----- si on se trouve en début de ligne, on enregistre la valeur dans la variable identifiant	
			if($colonne==3) {print'<td'.$couleur.'>'.sprintf('%.2f',$value).'</td>';}
				else {print'<td'.$couleur.'>'.$value.'</td>';}
			++$colonne;
			if($colonne==5) {$sous_tot=$rows['quant']*round($rows['prix_ht'],2);
					 print'<td'.$couleur.'>';
					 echo sprintf('%.2f',$sous_tot);
					 echo '</td>';}}
		
	//----- fin de la ligne du tableau
	print'</tr>';
	++$ligne;
	}

//------ rajout des frais de port
$requ4="select port from commande where numero_com=".$_GET['id'].";";
Requete($requ4);
if (($_SESSION['port']!=0) && ($nombre!=0)) {if($ligne%2 == 0) {$couleur=' class="fond1" ';}
				else {$couleur=' class="fond2" ';}
			 	print'<td'.$couleur.'>'.$ligne.'</td>';
				print'<td'.$couleur.'>-</td>';
				print'<td'.$couleur.'>Frais de Port</td>';
				$nombr=abs($nombre);
				print'<td'.$couleur.'>Envoi de '.$nombr.' livre';
				if($nombr>1) {print's';}
				print'<td'.$couleur.'>'.sprintf('%.2f',$_SESSION['port']/1.055).'</td>';
				print'<td'.$couleur.'>1</td>';
				print'<td'.$couleur.'>'.sprintf('%.2f',$_SESSION['port']/1.055).'</td>';
				$ligne++;}

//------ rajout des lignes vierges
$rest= max(20-$ligne,0);

while($rest>=0) {
print'<tr>';
$i=0;	

if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}
	
while($i<=6) {	
	if($i==0) {print'<td'.$couleur.'>'.$ligne.'</td>';}
		else {print'<td '.$couleur.'></td>';}
	$i++;}
print '</tr>';
$rest=$rest-1;
$ligne++;}
	

//----- fin du tableau listé
print'</table>';
print'</div>';

?>

