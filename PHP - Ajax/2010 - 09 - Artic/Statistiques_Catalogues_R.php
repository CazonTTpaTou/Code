<?php

$connectID=Connexion();

$id=$_GET['Catalogue'];

$req="select cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(lig.quantite) as nb_livre,";
$req.="sum(lig.quantite*pr.prix) as montant,(sum(lig.quantite*pr.prix)*100)/cati.total as pourcentage from ";
$req.="(select sum(lig.quantite*pr.prix) as total from catalogue as cat inner join commande as co on ";
$req.="cat.num_cat=co.catalogue inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join ";
$req.="clients as cl on cl.numero=co.numero_client inner join prix as pr on pr.id_livre=lig.numero_livre ";
$req.="where cat.num_cat=".$id.") as cati,catalogue as cat inner join commande as co on cat.num_cat=co.catalogue ";
$req.="inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join clients as cl ";
$req.="on cl.numero=co.numero_client inner join prix as pr on pr.id_livre=lig.numero_livre where co.date>=pr.d_begin ";
$req.="and co.date<=pr.d_end and cat.num_cat=".$id." group by cl.nom order by montant desc;";

$req2="select li.isbn,li.titre,sum(lig.quantite) as vente,";
$req2.="sum(lig.quantite*pr.prix) as CA,(sum(lig.quantite*pr.prix)*100)/cati.total as pourcentage from ";
$req2.="(select sum(lig.quantite*pr.prix) as total from catalogue as cat inner join commande as co on ";
$req2.="cat.num_cat=co.catalogue inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join ";
$req2.="clients as cl on cl.numero=co.numero_client inner join prix as pr on pr.id_livre=lig.numero_livre ";
$req2.="where cat.num_cat=".$id.") as cati,catalogue as cat inner join commande as co on cat.num_cat=co.catalogue ";
$req2.="inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join livres as li ";
$req2.="on li.numero=lig.numero_livre inner join prix as pr on pr.id_livre=lig.numero_livre where co.date>=pr.d_begin ";
$req2.="and co.date<=pr.d_end and cat.num_cat=".$id." group by li.numero order by vente desc;";

$req3="select dep.region as region,sum(lig.quantite) as nb_livre,";
$req3.="sum(lig.quantite*pr.prix) as montant,(sum(lig.quantite*pr.prix)*100)/cati.total as pourcentage from ";
$req3.="(select sum(lig.quantite*pr.prix) as total from catalogue as cat inner join commande as co on ";
$req3.="cat.num_cat=co.catalogue inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join ";
$req3.="clients as cl on cl.numero=co.numero_client inner join prix as pr on pr.id_livre=lig.numero_livre ";
$req3.="where cat.num_cat=".$id.") as cati,catalogue as cat inner join commande as co on cat.num_cat=co.catalogue ";
$req3.="inner join ligne_commande as lig on lig.numero_com=co.numero_com inner join clients as cl ";
$req3.="on cl.numero=co.numero_client inner join prix as pr on pr.id_livre=lig.numero_livre ";
$req3.="inner join departement as dep on dep.numero=left(cl.code_postal,2) where co.date>=pr.d_begin ";
$req3.="and co.date<=pr.d_end and cat.num_cat=".$id." group by dep.region order by montant desc;";

					$req35="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req35.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req35.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req35.="on li.numero=lig.numero_livre inner join liv_rubrique as lir on";
					$req35.=" lir.id_livre=li.numero inner join rubrique as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req35.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";
	


					$req4="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req4.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req4.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req4.="on li.numero=lig.numero_livre inner join liv_sujet as lir on";
					$req4.=" lir.id_livre=li.numero inner join sujet as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req4.=" co.date <= pr.d_end and co.catalogue=".$id." group by lir.id_cat order by ru.titre asc;";

					$req5="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req5.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req5.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req5.="on li.numero=lig.numero_livre inner join liv_periode as lir on";
					$req5.=" lir.id_livre=li.numero inner join periode as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req5.=" co.date <= pr.d_end and co.catalogue=".$id." group by lir.id_cat order by ru.titre asc;";

					$req6="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req6.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req6.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req6.="on li.numero=lig.numero_livre inner join liv_genre as lir on";
					$req6.=" lir.id_livre=li.numero inner join genre as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req6.=" co.date <= pr.d_end and co.catalogue=".$id." group by lir.id_cat order by ru.titre asc;";

					$req7="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req7.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req7.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req7.="on li.numero=lig.numero_livre inner join liv_lieu as lir on";
					$req7.=" lir.id_livre=li.numero inner join lieu as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req7.=" co.date <= pr.d_end and co.catalogue=".$id." group by lir.id_cat order by ru.titre asc;";

					$req0='select num_cat,nom,date_debut,date_fin from catalogue where num_cat='.$id.';';
					$success=mysql_query($req0,$connectID) or die ("Impossible d'accéder aux données");
					
					$nom="";
					while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
						$nom.='catalogue n° '.$row['num_cat'].' - '.$row['nom'].' du '.$row['date_debut'].' au '.$row['date_fin'].' : ';}
						
					$titre1='Liste des clients sur le '.$nom;
					$titre2='Liste des livres commandés sur le '.$nom;
					$titre3='Rubriques phares du '.$nom;
					$titre4='Sujets phares du '.$nom;
					$titre5='Périodes phares du '.$nom;
					$titre6='Genres phares du '.$nom;
					$titre7='Lieux phares du '.$nom;

					$total='client';
					$total1='nb_livre';
					$total2='montant';
					$tot1='';
					$tot2='';

					$total0='titre';
					$total3='vente';
					$total4='CA';
					$tot3='';
					$tot4='';			



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
	foreach($row as $key => $value) {
					if($key=='pourcentage') {$li.=$key.' : '.round($value,2).' % ';}
						else {$li.=$key.' : '.$value.' - ';}
					if($key==$total1) {$tot1+=$value;}
					if($key==$total2) {$tot2+=$value;}}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
