<?php

//----- Par le biais de Champ[nbcd] on récupère le nom du champ de la valeur (ex:codepostal, nom...)
$indice=$Champ[$nbcd];

//----- Par le biais de Champ1[nbcd] on récupère le type de variable du champ de la valeur (int, varchar...)
$Typo=$Champ1[$nbcd];

//----- à partir de la première lettre du type de la variable, on détermine l'encapsulation adéquate
//----- si c'est un int, alors on encapsule la valeur en un entier...
switch($Typo{0}) {
	case 'i':$valeur= (int) $_POST[$indice];break;
	case 'v':$valeur= $_POST[$indice];break;
	case 'f':$valeur= (float) $_POST[$indice];break;
	case 'd':$valeur= $_POST[$indice];break;
	default:$valeur=$_POST[$indice];}

?>

