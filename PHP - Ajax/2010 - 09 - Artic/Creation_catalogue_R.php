<?php
$connectID=Connexion();

$a="('".trim(addslashes($_POST['Nom_Cat']))."',";
$a.=trim(addslashes($_POST['Nb_envoi'])).",";
$a.="'".trim(addslashes($_POST['Begin']))."',";
$a.="'".trim(addslashes($_POST['End']))."',";
$a.=trim(addslashes($_POST['Nb_pages'])).");";

$req="INSERT INTO catalogue (nom,nb_envoi,date_debut,date_fin,nb_pages) VALUES ".$a;

//echo $req;

mysql_close($req,$connectID);

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
if($success) {$Last=Last_Insertion_Cat();
	      $_SESSION['Message']='Nouveau catalogue enregistré !!!';
	      
	      header('Location:Intro.php?Operation=0');}

	else {$_SESSION['Message']='Echec - Le nouveau catalogue n\'a pas été enregistré !!!';
	      header('Location:Intro.php?Operation=0');}

?>




