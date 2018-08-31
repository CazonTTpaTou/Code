<?php 

//----Nouvelle section logique pour la mise en page: Un encadré avec le titre MENU
echo'<div class="choix">';
echo'<span class="menu">MENU</span>';
echo'</div>';

//----Connexion à la BDD C216_Devoir2
include("Connexion.php");

//----Construction de la requête recensant les différents types de privilèges de l'utilisateur
$sqls='select privilege_type,table_name from information_schema.table_privileges where grantee like '.$id.' order by privilege_type,table_name';

$result = mysql_query($sqls,$connectID);

//----Initialisation de la variable Category qui contiendra le titre de famille de chaque type de privilèges accordés sur les tables
$Category='';
$nb=0;

//----Nouvelle section logique de mise en page: La liste à puce de chaque privilège table de l'utilisateur qui constituera le menu
echo'<div class="choix1">';
echo'<ol type="I">';

while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

//----On traduit chaque famille de privilège en français pour une meilleure compréhension du menu
switch ($row['privilege_type']) {
				
					case 'SELECT':$row['privilege_type']='Consultation';break;
					case 'UPDATE':$row['privilege_type']='Modification';break;
					case 'DELETE':$row['privilege_type']='Suppression';break;
					case 'INSERT':$row['privilege_type']='Insertion';break;}
	
	//---- A chaque privilège de table trouvé par la requête, on édite un lien qui renvoie vers l'URL suivante:
	//---- http://Domaine/Menu.php?Operation=TYPE DE PRIVILEGE & Table= TABLE ASSOCIE AU TYPE DE PRIVILEGE
	if ($Category==$row['privilege_type']) {
			++$nb;
		        print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$row['privilege_type'].'&Table='.$row['table_name'].'">'.$nb.' '.$row['table_name'].'</a>';
			echo'<br/>';}

		//----On fait en sorte de n'afficher qu'une seule fois le type de privilège pour chaque sous menu, d'où la variable Category
		else {$Category=$row['privilege_type'];  
		      if($nb<>0) {echo'<br/>';}
                      echo '<li class="menub">'.$row['privilege_type'].'</li>';
		      $nb=1;
		      print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$row['privilege_type'].'&Table='.$row['table_name'].'">'.$nb.' '.$row['table_name'].'</a>';
		      echo'<br/>';}
	}

echo'<br/>';

//---- On rajoute le sous menu STATISTIQUES pour le profil comptable, qui n'est pas associé à une table spécifique 
if ($_SESSION['Droits']=='Comptable')
	{echo'<li class="menub">Statistiques</li>';
	 print'<a href="'.$_SERVER['PHP_SELF'].'?Operation=Statistiques">1 Général</a>';}
echo'</ol>';
echo'</div>';		 

	
?>

