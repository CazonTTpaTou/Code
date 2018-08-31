<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';

if(!(isset($_GET['Modification'])))  {

			$periode[]='NO';
			$sujet[]='NO';
			$lieu[]='NO';
			$genre[]='NO';
			$rubrique[]='NO';}
			

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$connectID=Connexion();
	$_SESSION['URL']="&Modification=1";
	
	$req="select distinct id_cat from liv_periode where id_livre=".$_GET['Livre']." ;";
	
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$periode[]=$row['id_cat'];}

	$req="select distinct id_cat from liv_sujet where id_livre=".$_GET['Livre']." ;";
	
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$sujet[]=$row['id_cat'];}

	$req="select distinct id_cat from liv_lieu where id_livre=".$_GET['Livre']." ;";
	
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$lieu[]=$row['id_cat'];}
	
	$req="select distinct id_cat from liv_genre where id_livre=".$_GET['Livre']." ;";
	
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$genre[]=$row['id_cat'];}

	$req="select distinct id_cat from liv_rubrique where id_livre=".$_GET['Livre']." ;";
	
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			
			$rubrique[]=$row['id_cat'];}
			
		}

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=9&Livre='.$_GET['Livre'].$_SESSION['URL'].'" method="POST">';


print '<span class="libelle">';
print '<label>Période : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Periode[]','periode','num','titre',$periode);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Sujet : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Sujet[]','sujet','num','titre',$sujet);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Lieu : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Lieu[]','lieu','num','titre',$lieu);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Genre : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Genre[]','genre','num','titre',$genre);
print '</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Rubrique : </label></span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
cocher('Rubrique[]','rubrique','num','titre',$rubrique);
print '</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les classifications" />';
print'</span>';

print '</form>';
print '</div>';

?>