<?php
session_start();

//------------ Fonction qui permet de connecter l'utilisateur � la BDD CTNUM

function Connexion() {
	$hosturl='localhost';
	$user=$_SESSION['Utilisateur'];
	$password=$_SESSION['Passe'];
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("CTNUM",$connectID);
	return $connectID;}

//------------ Fonction qui permet de d�terminer le menu Utilisateur

function Deter_Menu() {

	//-----D�termination du compte utilisateur qui est l'association d'un nom d'utilisateur et l'h�te de cet utiisateur
	//-----Vu qu'il n'y a que l'h�te localhost dans ce cas th�orique, on choisit la facilit� de ne chercher que le nom d'utilisateur
  
	$id ='"%'.$_SESSION['Utilisateur'].'%"';

	//----Connexion � la BDD avec les identifiants rentr�s par l'utilisateur
	$connectID = Connexion_r();

	$sql='select privilege_type,table_name from information_schema.table_privileges where grantee like '.$id.' order by privilege_type,table_name ;';

	$result = mysql_query($sql,$connectID);
	$i=1;
	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

		$ent='Droit'.$i;
		$_SESSION[$ent]['privilege_type']=$row['privilege_type'];
		$_SESSION[$ent]['table_name']=$row['table_name'];
		$i++;
	}
	$_SESSION['Nb_droits']=$i-1;
	mysql_close($connectID);
	echo 'Droits :'.$_SESSION['Nb_droits'];
	}

//------------ Fonction qui permet de d�terminer les droits Utilisateur

function Droits() {

	//-----D�termination du compte utilisateur qui est l'association d'un nom d'utilisateur et l'h�te de cet utiisateur
	//-----Vu qu'il n'y a que l'h�te localhost dans ce cas th�orique, on choisit la facilit� de ne chercher que le nom d'utilisateur
  
	$id ='"%'.$_SESSION['Utilisateur'].'%"';

	//----Connexion � la BDD avec les identifiants rentr�s par l'utilisateur
	$connectID = Connexion_r();

	//----Construction de la requ�te comptant le nombre de type de privil�ge associ� au nom de l'utilisateur sur la BDD C216_Devoir2
	//----Dans l'absolu, il n'y aurait pas besoin de mettre une condition sur le nom utilisateur, puisque normalement l'utilisateur
	//----n'a les droits que pour consulter ses propres privil�ges et non ceux de l'ensemble des utilisateurs comme peut
	//----le faire l'administrateur root...
	$sql='select count(distinct privilege_type) as Nb_Priv from information_schema.table_privileges where grantee like '.$id;

	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	
	$nb=$row['Nb_Priv'];}

	//----Si le nombre de privil�ge est = � 1, c'est un utilisateur - privil�ge Select
	if ($nb=1) {
		    $_SESSION['Droits'] = 'Utilisateur';
		    $_SESSION['Grant']=3;}

	//----Si le nombre de privil�ge est = � 2, c'est un client - privil�ge Select,insert
	if ($nb=1) {
		    $_SESSION['Droits'] = 'Client';
                    $_SESSION['Grant']=2;}

	//----Si le nombre de privil�ge est = � 3, c'est un op�rateur - privil�ge Select,update,insert
	if ($nb=3) {
		    $_SESSION['Droits'] = 'Op�rateur';
                    $_SESSION['Grant']=1;}

	//----Si le nombre de privil�ge est = � 4, c'est un administrateur - privil�ge Select,update,insert,delete
	if ($nb=4) {
		    $_SESSION['Droits'] = 'Administrateur';
                    $_SESSION['Grant']=0;}

	mysql_close($connectID);

	Deter_Menu();}



//------------ Fonction qui permet de d�terminer les variables de session Table et Requ�te

function Op�ration() {

	//----- A partir de l'URL de la page charg�e, on initialise la variable de session de la requ�te choisie par l'utilisateur
	if(isset($_GET['Operation'])) {$_SESSION['Requ']=$_GET['Operation'];}

	//----- A partir de l'URL de la page charg�e, on initialise la variable de session de la table choisie par l'utilisateur
	if(isset($_GET['Table'])) {$_SESSION['Tab']=$_GET['Table'];}

	//----- Si la variable Table n'est pas d�fini dans l'URL, on initialise la variable de session de la table au vide
	if(!(isset($_GET['Table']))) {$_SESSION['Tab']='';}

	//----- On d�termine la variable de session Op�ration qui s'affichera dans le profil Utilisateur
	if(isset($_GET['Operation']) && isset($_GET['Table'])) {$_SESSION['Operation']=$_SESSION['Requ']." - ".$_SESSION['Tab'];} 
		else{$_SESSION['Operation']=$_SESSION['Requ'];}}

//------------ Fonction qui de d�terminer le num�ro d'incr�mentation de la derni�re commande ind�r�e

function Last_Insertion_Com() {

	$connectID=Connexion();
	$sql="select numero_com as last from commande order by numero_com desc limit 1;";
	//$sql="select last_insert_id() as last;";
	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		$a=$row['last'];}
 
	mysql_close($connectID);
	return $a;}

//--------- Fonction pour extraire les r�sultats d'une requ�te

function Requete($req) {

$connectID=Connexion();
//echo $req;

$success = mysql_query($req,$connectID) or die ("Impossible acc�der aux donn�es");
while ($row=mysql_fetch_array($success,MYSQL_ASSOC)) {

	foreach($row as $key => $value) {
		$_SESSION[$key]=$value;}}

mysql_close($connectID);

}

function Extraction($name,$table,$value,$cle1,$cle2,$cle3,$access) {

$connectID=Connexion();

if ($cle1!='') {$cle=$cle1;$option=1;}
if ($cle2!='') {$cle.=','.$cle2;$option=2;}
if ($cle3!='') {$cle.=','.$cle3;$option=3;}

$sqli=" select ".$cle." from ".$table." order by ".$cle1." ;";

$Choix= mysql_query($sqli,$connectID) or die("Impossible d'acc�der aux donn�es");

//----- d�but de la liste d�roulante
print'<select name="'.$name.'" size ="1">';

//----- si le formulaire n'est pas pr�-rempli, alors on ins�re une premi�re ligne vierge
if($value=='') {print'<option value ="" name="none">Choisissez une valeur</option>';}
	

//----- Insertion des diff�rentes lignes du menu d�roulant � partir des r�sultats de la requ�te
while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

		//----- hormis dans le cas d'une insertion, le champ sera pr�-s�lectionn� sur une valeur
		if ($Choice[$cle]==$Value) {$selec='selected';}
 				else {$selec="";}

		//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
		switch($option) {
			case '1':print'<option value="'.$Choice[$cle].'" '.$selec.' '.$accesss.' >'.$Choice[$cle].'</option>';
				 break;
			case '2':print'<option value="'.$Choice[$cle].'" '.$selec.' '.$accesss.' >'.$Choice[$cle].' - '.$Choice[$cle2].'</option>';
				 break;
			case '3':print'<option value="'.$Choice[$cle].'" '.$selec.' '.$accesss.' >'.$Choice[$cle].' - '.$Choice[$cle2].' - '.$Choice[$cle3].'</option>';
				 break;}
		}

//----- fin de la liste d�roulante
print'</select>';}


?>