<?php 
//----Nouvelle section logique pour la mise en page: Un encadr� avec le titre MENU
echo'<div class="choix">';
echo'<span class="menu">MENU</span>';
echo'</div>';

//----Initialisation de la variable Category qui contiendra le titre de famille de chaque type de privil�ges accord�s sur les tables
$Category='';
$nb=0;

//----Nouvelle section logique de mise en page: La liste � puce de chaque privil�ge table de l'utilisateur qui constituera le menu
echo'<div class="choix1">';
echo'<ol type="I">';

$i=1;
while($i<=$_SESSION['Nb_droits']) {

$ent='Droit'.$i;
//----On traduit chaque famille de privil�ge en fran�ais pour une meilleure compr�hension du menu
switch (trim($_SESSION[$ent]['privilege_type'])) {
				
					case 'SELECT':$_SESSION[$ent]['privilege_type']='Consultation';break;
					case 'UPDATE':$_SESSION[$ent]['privilege_type']='Modification';break;
					case 'DELETE':$_SESSION[$ent]['privilege_type']='Suppression';break;
					case 'INSERT':$_SESSION[$ent]['privilege_type']='Insertion';break;}
	
	//---- A chaque privil�ge de table trouv� par la requ�te, on �dite un lien qui renvoie vers l'URL suivante:
	//---- http://Domaine/Menu.php?Operation=TYPE DE PRIVILEGE & Table= TABLE ASSOCIE AU TYPE DE PRIVILEGE
		if ($Category==$_SESSION[$ent]['privilege_type'])  {
			++$nb;
		        print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION[$ent]['privilege_type'].'&Table='.$_SESSION[$ent]['table_name'].'">'.$nb.' '.$_SESSION[$ent]['table_name'].'</a>';
			echo'<br/>';
		}

		//----On fait en sorte de n'afficher qu'une seule fois le type de privil�ge pour chaque sous menu, d'o� la variable Category
		else {$Category=$_SESSION[$ent]['privilege_type'];  
		      if($nb<>0) {echo'<br/>';}
                      echo '<li class="menub">'.trim($_SESSION[$ent]['privilege_type']).'</li>';
		      $nb=1;
		      print'<td><a href="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION[$ent]['privilege_type'].'&Table='.$_SESSION[$ent]['table_name'].'">'.$nb.' '.$_SESSION[$ent]['table_name'].'</a>';
		      echo'<br/>';}
	$i++;}
echo'<br/>';
echo'</ol>';
echo'</div>';		 	
?>