<?php
$connectID=Connexion();

$b=trim(addslashes($_POST['Num_voie']));
$b.=' '.trim(addslashes($_POST['Typ_voie'])).' '.trim(addslashes($_POST['Nom_voie']));

if($_POST['telephone']=='facultatif') {$c='';}
	else {$c=$_POST['telephone'];}

if($_POST['e_mail']=='facultatif') {$d='';}
	else {$d=addslashes($_POST['e_mail']);}

$Last=Last_Insertion_client();
$connectID=Connexion();
$Last++;
$a=$Last.',';
$a.="'".trim(addslashes($_POST['Qualite']))."',";
$a.="'".trim(addslashes($_POST['Nom']))."',";
$a.="'".trim(addslashes($_POST['Prenom']))."',";
$a.="'".trim(addslashes($_POST['Ad_comp']))."',";
$a.="'".$b."',";;
$a.="'".trim(addslashes($_POST['Code_Postal']))."',";
$a.="'".trim(addslashes($_POST['Ville']))."',";
$a.="'Actif',";
$a.="'Nouveau',";
$a.="'".trim($c)."',";
$a.="'".trim($d)."'";

$req="INSERT INTO clients (numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville,npai,fichiers,telephone,e_mail) VALUES (";
$req.=$a.');';

echo $req;

$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");
	
if($success) {$Last=Last_Insertion_client();
	      $_SESSION['Message']='Nouveau client N° '.$Last.' enregistré !!!';
	      
	      header('Location:Intro.php?Operation=66&Client='.$Last);}

	else {$_SESSION['Message']='Echec - Le nouveau client n\'a pas été enregistré !!!';
	      header('Location:Intro.php?Operation=0');}

?>




