<?php

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$_SESSION['URL']="&Modification=1";}

	else {$_SESSION['URL']='';}

$connectID=Connexion();

$a="'".addslashes($_POST['mots'])."'";
$req="update mots_cles set mots=".$a." where id_livre=".$_GET['Livre']." ;";
echo $req;
$success=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données");

$adresse='Intro.php?Operation=18&Livre='.$_GET['Livre'].$_SESSION['URL'];
header('Location: '.$adresse);

?>




