<?php

print'<div class="princ">';

$_SESSION['Message']='Ajout attribut : ';

$connectID=Connexion();

if($_POST['Periode']!='') {$sql="select * from periode where titre like '".$_POST['Periode']."';";
			   //echo $sql;
			   $succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			   $i=0;
			   while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$i++;}
			   if($i==0) {$sql="insert into periode (titre) values('".trim(addslashes($_POST['Periode']))."');";
				      //echo $sql;
				      $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Periode'].' - ';}}}
				      
if($_POST['Sujet']!='') {$sql="select * from sujet where titre like '".$_POST['Sujet']."';";
			   //echo $sql;
			   $succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			   $i=0;
			   while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$i++;}
			   if($i==0) {$sql="insert into sujet (titre) values('".trim(addslashes($_POST['Sujet']))."');";
				      //echo $sql;
				      $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			              if($success) {$_SESSION['Message'].=' - '.$_POST['Sujet'].' - ';}}}

if($_POST['Lieu']!='') {$sql="select * from lieu where titre like '".$_POST['Lieu']."';";
			   $succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			   $i=0;
			   while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$i++;}
			   if($i==0) {$sql="insert into lieu (titre) values('".trim(addslashes($_POST['Lieu']))."');";
				      $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Lieu'].' - ';}}}

if($_POST['Genre']!='') {$sql="select * from genre where titre like '".$_POST['Genre']."';";
			   $succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			   $i=0;
			   while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$i++;}
			   if($i==0) {$sql="insert into genre (titre) values('".trim(addslashes($_POST['Genre']))."');";
				      $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Genre'].' - ';}}}

if($_POST['Rubrique']!='') {$sql="select * from rubrique where titre like '".$_POST['Rubrique']."';";
			   $succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
			   $i=0;
			   while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
				$i++;}
			   if($i==0) {$sql="insert into rubrique (titre) values('".trim(addslashes($_POST['Genre']))."');";
				      $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Rubrique'].' - ';}}}

header('Location: Intro.php?Operation=0');

print '</div>';

?>