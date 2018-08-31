<?php			

/* verif_operande renvoie 1 si les deux arguments de la fonction ne contiennent que des chiffres ou le "-" et renvoie 0 sinon.
   L'expression régulière rentré dans preg_match ^[[:digit:]]+$ signifie: que des chiffres ou "-" du début à la fin de l'expression $o1 */

			function verif_operande($o1,$o2) {
				if ((preg_match('/^([[:digit:]]|-|.)+$/',verif_vide($o1))) && (preg_match('/^([[:digit:]]|-|.)+$/',verif_vide($o2)))) {return 1;}
				else {return 0;}
			}

/* verif_div_nulle renvoie 1 si l'opérateur passé en argument est une division et le deuxième terme un 0 et renvoie 0 dans le cas contraire */

			function verif_div_nulle($op,$o2) {
				if (($op=='/') && ($o2=='0')) {return 1;}
				else {return 0;}
			}

/* La fonction verif_vide retourne le terme passé en argument, à moins que l'argument soit vide, auquel cas, la fonction retourne 0. */

			function verif_vide($o1) {
				if ($o1=='') {return 0;}
				else {return $o1;}
			}

/* La fonction non_vide vérifie que le terme passé en argument n'est pas vide */

			function non_vide($t1) {
				if ($t1<>'') {return 1;}
				else {return 0;}}

/* Le fonction verif_global permet de s'assurer que les termes passés en argument ne contiennent que des chiffres et aucune division par 0
   Si la fonction renvoie 1, alors les termes passés en argument remplissent les conditions d'un calcul mathématique correct. */

			function verif_global($op1,$op,$op2) {
				if ((verif_operande($op1,$op2)==1) && (verif_div_nulle($op,$op2)==0)) {return 1;}
				else {return 0;}
			}

			
			

?>

