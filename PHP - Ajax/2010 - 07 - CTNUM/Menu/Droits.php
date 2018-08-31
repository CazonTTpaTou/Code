<?php 

//-----Détermination du compte utilisateur qui est l'association d'un nom d'utilisateur et l'hôte de cet utiisateur
//-----Vu qu'il n'y a que l'hôte localhost dans ce cas théorique, on choisit la facilité de ne chercher que le nom d'utilisateur
  
$id ='"%'.$user.'%"';

//----Connexion à la BDD avec les identifiants rentrés par l'utilisateur
$connectID = mysql_connect($hosturl, $user, $password);

//----Sélection de la BDD C216_devoir2
mysql_select_db("C216_Devoir2",$connectID);

//----Construction de la requête comptant le nombre de type de privilège associé au nom de l'utilisateur sur la BDD C216_Devoir2
//----Dans l'absolu, il n'y aurait pas besoin de mettre une condition sur le nom utilisateur, puisque normalement l'utilisateur
//----n'a les droits que pour consulter ses propres privilèges et non ceux de l'ensemble des utilisateurs comme peut
//----le faire l'administrateur root...
$sql='select count(distinct privilege_type) as Nb_Priv from information_schema.table_privileges where grantee like '.$id;

$result = mysql_query($sql,$connectID);

while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	
	$nb=$row['Nb_Priv'];}

	//----Si le nombre de privilège est > à 1, l'utilisateur est un vendeur car les comptables n'ont que le privilège Select
	if ($nb>1) {session_start();
		    $_SESSION['Droits'] = 'Vendeur';}
	
	        //----Si le nombre de privilèges n'est pas > à 1, l'utilisateur est un comptable, car les vendeurs en ont 4
		else {session_start();
		      $_SESSION['Droits'] = 'Comptable';}
?>

