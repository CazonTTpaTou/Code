<?php

$date=date("Y-m-j");
$heure=date("H-i-s");
$i=1;
$eff=0;
$clients=" where numero <0 ;";
$clause=" where numero <0 ;";
$nombre1=0;
$nombre2=0;

$nom="Fichiers/TXT_Routage_".$date.'-'.$heure;
$noms="Fichiers/XML_Routage_".$date.'-'.$heure;
$connectID=Connexion();

$xml='<fichier date="'.$date.$heure.'" >';
enregistre($noms,$xml);

$nombre=0;

print '<div class="princ" >';

//$req="delete from dedoublonnage;";
//$succes=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données3");
//$succes=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données3");

			  
$req2="select count(*) as nombre from commande where (date+ interval (case catalogue when 1 then 8 when 2 then 14 end) Month )>=curdate() ;"; 
$succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données3");
while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
	$nombre=$row['nombre'];}

$req3="select cl.qualite,cl.nom,cl.prenom,cl.adresse_1,cl.adresse_2,cl.code_postal,cl.ville from commande as co inner join ";
$req3.="clients as cl on cl.numero=co.numero_client where (date+ interval (case catalogue when 1 then 8 when 2 then 14 end) Month )>=curdate() ;"; 
//echo $req3;
$succos=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données3");

if($eff==0) {$eff='Aucun';} 

if($succos) {
	     print '<span class="libelle" >';
	     print '<label>Résultats de l\'exportation : </label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';
	     
	     print '<span class="libelle" >';
       	     print '<label>Nombre de journaux à envoyer : '.$nombre.' adresses</label>';
             print '</span>';
	     print '<br/>';
	     print '<br/>';

	     print'<span class="libelle">';
	     print '<a href="Intro.php" >';
             print '<input type="button" value="Retour Page Principale" />';
	     print '</a>';
	     print'</span>';
             print '<br/>';
             print '<br/>';}

while($row = mysql_fetch_array($succos,MYSQL_ASSOC)) {

	$texte='';
	$xml='<prospect numero="'.$i.'" >';
	foreach($row as $key => $value) {
		$texte.=mb_strtoupper(trim($value)).";";
		$xml.='< '.$key.'>'.mb_strtoupper(trim($value)).'</'.$key.'>';}
		$texte.="\n";
		$xml.='</ prospect>';
		$xml.="\n";
		enregistre($nom,$texte);
		enregistre($noms,$xml);
		$i++;}

$xml='</fichier>';
enregistre($noms,$xml);

//select * from livres into outfile'C:\\Documents and Settings\\Fabien Monnery\\Bureau\\Prix.csv' fields terminated by';' lines terminated by '\r';
//select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from dedoublonnage group by match_code having count(*)>1;";

//delete from dedoublonnage where numero in (select numero from (select numero from dedoublonnage as d1 inner join dedoublonnage as d2 on d1.match_code=d2.match_code  and d1.numero>d2.numero order by 1)) ;
//delete from dedoublonnage where numero in (select tampon.numero from (select d1.numero from dedoublonnage as d1 inner join dedoublonnage as d2 on d1.match_code=d2.match_code  and d1.numero>d2.numero order by 1) as tampon ) ;

mysql_close($connectID);

print '<span class="libelle">';
print '<label>Lien des fichiers générés : </label>';
print '</span>';
print '<br/>';

print '<span class="libelle">';
print '<a href="'.$nom.'.txt" TARGET="_blank" >Fichier Export TXT généré le '.$date.' à '.$heure.' </a>';
print '</span>';

$adresse="Compression.php?Fichier=".$nom.".txt";
print '<span class="champs">';
print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
print '</span>';

print '<br/>';

print '<span class="libelle">';
print '<a href="'.$noms.'.txt" TARGET="_blank" >Fichier Export XML généré le '.$date.' à '.$heure.' </a>';
print '</span>';

$adresse="Compression.php?Fichier=".$noms.".txt";
print '<span class="champs">';
print '<input type="button" value="Générer l\'archive du fichier" id="'.$adresse.'" onclick="window.open(this.id);"/>'; 
print '</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=53" >';
print '<input type="button" value="Accéder aux autres fichiers d\'export" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '</div>';

?>