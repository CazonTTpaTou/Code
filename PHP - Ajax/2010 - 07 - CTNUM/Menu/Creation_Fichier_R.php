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

$_SESSION['Routeur']=$_POST['Nb_pages'];

$nombre=$_POST['Nb_pages'];

print '<div class="princ" >';

//----------------- Sélection des clients

if($_POST['client']==1) {$clients=" where nature_client not like '%Prospect%'";}

if($_POST['npai']==1) {$client=" and npai like 'Actif' ";}

$part1="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from clients ".$clients.$client." limit ".$nombre."";

$sql="select count(*) as nombre from clients ".$clients.$client." limit ".$nombre.";"; 
//echo $sql;

$succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données1");

while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {$nombre1=$row['nombre'];}

$nombre2=(max(0,$nombre-$nombre1));

//----------------- Sélection des prospects

if($_POST['excl']==2) {$clause=" and nature_client not like '%Client%'";}
if($_POST['npai']==1) {$clause.=" and npai like 'Actif' ";}

if($_POST['prospect']==1) {$clause.=" or fichiers like 'Nouveau'";}
if($_POST['prospect']==2) {$clause.=" and fichiers not like 'Nouveau'";}

$fic=$_POST['Fichier'];
//echo $fic;

foreach($fic as $value) {$clause.=" or fichiers like '".$value."' ";}

$part2="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from clients where numero>0 ".$clause." limit ".$nombre2.";"; 
//into outfile ".$nom." fields terminated by ';' lines terminated by '\r';";

$req=$part1." union ".$part2;
$req1="insert into dedoublonnage (numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville) ".$req;
//echo $req1;
//$succs=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données2");

if($_POST['doublon']==1) {$req="delete from dedoublonnage;";
			  $succes=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données3");

			  $succes=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données3");

			  $req2="update dedoublonnage set match_code=upper(concat(trim(coalesce(code_postal,'')),trim(coalesce(nom,'')),trim(coalesce(prenom,''))));";
			  $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données2");

			$req3="delete from dedoublonnage where numero in ";
			$req3.="(select tampon.numero from (select d1.numero from dedoublonnage as d1 ";
			$req3.="inner join dedoublonnage as d2 on d1.match_code=d2.match_code  ";
			$req3.="and d1.numero>d2.numero order by 1) as tampon ) ;";
			 
			$succis=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données4");
			$eff=mysql_affected_rows();}

$req4="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from dedoublonnage order by numero;";
$succos=mysql_query($req4,$connectID) or die ("Impossible d'accéder aux données5");

if($eff==0) {$eff='Aucun';} 

if($succos) {
	     print '<span class="libelle" >';
	     print '<label>Résultats de l\'exportation : </label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';
	     print '<span class="libelle" >';
	     print '<label>Nombre de doublons supprimés (conservation du N° client le plus ancien) : '.$eff.'</label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';
             print '<span class="libelle" >';
	     print '<label>Nombre de prospects : '.$nombre2.' ( ';
	     printf('%.2f',$nombre2/$nombre*100);
	     print ' % ) </label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';
             print '<span class="libelle" >';
             print '<label>Nombre de clients : '.$nombre1.' ( ';
	     printf('%.2f',$nombre1/$nombre*100);
	     print ' % ) </label>';
             print '</span>';
	     print '<br/>';
	     print '<br/>';
             print '<span class="libelle" >';
       	     print '<label>Taille total du fichier de routage: '.$nombre.' adresses</label>';
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
		$texte.=strtoupper(trim($value)).";";
		$xml.='< '.$key.'>'.strtoupper(trim($value)).'</'.$key.'>';}
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