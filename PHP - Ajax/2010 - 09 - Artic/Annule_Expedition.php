<?php

$connectID=Connexion();

if(isset($_GET['Expedition']))  {

	$exp=$_GET['Expedition'];
	$sql="delete from expedition where numero_co=".$exp;
	$success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
	
	if($success) {$Last=Last_Insertion_client();
	      $_SESSION['Message']='L\'expédition N° '.$exp.' a été supprimée !!!';
	      
	      header('Location:Intro.php?Operation=0');}

	else {$_SESSION['Message']='Echec - L\'expédition n\'a pas été supprimée !!!';
	      header('Location:Intro.php?Operation=0');}}

else {$_SESSION['Message']='Echec - L\'expédition n\'a pas été supprimée !!!';
	      header('Location:Intro.php?Operation=0');}

?>