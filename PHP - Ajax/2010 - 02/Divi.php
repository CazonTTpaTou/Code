<?php

/* On récupère la valeur des champs des opérandes du formulaire qui a été validé par l'utilisateur que l'on transtype en float 
   Si la deuxième opérande est vide, on lui attribue la valeur 1. */

	$num_op1 = (float) verif_vide($_POST["op1"]);
	if (non_vide($_POST["op2"])) {$num_op2 = (float) ($_POST["op2"]);}
		else {$num_op2 = 1;}

/* On effectue l'opération mathématique proprement dite */

	$res= round ( $num_op1 /  $num_op2,2);

/* PHP renvoie du code XHTML qui imprime sur l'écran du navigateur un champ résultat agrémenté de la valeur de l'opération mathématique
   effectuée à partir des opérandes rentrées dans le formulaire par l'utilisateur. */

	
	echo('<input id="ftw" type="text" name="result" value="'.$num_op1.' / '.$num_op2.' = '.$res.'" maxlength = "15" ></input>');
?>

