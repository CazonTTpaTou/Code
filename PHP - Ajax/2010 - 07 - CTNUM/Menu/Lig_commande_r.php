<?php

$i=1;

$connectID=Connexion();

$ligne_sup=$_SESSION['N_Lig_com'];

	while($i<=$ligne_sup) {

		$a='P_num_'.$i;
		$b='quantite'.$i;

		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO ligne_commande (numero_com,numero_livre,quantite) values(';
				$requete.=$_GET['Commande'].','.$_POST[$a].','.$_POST[$b].');';
				echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'acc�der aux donn�es");}}
			$i++;}

$_SESSION['Message']='La commande n� '.$_GET['Commande'].' a �t� enregistr�e !!!';
mysql_close($connectID);

$adresse='Fact_Edition.php?id='.$_GET['Commande'];
header('Location: '.$adresse);

?>

