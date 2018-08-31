<?php
$ligne=0;
$connectID=Connexion();
$_SESSION['N_Lig_com']=0;
$ret=0;
$value='';

$connectID=Connexion();
$i=0;

$req0="delete from stock_manquant;";
$success=mysql_query($req0,$connectID) or die ("Impossible d'accéder aux données1");

$req="select li.numero as numero,coalesce(sum(liv.quantite),0) as entree,coalesce(sum(co_ex.quantite),0) as sortie,";
$req.="(coalesce(sum(liv.quantite),0)-coalesce(sum(co_ex.quantite),0)) as real_stock from livres as li ";
$req.="left join ligne_livraison as liv on li.numero=liv.numero_livre left join (select co.numero_livre,co.quantite";
$req.=" from ligne_commande as co,expedition as exp where exp.numero_co=co.numero_com)";
$req.="as co_ex on co_ex.numero_livre=li.numero group by li.numero ;";

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
	$stock[0][$i]=$row['numero'];
	$stock[1][$i]=$row['entree'];
	$stock[2][$i]=$row['sortie'];
	$stock[3][$i]=$row['real_stock'];
	$i++;}

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données3");

$sql="select id_commande as numero,id_livre as isbn,quant as nb_livre,date ";
$sql.=" from com where quant>0 ";
$sql.="and id_commande not in (select ex.numero_co from expedition as ex) and date>'2010-01-01' ";
$sql.=" order by id_commande asc;";

//echo $sql;
$nb_livre=$i;
$i=0;

$success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données4");

while($row = mysql_fetch_array($success,MYSQL_ASSOC)) {
	$comm[0][$i]=$row['numero'];
	$comm[1][$i]=$row['isbn'];
	$comm[2][$i]=$row['nb_livre'];
	$comm[3][$i]=0;
	$i++;}
	
$nb_ligne_com=$i;
$i=0;

//echo 'Longueur : '.count($comm[0]);

while($i<count($comm[0])) {
	$indice=array_search($comm[1][$i],$stock[0]);
	//echo 'Indice :'.$comm[1][$i].' valeur : '.$indice.'livre '.$stock[0][$indice];
	$stock[3][$indice]-=$comm[2][$i];
	if($stock[3][$indice]<0) {$comm[3][$i]=-1;}
	$value.=',('.$comm[0][$i].','.$comm[1][$i].','.$comm[2][$i].','.$comm[3][$i].')';
	$i++;}

$value[0]=' ';
$value.=' ; ';
$rq="insert into stock_manquant (com,prod,quant,flag) values ".$value;
//echo $rq;
$success=mysql_query($rq,$connectID) or die ("Impossible d'accéder aux données5");

//$commu=array_unique($comm[0]);
		
$sql="select id_commande as numero,nom,prenom,ville,date,sum(com.quant) as nb_livre";
$sql.=",sum(com.quant*prix+port) as total,(datediff(curdate(),date)) as Retard from com ";
$sql.="inner join stock_manquant as st on com.id_commande=st.com ";
$sql.="where id_commande in (select st.com from stock_manquant as st group by st.com having sum(st.flag)<0) ";
$sql.="group by id_commande order by date asc;";

//echo $sql;
$success=mysql_query($sql,$connectID) or die("Impossible d'accéder aux données6");

if(isset($_GET['Avoir'])) {$operateur='<';
			   $form='&Avoir=1';}
	else {$operateur='>=';
	      $form='';}

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<label>Commandes en attente :</label>';
print'</span>';
print'<br/>';
print'<br/>';

$ligne=0;
$connectID=Connexion();

//echo $req1;
//$success=mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");

print '<form action="'.$_SERVER['PHP_SELF'].'?Operation=24'.$form.'" method="POST">';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Expédier les commandes sélectionnées"/>';

print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=43" >';
print '<input type="button" value="Consulter les livres manquants" />';
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