<?php

$i=1;

$connectID=Connexion();

$ligne_sup=$_SESSION['N_Lig_com'];

	while($i<=$ligne_sup) {

		$a='P_num_'.$i;
		$b='quantite'.$i;

		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO ligne_livraison (numero_com,numero_livre,quantite) values(';
				$requete.=$_GET['Livraison'].','.$_POST[$a].','.$_POST[$b].');';
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

$_SESSION['Message']='La livraison n° '.$_GET['Livraison'].' a été enregistrée !!!';
mysql_close($connectID);

include('Reliquat.php');

$adresse='Intro.php?Operation=0';
//header('Location: '.$adresse);

?>

