<?php

if(isset($_GET['Catalogue'])) {

$catalogue=$_GET['Catalogue'];

$date=date("Y-m-j");
$heure=date("H-i-s");

$nom='XML/XML_Catalogue_'.$catalogue.'_'.$date.'_'.$heure;
//echo $noms;
$noms='XML/Fichier_XML_Catalogue_'.$catalogue;

$xml[]='<catalogue numero="'.$catalogue.'" date="'.$date.'" >';

$connectID=Connexion();

$req="select * from chemin_fer_livre where num_cat=".$catalogue." ;";
//echo $req;
$result=mysql_query($req,$connectID);

$page=1;
$xml[]='<page numero="1" >';

print '<div class="princ_livre" >';

while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
	if($page!=$row['num_page']) {$page=$row['num_page'];
				     $xml[]='</page>';
			
				     $xml[]='<page numero="'.$page.'" >';}
	$livre=$row['num_livre'];
	$xml[]='<livre numero="'.$livre.'" >';
	$com=$row['num_com'];
	
	$sql="select li.titre as titre,li.sous_titre as sous_titre,li.prix as prix,li.pages as pages,";
	$sql.="li.isbn as isbn,li.image as image,li.editeur as editeur, ";
	$sql.="group_concat(aut.auteur) as author,co.commentaire as commentaire from livres as li ";
	$sql.="inner join liv_aut as liv on liv.id_livre=li.numero ";
	$sql.="inner join auteurs as aut on aut.id_auteur=liv.id_auteur ";
	$sql.="inner join commentaires as co on co.id_livre=li.numero ";
	$sql.="where co.num_ligne=".$com." and li.numero=".$livre." group by aut.auteur ;";

	//echo $sql;
	$results=mysql_query($sql,$connectID) or die("Impossible d'accéder aux données");
		
	while($row = mysql_fetch_array($results,MYSQL_ASSOC)) {

		$xml[]='<titre>'.$row['titre'].'</titre>';
		$xml[]='<sous titre>'.$row['sous_titre'].'</sous titre>';
		$xml[]='<auteur>'.trim($row['author']).'</auteur>';
		$xml[]='<isbn>'.$row['isbn'].'</isbn>';
		$xml[]='<prix>'.$row['prix'].'</prix>';
		$xml[]='<pages>'.$row['pages'].'</pages>';
		$xml[]='<image>'.$row['image'].'</image>';
		$xml[]='<editeur>'.$row['editeur'].'</editeur>';
		$xml[]='<commentaire>'.$row['commentaire'].'</commentaire>';}

	$xml[]='</livre>';}

$xml[]='</page>';
$xml[]='</catalogue>';

foreach($xml as $value) {enregistre($nom,$value."\n");}

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Dernier fichier d\'export généré du catalogue n°'.$catalogue.' : </label></span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Lien du fichier : </label>';
print '</span>';

print '<span class="libelle">';
print '<a href="'.$nom.'.txt" TARGET="_blank" >Fichier Export XML généré le '.$date.' à '.$heure.' </a>';
print '</span>';

$adresse="Compression.php?Fichier=".$nom.".txt";
print '<span class="champs">';
print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
print '</span>';

print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Autres fichiers d\'export XML : </label>';
print '</span>';}

if(!(isset($_GET['Catalogue']))) {

	print '<div class="princ_livre" >';

	print'<span class="libelle">';
	print '<a href="Intro.php?Operation=0" >';
	print '<input type="button" value="Retour Page Principale" />';
	print '</a>';
	print'</span>';
	print '<br/>';
	print '<br/>';

	print '<span class="libelle">';
	print '<label>Choisissez un fichier d\'export XML : </label>';
	print '</span>';

	print '<br/>';
	print '<br/>';}

$serverPath =$_SERVER['DOCUMENT_ROOT'];  
$folderPath = "/CTNUM/Menu/XML/"; 
$fullPath = $serverPath.$folderPath;

//echo $fullPath;

$folder=dir($fullPath);

$navArray = array();

while($thisItem=$folder->read()) {

	$printThis = 1;

	$folderItem=$fullPath.$thisItem;

				  $foundDot=(strpos($thisItem,".",0));
				  if($foundDot===0) $printThis=0;
				  $foundDot=(strpos($thisItem,"_",0));
				  if($foundDot===0) $printThis=0;

				  if($printThis) {$thisItemDisplay = str_replace("_"," ",$thisItem);
						  $thisItemDisplay = preg_replace('/^[0-9]+/',"",$thisItemDisplay);
						  $thisItemDisplay = ucfirst($thisItemDisplay);
						  $navArray[$thisItemDisplay]=$thisItem;}}

asort($navArray);
print"<ul>\n";

foreach ($navArray as $name=>$value) {
	print '<li><a href="'.$folderPath.$value.'" TARGET="_blank">'.$name."</a>";
	$adresse="Compression.php?Fichier=XML/".$value;
	//echo $adresse;
	print '<span class="champs">';
	print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
	print '</span>';
	print'</li>';}

	print "</ul>";
	$folder->close();
	

print '</div>';

?>