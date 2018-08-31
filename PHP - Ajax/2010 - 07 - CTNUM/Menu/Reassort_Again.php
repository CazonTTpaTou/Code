<?php

if (isset($_GET['Livraison'])) {$liv=$_GET['Livraison'];}
	else {$liv=Last_Insertion_Liv();}

$num=$liv;
$connectID=Connexion();

$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}

//$req0="delete from genere0;delete genere00;delete genere000;";

if($_GET['Crea']==0) {
	mysql_close($connectID);
	$adresse='Intro.php?Operation=0';
        header('Location: '.$adresse);
	}

if($_GET['Crea']==1) {
	
	$req="select * from livraison where numero_com=".$num.";";
		//echo $req.'<br/>';
	$succes=mysql_query($req,$connectID) or die("Impossible d'accéder aux données2");
	while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {$fournisseur=$row['Numero_Client'];
					                      $date=$row['date'];
							      $livraison=$row['livraison'];}
		
	$req="insert into reassortiment (fournisseur,date,livraison,etat) values (".$fournisseur.",'".$date."',".$livraison.",0);";
		//echo $req.'<br/>';

	$succes=mysql_query($req,$connectID) or die("Impossible d'accéder aux données31");

	$num=Last_Insertion_Rea();

	$connectID=Connexion();

	$req="select * from genere000;";
	$succes=mysql_query($req,$connectID) or die("Impossible d'accéder aux données35");

	while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
		$a=$num.',';
		$a.=$row['numero_livre'].',';
		$a.=$row['reliquat'].')';
		$req="insert into ligne_reassortiment (numero_com,numero_livre,quantite) values (".$a.";";
			//echo $req;
		$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données4");}

	$_SESSION['Message']='Le nouveau réassortiment n° '.$num.' a bien été créé !!! ';
		
	print '<div class="princ">';
	$Adresse='PDF_tab.php?Reassortiment='.$num;

	   print'<span class="libelle">';
	   print '<a href="Intro.php?Operation==0" >';
           print '<input type="button" value="Retour Page Principale" />';
           print '</a>';
           print'</span>';

           print'<span class="champs">';
           print '<a  href="'.$Adresse.'" target="_blank" >';
           print '<input type="button" value="Visualiser le nouveau réassortiment" />';
           print '</a>';
	   print'</span>';

	mysql_close($connectID);

	//$adresse='Intro.php?Operation=0';
        //header('Location: '.$adresse);
	}

?>
	

	