<?php

$_SESSION['Operation']=0;
$_SESSION['Message']='';

$connectID=Connexion();

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print'<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Statistiques globales :</label>';
print'</span>';
print '<br/>';
print '<br/>';

$req="select max(total.num) as maxi from (select count(*) as num from commande group by numero_client) as total ;";

$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$ligne=$row['maxi'];}

$i=2;
print '<ul>';
while($i<=$ligne) {

$req2="select count(total.num) as number from (select count(*) as num from commande group by numero_client having count(*)=".$i.") as total ;";

$success=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$numb=$row['number'];}

$req3="select cl.numero,cl.nom as nm,cl.prenom as pr,cl.code_postal as cp,cl.ville as vl from (select numero_client as num from commande ";
$req3.="group by numero_client having count(*)=".$i.") as total,clients as cl where total.num=cl.numero ;";

$successs=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données");

if($numb!=0) {  print '<br/>';
		print'<span class="libelle">';
		print '<label>Liste de client ayant effectué '.$i.' commandes : '.$numb.' </label>';
		print '<br/>';
		print '<br/>';
		print '<ul>';

$a=1;
while($row=mysql_fetch_array($successs,MYSQL_ASSOC)) {
	
		print '<li>'.$a.' - '.$row['nm'].' - '.$row['pr'].' - '.$row['cp'].' - '.$row['vl'].'</li>';
		$a++;}

	print '</ul>';
	print '</span>';}

	$i++;}

print'<br/>';
print'<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print'<br/>';
print'<br/>';


print '</div>';

mysql_close($connectID);

?>