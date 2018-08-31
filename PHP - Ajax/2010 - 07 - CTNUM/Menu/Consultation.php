<?php

//----- On se connecte � la BDD
$connectID=Connexion();

//----- Suivant la table choisie par l'utilisateur dans le menu, on construit la requ�te de s�lection correspondante
switch($_SESSION['Tab']) {

	//----- pour la table articles, on ins�re un champ artificiel stock pour meubler un peu le tableau
	//----- les donn�es seront s�par�es dans le tableau par les diff�rentes valeurs prises par le champ prix
	case 'clients':$sel_req="SELECT numero,nom,prenom,code_postal,ville from clients;";            
                        break;

	case 'ad_livraison':$sel_req="SELECT numero,nom,prenom,code_postal,ville from clients;";            
                        break;

	case 'livres':$sel_req="SELECT numero,auteur,titre,prix from livres;";
                        break;	
	
	//----- pour la table client, on s�lectionne tous les champs hormis le pays
	//----- les donn�es seront s�par�es dans le tableau par les diff�rentes valeurs prises par le champ codepostal
	case 'commande':$sel_req="select c.numero_com,c.date,cl.nom,cl.code_postal,sum(lig.quantite) as Nb_Livre,sum(li.prix*lig.quantite) as Total ";
                        $sel_req.="from commande as c inner join clients as cl on c.numero_client=cl.numero inner join ";
			$sel_req.="ligne_commande as lig on c.numero_com=lig.numero_com ";
			$sel_req.="inner join livres as li on lig.numero_livre=li.numero group by c.numero_com;";
                       break;

	default: $sel_req="SELECT * from ".$_SESSION['Tab'].";";}

$selection = mysql_query($sel_req,$connectID) or die ("Impossible de s�lectionner les donn�es");

//----- Section logique de style qui positionne le tableau list� retourn� par la requ�te
print'<div class="formi">';
print '<table id="tableau" border=1px  cellpadding=2px >';
//print'<caption>Donn�es du fichier '.$_SESSION['Tab'].'</caption>';

//----- la variable last permettra de v�rifier si la valeur du champ de tri a chang� par rapport � la ligne pr�c�dente  
$last="";

//----- la variable ligne nous permettra de n'�diter qu'une seule fois le nom des champs en en t�te
$ligne=0;

//---- la variable colonne nous permettra d'enregistrer la valeur de l'identifiant qui �diter le lien � chaque d�but de ligne
$colonne=0;

while($rows = mysql_fetch_array($selection,MYSQL_ASSOC)) {

if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//----- s'il s'agit de la premi�re ligne, on �dite les ent�tes de colonne
//----- On rajoute une fonction javascript tri() sur clic de l'en t�te qui change la cl� de tri du tableau
//----- et qui permettra de trier le tableau, sans � avoir recharger la page
if ($ligne==0) {foreach($rows as $key => $value) {print'<td id="'.$key.'" class="entete" onclick="tri(this.id)">'.$key.'</td>';}
			      
		print'<td class="entete">Op�ration</td>';}	

	$colonne=0;

	//----- en cas de changement de valeur sur la cl� tri, on ins�re des lignes de s�paration dans le tableau
	//if(!($rows[$tri]==$last)) {print'<tr></tr><tr><tr/><tr></tr><tr><tr/>';}

	//----- d�but de la ligne du tableau
	print'<tr class="tableau">';
	
	//----- on �dite chaque valeur de champ de la ligne de requ�te dans une cellule s�par�e du tableau	
	foreach($rows as $key => $value) {

			//----- si on se trouve en d�but de ligne, on enregistre la valeur dans la variable identifiant	
			if ($colonne==0) {$identifiant=$value;}	
        
		        print'<td'.$couleur.'>'.$value.'</td>';
			++$colonne;}
			
			//----- le dernier champ n'est pas extrait de la ligne de requ�te
			//----- on �dite le lien qui permettra de construire le formulaire correspondant 
			//----- � l'op�ration, la table et l'identifiant de ligne choisi par l'utilisateur
			//----- ce lien se pr�sentera sous la forme menu.php?operation=""&table=""$id=""

			//----- le sous menu statistiques n'�tant pas li� � une table ou � une op�ration, il renverra au menu d'accueil
			if($_SESSION['Requ']=='Statistiques') {print'<td'.$couleur.'><a href="'.$_SERVER['PHP_SELF'].'?Operation=Accueil">Retour</a>';}
			  
			   else {print'<td'.$couleur.'><a href="Fact_Edition.php?id='.$identifiant.'">'.$_SESSION['Requ'].'</a>';}
	
	//----- fin de la ligne du tableau
	print'</tr>';
	++$ligne;
	//$last=$rows[$tri];
	}

//----- fin du tableau list�
print'</table>';
print'</div>';

mysql_close($connectID);
?>

