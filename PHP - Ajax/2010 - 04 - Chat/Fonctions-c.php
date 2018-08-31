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
	//print 'dernière ligne: '.$ligne['last'];
	last_ten($connectID,$ligne['last']);

	mysql_close($connectID);}

//------------ Fonction qui extraie les 10 derniers messages à partir du dernier last_insert_id() attribué après une insertion de message


function last_ten($connectID,$last) {
	
	$first=max(0,$last-9);
	$sql="select message,heure,pseudo from messages m inner join utilisateurs u on m.num_auteur = u.numero where m.num_message between ".$first." and ".$last." order by num_message desc;"; 
	//print $sql;
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	print '<div class="formuc">';
	print '<ol class="formic">';	
	while($ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC)) {
		$mes='<span class ="expediteur" >'.$ligne['pseudo'].' a écrit le '.$ligne['heure'].' : </span>';
		$mess=$mes.'<span class="" >'.$ligne['message'].'</span>';
		print '<li>'.$mess.'</li>';
		print'<br/>';}
	print '</ol>';
	print '</div>';
	}

//------------ Fonction qui extraie les 10 derniers messages à partir de leur ordre chronologique d'enregistrement décroissant
	
function the_last_ten() {
	
	$i=0;
	$connectID=Connexion();
	$sql="select message,heure,pseudo from messages m inner join utilisateurs u on m.num_auteur = u.numero where m.heure <= current_timestamp() order by m.num_message desc limit 10;";
	$mysql_result = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
	print '<div class="formuc">';
	print '<ol class="formic">';
	while($ligne = mysql_fetch_array($mysql_result,MYSQL_ASSOC)) {
		$mes='<span class ="expediteur" >'.$ligne['pseudo'].' a écrit le '.$ligne['heure'].' : </span>';
		$mess=$mes.'<span class="" >'.$ligne['message'].'</span>';
		print '<li>'.$mess.'</li>';
		print'<br/>';}
	print '</ol>';
	print '</div>';
	}

//------------ Fonction qui détermine la nature du navigateur utilisé par l'utilisateur

function navig() {
	
	$c=$_SERVER['HTTP_USER_AGENT'];
	if(preg_match('/MSIE/i',$c)) {return'Internet Explorer';}
	if(preg_match('/Firefox/i',$c)) {return'Firefox';}
	}
		
?>



