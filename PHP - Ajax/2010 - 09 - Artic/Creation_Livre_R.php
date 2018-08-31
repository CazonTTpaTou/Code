<?php

$connectID=Connexion();

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

$a="titre='".trim(addslashes($_POST['Titre']))."',";
$a.="sous_titre='".trim(addslashes($_POST['Sous_titre']))."',";
$a.="pages='".trim(addslashes($_POST['Page']))."',";
$a.="image='".trim(addslashes($_POST['Couverture']))."',";
$a.="prix=".trim(addslashes($_POST['Prix'])).",";
$a.="isbn='".trim(addslashes($_POST['ISBN']))."',";
$a.="editeur='".trim(addslashes($_POST['Editeur']))."'";

$req="update livres set ".$a." where numero=".$_GET['Livre']." ;";
echo $req;
$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");

$req0="update prix set d_end=curdate()-1 where id_livre=".$_GET['Livre']." and d_end='2100-07-01' ;";
$success=mysql_query($req0,$connectID) or die("Impossible d'accéder aux données");

$req2="insert into prix (id_livre,d_begin,d_end,prix) values (".$_GET['Livre'].",curdate(),'2100-07-01',".$_POST['Prix'].");";
$succes=mysql_query($req2,$connectID) or die("Impossible d'accéder aux données");

mysql_close($connectID);

if($succes) {
	      $_SESSION['Message']='La fiche livre N° '.$_GET['Livre'].' a été modifiée !!!';
	      
	      header('Location:Intro.php?Operation=15&Modification=1&Livre='.$_GET['Livre']);}

	else {$_SESSION['Message']='Echec - La fiche livre n° '.$_GET['Livre'].' n\'a pas été modifiée !!!';
	      header('Location:Intro.php?Operation=0');} }

else {

$a="'".trim(addslashes($_POST['Titre']))."',";
$a.="'".trim(addslashes($_POST['Sous_titre']))."',";
$a.="'".trim(addslashes($_POST['Page']))."',";
$a.="'".trim(addslashes($_POST['Couverture']))."',";
$a.=trim(addslashes($_POST['Prix'])).",";
$a.="'".trim(addslashes($_POST['ISBN']))."',";
$a.="'".trim(addslashes($_POST['Editeur']))."'";


$req="INSERT into livres (titre,sous_titre,pages,image,prix,ISBN,editeur) values (".$a.");";
//echo $req;
$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
mysql_close($connectID);



$num_livre=Last_Insertion_livre();

$date_j = date_create(date("Y-m-j"));
date_sub($date_j, date_interval_create_from_date_string('1 day'));
$date_jo=date_format($date, 'Y-m-d');

$req_prix="insert into prix (id_livre,d_begin,d_end,prix) values (".$num_livre.",".date("Y-m-j").",'2100-07-01',".$_POST['Prix'].");";
$req_prix2="update prix set d_end='".$date_jo."' where id_livre=".$num_livre." and d_end='2100-07-01';";

//$connectID2=Connexion();
//$succe=mysql_query($req_prix2,$connectID2) or die("Impossible d'accéder aux données");
//$succes=mysql_query($req_prix,$connectID2) or die("Impossible d'accéder aux données");
//mysql_close($connectID2);

if($success) {
	      $_SESSION['Message']='La fiche livre N° '.$num_livre.' a été créée !!!';
	      
	      header('Location:Intro.php?Operation=15&Livre='.$num_livre);}

	else {$_SESSION['Message']='Echec - La nouvelle fiche livre n\'a pas été créée !!!';
	      header('Location:Intro.php?Operation=0');} }

?>




