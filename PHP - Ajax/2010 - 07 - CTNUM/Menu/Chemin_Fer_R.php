<?php

$connectID=Connexion();
$a="";

$req="delete from chemin_fer ; ";
$success=mysql_query($req,$connectID) or die ("Impossible d'acc�der aux donn�es");

$ligne=$_SESSION['Nb_pages'];
$_SESSION['Page_chem']=1;
$i=1;

while($i<=$ligne) {

	$nom='Cat'.$i;

	$a.=",(".$i.",";
	$a.=trim(addslashes($_POST[$nom])).')';
	$i++;}

$a[0]=' ';
$req="INSERT INTO chemin_fer (num_page,num_rub) VALUES ".$a." ;";

echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'acc�der aux donn�es");
	
mysql_close($connectID);

if($success) {
	      $_SESSION['Message']='Nouveau chemin de fer enregistr� !!!';      
	      header('Location:Intro.php?Operation=49&Catalogue='.$_GET['Catalogue'].'&Page='.$_SESSION['Page_chem']);
		}

	else {$_SESSION['Message']='Echec - Le nouveau chemin de fer n\'a pas �t� enregistr� !!!';
	      header('Location:Intro.php?Operation=0');}

?>