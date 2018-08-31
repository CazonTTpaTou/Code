
<?xml version="1.0" encoding="ISO-8859-1"?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr"> 

<!-- On rassemble tous les �l�ments de mise en page et de style dans une feuille externe css appel� menus.css -->

<head> 
	<link rel="stylesheet" type="text/css" href="menus.css">
	</link>

	<title> M1 C216 - Devoir n�1 </title>

</head>

<body>
	
<h1 class="titre">Calculatrice</h1>

<!-- On applique � la section div le style css menus1 qui d�finit la position, le cadre, la bordure et la couleur du calculateur-->

<div class="menus1">

	<!-- cr�ation du formulaire qui s'appellera lui m�me, lorsque l'utilisateur cliquera sur le bouton Valider-->

	<form name="calculator" action="<?php $_SERVER['PHP_SELF'] ?>" method="POST" >
		
		<!-- On applique � la sous section span le style css label qui aligne le libell� sur la gauche du formulaire -->
		
		<span class="label">
			<label for="stw">Entrez la premi�re op�rande</label>
		</span>

		<!-- On applique � la sous section span le style css formw qui aligne le champ sur la droite du formulaire -->

		<span class="formw">

			<!-- On ins�re un fragment de code javascript pour emp�cher l'utilisateur de taper autre chose que des chiffres dans le champ -->

			<input id="stw" type="text" name="op1" value="" size="20" maxlength="15" 
				onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false; 
				    if(event.which < 45 || event.which > 57) return false;">
		</span>
		<br/> <br/>

		<span class="label">
			<label for="lrt">Choisissez l'op�rateur</label>
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
			<label for="ltw">Entrez la deuxi�me op�rande</label>
		</span>

		<span class="formw">
			<input id="ltw" type="text" name="op2" value="" size="20" maxlength="15" 
				onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false; 
				    if(event.which < 45 || event.which > 57) return false;">
		</span>

		<br/> <br/>

		<!-- Lorsque l'utilisateur clique sur le bouton effacer, on r�appelle la page html pour effacer les champs d�j� remplis
 		     On aurait pu se contenter de la foncion de base du type reset, sauf que cela n'effa�ait le contenu du champ r�sultat, vu que celui-ci
 		     est d�termin� par le script Webcalc4.php -->

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
			<label for="ltw">Le r�sultat est : </label>
		</span>

		<span class="formw">
		
		<!-- D�but du script PHP qui va effectuer les calculs � partir des entr�es de l'utilisateur dans le formulaire -->

		<?php

			/* Si c'est le premier appel initial du formulaire, il n'y a pas de calcul � effectuer, on passe directement au bloc else. */

			if(@$_POST['submitted'])  {

				/* On appelle le fichier Fonctions.php qui regroupe toutes les fonctions de v�rification des caract�res rentr�s par l'utilisateur */
	
				include("Fonctions.php");

				/* la fonction verif_global s'assure que d'une part l'utilisateur n'a rentr� que des donn�es exploitables dans les champs (chiffres et pas 
 				   de lettres ou de ponctuation) et que d'autre part il n'y a pas de division par 0 */

				if (verif_global($_POST["op1"],$_POST["operateur"],$_POST["op2"])) {				
				
					/* selon l'op�rateur choisi par l'utilisateur, c'est le script correspondant � l'op�ration math�matique souhait�e qui sera appel� � l'aide de include */

					switch ($_POST["operateur"]) {
				
					case '+':include("Addi.php");break;
					case '-':include("Soustri.php");break;
					case '*':include("Multi.php");break;
					case '/':include("Divi.php");break;}}
				
				/* si les entr�es de l'utilisateur ne respectent pas les conditions de verif_global, aucun script de calcul n'est appel�,
				alors on affiche dans le champ R�sultat soit la mention "Donn�es incorrects" si l'utilisateur a rentr� autre chose que des chiffres
									soit la mention "Division par 0" si l'utilisateur a tent� une division par 0. */

				if (verif_operande($_POST["op1"],$_POST["op2"])==0) {
					print('<input id="ftw" type="text" name="result" value="Donn�es incorrectes !!!">');}
				
				if (verif_div_nulle($_POST["operateur"],$_POST["op2"])==1){
					print('<input id="ftw" type="text" name="result" value="Division par 0 !!!">');}}

			/* si l'utilisateur a cliqu� sur le bouton Restaurer, on va afficher la valeur de la variable de session sauvegard�e pr�c�demment. */

			else {if(@$_POST['Restor']) {include("Restaure.php");}

				/* Lors de premier appel, le champ r�sultat doit �tre vide, car il n'y a pas eu encore d'op�ration � effectuer. */

				else {print('<input id="ftw" type="text" name="result" value="" size="20" maxlength="15">');}}	
			
		?>

		</span>

		<br/> <br/>

		<!-- Lorsque l'utilisateur clique sur le bouton Sauvegarder, on lance le script PHP Sauvegarde.php, qui initialise une session et enregistre
		     la valeur du champ r�sultat dans une variable de session, qui sera donc accessible ult�rieurement. 
		     Nous utilisons deux m�thodes diff�rentes pour programmer nos actions li�s aux deux boutons Sauvegarde et Restauration:

			1) Pour la sauvegarde, nous utilisons un champ bouton avec du Javascript qui va lancer le script PHP correspondant sur le clic du bouton 
			2) Pour la restauration, nous utilisons un champ submit, qui appellera WebCalc5.php comme le fait le champ Calculer 
			   Sauf que le script Restaure.PHP correspondant sera appel� en amont � l'aide de la condition if(@$_POST['Restor']). -->

		<span class="label">
			<input type="button" name="Savior" value="Sauvegarder" 
		 	 onclick="this.form.action = 'Sauvegarde.php'; this.form.submit()"></input>
		</span>

		<!-- Lorsque l'utilisateur clique sur le bouton Restaurer, on lance le script PHP Restaure.php, qui r�cup�re la valeur de la variable de
 		    session enregistr�e lors de l'appel de la sauvegarde. La valeur du champ r�sultat prend alors la valeur de cette variable de session -->

		<span class="formw">
			<input type="submit" name="Restor" value="Restaurer">  
		</span>

		<br/> 
	</form>
</div>

<!-- On ins�re une image de calculatrice pour agr�menter la page -->

<div class="picture">
<img  alt="image formulaire calculatrice" src="calculatrice.jpg" />
</div>

</body>

</html>

