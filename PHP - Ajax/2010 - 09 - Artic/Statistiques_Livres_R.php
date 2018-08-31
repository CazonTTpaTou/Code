<?php

$connectID=Connexion();

$id=$_GET['Livre'];

				        $req="select co.date,cl.nom as nom,cl.prenom as prenom,";
					$req.="cl.code_postal as code_postal,count(*) as commande,";
					$req.="sum(lig.quantite) as quantite,sum(lig.quantite*pr.prix) as CA ";
					$req.="from livres as li inner join ligne_commande as lig ";
					$req.="on li.numero=lig.numero_livre inner join prix as pr on ";
					$req.="pr.id_livre=lig.numero_livre inner join commande as co on ";
					$req.="co.numero_com=lig.numero_com inner join clients as cl ";
					$req.="on cl.numero=co.numero_client ";
					$req.="where li.numero=".$id." group by cl.numero order by quantite desc ;";

					$req2="select cat.num_cat as numero,cat.nom as nom_catalogue,count(*) as commande,";
					$req2.="sum(lig.quantite) as quantite,sum(lig.quantite*pr.prix) as CA from livres as li ";
					$req2.="inner join ligne_commande as lig on li.numero=lig.numero_livre inner join prix";
					$req2.=" as pr on pr.id_livre=lig.numero_livre inner join commande as co on co.numero_com=lig.numero_com ";
					$req2.="inner join catalogue as cat on cat.num_cat=co.catalogue where ";
					$req2.="li.numero=".$id." group by cat.num_cat order by quantite desc ;";

					$req3="select dep.region as region,count(*) as commande,sum(lig.quantite) as quantite,";
					$req3.="sum(lig.quantite*pr.prix) as CA from livres as li inner join ligne_commande as lig";
					$req3.=" on li.numero=lig.numero_livre inner join prix as pr on pr.id_livre=lig.numero_livre ";
					$req3.="inner join commande as co on co.numero_com=lig.numero_com inner join clients ";
					$req3.="as cl on cl.numero=co.numero_client inner join departement as dep on dep.numero=left(cl.code_postal,2) ";
					$req3.="where li.numero=".$id." group by dep.region order by quantite desc ;";
		
					$req0='select isbn,titre from livres where numero='.$id.';';
					$success=mysql_query($req0,$connectID) or die ("Impossible d'accéder aux données");
					
					$nom="le livre n° ";
					while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
						$nom.=$row['isbn'].' - titre : '.$row['titre'].' : ';}
						
					$titre1='Liste des clients ayant acheté '.$nom;
					$titre2='Liste des catalogues où s\'est vendu '.$nom;
					$titre3='Liste des régions où s\'est vendu '.$nom;

					$total='client';
					$total1='quantite';
					$total2='CA';
					$tot1='';
					$tot2='';

					$total0='catalogue';
					$total3='commande';
					$total4='Moyenne';
					$tot3='';
					//$tot4=$total2/$total;			



print '<div class="princ_livre" >';

//-------------------- Partie n°1 -----------------------------------

print "<h1> ".$titre1." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
//echo $req;
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	$li='<li>'.$ligne.' - ';
	foreach($row as $key => $value) {$li.=$key.' : '.$value.' - ';
					if($key==$total1) {$tot1+=$value;}
					if($key==$total2) {$tot2+=$value;}}
	$li.=' € </li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
//print '<br/>';

$pan=' - Moyenne : '.round($tot2/$ligne,2).' € ';

if($ligne>1) {$s='s';} else{$s='';}
print '<p>Au total : '.$ligne.' '.$total.$s.' - '.$total1.':'.$tot1.' - '.$total2.':'.$tot2.' € '.$pan.' </p>';

if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
$com=max(1,$ligne);	

//print '<br/>';
print '<br/>';

//-------------------- Partie n°2 -----------------------------------

print "<h1> ".$titre2." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;

//echo $req2;
$success=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	$li='<li>'.$ligne.' - ';
	foreach($row as $key => $value) {$li.=$key.' : '.$value.' - ';
					if($key==$total3) {$tot3+=$value;}
					}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
//print '<br/>';

if($ligne>1) {$s='s';} else{$s='';}
$pan=round($tot2/$ligne,2);


if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
else {print '<p>Au total : '.$ligne.' '.$total0.$s.' - '.$total4.': '.$pan.' € </p>';}
print '<br/>';
//print '<br/>';

//-------------------- Partie n°3 -----------------------------------

print "<h1> ".$titre3." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	$li='<li>'.$ligne.' - ';
	foreach($row as $key => $value) {$li.=$key.' : '.$value.' - ';
					if($key==$total3) {$tot3+=$value;}
					}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
print '<br/>';

if($ligne>1) {$s='s';} else{$s='';}
$pan=round($tot2/$ligne,2);


if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
else {print '<p>Au total : '.$ligne.' région'.$s.' - '.$total4.': '.$pan.' € </p>';}

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print '</div>';

mysql_close($connectID);

?>