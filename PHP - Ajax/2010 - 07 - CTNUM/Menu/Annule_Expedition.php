<?php

$connectID=Connexion();

if(isset($_GET['Expedition']))  {

	$exp=$_GET['Expedition'];
	$sql="delete from expedition where numero_co=".$exp;
	$success=mysql_query($sql,$connectID) or die ("Impossible d'acc�der aux donn�es");
	
	if($success) {$Last=Last_Insertion_client();
	      $_SESSION['Message']='L\'exp�dition N� '.$exp.' a �t� supprim�e !!!';
	      
	      header('Location:Intro.php?Operation=0');}

	else {$_SESSION['Message']='Echec - L\'exp�dition n\'a pas �t� supprim�e !!!';
	      header('Location:Intro.php?Operation=0');}}

else {$_SESSION['Message']='Echec - L\'exp�dition n\'a pas �t� supprim�e !!!';
	      header('Location:Intro.php?Operation=0');}

?>