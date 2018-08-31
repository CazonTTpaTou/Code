<?php

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

$ligne=$_SESSION['N_Lig_com']-$_SESSION['Lig_sup'];
//echo 'Ligne: '.$ligne;

$i=1;
$connectID=Connexion();

	while($i<=$ligne) {

		$a='P_num_'.$i;
		//$b='quantite'.$i;
		$c='num_ligne'.$i;

		//if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$a]==73)) {
				$requete='DELETE from liv_aut where id_livre='.$_GET['Livre'].' and num_ligne='.$_POST[$c].' ;';}

			else {$requete='UPDATE liv_aut SET id_auteur='.$_POST[$a];
			      $requete.=' where id_livre='.$_GET['Livre'].' and num_ligne='.$_POST[$c].' ;';}
			//echo $requete;
			$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");
			//}
		$i++;}

$ligne_sup=$_SESSION['N_Lig_com'];

		$a='P_num_'.$i;
		$b='quantite'.$i;

	while($i<=$ligne_sup) {
		if(($_POST[$a]!='') && ($_POST[$b]!='')) {
			
			if(($_POST[$b]!=0)) {
				$requete='INSERT INTO liv_aut (id_livre,id_auteur) values(';
				$requete.=$_GET['Livre'].','.$_POST[$a].');';
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");}}
			$i++;}

$_SESSION['Message']='La fiche livre n° '.$_GET['Livre'].' a été modifiée !!!';
mysql_close($connectID);
$adresse='Intro.php?Operation=16&Livre='.$_GET['Livre'].'&Modification=1';
header('Location: '.$adresse);}


else {

$i=1;
$double=0;
$connectID=Connexion();
$auteur[]='';

$ligne_sup=$_SESSION['N_Lig_com'];

	while($i<=$ligne_sup) {

		$a='P_num_'.$i;
		
		foreach($auteur as $value) {if($value==$_POST[$a]) {$double=1;}}
			
		if(($_POST[$a]!='') && (!$double)) {
			
				$requete='INSERT INTO liv_aut (id_livre,id_auteur) values(';
				$requete.=$_GET['Livre'].','.$_POST[$a].');';
				//echo $requete;
				$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données");
				$auteur[]=$_POST[$a];}
			$i++;
			$double=0;}

mysql_close($connectID);

$adresse='Intro.php?Operation=16&Livre='.$_GET['Livre'];
header('Location: '.$adresse);}

?>

