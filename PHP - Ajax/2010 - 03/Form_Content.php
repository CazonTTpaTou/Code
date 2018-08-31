<?php

//----- On initialise la variable access � la valeur readonly, car pour les 3 tables, le premier champ est une cl� primaire 
//----- de type auto increment, que l'utilisateur ne doit en aucun cas pouvoir modifier, d'o� l'attribut readonly
$access="readonly";
$mention="Ne pas remplir";

//----- On d�termine la cl� primaire contenant l'id de l'enregistrement en fonction de la table choisie	
switch($_SESSION['Tab']) {
	case 'articles':$ref='reference';break;
	case 'achats':$ref='id_achat';break;
	case 'clients':$ref='numero';break;}

print '<div class="formi">';
print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'" method="POST">';
//print '<form action="'.$_SERVER['PHP_SELF'].'?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'" method="POST">';

include("Connexion.php");

//----- Si Get(id) est d�fini, c'est que le formulaire doit �tre pr�-rempli avec les valeurs correspondantes � cet identifiant
if (isset($_GET['id'])) {

   //----- Construction de la requ�te qui va s�lectionner la ligne correspondant � l'identifiant ins�r� dans l'URL
   //----- et qui va permettre d'extraire les valeurs de la table pour pr�-remplir les champs du formulaire
   $sql="select * from ".$_SESSION['Tab']." where ".$ref."=".$_GET['id'].";";

	$resulte = mysql_query($sql,$connectID) or die("Impossible d'acc�der aux donn�es");

	while($ligne = mysql_fetch_array($resulte,MYSQL_ASSOC)) {

		//----- On stocke les valeurs extraite de la ligne dans un tableau Contenu
		foreach($ligne as $key => $value) {$Contenu[$key]=$value;}}

	mysql_close($connectID);}

$num=0;	

//----- A partir de Liste_Champ, on lance une requ�te de type desc sur la table s�lectionn�e par l'utilisateur
//----- on stocke dans un tableau Champ le nom des champs de la table choisie
//----- on stocke dans un tableau Champ1 le nom des types de variables des champs de la table choisie	
include("Liste_Champ.php");
	
      foreach($Champ as $key) {
		
		//----- Si il s'agit d'une requ�te insertion, les champs �dit�s doivent �tre vides
		if($_SESSION['Requ']=='Insertion') {$Valeur=$mention;}

			//---- Sinon, on �dite la valeur extraite de la requ�te dans le champ correspondant
			else {$Valeur=$Contenu[$key];}
		
		//----- D�but d'une sous section de style qui aligne les libell�s de champ sur la gauche de l'�l�ment parent
		print'<span class="libelle">';
		$numi=$num+1;
		print '<label>'.$numi.'. '.$key.' :</label></span>';

		//----- D�but d'une sous section de style qui aligne les champs sur la droite de l'�l�ment parent
		print '<span class="champs">';

		//----- On ins�re des menus d�roulants dans les deux cas suivants
		if($key=='id_article' || $key=='id_client') {include("Extraction_Selection.php");}

			//----- Sinon on �dite une balise de champ de type input ou textarea
			//----- o� les attributs sont d�termin�s � partir du type de la variable du champ 
 			else {include("Code_JS.php");}

		print'</span>';
		
		//----- On ajuste la sym�trie du formulaire en ins�rant des lignes en fonction de la nature de
		//----- de la balise �dit�e: Input ou Textarea
		if(substr($balise,1,8)=="textarea") 
			{$lig= (int) ($size/50);
		         for($i=0;$i<$lig+1;$i++) {print '<br/>';}}
		   else{print '<br/><br/>';}

		++$num;

		//----- Seules les requ�tes Insertion et modification laisse � l'utilisateur la libert� de saisie dans les champs
		if(($_SESSION['Requ']=='Consultation') || ($_SESSION['Requ']=='Suppression')) {$access="readonly";}
			else{$access="";}
		$mention="";}

//----- On d�termine les boutons que l'on va ins�rer en fin de formulaire

//----- Pour la requ�te suppression, l'utilisateur ne doit pas pouvoir utiliser le bouton effacer
if ($_SESSION['Requ']=='Suppression') {$Eff="disabled";}
	else {$Eff="";}

switch($_SESSION['Requ']) {
	
	//----- Pour la simple consultation, on ne doit pas valider le formulaire
	//----- On ins�re donc un bouton qui va permettre de retourner au menu d'accueil, sans rien valider
	case 'Consultation':print'<span class="libelle">';
			    print'<input type="button" name="back" value="Retour au Menu"';
       			    print'onclick="this.form.action = \'Menu.php?Operation=Accueil\'; this.form.submit()"/ >';
			    print'</span>';
		            $_SESSION['Message']='Choisissez une op�ration SVP';
			    break;
	
	//----- Pour les autres requ�tes, on ins�re un classique bouton Valider et un bouton Effacer
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




