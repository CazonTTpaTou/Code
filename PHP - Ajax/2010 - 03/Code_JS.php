<?php

//----- On initialise la variable Typo avec le type du champ qui est contenu dans le tableau Champ1[num]
$Typo=$Champ1[$num];

//----- On attribue les fonctions javascript à chaque champ en fonction du type de variable contenu dans le champ
//----- Si c'est un entier int, que des nombres entiers possibles donc appel à la fonction JS numbers
//----- Si c'est un décimal float, que des nombres et virgule possible, donc appel à la fonction JS numbers_dec
//----- Si c'est une date, que des nombres et tiret possible, donc appel à la fonction JS numbers_dat
switch($Typo{0}) {
	case 'i':$verif= 'onkeypress="return numbers(event);"';break;
	case 'f':$verif= 'onkeypress="return numbers_dec(event);"';break;
	case 'd':$verif= 'onkeypress="return numbers_dat(event);"';break;
	default:$verif="";}

//----- On détermine la taille du champ (variable size) en fonction de la valeur de grandeur du type de la variable
//----- Ainsi, si le champ est de type varchar(100), le champ sera de taille 100
switch($Typo{0}) {
	case 'i':$los=strpos($Champ1[$num],'(')+1;
                 $lis=strpos($Champ1[$num],')')+1;
                 $size=substr($Champ1[$num],$los,$lis-$los-1);
                 break;
	case 'f':$size=10;
                 break;
	case 'v':$size=substr($Champ1[$num],strpos($Champ1[$num],'(')+1,strpos($Champ1[$num],')')-strpos($Champ1[$num],'(')-1);
		 break;
	case 'd':$size=10;break;
	default:$size=50;}

//----- Par souci d'harmonie esthétique, on fixe une taille d'affichage minimale de 50
$sizes="size=".min($size,50);

//----- Pour les champs normalisés, on fixe une taille maximale de saisie, 
//----- même si cette longueur sera ensuite vérifiée par la fonction javascripts verif() sur validation du formulaire
switch($Champ[$num]) {
	case 'codepostal':$taille="maxlength=5";
			  break;
	case 'telephone':$taille="maxlength=10";
		         break;
	case 'prix':$taille="maxlength=8";
		    break;
	case 'quantite';$taille="maxlength=5";
			break;
	case 'date':$taille="maxlength=10";
	default:$taille="";}

//----- Si la taille du champ est inférieure à 100, on édite une balise Input avec l'ensemble des attributs définis 
//----- par les variables valeur, access, sizes, taille, name et verif (qui est l'appel éventuel une fonction JS)
if($size<=100) {$balise='<input type="text"';$balise2='/>';
		$Le_Champ=$balise.' value="'.$Valeur.'" '.$access.' '.$sizes.' '.$taille.' name="'.$key.'" '.$verif.' '.$balise2;}

//----- Si la taille du champ est supérieur à 100, on édite une balise Textarea
          else {$balise='<textarea cols=47 rows=3 ';$balise2='</textarea>';
                $Le_Champ=$balise.$access.' '.$sizes.' '.$taille.' name="'.$key.'" '.$verif.'>'.$Valeur.$balise2;}

print $Le_Champ;

?>

