<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;

if($_POST['Client']=='') {$clause=' where numero=0 ;';}
	else {$choix='(';
              $data[]=explode('.',chop($_POST['Client']));
	      foreach($data[0] as $value) {$value=$value+30000;$choix.=$value.',';}
	      $choix.='0)';
	      $clause=' where numero in '.$choix.';';}

$sq="select numero,qualite,nom,prenom,adresse_2,code_postal,ville,npai from clients ".$clause;
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$last="";
$Code[]="<p> Liste des propositions (cliquer sur l'en tête de colonne pour trier): </p/>";
//$Code[]="<br/>";
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {if($key=='npai'){$key='etat';}
					         $Code[]='<td id="'.$key.'" class="entete" >'.$key.'</td>';}
		//$Code[]='<td class="entete">Etat</td>';
		}

//------- Si il y a un changement de valeur sur la colonne de tri, on insère deux lignes de séparation
//if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
foreach($row as $value) {if($colonne==0) {$identifiant[]=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
//------- On doit faire attention de bien saisir le nom de la page qui édite le tableau avant son tri, dans le lien
//------- car si on fait appel à la variable serveur Php _self, le lien renverra à cette page qui sert uniquement de tampon
//------- pour l'objet XmlHttpRequest, appelée par la fonction javascript
//$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;}

$Code[]='</table>';

$manquant='';
$manqu=0;
$phrase='';
foreach($data[0] as $value) {   $manq=0;
				foreach($identifiant as $value2) {if($value2==$value) {$manq=1;}}
				if($manq==0) {$manquant.=$value.' - ';$manqu++;}}

$s='';

if($manqu!=0) {$phrase=' - Les numéros suivants ne correspondent à aucun client :'.$manquant;} 

if ($ligne==0) {$Code[]='Aucune donnée ne correspond aux numéros rentrés...'.$phrase;}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>Résultat: '.$ligne.' correspondance'.$s.' trouvée'.$s.$phrase.' </p>';
	}
//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

?>