<?php

header('Content-type: text/html; charset=iso-8859-1'); 

//session_start();

include("Fonc.php");

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'opère pas de tri sur la sélection
if(isset($_POST['family'])) {$col="'".$_POST['family']."'";}
	else {$col=";";}

$_SESSION['Last_Menu']=$col;

$sq="select ref,sous_menu from menu where droit<=".$_SESSION['Grant']." AND menu=".$col.";";
$req="SELECT distinct menu from menu;";

//------- Connexion à la BDD et lancement de la requête de tri-sélection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'accéder aux données2");
$selection = mysql_query($req,$connectID) or die ("Impossible de sélectionner les données");

$ligne=1;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoyées par xmlhttprequet.responseText
$last="";

$Code[]='<table id="tableau" color:#000000 height=100% width=100% background-color:#FFFFFF border=0px  cellpadding=2px >';

while($rows = mysql_fetch_array($selection,MYSQL_ASSOC)) {
	$Code[]='<tr>';
	$men="'".$rows['menu']."'";
		
	//$Code[]=$col;
	
	if ($men==$col) {	  $Code[]='<td id="'.$rows['menu'].'" class="tabl2" onClick="choix(this.id)" >'.$rows['menu'].'</td>';
				  $Code[]='<td>';
				  $Code[]= '<table>';

				//------- On extrait chaque ligne de la requête pour la convertir en code html qu'on stocke dans le tableau code
				while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

					$Code[]='<tr>';

					//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
					if($ligne%2 == 0) {$couleur=' class="fond2" ';}
						else {$couleur=' class="fond1" ';}

			      	  	 $Code[]='<td'.$couleur.'>';
					 $Code[]='<a href="Intro.php?Operation='.$row['ref'].'">'.$ligne.'-'.$row['sous_menu'].'</a>';
					 $Code[]='</td>';
					 $Code[]='</tr>';

					 ++$ligne;}

				$Code[]='</table>';
				$Code[]='</td>';}

		else {$Code[]='<td id="'.$rows['menu'].'" class="tabl" onClick="choix(this.id)" >'.$rows['menu'].'</td>';
		      $Code[]='<td id="'.$rows['menu'].'1" class="tabl1" ></td>';}	
	$Code[]='</tr>';}
	

$Code[]='</table>';
$Code[]='</div>';

//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml

foreach($Code as $value) {echo $value;}

mysql_close($connectID);

?>