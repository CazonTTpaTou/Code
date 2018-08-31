<?php
$connectID=Connexion();

$a=$_POST['N_Client'].',';
$a.="'".$_POST['date']."',";
$a.="'".$_POST['port']."',";
$a.=$_POST['Catalogue'].',';
$a.="'".$_POST['livres']."',";

//print $a;


if (isset($_GET['Commande']) && ($_GET['Commande']!=0)) {
	$req="UPDATE commande set Numero_Client=".$_POST['N_Client'].",date='".$_POST['date']."',port='".$_POST['port']."',catalogue='".$_POST['Catalogue']."',livraison='".$_POST['livres']."' where numero_com=".$_GET['Commande'].";";
	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

	if($success) {
	      		$_SESSION['Message']='Commande N° '.$_GET['Commande'].' modifiée !!!';
	                header('Location:Intro.php?Operation=9');}

	else {$_SESSION['Message']='Echec - La commande N° '.$_GET['Commande'].' n\'a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');}	
	}

else {$req="INSERT INTO commande (Numero_Client,date,port,catalogue,livraison) VALUES (";
	$req.=$a.');';

	//echo $req;

	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");



	if($success) {$_SESSION['Last_Insert']=Last_Insertion_Com();
	   	      $_SESSION['Message']='Nouvelle commande N° '.$_SESSION['Last_Insert'].' enregistrée !!!';
	   	      header('Location:Intro.php?Operation=66');
			}

		else {$_SESSION['Message']='Echec - La commande N° '.$_SESSION['Last_Insert'].' n\'a pas été enregistrée !!!';
	      	      header('Location:Intro.php?Operation=0');}}

?>




