<?php

$connectID=Connexion();
$ligne=0;
$i=0;
$client='';
$date=date("Y-m-j");

print'<div class="princ_livre">';

if($_POST['NPAI']!='') {
           		   $data[]=explode('.',chop($_POST['NPAI']));
	    		   foreach($data[0] as $value) {$value=$value+30000;
							$Choix[]="update clients set npai='".$_POST['etat']."',date_etat='".$date."' where numero=".$value.";";
							$tous[]=$value;
							$client.=$value.',';}

	   		   foreach($Choix as $sql) {$success=mysql_query($sql,$connectID) or die ("Impossible d'acc�der aux donn�es");
						    //echo $sql;
						    $i++;}
	  		   if($i>1) {$s='s';}
				else {$s='';}
			   print $i.' requ�te'.$s.' effectu�e.'.$s.' : ';
			   print '<br/>';
			   print '<br/>';
			   print 'Liste des adresses mises � jour comme '.$_POST['etat'];
			   print '<br/>';
			   print '<br/>';
				
			   
			   $sql="select numero,qualite,nom,prenom,code_postal,ville from clients where numero in (".$client."0);";
			   print '<ol>';
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'acc�der aux donn�es");

			   while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
				$lig='';
				$identifiant[]=$row['numero'];
			   	foreach($row as $value) {$lig.=$value.' - ';}
				print '<li>'.$lig.'</li>';}
			   print '</ol>';
			   print '<br/>';
			   print '<br/>';

				$manquant='';
				$manqu=0;
				$phrase='';
				foreach($tous as $value) {$manq=0;
							  foreach($identifiant as $value2) {if($value2==$value) {$manq=1;}}
				if($manq==0) {$manquant.=$value.' - ';$manqu++;}}
			  if($manqu!=0) {$phrase='Attention - Les num�ros suivants ne correspondent � aucun client :'.$manquant;} 
			     else{$phrase='Aucun num�ro incorrect intercept� !!!';}
			  print $phrase;
			   }

else {print 'Vous n\'avez rentr� aucune donn�e !!!';}

print '<br/>';
print '<br/>';

$_SESSION['Message']='Les NPAI ont bien �t� enregistr�s';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=33" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'</div>';
mysql_close($connectID);

?>