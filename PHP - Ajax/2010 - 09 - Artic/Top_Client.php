<?php

$Code[]="";



print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour au menu" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

$_SESSION['Tab']=$_GET['Stats'];

switch($_SESSION['Tab']) {

//-----------------------------------Statistiques clients

case 'clients':

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=58&Client=';

if($_GET['Fournisseur']==0) {$clause=" where cl.numero not in (select ci.numero from fournisseurs as ci) ";
			     $_SESSION['Fournisseur']=0;}
	else {$clause='';
	      $_SESSION['Fournisseur']=1;}

$req="select cl.numero as N,cl.nom,cl.prenom,cl.code_postal as cp,nb.quantite as livre,nb.somme as total,count(co.numero_com) as panier,";
$req.="round(nb.quantite/count(co.numero_com),2) as quant_moy,round(nb.somme/count(co.numero_com),2) as panier_moyen from clients as cl ";
$req.="inner join client_vente_nb as nb on cl.numero=nb.id_client ";
$req.="inner join commande as co on co.numero_client=cl.numero ";
$req.=$clause."group by cl.numero order by nb.somme desc ;";
//echo $req;
break;


//-----------------------------------Statistiques livres

case 'livres':

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=60&Livre=';

if($_GET['Fournisseur']==0) {$clause=" and cl.numero not in (select ci.numero from fournisseurs as ci) ";
			     $_SESSION['Fournisseur']=0;}
	else {$clause='';
	      $_SESSION['Fournisseur']=1;}

$req="select li.numero as N,li.isbn as isbn,li.titre as titre,count(*) as commande,sum(lig.quantite) as quantite,";
$req.="sum(lig.quantite*pr.prix) as CA from livres as li inner join ";
$req.="ligne_commande as lig on li.numero=lig.numero_livre inner join prix as pr on pr.id_livre=lig.numero_livre";
$req.=" inner join commande as co on co.numero_com=lig.numero_com inner join clients as cl on cl.numero=co.numero_client ";
$req.=" where co.date >=pr.d_begin and co.date<= pr.d_end ".$clause;
$req.=" group by li.numero order by CA desc;";

break;

//-----------------------------------Statistiques catalogues

case 'catalogues':

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=62&Catalogue=';

if($_GET['Fournisseur']==0) {$clause=" and cv.id_client not in (select ci.numero from fournisseurs as ci) ";
			     $_SESSION['Fournisseur']=0;}
	else {$clause='';
	      $_SESSION['Fournisseur']=1;}

$req="select cat.num_cat as numero,cat.date_debut as date,count(cat.num_cat) as";
$req.=" commande,sum(cv.quantite) as nb_livre,sum(cv.somme) as CA,(count(co.numero_com)";
$req.="/coalesce(cat.nb_envoi,1)) as taux_retour,(sum(cv.somme)/count(cat.num_cat)) as ";
$req.="panier_moyen from commande as co inner join catalogue_vente_nb as cv on cv.id_commande=co.numero_com ";
$req.=" inner join clients as cl on cl.numero=co.numero_client ";
$req.="inner join catalogue as cat on cat.num_cat=co.catalogue  where cv.date>=cat.date_debut ";
$req.="and cv.date<=cat.date_fin ".$clause;
$req.=" group by co.catalogue order by CA ;";

break;

case 'RFM':

$_SESSION['Lien']='Consulter';
$_SESSION['Adresse']='Intro.php?Operation=58&Client=';

if($_GET['Fournisseur']==0) {$clause=" and cl.numero not in (select ci.numero from fournisseurs as ci) ";
			     $_SESSION['Fournisseur']=0;}
	else {$clause='';
	      $_SESSION['Fournisseur']=1;}

$req="select numero,nom,prenom,code_postal,";
$req.="round((datediff(curdate(),max(co.date)))/30,2) as recence,";
$req.="(count(co.numero_client)) as frequence,sum(lig.quantite*pr.prix) as montant,";
$req.="round((count(co.numero_client)*power(sum(lig.quantite*pr.prix),1/2))*";
$req.="(power(datediff(curdate(),co.date),-1/3)),2) as RFM from clients as cl inner join ";
$req.="commande as co on cl.numero=co.numero_client inner join ligne_commande ";
$req.="as lig on lig.numero_com=co.numero_com inner join prix as pr on ";
$req.="pr.id_livre=lig.numero_livre where ";
$req.="nature_client like '%client%' ".$clause;
$req.="group by cl.numero order by RFM desc ; ";

break;

}

//echo $req;
$success=mysql_query($req,$connectID) or die ("impossible d'acc�der aux donn�es9");

mysql_close($connectID);
$ligne=0;
$last="";

print "<h1> Classement des meilleurs ".$_SESSION['Tab']." (cliquer sur l'en t�te de colonne pour trier): </h1>";
//print '<br/>';
$Code[]='<table id="tableau" border=1px  cellpadding=2px >';

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="topi(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Op�ration</td>';}
		$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
	foreach($row as $value) {if($colonne==0) {$identifiant=$value;
						   $value=$ligne+1;}
		         $Code[]='<td'.$couleur.' >'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
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

print '<div id="tableaux">';

foreach($Code as $value) {echo $value;}

print'</div>';

print'</div>';

?>