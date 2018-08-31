
<?xml version="1.0" encoding="ISO-8859-1"?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr"> 

<!-- On rassemble tous les éléments de mise en page et de style dans une feuille externe css appelé menus.css -->

<head> 
	<link rel="stylesheet" type="text/css" href="menus.css">
	</link>

	<title> M1 C216 - Devoir n°1 </title>

</head>

<body>
	
<h1 class="titre">Calculatrice</h1>

<!-- On applique à la section div le style css menus1 qui définit la position, le cadre, la bordure et la couleur du calculateur-->

<div class="menus1">

	<!-- création du formulaire qui s'appellera lui même, lorsque l'utilisateur cliquera sur le bouton Valider-->

	<form name="calculator" action="<?php $_SERVER['PHP_SELF'] ?>" method="POST" >
		
		<!-- On applique à la sous section span le style css label qui aligne le libellé sur la gauche du formulaire -->
		
		<span class="label">
			<label for="stw">Entrez la première opérande</label>
		</span>

		<!-- On applique à la sous section span le style css formw qui aligne le champ sur la droite du formulaire -->

		<span class="formw">

			<!-- On insère un fragment de code javascript pour empêcher l'utilisateur de taper autre chose que des chiffres dans le champ -->

			<input id="stw" type="text" name="op1" value="" size="20" maxlength="15" 
				onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false; 
				    if(event.which < 45 || event.which > 57) return false;">
		</span>
		<br/> <br/>

		<span class="label">
			<label for="lrt">Choisissez l'opérateur</label>
		</span>
		
		<span class="formw">
		<select id="lrt" type="text" name="operateur" >
			<option value="+">+</option>
			<option value="*">*</option>
			<option value="/">/</option>
			<option value="-">-</option>
		</select>
		</span>

		<br/> <br/>

		<span class="label">
			<label for="ltw">Entrez la deuxième opérande</label>
		</span>

		<span class="formw">
			<input id="ltw" type="text" name="op2" value="" size="20" maxlength="15" 
				onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false; 
				    if(event.which < 45 || event.which > 57) return false;">
		</span>

		<br/> <br/>

		<!-- Lorsque l'utilisateur clique sur le bouton effacer, on réappelle la page html pour effacer les champs déjà remplis
 		     On aurait pu se contenter de la foncion de base du type reset, sauf que cela n'effaçait le contenu du champ résultat, vu que celui-ci
 		     est déterminé par le script Webcalc4.php -->

		<span class="label">
			<input type="reset" name="btnG1" value="Effacer"
				onclick="this.form.action = 'WebCalc5.php'; this.form.submit()"></input>
		</span>

		<!-- En appuyant sur le bouton calculer, l'utilisateur valide le formulaire et appelle le scrip t php Webcalc4.php qui va effectuer les calculs -->

		<span class="formw">
			<input type="submit" name="submitted" value="Calculer">
		</span>

		<br/> <br/>

		<span class="label">
			<label for="ltw">Le résultat est : </label>
		</span>

		<span class="formw">
		
		<!-- Début du script PHP qui va effectuer les calculs à partir des entrées de l'utilisateur dans le formulaire -->

		<?php

			/* Si c'est le premier appel initial du formulaire, il n'y a pas de calcul à effectuer, on passe directement au bloc else. */

			if(@$_POST['submitted'])  {

				/* On appelle le fichier Fonctions.php qui regroupe toutes les fonctions de vérification des caractères rentrés par l'utilisateur */
	
				include("Fonctions.php");

				/* la fonction verif_global s'assure que d'une part l'utilisateur n'a rentré que des données exploitables dans les champs (chiffres et pas 
 				   de lettres ou de ponctuation) et que d'autre part il n'y a pas de division par 0 */

				if (verif_global($_POST["op1"],$_POST["operateur"],$_POST["op2"])) {				
				
					/* selon l'opérateur choisi par l'utilisateur, c'est le script correspondant à l'opération mathématique souhaitée qui sera appelé à l'aide de include */

					switch ($_POST["operateur"]) {
				
					case '+':include("Addi.php");break;
					case '-':include("Soustri.php");break;
					case '*':include("Multi.php");break;
					case '/':include("Divi.php");break;}}
				
				/* si les entrées de l'utilisateur ne respectent pas les conditions de verif_global, aucun script de calcul n'est appelé,
				alors on affiche dans le champ Résultat soit la mention "Données incorrects" si l'utilisateur a rentré autre chose que des chiffres
									soit la mention "Division par 0" si l'utilisateur a tenté une division par 0. */

				if (verif_operande($_POST["op1"],$_POST["op2"])==0) {
					print('<input id="ftw" type="text" name="result" value="Données incorrectes !!!">');}
				
				if (verif_div_nulle($_POST["operateur"],$_POST["op2"])==1){
					print('<input id="ftw" type="text" name="result" value="Division par 0 !!!">');}}

			/* si l'utilisateur a cliqué sur le bouton Restaurer, on va afficher la valeur de la variable de session sauvegardée précédemment. */

			else {if(@$_POST['Restor']) {include("Restaure.php");}

				/* Lors de premier appel, le champ résultat doit être vide, car il n'y a pas eu encore d'opération à effectuer. */

				else {print('<input id="ftw" type="text" name="result" value="" size="20" maxlength="15">');}}	
			
		?>

		</span>

		<br/> <br/>

		<!-- Lorsque l'utilisateur clique sur le bouton Sauvegarder, on lance le script PHP Sauvegarde.php, qui initialise une session et enregistre
		     la valeur du champ résultat dans une variable de session, qui sera donc accessible ultérieurement. 
		     Nous utilisons deux méthodes différentes pour programmer nos actions liés aux deux boutons Sauvegarde et Restauration:

			1) Pour la sauvegarde, nous utilisons un champ bouton avec du Javascript qui va lancer le script PHP correspondant sur le clic du bouton 
			2) Pour la restauration, nous utilisons un champ submit, qui appellera WebCalc5.php comme le fait le champ Calculer 
			   Sauf que le script Restaure.PHP correspondant sera appelé en amont à l'aide de la condition if(@$_POST['Restor']). -->

		<span class="label">
			<input type="button" name="Savior" value="Sauvegarder" 
		 	 onclick="this.form.action = 'Sauvegarde.php'; this.form.submit()"></input>
		</span>

		<!-- Lorsque l'utilisateur clique sur le bouton Restaurer, on lance le script PHP Restaure.php, qui récupère la valeur de la variable de
 		    session enregistrée lors de l'appel de la sauvegarde. La valeur du champ résultat prend alors la valeur de cette variable de session -->

		<span class="formw">
			<input type="submit" name="Restor" value="Restaurer">  
		</span>

		<br/> 
	</form>
</div>

<!-- On insère une image de calculatrice pour agrémenter la page -->

<div class="picture">
<img  alt="image formulaire calculatrice" src="calculatrice.jpg" />
</div>

</body>

</html>

