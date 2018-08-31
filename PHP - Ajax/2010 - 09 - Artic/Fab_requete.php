<?php

//-----1er cas, l'utilisateur a choisi une requête d'insertion, on va donc fabriquer une requête de la forme INSERT
if ($_SESSION['Requ']=='Insertion') {
	$requete='INSERT INTO '.$_SESSION['Tab'].' (';
       
	//----- A partir de Liste_Champ, on lance une requête de type desc sur la table sélectionnée par l'utilisateur
	//----- on stocke dans un tableau Champ le nom des champs de la table choisie
	//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie
	include("Liste_champ.php");
	$requete1="(";
	
	//----- On débute au deuxième champ, car le premier champ dans les 3 tables est de type auto increment
	//----- De ce fait, on ne peut insérer de valeurs dans ce champ par le biais d'une requête insertion
	//----- C'est pourquoi, on initialise l'indice de tableau nbcd à la valeur 1
	$nbcd=1;
	
	//----- Tant que l'indice nbcd est inférieur à la longueur nbc du tableau Champ qui contient les noms de champs de la table
	 while($nbcd<$nbc) {
	  	
		 //----- On encapsule les valeurs extraites de la requête dans le type requis par le format de leur variable
	  	 include("Encapsulation.php");

		 //----- On ajoute nom de champ et valeur associée autant de fois qu'il y a de différents champs dans la table
	  	 $requete = $requete.$Champ[$nbcd].',';			      
	  	 $requete1 = $requete1."'".$valeur."',";
	  	 ++$nbcd;}
           
	   //----- On supprime la dernière virgule de l'expression obtenue pour se conformer à la doxa
	   $requete{strlen($requete)-1}=')';
	   $requete1{strlen($requete1)-1}=')';

	   //----- On obtient la formulation de requête qu'on soumettra à la BDD 
           $requete= $requete.' VALUES '.$requete1.' ;';}

//----- 2ème cas, l'utilisateur a choisi une requête de modification, on va donc fabriquer une requête de la forme UPDATE
if ($_SESSION['Requ']=='Modification') {
	$requete='UPDATE '.$_SESSION['Tab'].' SET ';

	//----- A partir de Liste_Champ, on lance une requête de type desc sur la table sélectionnée par l'utilisateur
	//----- on stocke dans un tableau Champ le nom des champs de la table choisie
	//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie
	include("Liste_champ.php");

	$requete1="";
	$nbcd=0;
	
	//----- Tant que l'indice nbcd est inférieur à la longueur nbc du tableau Champ qui contient les noms de champs de la table
	while($nbcd<$nbc) {

		//----- On encapsule les valeurs extraites de la requête dans le type requis par le format de leur variable
		include("Encapsulation.php");

		//----- Fabrication du début du corps de la requête
		if ($nbcd==0) {$requete1=" WHERE ".$Champ[$nbcd]."='".$valeur."'".";";}

		else {$requete.= $Champ[$nbcd]."="."'".$valeur."'".',';}
		++$nbcd;}

	$requete=substr($requete,0,strlen($requete)-1);
	$requete .= $requete1;}

//----- 3ème cas, l'utilisateur a choisi une requête de suppression on va donc fabriquer une requête de la forme DELETE
if ($_SESSION['Requ']=='Suppression') {

	$nbcd=0;
	$requete="DELETE FROM ".$_SESSION['Tab'];

	//----- A partir de Liste_Champ, on lance une requête de type desc sur la table sélectionnée par l'utilisateur
	//----- on stocke dans un tableau Champ le nom des champs de la table choisie
	//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie
	include("Liste_champ.php");

	include("Encapsulation.php");
	$requete.= " WHERE ".$Champ[0]."="."'".$valeur."'".";";}

	   
?>


	