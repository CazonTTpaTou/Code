<?php

include("Connexion.php");

//----- On construit une requ�te qui d�crit la structure de la table enregistr�e dans la variable de session en cours
$sqls='desc '.@$_SESSION['Tab'].';';

$result = mysql_query($sqls,$connectID) or die("Impossible d'acc�der aux donn�es");
$nbc=0;

//----- On va stocker les diff�rents renseignements de structure de la table dans deux tableaux
//----- Ce proc�d� nous permet de faire l'�conomie de nombreuses lignes de codes en appelant des champs de fa�on
//----- g�n�rique sans rentrer en dur leur nom ou leur type dans l'algorithme
while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	
        foreach($row as $key => $value) {

		//----- on stocke dans un tableau Champ le nom des champs de la table choisie
		if($key=='Field') {$Champ[] = $value;
				   ++$nbc;}

		//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie	
		if($key=='Type') {$Champ1[] = $value;}
				   }}

//----- On ferme la connexion � la BDD
mysql_close($connectID);


?>

