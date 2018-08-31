<?php

$date=date("Y-m-j");
$heure=date("H-i-s");
$i=1;

$nom="Fichiers/Coeur-Cible_TXT_".$date.'-'.$heure;
$noms="Fichiers/Coeur-Cible_XML_".$date.'-'.$heure;
$connectID=Connexion();

$xml='<fichier date="'.$date.$heure.'" >';
$xml.="\n";
enregistre($noms,$xml);

$nombre=$_POST['quantite'];

$req="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville,";
$req.="round((datediff(curdate(),max(co.date)))/30,2) as recence,";
$req.="(count(co.numero_client)) as frequence,sum(lig.quantite*pr.prix) as montant,";
$req.="round((count(co.numero_client)*power(sum(lig.quantite*pr.prix),1/2))*";
$req.="(power(datediff(curdate(),co.date),-1/3)),2) as RFM from clients as cl inner join ";
$req.="commande as co on cl.numero=co.numero_client inner join ligne_commande ";
$req.="as lig on lig.numero_com=co.numero_com inner join prix as pr on ";
$req.="pr.id_livre=lig.numero_livre where ";
$req.="nature_client like '%client%' group by cl.numero order by RFM desc limit ".$nombre." ;";

$succos=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données1");

while($row = mysql_fetch_array($succos,MYSQL_ASSOC)) {

	$texte='';
	$xml='<client numero="'.$i.'" >';
	$a=1;
	foreach($row as $key => $value) {
		if($a<=8) {
			$texte.=strtoupper(trim($value)).";";
			$xml.='< '.$key.'>'.strtoupper(trim($value)).'</'.$key.'>';
			$a++;}}
		$texte.="\n";
		$xml.='</ client>';
		$xml.="\n";
		enregistre($nom,$texte);
		enregistre($noms,$xml);
		$i++;}

$xml='</fichier>';
enregistre($noms,$xml);

mysql_close($connectID);

print '<div class="princ" >';

print '<span class="libelle">';
print '<label>Lien des fichiers générés par la segmentation RFM : </label>';
print '</span>';
print '<br/>';

print '<span class="libelle">';
print '<a href="'.$nom.'.txt" TARGET="_blank" >Fichier Coeur de cible TXT généré le '.$date.' à '.$heure.' </a>';
print '</span>';

$adresse="Compression.php?Fichier=".$nom.".txt";
print '<span class="champs">';
print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
print '</span>';

print '<br/>';

print '<span class="libelle">';
print '<a href="'.$noms.'.txt" TARGET="_blank" >Fichier Coeur de cible XML généré le '.$date.' à '.$heure.' </a>';
print '</span>';

$adresse="Compression.php?Fichier=".$noms.".txt";
print '<span class="champs">';
print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
print '</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour à la page principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '</div>';

?>