<?php
session_start();

//------------ Fonction qui permet de connecter l'utilisateur à la BDD CTNUM

function Connexion() {
	$hosturl='localhost';
	$user=$_SESSION['Utilisateur'];
	$password=$_SESSION['Passe'];
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("CTNUM",$connectID);
	return $connectID;}



//------------ Fonction qui permet de déterminer les variables de session Table et Requête

function Opération() {

	//----- A partir de l'URL de la page chargée, on initialise la variable de session de la requête choisie par l'utilisateur
	if(isset($_GET['Operation'])) {$_SESSION['Operation']=$_GET['Operation'];}}

//------------ Fonction qui de déterminer le numéro d'incrémentation de la dernière commande insérée

function Last_Insertion_Com() {

	$connectID=Connexion();
	$sql="select numero_com as last from commande order by numero_com desc limit 1;";
	//$sql="select last_insert_id() as last;";
	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		$a=$row['last'];}
 
	mysql_close($connectID);
	return $a;}

//------------ Fonction qui de déterminer le numéro d'incrémentation de la dernière fiche client insérée

function Last_Insertion_client() {

	$connectID=Connexion();
	$sql="select numero as last from clients order by numero desc limit 1;";
	//$sql="select last_insert_id() as last;";
	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		$a=$row['last'];}
 
	mysql_close($connectID);
	return $a;}

//------------ Fonction qui de déterminer le numéro d'incrémentation de la dernière fiche livre insérée

function Last_Insertion_livre() {

	$connectID=Connexion();
	$sql="select numero as last from livres order by numero desc limit 1;";
	//$sql="select last_insert_id() as last;";
	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		$a=$row['last'];}
 
	mysql_close($connectID);
	return $a;}


//------------ Fonction qui de déterminer le numéro d'incrémentation du dernier réassort inséré

function Last_Insertion_Rea() {

	$connectID=Connexion();
	$sql="select numero as last from reassortiment order by numero desc limit 1;";
	//$sql="select last_insert_id() as last;";
	$result = mysql_query($sql,$connectID);

	while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
		$a=$row['last'];}
 
	mysql_close($connectID);
	return $a;}

//--------- Fonction pour extraire les résultats d'une requête

function Requete($req) {

$connectID=Connexion();
//echo $req;

$success = mysql_query($req,$connectID) or die ("Impossible accéder aux données");
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

$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");

//----- début de la liste déroulante
print'<select name="'.$name.'" id="'.$name.'_id" size ="1">';

print 'Valeur : '.$value;

//----- si le formulaire n'est pas pré-rempli, alors on insère une première ligne vierge
if($value=='NO') {print'<option value ="" name="none">Choisissez une valeur</option>';}
	

//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
while ($Choice=mysql_fetch_array($Choix,MYSQL_ASSOC)) {

		//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
		if ($Choice[$cle1]==$value) {$selec='selected';}
 				else {$selec="";}

		//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
		switch($option) {
			case '1':print'<option value="'.$Choice[$cle1].'" '.$selec.' '.$access.' >'.$Choice[$cle1].'</option>';
				 break;
			case '2':print'<option value="'.$Choice[$cle1].'" '.$selec.' '.$access.' >'.$Choice[$cle1].' - '.$Choice[$cle2].'</option>';
				 break;
			case '3':print'<option value="'.$Choice[$cle1].'" '.$selec.' '.$access.' >'.$Choice[$cle1].' - '.$Choice[$cle2].' - '.$Choice[$cle3].'</option>';
				 break;}
		}

//----- fin de la liste déroulante
print'</select>';}

//---------------- Affiche les messages de l'application

function message() {

print '<div class="dernier">';
print '<h1>';
print $_SESSION['Message'];
print '</h1>';
print '</div>';
	}

function signe($sig) {

	switch($sig) {
		case '1':$a='=';break;
		case '2':$a='>';break;
		case '3':$a='<';break;
		case '4':$a='>=';break;
		case '5':$a='<=';break;}

return $a;}

//-------------- Fonction qui enregistre le n° du dernier message posté dans un fichier texte

function enregistre($nom,$num) {
	
	 $noms=$nom.'.txt';
	 $a=fopen($noms,'a+');
	 fputs($a, $num);
	 fclose($a);}

//-------------- Fonction qui lit le n° du dernier message posté dans un fichier texte

function lecture($nom) {
	
	 $noms=$nom.'.txt';
	 if(!$b=fopen($noms,'r')) {return 10;}
	 	else{   $l=fgets($b,20);
			fclose($b);
	 		return $l;}}

//-------------- Fonction qui construit un menu par case à cocher

function cocher($nom,$table,$champ1,$champ2,$valeur) {

$req="select * from ".$table." order by ".$champ2." ;";

	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {

			$selec='';
			foreach($valeur as $value) {
			if($value==$row[$champ1]) {$selec='Checked';}
				}
			
			print '<input type="Checkbox" name="'.$nom.'" value="'.$row[$champ1].'" '.$selec.' >'.$row[$champ2];
			//enregistre('abc','<input type="Checkbox" name="'.$nom.'" value="'.$row[$champ1].'" '.$selec.' >'.$row[$champ2]);
			//print '<br/>';
			//print '<br/>';
			}
	
	mysql_close($connectID);}
?>