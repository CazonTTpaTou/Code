<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';
$numero=-1;
//session_start();

include("Fonct.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;
//$op=signe($_POST['Operateur']);

$clause.="id_livre=".$_POST['isbn']."; ";

$sq="select num_ligne,num,titre from commentaires as c inner join rubrique as r on c.id_cat=r.num where ".$clause;
//$sq="select co.numero_com,co.date,co.catalogue,cl.nom,cl.prenom,cl.code_postal,cl.ville,sum(li.quantite) as Nb_livre,sum(li.quantite*liv.prix)+co.port as Montant from commande as co inner join clients as cl on co.Numero_Client=cl.numero inner join ligne_commande as li on li.numero_com=co.numero_com inner join livres as liv on liv.numero=li.numero_livre  where co.numero_com>0 ".$clause." group by co.numero_com;";
//echo $sq;
//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();

$nom=$_POST['num'];
$ligne=0;

$product='P_num_'.$nom;
$id='1000_'.$nom; 
$menu='Menu'.$nom;
$co='Comm'.$nom;

		 	$Choix=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");

			//----- d�but de la liste d�roulante
			//$Code[]='<span id="'.$id.'" class="libelle" >';
			$Code[]='<select name="'.$co.'" size ="1" id="'.$menu.'" >';

			$Code[]='<option value ="" name="none">Choix du commentaire</option>';

			//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
			while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

			//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
			if($Choice['num_ligne']==$numero) {$selec="selected";} else {$selec="";}

			//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
			$Code[]='<option value="'.$Choice['num_ligne'].'" '.$selec.' >'.$Choice['num'].' - '.$Choice['titre']. '</option>';}
			
			//----- fin de la liste d�roulante
			$Code[]='</select>';
			//$Code[]='</span>';

foreach($Code as $value) {echo $value;}

?>