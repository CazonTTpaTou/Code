<?php

$i=1;
$connecID=Connexion();

print'Valeur :'.@$_POST['abc'];
print'<br/>';
print'champ :'.@$_POST['numero1'];
print'<br/>';


for($a=1;;$a++) {
	$tab[$a][0]=
	$tit='numero'.$a;
	$tits='quantite'.$a;
	if(@$_POST[$tit]=='') {$tab[$a][0]=-1;}
		else {$tab[$a][0]=@$_POST[$tit];}
	$tab[$a][1]=@$_POST[$tits];
	if($a>=14) {break;}}

$code=0;
while($tab[$i][0]!=-1) {
	$tit='numero'.$i;
	$tits='quantite'.$i;
	$code=$tab[$i][0];
	$quant=$tab[$i][1];
	$requete="INSERT INTO ligne_commande (Numero_com,numero_livre,Quantite) VALUES (";
	$requete.="'".$_SESSION['Last_Insert']."','".$code."','".$quant."');";
	echo 'La requete: '.$requete;
	$success = mysql_query($requete,$connectID) or die ("Impossible d'accéder aux données2");
	$i++;
	}

	$fois=$i-1;
	//----- Si la requête réussit, on enregistre un message de succès dans la variable de session message
	if ($success) {$_SESSION['Message']='Votre requête: Insertion de Ligne_Commande '.$fois.' fois a réussi !!!';}
	     
	      //----- Sinon, on enregistre un message d'échec de la requête effectuée
	      else {$_SESSION['Message']='Votre requête '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a échoué !!!';} 
	 	

//----- Fermeture de la connexion et retour à la page d'accueil de l'application
$_SESSION['Operation']="Accueil";
mysql_close($connectID);

header('Location: '.$_SERVER['PHP_SELF'].'?Operation=Accueil');

?>

