<?php 

//----Nouvelle section logique pour la mise en page: Un encadr� avec le titre MENU
echo'<div class="choix">';
echo'<span class="menu">MENU</span>';
echo'</div>';

//----Connexion � la BDD C216_Devoir2
include("Connexion.php");

//----Construction de la requ�te recensant les diff�rents types de privil�ges de l'utilisateur
$sqls='select privilege_type,table_name from information_schema.table_privileges where grantee like '.$id.' order by privilege_type,table_name';

$result = mysql_query($sqls,$connectID);

//----Initialisation de la variable Category qui contiendra le titre de famille de chaque type de privil�ges accord�s sur les tables
$Category='';
$nb=0;

//----Nouvelle section logique de mise en page: La liste � puce de chaque privil�ge table de l'utilisateur qui constituera le menu
echo'<div class="choix1">';
echo'<ol type="I">';

while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

//----On traduit chaque famille de privil�ge en fran�ais pour une meilleure compr�hension du menu
switch ($row['privilege_type']) {
				
					case 'SELECT':$row['privilege_type']='Consultation';break;
					case 'UPDATE':$row['privilege_type']='Modification';break;
					case 'DELETE':$row['privilege_type']='Suppression';break;
					case 'INSERT':$row['privilege_type']='Insertion';break;}
	
	//---- A chaque privil�ge de table trouv� par la requ�te, on �dite un lien qui renvoie vers l'URL suivante:
	//---- http://Domaine/Menu.php?Operation=TYPE DE PRIVILEGE & Table= TABLE ASSOCIE AU TYPE DE PRIVILEGE
	if ($Category==$row['privilege_type']) {
			++$nb;
		        print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$row['privilege_type'].'&Table='.$row['table_name'].'">'.$nb.' '.$row['table_name'].'</a>';
			echo'<br/>';}

		//----On fait en sorte de n'afficher qu'une seule fois le type de privil�ge pour chaque sous menu, d'o� la variable Category
		else {$Category=$row['privilege_type'];  
		      if($nb<>0) {echo'<br/>';}
                      echo '<li class="menub">'.$row['privilege_type'].'</li>';
		      $nb=1;
		      print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$row['privilege_type'].'&Table='.$row['table_name'].'">'.$nb.' '.$row['table_name'].'</a>';
		      echo'<br/>';}
	}

echo'<br/>';

//---- On rajoute le sous menu STATISTIQUES pour le profil comptable, qui n'est pas associ� � une table sp�cifique 
if ($_SESSION['Droits']=='Comptable')
	{echo'<li class="menub">Statistiques</li>';
	 print'<a href="'.$_SERVER['PHP_SELF'].'?Operation=Statistiques">1 G�n�ral</a>';}
echo'</ol>';
echo'</div>';		 

	
?>

