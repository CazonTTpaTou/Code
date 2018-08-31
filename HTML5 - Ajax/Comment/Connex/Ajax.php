<?php

header('Content-type: text/html; charset=iso-8859-1'); 

	$hosturl='fabien.monnery.sql.free.fr';
	$user='fabien.monnery';
	$password='crocodil';
	$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	mysql_select_db("fabien_monnery",$connectID);
	//mysql_query("SET NAMES UTF8"); 
	

	//$hosturl='localhost';
	//$user='root';
	//$password='';
	//$connectID = mysql_connect($hosturl, $user, $password) or die('Connexion impossible!!!');
	//mysql_select_db("cv_site",$connectID);
	//mysql_query("SET NAMES UTF8"); 

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'opère pas de tri sur la sélection
if(isset($_POST['number'])) {


	$num=$_POST['number'];
	$sql="select message,civilite,nom,prenom from message where numero=".$num.";";
	//print $sql;
	$success=mysql_query($sql,$connectID) or die ("impossible d'accéder aux données2");
	$Code[]='<p class="messages_paragraphe" >';	
	while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
			
			$Code[]='<span style="font-weight:bold">';
			$Code[]=' - '.stripslashes($row['civilite']).' '.stripslashes($row['prenom']).' '.stripslashes($row['nom']).' a écrit: ';
			$Code[]='</span>';
			$Code[]='</br>';
			$Code[]='</br>';
			$Code[]=stripslashes($row['message']);
	}
	$Code[]="</p>";

//------- On édite la succession de commandes html du tableau trié que nous avons stocké dans le tableau code, 
//------- pour qu'elle soient lisible par la méthode responseText et exécutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}
}
?>