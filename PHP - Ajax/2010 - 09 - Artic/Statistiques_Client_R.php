<?php

$connectID=Connexion();

$id=$_GET['Client'];

				        $req="select co.numero_com as commande,co.date as date,";
					$req.="co.catalogue as catalogue,sum(lig.quantite) as nb_livre,";
					$req.="sum(lig.quantite*pr.prix) as montant from commande as co ";
					$req.="inner join ligne_commande "; 
					$req.="as lig on lig.numero_com=co.numero_com inner join prix as pr ";
					$req.="on lig.numero_livre=pr.id_livre where co.date >= pr.d_begin ";
					$req.="and co.date <= pr.d_end and co.numero_client=".$id." group by ";
					$req.="co.numero_com order by co.numero_com desc;";

					$req2="select li.isbn as isbn,li.titre as titre,pr.prix as prix,";
					$req2.="li.editeur as editeur,sum(lig.quantite) as nombre ";
					$req2.="from commande as co inner join ligne_commande ";
					$req2.="as lig on lig.numero_com=co.numero_com inner join prix as pr "; 
					$req2.="on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req2.="on li.numero=lig.numero_livre where co.date >= pr.d_begin ";
					$req2.="and co.date <= pr.d_end and co.numero_client=".$id." ";
					$req2.="group by li.numero order by li.titre asc;";
					
					$req3="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req3.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req3.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req3.="on li.numero=lig.numero_livre inner join liv_rubrique as lir on";
					$req3.=" lir.id_livre=li.numero inner join rubrique as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req3.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";

					$req4="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req4.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req4.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req4.="on li.numero=lig.numero_livre inner join liv_sujet as lir on";
					$req4.=" lir.id_livre=li.numero inner join sujet as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req4.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";

					$req5="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req5.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req5.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req5.="on li.numero=lig.numero_livre inner join liv_periode as lir on";
					$req5.=" lir.id_livre=li.numero inner join periode as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req5.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";

					$req6="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req6.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req6.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req6.="on li.numero=lig.numero_livre inner join liv_genre as lir on";
					$req6.=" lir.id_livre=li.numero inner join genre as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req6.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";

					$req7="select ru.titre as titre,sum(lig.quantite) as nombre_livre,sum(lig.quantite*pr.prix) ";
					$req7.="as montant from commande as co inner join ligne_commande as lig on lig.numero_com=co.numero_com ";
					$req7.="inner join prix as pr on lig.numero_livre=pr.id_livre inner join livres as li ";
					$req7.="on li.numero=lig.numero_livre inner join liv_lieu as lir on";
					$req7.=" lir.id_livre=li.numero inner join lieu as ru on ru.num=lir.id_cat where co.date >= pr.d_begin and";
					$req7.=" co.date <= pr.d_end and co.numero_client=".$id." group by lir.id_cat order by ru.titre asc;";

					$req0='select qualite,prenom,nom,ville from clients where numero='.$id.';';
					$success=mysql_query($req0,$connectID) or die ("Impossible d'accéder aux données");
					
					$nom="";
					while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
						$nom.=$row['qualite'].' '.$row['prenom'].' '.$row['nom'].' de '.$row['ville'].' : ';}
						
					$titre1='Liste des commandes effectuées par '.$nom;
					$titre2='Liste des livres commandés par '.$nom;
					$titre3='Rubriques favorites de '.$nom;
					$titre4='Sujets favoris de '.$nom;
					$titre5='Périodes préférées de '.$nom;
					$titre6='Genres préférés de '.$nom;
					$titre7='Lieux préférés de '.$nom;

					$total='commande';
					$total1='nb_livre';
					$total2='montant';
					$tot1='';
					$tot2='';

					$total0='titre';
					$total3='nombre';
					$total4='panier moyen';
					$tot3='';
					//$tot4=$tot1/$tot2;			



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
	$li.='</li>';
	print $li;
	$ligne++;}

$ligne--;
print '</ul>';
//print '<br/>';

if($ligne>1) {$s='s';} else{$s='';}
print '<p>Au total :'.$ligne.' '.$total.$s.' - '.$total1.':'.$tot1.' - '.$total2.' total :'.$tot2.' € </p>';

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
$pan=round($tot2/$com,2);


if($ligne==0) {print '<p>Aucune donnée trouvée</p>';}
else {print '<p>Au total :'.$ligne.' '.$total0.$s.' distinct'.$s.' - '.$tot3.' livre'.$s.' - '.$total4.':'.$pan.' € </p>';}
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