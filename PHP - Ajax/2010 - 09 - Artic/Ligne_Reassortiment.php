<?php
$ligne=0;

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<label>Réassortiment fournisseur :</label>';
print'</span>';
print'<br/>';
print'<br/>';

$ligne=0;
$connectID=Connexion();
$req1="select numero,isbn,titre,stock,0 as stock_virtuel,stock as stock_virtuel from livres as li,four_edit as fo where fo.num_four=".$_GET['Fournisseur']." and fo.nom_edit=li.editeur and li.numero not in (select numero_livre from ligne_reassortiment) order by stock_virtuel asc ";
//$req1="select numero,isbn,titre,stock,0,stock as stock_virtuel from livres as li,four_edit as fo where fo.num_four=".$_GET['Fournisseur']." and fo.nom_edit=li.editeur order by stock_virtuel asc ";
$req0="select li.numero,li.isbn,li.titre,li.stock as stock_reel,sum(lr.quantite) as reassort_en_cours,(li.stock+sum(lr.quantite)) as stock_virtuel from livres as li inner join ligne_reassortiment as lr on lr.numero_livre=li.numero inner join reassortiment as rea on rea.numero=lr.numero_com  inner join four_edit as fo on fo.num_four=rea.fournisseur where fo.num_four=".$_GET['Fournisseur']." and rea.etat<2 group by li.numero  ";
$req=$req0." union ".$req1." ; ";
//echo $req;
$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=18&Reassortiment='.$_GET['Reassortiment'].'" method="POST">';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Enregistrer la demande de réassortiment"/>';
print'</span>';
print'<br/>';
print'<br/>';

print '<table id="tableau" border=1px  cellpadding=2px >';

	while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
		$product='P_num_'.$ligne;
		$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	     else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {
		if($key!='numero') {$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}}
		$Code[]='<td class="entete">Quantité</td>';}
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         		else {$Code[]='<td'.$couleur.'>'.$value.'</td>';}
			         ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.'><input type="text" value="quantité" id="quant_id'.$ligne.'" name="quantite'.$ligne.'" onBlur="coloriage(this.id);" onkeypress="return numbers(event);" onFocus="eff(this.id);"/ ></td>';
$Code[]='<input type="hidden" name="'.$product.'" value="'.$identifiant.'" / >';

$Code[]='</tr>';

++$ligne;}

$Code[]= '</table>';
$_SESSION['N_Lig_rea']=$ligne-1;

foreach($Code as $value) {echo $value;}

print '</form>';
print '</div>';
		

?>		