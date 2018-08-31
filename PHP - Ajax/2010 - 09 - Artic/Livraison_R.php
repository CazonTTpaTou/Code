<?php
$connectID=Connexion();

$a=$_POST['Fournisseur'].',';
$a.="'".$_POST['date']."',";
$a.="'".$_POST['port']."',";
$a.="'".$_POST['Reas1']."',";
$a.="'".$_POST['Reas2']."',";
$a.="'".$_POST['Reas3']."',";
$a.=$_POST['Livraison'];

if (isset($_GET['Livraison']) && (isset($_GET['Livraison'])!=0)) {
	
	//$req="update reassortiment set etat=0 where numero in (select catalogue from livraison where numero_com=".$_GET['Livraison'].");";
	//$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
	$req="UPDATE livraison set Numero_Client=".$_POST['Fournisseur'].",date='".$_POST['date']."',port='".$_POST['port']."',catalogue='".$_POST['Reas1']."',catalogue_2='".$_POST['Reas2']."',catalogue_3='".$_POST['Reas3']."',livraison='".$_POST['Livraison']."' where numero_com=".$_GET['Livraison'].";";
	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
	$req="update reassortiment set etat=2 where numero in (select catalogue from livraison where numero_com=".$_GET['Livraison']." union select catalogue_2 from livraison where numero_com=".$_GET['Livraison']." union select catalogue_3 from livraison where numero_com=".$_GET['Livraison'].");";
	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
//select catalogue from livraison where numero_com=".$_GET['Livraison']." union select catalogue_2 from livraison where numero_com=".$_GET['Livraison']." union select catalogue_3 from livraison where numero_com=".$_GET['Livraison'].";

	if($success) {
	      		$_SESSION['Message']='Livraison N° '.$_GET['Livraison'].' modifiée !!!';
	                header('Location:Intro.php?Operation=36&Livraison='.$_GET['Livraison']);}

	else {$_SESSION['Message']='Echec - La Livraison N° '.$_GET['Livraison'].' n\'a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');}	
	}

else {$req="INSERT INTO Livraison (Numero_Client,date,port,catalogue,catalogue_2,catalogue_3,livraison) VALUES (";
	$req.=$a.');';

	//echo $req;

	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

	$_SESSION['Last_Insert']=Last_Insertion_Liv();
	mysql_close($connectID);

	$connectID=Connexion();

	$req="update reassortiment set etat=2 where numero in (select catalogue from livraison where numero_com=".$_SESSION['Last_Insert']." union select catalogue_2 from livraison where numero_com=".$_SESSION['Last_Insert']." union select catalogue_3 from livraison where numero_com=".$_SESSION['Last_Insert'].");";
	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");	

	if($success) {
	   	      $_SESSION['Message']='Nouvelle Livraison N° '.$_SESSION['Last_Insert'].' enregistrée !!!';
	   	      header('Location:Intro.php?Operation=35&id='.$_SESSION['Last_Insert']);}

		else {$_SESSION['Message']='Echec - La Livraison N° '.$_SESSION['Last_Insert'].' n\'a pas été enregistrée !!!';
	      	      header('Location:Intro.php?Operation=0');}}

?>




