<?php

include("Connexion.php");

//----- On construit une requête qui décrit la structure de la table enregistrée dans la variable de session en cours
$sqls='desc '.@$_SESSION['Tab'].';';

$result = mysql_query($sqls,$connectID) or die("Impossible d'accéder aux données");
$nbc=0;

//----- On va stocker les différents renseignements de structure de la table dans deux tableaux
//----- Ce procédé nous permet de faire l'économie de nombreuses lignes de codes en appelant des champs de façon
//----- générique sans rentrer en dur leur nom ou leur type dans l'algorithme
while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	
        foreach($row as $key => $value) {

		//----- on stocke dans un tableau Champ le nom des champs de la table choisie
		if($key=='Field') {$Champ[] = $value;
				   ++$nbc;}

		//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie	
		if($key=='Type') {$Champ1[] = $value;}
				   }}

//----- On ferme la connexion à la BDD
mysql_close($connectID);


?>

