<?php

/* On r�cup�re la valeur des champs des op�randes du formulaire qui a �t� valid� par l'utilisateur que l'on transtype en float 
   Si la deuxi�me op�rande est vide, on lui attribue la valeur 1. */

	$num_op1 = (float) verif_vide($_POST["op1"]);
	if (non_vide($_POST["op2"])) {$num_op2 = (float) ($_POST["op2"]);}
		else {$num_op2 = 1;}

/* On effectue l'op�ration math�matique proprement dite */

	$res= round ( $num_op1 /  $num_op2,2);

/* PHP renvoie du code XHTML qui imprime sur l'�cran du navigateur un champ r�sultat agr�ment� de la valeur de l'op�ration math�matique
   effectu�e � partir des op�randes rentr�es dans le formulaire par l'utilisateur. */

	
	echo('<input id="ftw" type="text" name="result" value="'.$num_op1.' / '.$num_op2.' = '.$res.'" maxlength = "15" ></input>');
?>

