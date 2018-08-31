<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';

$connectID=Connexion();

$req="select sum(quantite) as nb_livre,count(id_commande) as nb_commande,sum(somme) as total_CA,sum(somme)/count(id_commande) as panier_moyen from catalogue_vente_nb ;";

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$stat0=$row['total_CA'];
	$stat1=$row['nb_livre'];
	$stat2=$row['nb_commande'];
	$stat4=$row['panier_moyen'];}

$req1="select count(co.numero_com)/cat.nb_envois as taux_retour from commande as co,(select sum(nb_envoi) as nb_envois from catalogue) as cat;";

$success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat3=$row['taux_retour'];}

$req2="select total.nb/count(li.numero) as vente_moyen,total.ca/count(li.numero) as ca_moyen from livres as li,(select sum(quantite) as nb,sum(somme) as ca  from catalogue_vente_nb) as total;";

$success=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat5=$row['vente_moyen'];
	$stat6=$row['ca_moyen'];}

$req3="select vente as mediane from (select v1.numero,v1.vente,count(v1.vente) as rank from vente_livres as v1,vente_livres as v2 ";
$req3.="where v1.vente<v2.vente or (v1.vente=v2.vente and v1.numero<=v2.numero) group by v1.numero,v1.vente order by v1.vente desc) ";
$req3.="as v3 where v3.rank=(select (count(*)+1) div 2 from vente_livres);";

$success=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat7=$row['mediane'];}

$req4="select C2.inac/c1.tot as attrition from (select count(*) as tot from clients ) as c1,";
$req4.="(select count(*) as inac from clients where npai like '%npai%' or npai like '%refuse%' or npai like '%dcd%') as c2;";

$success=mysql_query($req4,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat8=$row['attrition'];}

$req5="select count(*) as client_dis from (select distinct numero_client from commande) as C1;";

$success=mysql_query($req5,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat9=$row['client_dis'];}

$req6="select avg(total.num) as recom from (select count(*) as num from commande group by numero_client) as total;";

$success=mysql_query($req6,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat11=$row['recom'];}

$req7="select c1.cli/c2.pro as penetration from (select count(*) as cli from clients where nature_client ";
$req7.="like '%client%') as c1,(select count(*) as pro from clients) as c2;";

$success=mysql_query($req7,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat12=$row['penetration'];}

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Statistiques globales :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>0. Cumul du chiffre d\'affaires : '.$stat0.' €</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>1. Total de livres vendus : '.$stat1.' unités</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>2. Cumul du nombre de commandes : '.$stat2.'</label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat3=round($stat3*100,2);
print'<span class="libelle">';
print '<label>3. Taux de retour moyen : '.$stat3.' % </label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat4=round($stat4,2);
print'<span class="libelle">';
print '<label>4. Valeur du panier moyen : '.$stat4.' €</label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat5=round($stat5,2);
print'<span class="libelle">';
print '<label>5. Ventes moyennes d\'un livre : '.$stat5.' unités</label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat6=round($stat6,2);
print'<span class="libelle">';
print '<label>6. Chiffre d\'affaire moyen d\'un livre : '.$stat6.' €</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>7. Ventes médianes d\'un livre : '.$stat7.' unités</label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat8=round($stat8*100,2);
print'<span class="libelle">';
print '<label>8. Taux d\'attrition : '.$stat8.' %</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>9. Nombre de clients distincts : '.$stat9.'</label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat12=round($stat12*100,2);
print'<span class="libelle">';
print '<label>10. Taux de pénétration : '.$stat12.' %</label>';
print'</span>';
print '<br/>';
print '<br/>';

if($stat2==0) {$stat10=0;}
	else {$stat10=round($stat9/$stat2,2)*100;}

print'<span class="libelle">';
print '<label>11. Taux de fidélisation : '.$stat10.' % </label>';
print'</span>';
print '<br/>';
print '<br/>';

$stat11=round($stat11,2);
print'<span class="libelle">';
print '<label>12. Nombre moyen de commande par client distinct : '.$stat11.'</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>13. Détail des multi-commandes client : </label>';
print'</span>';
print '<br/>';
print '<br/>';


$req="select max(total.num) as maxi from (select count(*) as num from commande group by numero_client) as total ;";

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$ligne=$row['maxi'];}

$i=1;
print '<ul>';
while($i<=$ligne) {

$req2="select count(total.num) as number from (select count(*) as num from commande group by numero_client having count(*)=".$i.") as total ;";

$success=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$numb=$row['number'];
	if($numb!=0) {
		if ($i>1) {$s='s';} else {$s=' unique ';}
		print '<li>Nombre de client ayant effectué '.$i.' commande'.$s.' : '.$numb.' </li>';}}

	$i++;}

print'</ul>';
print'<br/>';
print'<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=64" >';
print '<input type="button" value="Détail de la fidélisation" />';
print '</a>';
print'</span>';

mysql_close($connectID);

print'</div>';

?>