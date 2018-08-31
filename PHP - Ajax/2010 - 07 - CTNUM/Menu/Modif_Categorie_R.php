<?php

$_SESSION['Message']='Ajout modifié : ';

$connectID=Connexion();

if(($_POST['Periode_M']!='') && ($_POST['Periode_M']!='nouveau nom') && ($_POST['Periode']!=''))
 
			  {$sql="update periode set titre='".trim(addslashes($_POST['Periode_M']))."' where num=".$_POST['Periode']." ;";
			   //echo $sql;
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Periode_M'].' - ';}}
				      
if(($_POST['Sujet_M']!='') && ($_POST['Sujet_M']!='nouveau nom') && ($_POST['Sujet']!=''))
 
			  {$sql="update sujet set titre='".trim(addslashes($_POST['Sujet_M']))."' where num=".$_POST['Sujet']." ;";
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Sujet_M'].' - ';}}

if(($_POST['Lieu_M']!='') && ($_POST['Lieu_M']!='nouveau nom') && ($_POST['Lieu']!=''))
 
			  {$sql="update lieu set titre='".trim(addslashes($_POST['Lieu_M']))."' where num=".$_POST['Lieu']." ;";
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Lieu_M'].' - ';}}

if(($_POST['Genre_M']!='') && ($_POST['Genre_M']!='nouveau nom') && ($_POST['Genre']!=''))
 
			  {$sql="update genre set titre='".trim(addslashes($_POST['Genre_M']))."' where num=".$_POST['Genre']." ;";
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Genre_M'].' - ';}}

if(($_POST['Rubrique_M']!='') && ($_POST['Rubrique_M']!='nouveau nom') && ($_POST['Rubrique']!=''))
 
			  {$sql="update rubrique set titre='".trim(addslashes($_POST['Rubrique_M']))."' where num=".$_POST['Rubrique']." ;";
			   $success=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données");
				      if($success) {$_SESSION['Message'].=' - '.$_POST['Rubrique_M'].' - ';}}

header('Location: Intro.php?Operation=0');

?>