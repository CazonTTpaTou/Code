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

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'op�re pas de tri sur la s�lection
if(isset($_POST['number'])) {


	$num=$_POST['number'];
	$sql="select message,civilite,nom,prenom from message where numero=".$num.";";
	//print $sql;
	$success=mysql_query($sql,$connectID) or die ("impossible d'acc�der aux donn�es2");
	$Code[]='<p class="messages_paragraphe" >';	
	while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
			
			$Code[]='<span style="font-weight:bold">';
			$Code[]=' - '.stripslashes($row['civilite']).' '.stripslashes($row['prenom']).' '.stripslashes($row['nom']).' a �crit: ';
			$Code[]='</span>';
			$Code[]='</br>';
			$Code[]='</br>';
			$Code[]=stripslashes($row['message']);
	}
	$Code[]="</p>";

//------- On �dite la succession de commandes html du tableau tri� que nous avons stock� dans le tableau code, 
//------- pour qu'elle soient lisible par la m�thode responseText et ex�cutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}
}
?>