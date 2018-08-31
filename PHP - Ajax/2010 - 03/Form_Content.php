<?php

//----- On initialise la variable access à la valeur readonly, car pour les 3 tables, le premier champ est une clé primaire 
//----- de type auto increment, que l'utilisateur ne doit en aucun cas pouvoir modifier, d'où l'attribut readonly
$access="readonly";
$mention="Ne pas remplir";

//----- On détermine la clé primaire contenant l'id de l'enregistrement en fonction de la table choisie	
switch($_SESSION['Tab']) {
	case 'articles':$ref='reference';break;
	case 'achats':$ref='id_achat';break;
	case 'clients':$ref='numero';break;}

print '<div class="formi">';
print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'" method="POST">';
//print '<form action="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'" method="POST">';

include("Connexion.php");

//----- Si Get(id) est défini, c'est que le formulaire doit être pré-rempli avec les valeurs correspondantes à cet identifiant
if (isset($_GET['id'])) {

   //----- Construction de la requête qui va sélectionner la ligne correspondant à l'identifiant inséré dans l'URL
   //----- et qui va permettre d'extraire les valeurs de la table pour pré-remplir les champs du formulaire
   $sql="select * from ".$_SESSION['Tab']." where ".$ref."=".$_GET['id'].";";

	$resulte = mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");

	while($ligne = mysql_fetch_array($resulte,MYSQL_ASSOC)) {

		//----- On stocke les valeurs extraite de la ligne dans un tableau Contenu
		foreach($ligne as $key => $value) {$Contenu[$key]=$value;}}

	mysql_close($connectID);}

$num=0;	

//----- A partir de Liste_Champ, on lance une requête de type desc sur la table sélectionnée par l'utilisateur
//----- on stocke dans un tableau Champ le nom des champs de la table choisie
//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie	
include("Liste_Champ.php");
	
      foreach($Champ as $key) {
		
		//----- Si il s'agit d'une requête insertion, les champs édités doivent être vides
		if($_SESSION['Requ']=='Insertion') {$Valeur=$mention;}

			//---- Sinon, on édite la valeur extraite de la requête dans le champ correspondant
			else {$Valeur=$Contenu[$key];}
		
		//----- Début d'une sous section de style qui aligne les libellés de champ sur la gauche de l'élément parent
		print'<span class="libelle">';
		$numi=$num+1;
		print '<label>'.$numi.'. '.$key.' :</label></span>';

		//----- Début d'une sous section de style qui aligne les champs sur la droite de l'élément parent
		print '<span class="champs">';

		//----- On insère des menus déroulants dans les deux cas suivants
		if($key=='id_article' || $key=='id_client') {include("Extraction_Selection.php");}

			//----- Sinon on édite une balise de champ de type input ou textarea
			//----- où les attributs sont déterminés à partir du type de la variable du champ 
 			else {include("Code_JS.php");}

		print'</span>';
		
		//----- On ajuste la symétrie du formulaire en insérant des lignes en fonction de la nature de
		//----- de la balise éditée: Input ou Textarea
		if(substr($balise,1,8)=="textarea") 
			{$lig= (int) ($size/50);
		         for($i=0;$i<$lig+1;$i++) {print '<br/>';}}
		   else{print '<br/><br/>';}

		++$num;

		//----- Seules les requêtes Insertion et modification laisse à l'utilisateur la liberté de saisie dans les champs
		if(($_SESSION['Requ']=='Consultation') || ($_SESSION['Requ']=='Suppression')) {$access="readonly";}
			else{$access="";}
		$mention="";}

//----- On détermine les boutons que l'on va insérer en fin de formulaire

//----- Pour la requête suppression, l'utilisateur ne doit pas pouvoir utiliser le bouton effacer
if ($_SESSION['Requ']=='Suppression') {$Eff="disabled";}
	else {$Eff="";}

switch($_SESSION['Requ']) {
	
	//----- Pour la simple consultation, on ne doit pas valider le formulaire
	//----- On insère donc un bouton qui va permettre de retourner au menu d'accueil, sans rien valider
	case 'Consultation':print'<span class="libelle">';
			    print'<input type="button" name="back" value="Retour au Menu"';
       			    print'onclick="this.form.action = \'Menu.php?Operation=Accueil\'; this.form.submit()"/ >';
			    print'</span>';
		            $_SESSION['Message']='Choisissez une opération SVP';
			    break;
	
	//----- Pour les autres requêtes, on insère un classique bouton Valider et un bouton Effacer
	default:print'<span class="libelle">';
		print'<input type="submit" name="submited" value="Valider"/>';
		print'</span>';

		print'<span class="champs">';
		print'<input type="reset" name="reseted" value="Effacer"'.$Eff.'/>';
		print'</span>';}

//----- Fin du formulaire
print'</form>';
print'</div>';


?>




