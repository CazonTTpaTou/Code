<?php

//----- Par le biais de Champ[nbcd] on r�cup�re le nom du champ de la valeur (ex:codepostal, nom...)
$indice=$Champ[$nbcd];

//----- Par le biais de Champ1[nbcd] on r�cup�re le type de variable du champ de la valeur (int, varchar...)
$Typo=$Champ1[$nbcd];

//----- � partir de la premi�re lettre du type de la variable, on d�termine l'encapsulation ad�quate
//----- si c'est un int, alors on encapsule la valeur en un entier...
switch($Typo{0}) {
	case 'i':$valeur= (int) $_POST[$indice];break;
	case 'v':$valeur= $_POST[$indice];break;
	case 'f':$valeur= (float) $_POST[$indice];break;
	case 'd':$valeur= $_POST[$indice];break;
	default:$valeur=$_POST[$indice];}

?>

