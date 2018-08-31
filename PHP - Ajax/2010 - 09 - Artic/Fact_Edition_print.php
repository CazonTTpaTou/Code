<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script src="fonctions_JS.js" type="text/javascript"></script>   

<link rel="stylesheet" type="text/css" href="présentation3.css">
</link>

<?php 
include('fonc.php');
$titre='Facture n°'.$_GET['id'];
echo '<title>'.$titre.'</title>';
?>

</head>

<body onload="window.print();" >

<?php
echo'<img class="image" alt="logo" src="Fact_Livre.JPG" />';
echo'<h1 class="titre">CENTRE DE TRAITEMENT NUMERIQUE</h1>';
echo'<img class="image2" alt="logo" src="Fact_Livre.JPG" />';

$number=$_GET['id'];

$connectID=Connexion();

$requ1="select date,id_commande from com where id_commande=".$number." group by id_commande;";

$requ2="select id_client,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from com where id_commande=".$number." group by id_commande ;";
$requ3="select id_livre,auteur,titre,prix,quant from com where id_commande=".$number." ;";
$requ4="select sum(quant)as nombre,sum(prix*quant) as total_HT, sum(prix*quant)*0.055 as TVA,sum(prix*quant*1.055) as total_TTC from com where id_commande=".$number." group by id_commande ; ";

//$success = mysql_query($requete,$connectID) or die ("Impossible accéder aux données2");

//while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {}

Requete($requ1);
$date=substr($_SESSION['date'],0,10);
echo'<h3 class="titre2">Facture n° '.$_GET['id'].' - du '.$date.'</h3>';


Requete($requ2);
$lig1=$_SESSION['qualite'].' '.$_SESSION['nom'].' '.$_SESSION['prenom'];
$lig2=$_SESSION['adresse_1'];
$lig3=$_SESSION['adresse_2'];
$lig4=$_SESSION['code_postal'].' - '.$_SESSION['ville'];

echo '<div class="fact">';
echo'<p class="title_fact" >ADRESSE DE FACTURATION</p>';
if(($lig2=="")||($lig3=="")) {echo '<br/>';}
echo $lig1;
echo '<br/>';
if($lig2!="") {echo $lig2;echo '<br/>';}
if($lig3!="") {echo $lig3;echo '<br/>';}
echo $lig4;
echo '</div>';

$req2="select numero_l as nb,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from ad_livraison as li,commande as c where c.livraison=li.numero_l and c.numero_com=".$number." ;";
Requete($req2);

echo '<div class="liv">';
echo'<p class="title_liv" >ADRESSE DE LIVRAISON</p>';
if ($_SESSION['nb']!=1) {
	$lig1=$_SESSION['qualite'].' '.$_SESSION['nom'].' '.$_SESSION['prenom'];
	$lig2=$_SESSION['adresse_1'];
	$lig3=$_SESSION['adresse_2'];
	$lig4=$_SESSION['code_postal'].' - '.$_SESSION['ville'];}

if(($lig2=="")||($lig3=="")) {echo '<br/>';}
echo $lig1;
echo '<br/>';
if($lig2!="") {echo $lig2;echo '<br/>';}
if($lig3!="") {echo $lig3;echo '<br/>';}
echo $lig4;

echo '</div>';

$requ4="select sum(quant*nbl) as nombre,(sum(quant*prix/1.055)+port/1.055) as total_HT, (sum(prix/1.055*quant)+port/1.055)*0.055 as TVA,sum(prix*quant)+port as total_TTC from com where id_commande=".$number." group by id_commande;";
Requete($requ4);
$total_HT=round($_SESSION['total_HT'],2);
$TVA=round($_SESSION['TVA'],2);
$total_TTC=round($_SESSION['total_TTC'],2);
$nombre=$_SESSION['nombre'];

print '<div class="sous_total">';
echo 'Total HT : '.sprintf('%.2f',$total_HT).' € <br/>';
echo 'Montant TVA : '.sprintf('%.2f',$TVA).' € <br/>';
echo 'Total TTC : '.sprintf('%.2f',$total_TTC).' € <br/>';
echo '</div>';

//echo'<a href="Intro.php?Operation=0" class="retour" >Retour au Menu</a>';

echo'<div class="nomb_livre">';
echo 'Nombre de livre : '.$nombre.' <br/>';
echo '</div>';

include('tableau.php');

echo '<div class="fin" >';
echo 'CTNUM - 13 Bis rue d\'Alsace - 69100 VILLEURBANNE';
//echo '<br/>';
echo ' - SIRET:12345678 - SARL au capital de 1800 € ';
//echo '<br/>';
echo ' - N° TVA intracommunautaire : FR1234567890 ';
echo '<br/>';
echo '</div>';

//echo'<br/>';
//echo'<br/>';

$_SESSION['total_HT']=0;
$_SESSION['TVA']=0;
$_SESSION['total_TTC']=0;
$_SESSION['nombre']=0;

?>

</body>
</html>
