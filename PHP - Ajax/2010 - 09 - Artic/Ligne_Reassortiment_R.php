<?php
$i=0;
$connectID=Connexion();
$ligne_sup=$_SESSION['N_Lig_rea'];

	while($i<=$ligne_sup) {

		$a='P_num_'.$i;
		$b='quantite'.$i;

		if(($_POST[$a]!='') && ($_POST[$b]!='') && ($_POST[$b]!='quantite')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO ligne_reassortiment (numero_com,numero_livre,quantite) values(';
				$requete.=$_GET['Reassortiment'].','.$_POST[$a].','.$_POST[$b].');';
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

$_SESSION['Message']='Le réassortiment n° '.$_GET['Reassortiment'].' a été enregistré !!!';

$sql="select li.isbn,li.titre,li.editeur,lig.quantite from reassortiment as rea inner join ligne_reassortiment as lig on rea.numero=lig.numero_com inner join livres as li on li.numero=lig.numero_livre where rea.numero=".$_GET['Reassortiment']." ;";
//echo $sql;
$file=mysql_query($sql,$connectID) or die("impossible d'accéder aux données");

mysql_close($connectID);

//include("Consultation_reassortiment.php");

$adresse='Intro.php?Operation=37';
header('Location: '.$adresse);
?>