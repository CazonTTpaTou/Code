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
	$success = mysql_query($requete,$connectID) or die ("Impossible d'acc�der aux donn�es2");
	$i++;
	}

	$fois=$i-1;
	//----- Si la requ�te r�ussit, on enregistre un message de succ�s dans la variable de session message
	if ($success) {$_SESSION['Message']='Votre requ�te: Insertion de Ligne_Commande '.$fois.' fois a r�ussi !!!';}
	     
	      //----- Sinon, on enregistre un message d'�chec de la requ�te effectu�e
	      else {$_SESSION['Message']='Votre requ�te '.$_SESSION['Requ'].' dans la table '.$_SESSION['Tab'].' a �chou� !!!';} 
	 	

//----- Fermeture de la connexion et retour � la page d'accueil de l'application
$_SESSION['Operation']="Accueil";
mysql_close($connectID);

header('Location: '.$_SERVER['PHP_SELF'].'?Operation=Accueil');

?>

