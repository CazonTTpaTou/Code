<?php
$connectID=Connexion();
$ligne=0;

$num=$_POST['Catalogue'];
$form='&Catalogue='.$num;

$req="select distinct num_page as Numero_Page from chemin_fer_livre where num_cat=".$num.";";

$success=mysql_query($req,$connectID) or die ("Impossible d'acc�der aux donn�es");

print '<div class="princ_livre" >';

//echo $req;

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=29'.$form.'" method="POST">';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Acc�der � la page s�lectionn�e"/>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

$Code[]='';
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

	while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
		$product='P_num_'.$ligne;
		$prodict='P_nim_'.$ligne;
		$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	     else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {$Code[]='<tr>';
		foreach($row as $key => $value) {
		$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">S�lectionner la page</td>';
		//$Code[]='<td></td>';
		$Code[]='</tr>';}

		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
	foreach($row as $key => $value) {
				if($colonne==0) {$identifiant=$value;}

				$Code[]='<td'.$couleur.'>'.$value.'</td>';

			         ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
if($ligne==1) {$etat1="checked";} else {$etat1="";}

$Code[]= '<td'.$couleur.'><input type=radio name="page_cat" value="'.$identifiant.'" '.$etat1.' >Page n� '.$identifiant.'</td>';

$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
//$_SESSION['N_Lig_com']=$ligne-1;

if ($ligne==0) {$Code[]='Le catalogue s�lectionn� est vide !!!';}
	else {
		if($ligne>1) {$s='s';} else {$s='';}
		$Code[0]='<p>R�sultat: '.$ligne.' page'.$s.' trouv�e'.$s.' pour ce catalogue </p>';}

foreach($Code as $value) {echo $value;}

print '</form>';
print '</div>';

mysql_close($connectID);

?>
