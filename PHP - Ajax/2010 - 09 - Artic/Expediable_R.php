<?php

$i=0;
$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}
//$Code[]='';
$exp='(';
$couleur=' class="fond2" ';

if(isset($_GET['Avoir'])) {$operateur='<';
			   $form='&Avoir=1';}
	else {$operateur='>=';
	      $form='';}

$connectID=Connexion();

$ligne_sup=$_SESSION['N_Lig_com'];

	while($i<=$ligne_sup) {

		$a='P_num_'.$i;
		$b='P_nim_'.$i;

		if(isset($_POST[$b])) {
			if(($_POST[$a]!='') && ($_POST[$b]=="Exp")) {
					
				$Codes[]=$_POST[$a];
				$requete='INSERT INTO expedition (numero_co,date) values(';
				$requete.=$_POST[$a].",'".$date."');";
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

foreach($Codes as $value) {$exp.=$value.',';}
$exp.='0)';
$_SESSION['expedition']=$exp;

$req1="select co.numero_com as numero,cl.nom as nom,cl.ville as ville,co.date as date,sum(lig.quantite) as nb_livre,";
$req1.="(sum(lig.quantite*price.prix)+port) as total,(curdate()) as Date_exp ";
$req1.=" from commande as co inner join ligne_commande as lig on co.numero_com=lig.numero_com ";
$req1.="inner join livres as li on lig.numero_livre=li.numero inner join prix as price on li.numero=price.id_livre ";
$req1.=" inner join clients as cl on co.numero_client=cl.numero ";
$req1.="where li.stock>=0 and co.date>=price.d_begin and co.date<=price.d_end and lig.quantite".$operateur."0 ";
$req1.="and co.date>'2010-07-01' and co.numero_com in ".$exp;
$req1.=" group by co.numero_com order by co.date asc ;";

//echo $req1;
$success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données");

print '<div class="princ_livre" >';

print'<span class="libelle">';
//print '<a href="PDF_exp_com.php" target="_blank" >';
print '<input type="button" value="Générer le PDF des adresses" id="PDF_exp_com.php" onclick="window.open(this.id);"/>';
//print '</a>';
print'</span>';

print'<span class="libelle">';
//print '<a href="PDF_exp_quant.php" target="_blank" >';
print '<input type="button" value="Générer le PDF des livres" id="PDF_exp_quant.php" onclick="window.open(this.id);" />';
//print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu"  />';
print '</a>';
print'</span>';

print'<br/>';
print'<br/>';

$ligne=0;
$Code[]='';
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

	while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
		$product='Fact_Edition_print.php?id=';
		$prodict='P_nim_'.$ligne;
		$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
//if($ligne%2 == 0) {$couleur=' class="fond1" ';}
//	     else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {$Code[]='<tr>';
		foreach($row as $key => $value) {
		$Code[]='<td id="'.$key.'" class="entete">'.$key.'</td>';}
		$Code[]='<td class="entete">Impression</td>';
		//$Code[]='<td></td>';
		$Code[]='</tr>';}

		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
	foreach($row as $key => $value) {
				if($colonne==0) {$identifiant=$value;}
		         
				$Code[]='<td'.$couleur.'>'.$value.'</td>';

			         ++$colonne;}

$Code[]='<td><input type="button" value="Imprimer" id="Fact_Edition_print.php?id='.$identifiant.'" onclick="clustre(this.id);" /></td>';

$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';

if ($ligne==0) {$Code[]='Aucune commande n\'est en instance d\'expédition actuellement...';}
	else {
		if($ligne>1) {$s='s';} else {$s='';}
		$Code[0]='<p>Résultat: '.$ligne.' commande'.$s.' en instance d\'expédition'.$s.' </p>';}

foreach($Code as $value) {echo $value;}

$_SESSION['Message']='L\' expédition des commandes a bien été enregistrée !!!';

mysql_close($connectID);

$adresse='Intro.php?Operation=0';
//header('Location: '.$adresse);

?>