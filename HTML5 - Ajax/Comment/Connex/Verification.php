<?php 
      //------- On d�sactive les avertissements qui s'affichent lorsque les identifiants de connexion sont incorrects
      error_reporting(E_ALL^E_WARNING);

	//--------Cr�ation d'un tableau qui contiendra chaque erreur de saisie � chaque ligne
	$Erreur_msg=array();

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP']!='alligator') {$Erreur_msg[]="Le mot de passe n� 1 est incorrect !!!";}
	    else {$password=$_POST['MDP'];}

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP2']!='caiman') {$Erreur_msg[]="Le mot de passe n�2 est incorrect !!!";}
	    else {$password2=$_POST['MDP2'];}

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP3']!='crocodile') {$Erreur_msg[]="Le mot de passe n�3 est incorrect !!!";}
	    else {$password3=$_POST['MDP3'];}

	//--------D�finition du cas d'erreur n�2: le mot de passe n'est pas renseign�
	if ($_POST['MDP4']!='gavial') {$Erreur_msg[]="Le mot de passe n�4 est incorrect !!!";}
	    else {$password4=$_POST['MDP4'];}
		

	if(($password=='alligator')&&($password2=='caiman')&&($password3=='crocodile')&&($password4=='gavial'))
		     {$flag=3;}

		else {$flag=2;}
	
	 ?>