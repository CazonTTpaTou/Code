<?php

$ligne=$_SESSION['N_Lig_com']-$_SESSION['Lig_sup'];
//echo 'Ligne: '.$ligne;

$i=1;
$connectID=Connexion();

	while($i<=$ligne) {

		$a='P_num_'.$i;
		$b='quantite'.$i;
		$c='num_ligne'.$i;

		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]==0)) {
				$requete='DELETE from ligne_livraison where numero_com='.$_GET['Livraison'].' and num_ligne='.$_POST[$c].' ;';}

			else {$requete='UPDATE ligne_commande SET numero_livre='.$_POST[$a].', quantite='.$_POST[$b];
			      $requete.=' where numero_com='.$_GET['Livraison'].' and num_ligne='.$_POST[$c].' ;';}
			echo $requete;
			$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}
		$i++;}

$ligne_sup=$_SESSION['N_Lig_com'];

		$a='P_num_'.$i;
		$b='quantite'.$i;

	while($i<=$ligne_sup) {
		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO ligne_livraison (numero_com,numero_livre,quantite) values(';
				$requete.=$_GET['Livraison'].','.$_POST[$a].','.$_POST[$b].');';
				echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

$_SESSION['Message']='La livraison n° '.$_GET['Livraison'].' a été modifiée !!!';
mysql_close($connectID);

include('Reliquat.php');

$adresse='Intro.php?Operation=0';
//header('Location: '.$adresse);
?>