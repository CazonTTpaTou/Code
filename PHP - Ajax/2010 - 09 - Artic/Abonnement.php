<?php

print '<div class="princ" >';

$connectID=Connexion();
$clause=" and co.numero_com=".$_GET['id'];

$sq="select cl.numero,cl.nom,cl.prenom,cl.adresse_1,cl.adresse_2,cl.code_postal,cl.ville,";
$sq.="cl.npai,cl.nature_client,cl.fichiers,cl.telephone,";
$sq.="cl.e_mail,co.port as montant,co.numero_com,co.date,co.livraison as anciens_numeros_achetés, ";
$sq.="(case co.catalogue when 2 then 'Un an' when 1 then '6 mois' end) as abonnement from commande as co ";
$sq.="inner join clients as cl on cl.numero=co.numero_client where co.numero_com>=3141 ".$clause." ;";
//$sq="select id_commande,date,nom,prenom,code_postal,ville,montant,nb_livre from comi where id_commande>0 ".$clause." ;";
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$colonne=1;

$Code[]="<p> Détail de l'abonnement n° ".$_GET['id']." : </p>";
//$Code[]="<br/>";
$Code[]='<ul >';

//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
foreach($row as $key => $value) {
		         $Code[]='<li>'.$colonne.'. '.$key.' : '.$value.'</li>';
			 ++$colonne;}}

$Code[]='</ul>';

foreach($Code as $value) {echo $value;}

print '<br/>';
print '<br/>';
print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '</div>';

?>