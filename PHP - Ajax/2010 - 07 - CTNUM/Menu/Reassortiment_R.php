<?php
$connectID=Connexion();

$a=$_POST['N_Client'].',';
$a.="'".$_POST['date']."',";
$a.=$_POST['Livraison'];

if (isset($_GET['Reassortiment']) && ($_GET['Reassortiment']!=0)) {
	$req="UPDATE reassortiment set Numero_Client=".$_POST['N_Client'].",date='".$_POST['date']."',port='".$_POST['port']."',catalogue='".$_POST['Catalogue']."',livraison='".$_POST['Livraison']."' where numero_com=".$_GET['Reassortiment'].";";
	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

	if($success) {
	      		$_SESSION['Message']='Réassortiment N° '.$_GET['Reassortiment'].' modifié !!!';
	                header('Location:Intro.php?Operation=5&Reassortiment='.$_GET['Reassortiment']);}

	else {$_SESSION['Message']='Echec - La réassortiment N° '.$_GET['Reassortiment'].' n\'a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');}	
	}

else {$req="INSERT INTO reassortiment (fournisseur,date,livraison) VALUES (";
	$req.=$a.');';

	//echo $req;

	$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	$_SESSION['Last_Insert']=Last_Insertion_Rea();

	if($_POST['rea']=="automatique") {header('Location:Intro.php?Operation=38&Fournisseur='.$_POST['N_Client'].'&Reassortiment='.$_SESSION['Last_Insert']);}
	else{
	if($success) {
	   	      $_SESSION['Message']='Nouveau réassort N° '.$_SESSION['Last_Insert'].' enregistrée !!!';
	   	      header('Location:Intro.php?Operation=31&Fournisseur='.$_POST['N_Client'].'&Reassortiment='.$_SESSION['Last_Insert']);}

		else {$_SESSION['Message']='Echec - Le réassortiment N° '.$_SESSION['Last_Insert'].' n\'a pas été enregistrée !!!';
	      	      header('Location:Intro.php?Operation=0');}}}

?>




