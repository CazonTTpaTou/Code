<?php

/* On récupère la valeur des champs des opérandes du formulaire qui a été validé par l'utilisateur que l'on transtype en float */

	$num_op1 = (float) verif_vide($_POST["op1"]);
	$num_op2 = (float) verif_vide($_POST["op2"]);

/* On effectue l'opération mathématique proprement dite */

	$res=  $num_op1 +  $num_op2;
	
/* PHP renvoie du code XHTML qui imprime sur l'écran du navigateur un champ résultat agrémenté de la valeur de l'opération mathématique
   effectuée à partir des opérandes rentrées dans le formulaire par l'utilisateur. */

	echo('<input id="ftw" type="text" name="result" value="'.$num_op1.' + '.$num_op2.' = '.$res.'" maxlength = "15" ></input>');
?>

