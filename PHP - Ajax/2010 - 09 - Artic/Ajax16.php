<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;
$op=signe($_POST['Operateur']);

if(($_POST['Client']!='inconnu')&&($_POST['Client']!='')) {$clause.="and id_commande =".$_POST['Client']." ";}
if(($_POST['Commande']!='inconnu') && ($_POST['Commande']!='')) {
								 $clause.="and Montant".$op.$_POST['Commande']." ";}
if(($_POST['Date_d']!='inconnu')&&($_POST['Date_d']!=''))  {$clause.="and ex.date>='".$_POST['Date_d']."' ";}
if(($_POST['Date_f']!='inconnu')&&($_POST['Date_f']!='')) {$clause.="and ex.date<='".$_POST['Date_f']."' ";}
if($_POST['Ordre']!='inconnu') {$clause.=" order by ".$_POST['Ordre']." ";}

$nb=0;
if($_POST['Client']=='inconnu') {$nb++;}
if($_POST['Commande']=='inconnu') {$nb++;}
if($_POST['Date_d']=='inconnu') {$nb++;}
if($_POST['Date_f']=='inconnu') {$nb++;} 
if($_POST['Client']=='') {$nb++;}
if($_POST['Commande']=='') {$nb++;}
if($_POST['Date_d']=='') {$nb++;}
if($_POST['Date_f']=='') {$nb++;}

if($nb==4) {print'<br/>';
	    echo 'Veuillez choisir au moins un crit�re de recherche !!! ';}

	else {

$sq="select id_commande,comi.date,nom,code_postal,ville,montant,nb_livre,ex.date as date_expedition from comi inner join expedition as ex on ex.numero_co=comi.id_commande where id_commande>0 ".$clause." ;";
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoy�es par xmlhttprequet.responseText
$last="";
$Code[]="<p> Liste des propositions (cliquer sur l'en t�te de colonne pour trier): </p/>";
//$Code[]="<br/>";
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

//------- On extrait chaque ligne de la requ�te pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="expedition(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Op�ration</td>';}

//------- Si il y a un changement de valeur sur la colonne de tri, on ins�re deux lignes de s�paration
//if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
//------- On doit faire attention de bien saisir le nom de la page qui �dite le tableau avant son tri, dans le lien
//------- car si on fait appel � la variable serveur Php _self, le lien renverra � cette page qui sert uniquement de tampon
//------- pour l'objet XmlHttpRequest, appel�e par la fonction javascript
$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donn�e ne correspond � votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>R�sultat: '.$ligne.' proposition'.$s.' trouv�e'.$s.' (cliquer sur l\'en t�te de colonne pour trier): </p>';
	}
//------- On �dite la succession de commandes html du tableau tri� que nous avons stock� dans le tableau code, 
//------- pour qu'elle soient lisible par la m�thode responseText et ex�cutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}}

?>