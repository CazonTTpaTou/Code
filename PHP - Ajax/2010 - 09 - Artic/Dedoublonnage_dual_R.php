<?php
$tamp=0;
$connectID=Connexion();

print '<div class="princ" >';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=34" method="POST">';

print'<span class="libelle">';
	     print '<a href="Intro.php?Operation=0" >';
             print '<input type="button" value="Retour Page Principale" />';
	     print '</a>';
	     print'</span>';
print'<br/>';
print'<br/>';

$sql="select count(*) as nombre from clients where fichiers like '%".$_POST['Fichier']."%'";

$succes=mysql_query($sql,$connectID) or die ("Impossible d'accéder aux données1");

while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {$total=$row['nombre'];}

//----------------- Sélection des dédoublonnés

$clients=" where fichiers like '%".$_POST['Fichier']."%'";

$part1="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from clients ".$clients;
//$nombre2=(max(0,$nombre-$nombre1));
$i=0;
$tampon='';

//----------------- Sélection des dédoublonneurs

$clause=" where fichiers not like ".$_POST['Fichier'];

$part2="select numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville from clients ".$clause.";"; 
//into outfile ".$nom." fields terminated by ';' lines terminated by '\r';";

$req=$part1." ; ";
$req1="insert into dedoublonnage (numero,qualite,nom,prenom,adresse_1,adresse_2,code_postal,ville) ".$req;
//echo $req1;
//$succs=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données2");

	                  $req="delete from dedoublonnage;";
			  $succes=mysql_query($req,$connectID) or die ("Impossible d'accéder aux données3");

			  $succs=mysql_query($req1,$connectID) or die ("Impossible d'accéder aux données2");

			  $req2="update dedoublonnage set match_code=upper(concat(trim(coalesce(code_postal,'')),trim(coalesce(nom,'')),trim(coalesce(prenom,''))));";
			  $succes=mysql_query($req2,$connectID) or die ("Impossible d'accéder aux données2");

			$req3="select d.match_code as match_code from dedoublonnage as d where numero in ";
			$req3.="(select tampon.numero from (select d1.numero from dedoublonnage as d1 ";
			$req3.="inner join dedoublonnage as d2 on d1.match_code=d2.match_code  ";
			$req3.="and d1.numero<>d2.numero order by 1) as tampon )  ;";
			 
			//echo $req3;
			$succis=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données4");
			//$eff=mysql_affected_rows();
$i=0;
$nombre=0;
while($row = mysql_fetch_array($succis,MYSQL_ASSOC)) {
			//array_search($comm[1][$i],$stock[0]);
						       $Doub[$i][0]=$row['match_code'];		
							$i++;}
		

$b=round($i/2,0);			
print '<span class="libelle" >';
	     print '<label>Dédoublonnage de fichiers (conservation du N° client le plus ancien) : </label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';

			 
print '<span class="libelle" >';
	     print '<label>Nombre de doublons trouvés : '.$b.'</label>';
	     print '</span>';
	     print '<br/>';
	     print '<br/>';

$a=1;
print"<ul>\n";
while($b<$i) {print'<li>Doublon n° '.$a.' - Match_code: '.$Doub[$b][0];
		    print '</li>';
		    $b++;
		    $a++;}
print'</ul>';
print'<br/>';
print'<br/>';

	     print'<span class="libelle">';
	     print '<input type="submit" name="submited" value="Supprimer les doublons"  />';
             print'</span>';

print'</form>';
print'</div>';

mysql_close($connectID);

?>