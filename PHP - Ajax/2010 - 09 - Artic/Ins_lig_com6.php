<?php

$i=1;
$connecID=Connexion();

$requete='UPDATE commande SET Numero_Client='.$_POST['numero_com'].', date=';
$requete.="'";
$requete.=$_POST['date'];
$requete.="'";
$requete.=', port='.$_POST['port'].',catalogue='.$_POST['catalogue'];
$requete.=' where numero_com='.$_POST['numero_com'].';';

echo $requete;

$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");

$a=1;
$i=$_SESSION['N_Lig_com'];
$_POST['numero']=$_POST['numero1'];
//echo 'nombre ligne:'.$_SESSION['N_Lig_com'];

$roq="select num_ligne from ligne_commande where numero_com=".$_POST['numero_com'].";";
//echo $roq;
$suc = mysql_query($roq,$connectID) or die ("Impossible d'accéder aux données");

while($ligne = mysql_fetch_array($suc,MYSQL_ASSOC)) {
	
	$qt='quantite'.$a;
	$nl='numero'.$a;
	$requete='UPDATE ligne_commande SET numero_livre='.$_POST[$nl].', quantite='.$_POST[$qt];
	$requete.=' where numero_com='.$_POST['numero_com'].' and num_ligne='.$ligne['num_ligne'].';';
	//echo'<br/>';echo $requete;
	$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données2");
	$a++;
	}

	$_SESSION['Message']='Votre requête: modification de Commande réussie !!!';
	     
$_SESSION['Operation']="Accueil";
mysql_close($connectID);

header('Location: Fact_Edition.php?id='.$_POST['numero_com']);

?>

