<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$numero=-1;
//session_start();

include("Fonct.php");

//------- La variable nous servira pour éditer les en têtes de champs
$ligne=0;
//$op=signe($_POST['Operateur']);

$clause.="isbn like '".$_POST['isbn']."' ";

$sq="select numero from livres where ".$clause." ;";
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();

$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	$numero=$row['numero'];}

$nom=$_POST['num'];
$ligne=0;

$product='P_num_'.$nom;
$id='P_num_id'.$nom;
		 
		 	$sqli="select numero,titre,ISBN from livres order by numero asc;";

			$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

			//----- début de la liste déroulante
			//$Code[]='<span id="'.$id.'" class="libelle" >';
			$Code[]='<select name="'.$product.'" size ="1">';

			$Code[]='<option value ="" name="none">Choisissez un ISBN</option>';

			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
			if($Choice['numero']==$numero) {$selec="selected";} else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			$Code[]='<option value="'.$Choice['numero'].'" '.$selec.' >'.$Choice['ISBN'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste déroulante
			$Code[]='</select>';
			//$Code[]='</span>';

foreach($Code as $value) {echo $value;}

?>