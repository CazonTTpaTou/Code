<?php
session_start();

//------------ Fonction qui permet de connecter l'utilisateur générique chat à la BDD C216_devoir3

function Connexion() {
	$hosturl='localhost';
	$user='chat';
	$password='chat';
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("C216_Devoir3",$connectID);
	return $connectID;}

//------------ Fonction qui vérifie que l'utilisateur n'envoie pas un formulaire vide

function EstVide($a,$b) {

	if(($a=='') && ($b=='')) {return 1;}
	if(($a!='') || ($b!='')) {return 0;}}

//------------ Fonction qui vérifie que le pseudo et le MDP rentré par l'utilisateur sont bien enregistrés dans table Utilisateurs

function Verif_pseudo($a,$b) {

	$connectID=Connexion();
	$sql="select *,count(*) as nombre from utilisateurs u left outer join messages m  on u.numero=m.num_auteur where u.pseudo like '".$a."';";
	//print $sql;
	$mysql_result = mysql_query($sql,$connectID);
	
	$ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC);
	
	if ($ligne['pseudo']!=$a) {return 0;}

	if (($ligne['pseudo']==$a) &&($ligne['mot_de_passe']!=$b)) {return 1;}

	if (($ligne['pseudo']==$a) &&($ligne['mot_de_passe']==$b)) {
		
		@$_SESSION['pseudo']=$a;
		@$_SESSION['ville']=$ligne['ville'];
		@$_SESSION['nb_mess']=$ligne['nombre'];
		@$_SESSION['num']=$ligne['numero'];
		return 2;}

	mysql_close($connectID);}

//------------ Fonction qui initialise les variables de session d'un nouvel utilisateur

function nouveau($a,$b,$c) {
	
	if (Verif_pseudo($a,$b)!=0) {return 0;}
		else {
			$connectID=Connexion();
			$sql="insert into utilisateurs (pseudo,mot_de_passe,ville) values('".$a."','".$b."','".$c."');";
			
			$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'insérer les données");

			$sql="select last_insert_id() as last;";
			$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
			$ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC);

			@$_SESSION['pseudo']=$a;
			@$_SESSION['ville']=$c;
			@$_SESSION['nb_mess']=0;
			@$_SESSION['num']=$ligne['last'];
			mysql_close($connectID);
			return 1;}}

//------------ Fonction qui insère une nouvelle ligne dans la table Utilisateurs

function inser_mess($a) {
	
	$connectID=Connexion();
	$sql="insert into messages (num_auteur,message) values('".@$_SESSION['num']."','".addslashes($a)."');";
	//print $sql;
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'insérer les données");
	@$_SESSION['nb_mess']++;
	
	$sql="select last_insert_id() as last;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	$ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC);
	enregistre('TellMeMore',$ligne['last']);
	mysql_close($connectID);

	//the_last_ten();
	}

	
//------------ Fonction qui extraie les 10 derniers messages à partir de leur ordre chronologique d'enregistrement décroissant

function the_last_ten() {
	
	$i=lecture('TellMeMore');
	$a=$i-9;
	$connectID=Connexion();
	$sql="select num_message,message,heure,pseudo from messages m inner join utilisateurs u on m.num_auteur = u.numero where m.num_message <= ".$i." and m.num_message >= ".$a." order by m.num_message asc;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	print '<div  class="formu">';
	print '<div id="insertion" class="formi" type=" ">';
	while($ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC)) {
		$me='<span class="numero">'.$ligne['num_message'].' . </span>';
		$mes=$me.'<span class ="expediteur" >'.$ligne['pseudo'].' a écrit le '.$ligne['heure'].' : </span>';
		$mess=$mes.'<span class="" >'.$ligne['message'].'</span>';
		print $mess;
		print'<br/>';
		print"---------------------------------------------------------------------------";
		print'<br/';}
	print '</div>';
	print '</div>';
	enregistre(@$_SESSION['pseudo'],$i);
	}

//------------ Fonction qui détermine la nature du navigateur utilisé par l'utilisateur

function navig() {
	
	$c=$_SERVER['HTTP_USER_AGENT'];
	if(preg_match('/MSIE/i',$c)) {return'Internet Explorer';}
	if(preg_match('/Firefox/i',$c)) {return'Firefox';}
	}

//------------ Fonction qui retourne le n° du dernier message posté
		
function the_last() {

	$connectID=Connexion();
	$sql="select num_message from messages order by heure desc limit 1;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	$ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC);
	$a=$ligne['num_message'];
	return $a;}

//-------------- Fonction qui enregistre le n° du dernier message posté dans un fichier texte

function enregistre($nom,$num) {
	
	 $noms=$nom.'.txt';
	 $a=fopen($noms,'w');
	 fputs($a, $num);
	 fclose($a);}

//-------------- Fonction qui lit le n° du dernier message posté dans un fichier texte

function lecture($nom) {
	
	 $noms=$nom.'.txt';
	 if(!$b=fopen($noms,'r')) {return 10;}
	 	else{   $l=fgets($b,20);
			fclose($b);
	 		return $l;}}

//--------------- Fonction qui compare le n° du dernier message posté et le n° du dernier message affiché

function compare() {
	$a=lecture('TellMeMore');
	$b=lecture($_SESSION['pseudo']);
	if($a==$b) {return 1;}
	   else{return 0;}}
?>