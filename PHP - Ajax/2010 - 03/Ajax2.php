<?php

header('Content-type: text/html; charset=iso-8859-1'); 

session_start();

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

//------- On construit la requête sélection correspondante à la table en cours de consultation
switch($_SESSION['Tab']) {

	case 'articles':$sq="SELECT *,round(rand()*800,0) as stock from articles";break;

	case 'clients':$sq="SELECT numero,nom,prenom,adresse,codepostal,ville from clients";break;

	case 'achats':$sq="select ac.id_achat as id,c.nom as acheteur,ac.quantite,a.nom as produit,a.prix,";
		      $sq.="ac.quantite*a.prix as total,ac.date from achats as ac ";
		      $sq.="inner join clients as c on ac.id_client=c.numero ";
		      $sq.="inner join articles as a on ac.id_article=a.reference";
		      break;

	default:$sq="select a.nom,sum(ac.quantite) as Nb_Total,count(ac.id_achat) as Nb_Commande,";
		$sq.="(sum(ac.quantite))/(count(ac.id_achat)) as Moyenne,sum(ac.quantite*a.prix) as ";
		$sq.="CA from achats as ac inner join articles as a on ac.id_article=a.reference group ";
		$sq.=" by a.nom";}

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'opère pas de tri sur la sélection
if(isset($_POST['family'])) {$col=" order by ".$_POST['family'].";";}
	else {$col=";";}


//------- on rajoute la clé de tri transmis par l'instance de xmlhttprequest à la requête de sélection définie plus haut
$sq.=$col;

//------- Connexion à la BDD et lancement de la requête de tri-sélection
include("Connexion.php");
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$last="";
$Code[]="";

//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="tri(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Opération</td>';}

//------- Si il y a un changement de valeur sur la colonne de tri, on insère deux lignes de séparation
if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
//------- On doit faire attention de bien saisir le nom de la page qui édite le tableau avant son tri, dans le lien
//------- car si on fait appel à la variable serveur Php _self, le lien renverra à cette page qui sert uniquement de tampon
//------- pour l'objet XmlHttpRequest, appelée par la fonction javascript
$Code[]='<td'.$couleur.'><a href="Menu.php?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'&id='.$identifiant.'">'.$_SESSION['Requ'].'</a></td>';
$Code[]='</tr>';

++$ligne;
$last=$row[$_POST['family']];}


//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

?>