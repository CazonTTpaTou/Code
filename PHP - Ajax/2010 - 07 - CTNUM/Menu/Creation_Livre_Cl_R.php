<?php

$mots[]='';
$liste='';

$connectID=Connexion();

print '<div class="princ">';

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {


$per=$_POST['Periode'];

$req="delete from liv_periode where id_livre=".$_GET['Livre']."; ";
echo $req;
$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

foreach($per as $value) {$req1="insert liv_periode (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données1");
			 $req2="select titre from periode where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données2");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

$req="delete from liv_sujet where id_livre=".$_GET['Livre']."; ";
$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

$suj=$_POST['Sujet'];

foreach($suj as $value) {$req1="insert into liv_sujet (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données3");
			 $req2="select titre from sujet where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données4");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

$req="delete from liv_lieu where id_livre=".$_GET['Livre']."; ";
$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

$lie=$_POST['Lieu'];

foreach($lie as $value) {$req1="insert into liv_lieu (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données5");
			 $req2="select titre from lieu where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données6");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

$req="delete from liv_genre where id_livre=".$_GET['Livre']."; ";
$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

$gen=$_POST['Genre'];

foreach($gen as $value) {$req1="insert into liv_genre (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données7");
			 $req2="select titre from genre where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données8");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}


$req="delete from liv_rubrique where id_livre=".$_GET['Livre']."; ";
$succs=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données2");

$rub=$_POST['Rubrique'];

foreach($rub as $value) {$req1="insert into liv_rubrique (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données7");
			 $req2="select titre from rubrique where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données8");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

foreach($mots as $value) {$liste.=$value.' - ';}

$req="update mots_cles set surplus='".addslashes($liste)."' where id_livre=".$_GET['Livre']." ; ";
echo $req;
$lis=mysql_query($req,$connectID) or die ("impossible d'accéder aux données9");

mysql_close($connectID);

$adresse='Intro.php?Operation=17&Livre='.$_GET['Livre'].'&Modification=1';;
header('Location: '.$adresse);}

else {

$per=$_POST['Periode'];

foreach($per as $value) {$req1="insert into liv_periode (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données1");
			 $req2="select titre from periode where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données2");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

$suj=$_POST['Sujet'];

foreach($suj as $value) {$req1="insert into liv_sujet (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données3");
			 $req2="select titre from sujet where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données4");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

$lie=$_POST['Lieu'];

foreach($lie as $value) {$req1="insert into liv_lieu (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données5");
			 $req2="select titre from lieu where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données6");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}


$gen=$_POST['Genre'];

foreach($gen as $value) {$req1="insert into liv_genre (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données7");
			 $req2="select titre from genre where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données8");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}


$rub=$_POST['Rubrique'];

foreach($rub as $value) {$req1="insert into liv_rubrique (id_livre,id_cat) values (".$_GET['Livre'].",".$value.");";
			 //echo $req1;
			 $success=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données7");
			 $req2="select titre from rubrique where num=".$value." ;";
			 $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données8");
			 while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$mots[]=" ".$row['titre']." ";}}

foreach($mots as $value) {$liste.=$value.' - ';}

$req="insert into mots_cles (id_livre,mots) values (".$_GET['Livre'].",'".$liste."');";
//echo $req;
$lis=mysql_query($req,$connectID) or die ("impossible d'accéder aux données9");

mysql_close($connectID);

$adresse='Intro.php?Operation=17&Livre='.$_GET['Livre'];
header('Location: '.$adresse);}

print '</div>';
?>

