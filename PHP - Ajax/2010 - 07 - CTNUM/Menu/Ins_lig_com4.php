<?php

$i=1;
$connectID=Connexion();

//print'Valeur :'.@$_POST['abc'];
//print'<br/>';
//print'champ :'.@$_POST['numero1'];
//print'<br/>';

	$code = @$_POST['numero'];
	$quant= @$_POST['quantite'];
		
	$requete="INSERT INTO ligne_commande (Numero_com,numero_livre,Quantite) VALUES (";
	$requete.="'".$_SESSION['Last_Insert']."','".$code."','".$quant."');";
	//echo 'La requete: '.$requete;
	$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données2");
	
	
mysql_close($connectID);

$adresse=$_SERVER['PHP_SELF'].'?Operation=Insertion-Ligne_commande&id='.$_SESSION['Last_Insert'];
header('Location: '.$adresse);

?>

