<?php 

//-----D�termination du compte utilisateur qui est l'association d'un nom d'utilisateur et l'h�te de cet utiisateur
//-----Vu qu'il n'y a que l'h�te localhost dans ce cas th�orique, on choisit la facilit� de ne chercher que le nom d'utilisateur
  
$id ='"%'.$user.'%"';

//----Connexion � la BDD avec les identifiants rentr�s par l'utilisateur
$connectID = mysql_connect($hosturl, $user, $password);

//----S�lection de la BDD C216_devoir2
mysql_select_db("C216_Devoir2",$connectID);

//----Construction de la requ�te comptant le nombre de type de privil�ge associ� au nom de l'utilisateur sur la BDD C216_Devoir2
//----Dans l'absolu, il n'y aurait pas besoin de mettre une condition sur le nom utilisateur, puisque normalement l'utilisateur
//----n'a les droits que pour consulter ses propres privil�ges et non ceux de l'ensemble des utilisateurs comme peut
//----le faire l'administrateur root...
$sql='select count(distinct privilege_type) as Nb_Priv from information_schema.table_privileges where grantee like '.$id;

$result = mysql_query($sql,$connectID);

while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	
	$nb=$row['Nb_Priv'];}

	//----Si le nombre de privil�ge est > � 1, l'utilisateur est un vendeur car les comptables n'ont que le privil�ge Select
	if ($nb>1) {session_start();
		    $_SESSION['Droits'] = 'Vendeur';}
	
	        //----Si le nombre de privil�ges n'est pas > � 1, l'utilisateur est un comptable, car les vendeurs en ont 4
		else {session_start();
		      $_SESSION['Droits'] = 'Comptable';}
?>

