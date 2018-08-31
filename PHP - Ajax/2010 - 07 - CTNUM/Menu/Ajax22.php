<?php

header('Content-type: text/html; charset=iso-8859-1'); 

//session_start();



include("Fonc.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;
$Code[]='';

if($_POST['sens']%2 == 0) {$sens="desc";}
	else {$sens="asc";}

//------- On construit la requête sélection correspondante à la table en cours de consultation
switch($_SESSION['Tab']) {

	case 'clients': if($_SESSION['Fournisseur']==0) {$clause=" where cl.numero not in (select ci.numero from fournisseurs as ci) ";}
				 		    else {$clause='';}
			$req="select cl.numero as N,cl.nom,cl.prenom,cl.code_postal as cp,nb.quantite as livre,nb.somme as total,count(co.numero_com) as panier,";
			$req.="round(nb.quantite/count(co.numero_com),2) as quant_moy,round(nb.somme/count(co.numero_com),2) as panier_moyen from clients as cl ";
			$req.="inner join client_vente_nb as nb on cl.numero=nb.id_client ";
			$req.="inner join commande as co on co.numero_client=cl.numero ".$clause;
			$req.="group by cl.numero ";          
                        break;

	case 'livres': if($_SESSION['Fournisseur']==0) {$clause=" and cl.numero not in (select ci.numero from fournisseurs as ci) ";}
				 		   else {$clause='';}

		      $req="select li.numero as N,li.isbn as isbn,li.titre as titre,count(*) as commande,sum(lig.quantite) as quantite,";
		      $req.="sum(lig.quantite*pr.prix) as CA from livres as li inner join ";
                      $req.="ligne_commande as lig on li.numero=lig.numero_livre inner join prix as pr on pr.id_livre=lig.numero_livre";
                      $req.=" inner join commande as co on co.numero_com=lig.numero_com inner join clients as cl on cl.numero=co.numero_client ";
                      $req.=" where co.date >=pr.d_begin and co.date<= pr.d_end ".$clause;
                      $req.=" group by li.numero  ";         
                      break;

	//-----------------------------------Statistiques catalogues

case 'catalogues':

if($_SESSION['Fournisseur']==0) {$clause=" and cv.id_client not in (select ci.numero from fournisseurs as ci) ";}	   
	else {$clause='';}

$req="select cat.num_cat as numero,cat.date_debut as date,count(cat.num_cat) as";
$req.=" commande,sum(cv.quantite) as nb_livre,sum(cv.somme) as CA,(count(co.numero_com)";
$req.="/coalesce(cat.nb_envoi,1)) as taux_retour,(sum(cv.somme)/count(cat.num_cat)) as ";
$req.="panier_moyen from commande as co inner join catalogue_vente_nb as cv on cv.id_commande=co.numero_com ";
$req.=" inner join clients as cl on cl.numero=co.numero_client ";
$req.="inner join catalogue as cat on cat.num_cat=co.catalogue  where cv.date>=cat.date_debut ";
$req.="and cv.date<=cat.date_fin ".$clause;
$req.=" group by co.catalogue ";

break;

case 'RFM':

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=58&Client=';

if($_GET['Fournisseur']==0) {$clause=" and cl.numero not in (select ci.numero from fournisseurs as ci) ";
			     $_SESSION['Fournisseur']=0;}
	else {$clause='';
	      $_SESSION['Fournisseur']=1;}

$req="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville,";
$req.="round((datediff(curdate(),max(co.date)))/30,2) as recence,";
$req.="(count(co.numero_client)) as frequence,sum(lig.quantite*pr.prix) as montant,";
$req.="round((count(co.numero_client)*power(sum(lig.quantite*pr.prix),1/2))*";
$req.="(power(datediff(curdate(),co.date),-1/3)),2) as RFM from clients as cl inner join ";
$req.="commande as co on cl.numero=co.numero_client inner join ligne_commande ";
$req.="as lig on lig.numero_com=co.numero_com inner join prix as pr on ";
$req.="pr.id_livre=lig.numero_livre where ";
$req.="nature_client like '%client%' ".$clause;
$req.="group by cl.numero ";

break;


}

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'opère pas de tri sur la sélection
if(isset($_POST['family'])) {$col=" order by ".$_POST['family']." ".$sens.";";}
	else {$col=";";}

//------- on rajoute la clé de tri transmis par l'instance de xmlhttprequest à la requête de sélection définie plus haut
$req.=$col;
//echo $req;
//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($req,$connectID) or die ("impossible d'accéder aux données2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$last="";
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On édite les en têtes de champ qui doivent contenir le code javascript nécessaires à l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="topi(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Opération</td>';}

//------- Si il y a un changement de valeur sur la colonne de tri, on insère deux lignes de séparation
//if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'éditer le corps du tableau nouvellement trié
foreach($row as $value) {if($colonne==0) {$identifiant=$value;
					  $value=$ligne+1;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour éditer le lien qui permettre une action sur la ligne correspondante du tableau
$Code[]='<td'.$couleur.'><a href="'.$_SESSION['Adresse'].$identifiant.'">'.$_SESSION['Lien'].'</a></td>';
$Code[]='</tr>';

++$ligne;
$last=$row[$_POST['family']];}


$Code[]='</table>';
$s='';

if ($ligne==0) {$Code[]='Aucune donnée ne correspond à votre recherche...';}
	else {
		if($ligne>1) {$s='s';}
		$Code[0]='<p>Résultat: '.$ligne.' proposition'.$s.' trouvée'.$s.' (cliquer sur l\'en tête de colonne pour trier): </p>';
	}

//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

mysql_close($connectID);

?>