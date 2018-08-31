<?php
$ligne=0;
$connectID=Connexion();
$_SESSION['N_Lig_com']=0;
$ret=0;

if(isset($_GET['Avoir'])) {$operateur='<';
			   $form='&Avoir=1';}
	else {$operateur='>=';
	      $form='';}

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<label>Commandes potentiellement expédiables immédiatement :</label>';
print'</span>';
print'<br/>';
print'<br/>';

$ligne=0;
$connectID=Connexion();

$req1="select co.numero_com as numero,cl.nom as nom,cl.ville as ville,co.date as date,sum(lig.quantite) as nb_livre,";
$req1.="(sum(lig.quantite*price.prix)+port) as total,(DATEDIFF(curdate(),co.date)) as Retard ";
$req1.=" from commande as co inner join ligne_commande as lig on co.numero_com=lig.numero_com ";
$req1.="inner join livres as li on lig.numero_livre=li.numero inner join prix as price on li.numero=price.id_livre ";
$req1.=" inner join clients as cl on co.numero_client=cl.numero ";
$req1.="where li.stock>=0 and co.date>=price.d_begin and co.date<=price.d_end and lig.quantite".$operateur."0 ";
$req1.="and co.date>'2010-07-01' and co.numero_com not in (select ex.numero_co from expedition as ex) ";
$req1.="group by co.numero_com order by co.date asc ;";

//echo $req1;
$success=mysql_query($req1,$connectID) or die("Impossible d'accéder aux données");

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=24'.$form.'" method="POST">';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Expédier les commandes sélectionnées"/>';
print '<a href="Intro.php?Operation=40&Avoir=1" >';
print '<input type="button" value="Avoirs expédiables" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=42" >';
print '<input type="button" value="Optimisation des envois" />';
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
		$Code[]='<td class="entete">Expédier</td>';
		//$Code[]='<td></td>';
		$Code[]='</tr>';}

		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $key => $value) {
				if($colonne==0) {$identifiant=$value;}
		         	if($key=='Retard') {if($value>1) {$j='s';} else {$j='';}
						    if($value>=30) {$ret++;}
						    $Code[]='<td'.$couleur.'>'.$value.' jour'.$j.'</td>';}

					else {$Code[]='<td'.$couleur.'>'.$value.'</td>';}

			         ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau

if($value>=30) {$couleurs=' class="fond3" ';} else {$couleurs=$couleur;}

$Code[]= '<td'.$couleurs.'><input type="Checkbox" name="'.$prodict.'" value="Exp" / ></td>';
$Code[]= '<input type="hidden" name="'.$product.'" value="'.$identifiant.'" / >';

$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$_SESSION['N_Lig_com']=$ligne-1;

if($ret==0) {$reta=' - Pas de commande dépassant le mois de retard';}
	else{if($ret==1) {$r='';} else {$r='s';}
	     $reta=' - dont '.$ret.' commande'.$r.' dépassant le mois de retard...';} 

if ($ligne==0) {$Code[]='Aucune commande n\'est en attente actuellement...'.$phrase;}
	else {
		if($ligne>1) {$s='s';} else {$s='';}
		$Code[0]='<p>Résultat: '.$ligne.' commande'.$s.' trouvée'.$s.$reta.' </p>';}

foreach($Code as $value) {echo $value;}

print '</form>';
print '</div>';

mysql_close($connectID);

?>