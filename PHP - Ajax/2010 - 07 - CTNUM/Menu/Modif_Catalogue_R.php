<?php
$connectID=Connexion();
$ligne=0;

$num=$_POST['Catalogue'];
$form='&Catalogue='.$num;

$req="select distinct num_page as Numero_Page from chemin_fer_livre where num_cat=".$num.";";

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

print '<div class="princ_livre" >';

//echo $req;

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=29'.$form.'" method="POST">';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Accéder à la page sélectionnée"/>';
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

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {$Code[]='<tr>';
		foreach($row as $key => $value) {
		$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">Sélectionner la page</td>';
		//$Code[]='<td></td>';
		$Code[]='</tr>';}

		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $key => $value) {
				if($colonne==0) {$identifiant=$value;}

				$Code[]='<td'.$couleur.'>'.$value.'</td>';

			         ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
if($ligne==1) {$etat1="checked";} else {$etat1="";}

$Code[]= '<td'.$couleur.'><input type=radio name="page_cat" value="'.$identifiant.'" '.$etat1.' >Page n° '.$identifiant.'</td>';

$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
//$_SESSION['N_Lig_com']=$ligne-1;

if ($ligne==0) {$Code[]='Le catalogue sélectionné est vide !!!';}
	else {
		if($ligne>1) {$s='s';} else {$s='';}
		$Code[0]='<p>Résultat: '.$ligne.' page'.$s.' trouvée'.$s.' pour ce catalogue </p>';}

foreach($Code as $value) {echo $value;}

print '</form>';
print '</div>';

mysql_close($connectID);

?>
