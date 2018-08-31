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
				$requete='DELETE from ligne_commande where numero_com='.$_GET['Commande'].' and num_ligne='.$_POST[$c].' ;';}

			else {$requete='UPDATE ligne_commande SET numero_livre='.$_POST[$a].', quantite='.$_POST[$b];
			      $requete.=' where numero_com='.$_GET['Commande'].' and num_ligne='.$_POST[$c].' ;';}
			echo $requete;
			$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}
		$i++;}

$ligne_sup=$_SESSION['N_Lig_com'];

		$a='P_num_'.$i;
		$b='quantite'.$i;

	while($i<=$ligne_sup) {
		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO ligne_commande (numero_com,numero_livre,quantite) values(';
				$requete.=$_GET['Commande'].','.$_POST[$a].','.$_POST[$b].');';
				echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

$_SESSION['Message']='La commande n° '.$_GET['Commande'].' a été modifiée !!!';
mysql_close($connectID);
$adresse='Fact_Edition.php?id='.$_GET['Commande'];
header('Location: '.$adresse);
?>