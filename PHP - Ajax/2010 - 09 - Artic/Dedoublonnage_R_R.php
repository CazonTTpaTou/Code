<?php

$connectID=Connexion();

			$req3="delete from clients where numero in ";
			$req3.="(select tampon.numero from (select d1.numero from dedoublonnage as d1 ";
			$req3.="inner join dedoublonnage as d2 on d1.match_code=d2.match_code  ";
			$req3.="and d1.numero>d2.numero order by 1) as tampon ) ;";
			 
			$succis=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données4");
			$eff=mysql_affected_rows();
			
if($succis) {
 	$_SESSION['Message']=$eff.' doublons ont été supprimés !!!';      
	      header('Location:Intro.php?Operation=0');
		}

	else {$_SESSION['Message']='Le dédoublonnage des pages a échoué !!!';
	     header('Location:Intro.php?Operation=0');}

$mysql_close($connectID);

?>