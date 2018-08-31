<?php

//----- On se connecte à la BDD
include("Connexion.php");

//----- Suivant la table choisie par l'utilisateur dans le menu, on construit la requête de sélection correspondante
switch($_SESSION['Tab']) {

	//----- pour la table articles, on insère un champ artificiel stock pour meubler un peu le tableau
	//----- les données seront séparées dans le tableau par les différentes valeurs prises par le champ prix
	case 'articles':$sel_req="SELECT *,round(rand()*800,0) as stock from articles order by prix;";
                        $tri='prix';
                        break;

	//----- pour la table client, on sélectionne tous les champs hormis le pays
	//----- les données seront séparées dans le tableau par les différentes valeurs prises par le champ codepostal
	case 'clients':$sel_req="SELECT numero,nom,prenom,adresse,codepostal,ville from clients order by codepostal;";
                       $tri='codepostal';
                       break;

	//----- pour la table achats, on fait une jointure sur sur la table clients et sur la table produits
	//----- pour afficher à chaque achat, le nom du client, le nom du produit et son prix
	//----- les données seront séparées dans le tableau par les différentes valeurs prises par le champ date
	case 'achats':$sel_req="select ac.id_achat as id,c.nom as acheteur,ac.quantite,a.nom as produit,a.prix,";
		      $sel_req.="ac.quantite*a.prix as total,ac.date from achats as ac ";
		      $sel_req.="inner join clients as c on ac.id_client=c.numero ";
		      $sel_req.="inner join articles as a on ac.id_article=a.reference order by ac.date asc,total desc;";
                      $tri='date';
		      break;

	//----- pour les statistiques, il s'agit d'agrégation et de sommes sur les champs quantité et prix
	//----- des tables jointes articles et achats pour obtenir le chiffre d'affaire par produit
	//----- les données seront séparées dans le tableau par les différentes valeurs prises par le champ Nb_Total qui représente le nombre de ventes par produit	
	default:$sel_req="select a.nom,sum(ac.quantite) as Nb_Total,count(ac.id_achat) as Nb_Commande,";
		$sel_req.="(sum(ac.quantite))/(count(ac.id_achat)) as Moyenne,sum(ac.quantite*a.prix) as ";
		$sel_req.="CA from achats as ac inner join articles as a on ac.id_article=a.reference group ";
		$sel_req.=" by a.nom order by sum(ac.quantite) desc;";
		$tri='Nb_Total';
		$_SESSION['Message']="Choisissez une opération SVP";}

$selection = mysql_query($sel_req,$connectID) or die ("Impossible de sélectionner les données");

//----- Section logique de style qui positionne le tableau listé retourné par la requête
print'<div class="formi">';
print '<table id="tableau" border=1px  cellpadding=2px >';
//print'<caption>Données du fichier '.$_SESSION['Tab'].'</caption>';

//----- la variable last permettra de vérifier si la valeur du champ de tri a changé par rapport à la ligne précédente  
$last="";

//----- la variable ligne nous permettra de n'éditer qu'une seule fois le nom des champs en en tête
$ligne=0;

//---- la variable colonne nous permettra d'enregistrer la valeur de l'identifiant qui éditer le lien à chaque début de ligne
$colonne=0;

while($rows = mysql_fetch_array($selection,MYSQL_ASSOC)) {

if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//----- s'il s'agit de la première ligne, on édite les entêtes de colonne
//----- On rajoute une fonction javascript tri() sur clic de l'en tête qui change la clé de tri du tableau
//----- et qui permettra de trier le tableau, sans à avoir recharger la page
if ($ligne==0) {foreach($rows as $key => $value) {print'<td id="'.$key.'" class="entete" onclick="tri(this.id)">'.$key.'</td>';}
			      
		print'<td class="entete">Opération</td>';}	

	$colonne=0;

	//----- en cas de changement de valeur sur la clé tri, on insère des lignes de séparation dans le tableau
	if(!($rows[$tri]==$last)) {print'<tr></tr><tr><tr/><tr></tr><tr><tr/>';}

	//----- début de la ligne du tableau
	print'<tr class="tableau">';
	
	//----- on édite chaque valeur de champ de la ligne de requête dans une cellule séparée du tableau	
	foreach($rows as $key => $value) {

			//----- si on se trouve en début de ligne, on enregistre la valeur dans la variable identifiant	
			if ($colonne==0) {$identifiant=$value;}	
        
		        print'<td'.$couleur.'>'.$value.'</td>';
			++$colonne;}
			
			//----- le dernier champ n'est pas extrait de la ligne de requête
			//----- on édite le lien qui permettra de construire le formulaire correspondant 
			//----- à l'opération, la table et l'identifiant de ligne choisi par l'utilisateur
			//----- ce lien se présentera sous la forme menu.php?operation=""&table=""$id=""

			//----- le sous menu statistiques n'étant pas lié à une table ou à une opération, il renverra au menu d'accueil
			if($_SESSION['Requ']=='Statistiques') {print'<td'.$couleur.'><a href="'.$_SERVER['PHP_SELF'].'?Operation=Accueil">Retour</a>';}
			  
			   else {print'<td'.$couleur.'><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'&id='.$identifiant.'">'.$_SESSION['Requ'].'</a>';}
	
	//----- fin de la ligne du tableau
	print'</tr>';
	++$ligne;
	$last=$rows[$tri];}

//----- fin du tableau listé
print'</table>';
print'</div>';

mysql_close($connectID);
?>