//print '<br/>';

$pan=' - Panier moyen : '.round($tot2/max($ligne,1),2).' € ';

if($ligne>1) {$s='s';} else{$s='';}
print '<p>Au total :'.$ligne.' '.$total.$s.' - '.$total1.':'.$tot1.' - '.$total2.':'.$tot2.' € '.$pan.' </p>';

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
	foreach($row as $key => $value) {
					if($key=='pourcentage') {$li.=$key.' : '.round($value,2).' % ';}
						else {$li.=$key.' : '.$value.' - ';}
					if($key==$total4) {$tot3+=$value;}
					}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
//print '<br/>';

if($ligne>1) {$s='s';} else{$s='';}
$pan='Vente moyenne par livre : '.round($tot1/max($ligne,1),2);
$com=round($tot2/max($ligne,1),2);

if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
else {print '<p>Au total :'.$ligne.' '.$total0.$s.' - '.$total1.':'.$tot1.' - '.$total4.' moyen par livre :'.$com.' € - '.$pan.' </p>';}
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
	foreach($row as $key => $value) {if($key=='pourcentage') {$li.=$key.' : '.round($value,2).' % ';}
						else {$li.=$key.' : '.$value.' - ';}
					 if($key==$total2) {$tot4+=$value;}
					}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
print '<br/>';

if($ligne>1) {$s='s';} else{$s='';}
$pan='CA moyen par région: '.round($tot2/max($ligne,1),2);


if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
else {print '<p>Au total : '.$ligne.' région'.$s.' - '.$total4.' global : '.$tot2.' € - '.$pan.' € </p>';}


print '<br/>';
print '<br/>';

//-------------------- Partie n°35 -----------------------------------

print "<h1> ".$titre3." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req35,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	$li='<li>'.$ligne.' - ';
	foreach($row as $key => $value) {
					$li.=$key.' : '.$value.' - ';
					if($key==$total3) {$tot3+=$value;}
					}
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
print '<br/>';

if($ligne==0) {print '<p>Aucune rubrique trouvée</p>';}

print '<br/>';
print '<br/>';

//-------------------- Partie n°4 -----------------------------------

print "<h1> ".$titre4." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req4,$connectID) or die ("Impossible d'accéder aux données");

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

if($ligne==0) {print '<p>Aucun sujet trouvé</p>';}

print '<br/>';
print '<br/>';

//-------------------- Partie n°5 -----------------------------------

print "<h1> ".$titre5." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req5,$connectID) or die ("Impossible d'accéder aux données");

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

if($ligne==0) {print '<p>Aucune période trouvée</p>';}

print '<br/>';
print '<br/>';

//-------------------- Partie n°6 -----------------------------------

print "<h1> ".$titre6." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req6,$connectID) or die ("Impossible d'accéder aux données");

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

if($ligne==0) {print '<p>Aucun genre trouvé</p>';}

print '<br/>';
print '<br/>';

//-------------------- Partie n°7 -----------------------------------

print "<h1> ".$titre7." </h1>";
//print '<br/>';
print '<ul>';
$ligne=1;
$success=mysql_query($req7,$connectID) or die ("Impossible d'accéder aux données");

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

if($ligne==0) {print '<p>Aucun lieu trouvé</p>';}

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