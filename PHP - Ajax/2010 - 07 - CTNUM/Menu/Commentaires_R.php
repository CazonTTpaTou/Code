<?php

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

$i=0;

$connectID=Connexion();

$ligne_sup=$_SESSION['N_Commentaire'];

$sql="delete from commentaires where id_livre=".$_GET['Livre'];
$succes = mysql_query($sql,$connectID) or die ("Impossible d'acc�der aux donn�es");

	while($i<$ligne_sup) {

		$a='P_nim_'.$i;
		$b='commentaire'.$i;

		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
				
				$c="'".addslashes($_POST[$b])."'";
				$d=$_POST[$a];
				$requete='insert into commentaires (id_livre,id_cat,commentaire) values(';
				$requete.=$_GET['Livre'].','.$d.','.$c.');';
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'acc�der aux donn�es");}
			$i++;}

$_SESSION['Message']='La fiche Livre n� '.$_GET['Livre'].' a bien �t� modifi�e !!!';
mysql_close($connectID);

$adresse='Intro.php?Operation=0';
header('Location: '.$adresse);
}


else {

$i=0;

$connectID=Connexion();

$ligne_sup=$_SESSION['N_Commentaire'];

	while($i<$ligne_sup) {

		$a='P_nim_'.$i;
		$b='commentaire'.$i;
		
		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
				$c="'".addslashes($_POST[$b])."'";
				$d=$_POST[$a];
				$requete='INSERT INTO commentaires (id_cat,id_livre,commentaire) values(';
				$requete.=$d.','.$_GET['Livre'].','.$c.');';
				echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'acc�der aux donn�es");}
			$i++;}

$_SESSION['Message']='La fiche Livre n� '.$_GET['Livre'].' a �t� compl�tement enregistr�e !!!';
mysql_close($connectID);

$adresse='Intro.php?Operation=0';
header('Location: '.$adresse);}

?>

