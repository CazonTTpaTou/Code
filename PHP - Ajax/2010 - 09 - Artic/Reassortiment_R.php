<?php
$connectID=Connexion();

$a=$_POST['N_Client'].',';
$a.="'".$_POST['date']."',";
$a.=$_POST['Livraison'];

if (isset($_GET['Reassortiment']) && ($_GET['Reassortiment']!=0)) {
	$req="UPDATE reassortiment set Numero_Client=".$_POST['N_Client'].",date='".$_POST['date']."',port='".$_POST['port']."',catalogue='".$_POST['Catalogue']."',livraison='".$_POST['Livraison']."' where numero_com=".$_GET['Reassortiment'].";";
	$success=mysql_query($req,$connectID) or die("Impossible d'acc�der aux donn�es");

	if($success) {
	      		$_SESSION['Message']='R�assortiment N� '.$_GET['Reassortiment'].' modifi� !!!';
	                header('Location:Intro.php?Operation=5&Reassortiment='.$_GET['Reassortiment']);}

	else {$_SESSION['Message']='Echec - La r�assortiment N� '.$_GET['Reassortiment'].' n\'a pas �t� modifi�e !!!';
	      header('Location:Intro.php?Operation=0');}	
	}

else {$req="INSERT INTO reassortiment (fournisseur,date,livraison) VALUES (";
	$req.=$a.');';

	//echo $req;

	$success=mysql_query($req,$connectID) or die("Impossible d'acc�der aux donn�es");
	$_SESSION['Last_Insert']=Last_Insertion_Rea();

	if($_POST['rea']=="automatique") {header('Location:Intro.php?Operation=38&Fournisseur='.$_POST['N_Client'].'&Reassortiment='.$_SESSION['Last_Insert']);}
	else{
	if($success) {
	   	      $_SESSION['Message']='Nouveau r�assort N� '.$_SESSION['Last_Insert'].' enregistr�e !!!';
	   	      header('Location:Intro.php?Operation=31&Fournisseur='.$_POST['N_Client'].'&Reassortiment='.$_SESSION['Last_Insert']);}

		else {$_SESSION['Message']='Echec - Le r�assortiment N� '.$_SESSION['Last_Insert'].' n\'a pas �t� enregistr�e !!!';
	      	      header('Location:Intro.php?Operation=0');}}}

?>




