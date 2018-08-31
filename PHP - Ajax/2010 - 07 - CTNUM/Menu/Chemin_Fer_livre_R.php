<?php

$page=$_GET['Page'];
$catalogue=$_GET['Catalogue'];
$modif='';

$nb_page=$_SESSION['Nombre_de_livre'];
$i=1;
//echo $nb_page;
//echo 'nombre de livres : '.$_SESSION['Nombre_de_livre'];

//$cate=$_POST[$product];
//$books=$_POST[$nom];

//$_SESSION['Nb_pages']=$_GET['Nb_pages'];

$connectID=Connexion();

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

$modif='&Modification=1';

$req="delete from chemin_fer_livre where num_page=".$_GET['Page']." and num_cat=".$_GET['Catalogue']."; ";

$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");}

while($i<=$nb_page) {
			 $product='P_num_'.$i;
			 $a=$_POST[$product];
			 $co='Comm'.$i;
			 $b=$_POST[$co];

			$req1="insert chemin_fer_livre (num_cat,num_page,num_com,num_livre) values (".$catalogue.",".$_GET['Page'].",".$b.",".$a.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données1");
			$i++;}

if(($page<$_SESSION['Nb_pages']) &&(!(isset($_GET['Modification'])))) {
	$_SESSION['Page_chem']++;
 	$_SESSION['Message']='La page n° '.$_GET['Page'].' a été renseignée !!!';      
	      header('Location:Intro.php?Operation=49&Catalogue='.$_GET['Catalogue'].'&Page='.$_SESSION['Page_chem'].$modif);
		}

	else {$_SESSION['Message']='Fin du renseignement des pages !!!';
	     header('Location:Intro.php?Operation=50&Catalogue='.$_GET['Catalogue']);
		}

mysql_close($connectID);

?>