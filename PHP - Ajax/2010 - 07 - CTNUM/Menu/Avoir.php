<?php

$connectID=Connexion();

$rq="select * from commande where numero_com=".$_GET['Commande'].";";

	$succes=mysql_query($rq,$connectID);

while($row=mysql_fetch_array($succes,MYSQL_ASSOC)) {
	$dat="'".date("Y-m-j")."'";
	$new_port=$row['port']*(-1);
	$sqli="insert into commande (Numero_Client,date,port,catalogue,livraison) VALUES (";
	$sqli.=$row['Numero_Client'].",".$dat.",".$new_port.",".$row['catalogue'].",".$row['livraison'].");";
		}

//enregistre('Algo',$sqli);

	mysql_close($connectID);
	$connectID1=Connexion();
	$avoir=mysql_query($sqli,$connectID1) or die("Impossible d'accéder aux données");
	mysql_close($connectID1);

$num_avoir=Last_Insertion_Com();
$req="select * from ligne_commande where numero_com=".$_GET['Commande'].";";

//enregistre('Algo',$req);

	$connectID2=Connexion();
	$succes=mysql_query($req,$connectID2) or die("Impossible d'accéder aux données");
	
	mysql_close($connectID2);
	$connectID3=Connexion();

while($row=mysql_fetch_array($succes,MYSQL_ASSOC)) {
	$inv_quant=$row['quantite']*(-1);
	$req="insert into ligne_commande (numero_com,numero_livre,quantite) VALUES (";
	$req.=$num_avoir.",".$row['numero_livre'].",".$inv_quant.");";
		enregistre('Algo',$req);
		$success=mysql_query($req,$connectID3) or die("Impossible d'accéder aux données");
		}

mysql_close($connectID3);

if($avoir) {$_SESSION['Message']='L\'avoir n° '.$num_avoir.' a été enregistré !!!';
	    $adresse='Fact_Edition.php?id='.$num_avoir;
	    header('Location: '.$adresse);
		}
	
	else {$_SESSION['Message']='L\'enregistrement de l\'avoir a échoué !!!';
	      $adresse='Intro.php?Operation=0';
	      header('Location: '.$adresse);}


?>