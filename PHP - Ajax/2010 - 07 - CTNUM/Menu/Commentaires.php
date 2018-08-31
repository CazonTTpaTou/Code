<?php

$nomb=0;
$_SESSION['N_Commentaire']=0;
$_SESSION['URL']='';

if(isset($_GET['Modification']) && ($_GET['Modification']==1)) {

	$_SESSION['URL']="&Modification=1";

$connectID=Connexion();
$sqli="select rubrique.num,rubrique.titre as title from rubrique inner join liv_rubrique on rubrique.num=liv_rubrique.id_cat where liv_rubrique.id_livre=".$_GET['Livre']." ;";
//echo $sqli;
$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");
				
	while ($row=mysql_fetch_array($Choix,MYSQL_ASSOC)) {
		$rub[]=$row['title'];
		$num[]=$row['num'];
		//$com[]=$row['com'];
		$nomb++;}

print '<div class="princi">';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=19&Livre='.$_GET['Livre'].$_SESSION['URL'].'" method="POST">';

$i=0;

while($i<$nomb) {
		$a=$i+1;
		print'<span class="libelle" >';
		echo 'Commentaire n° '.$a.' : ---------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libellé du champ rubrique

			$product='P_num_'.$i;
			$product2='P_nim_'.$i;
			$value=$rub[$i];
			$value2=$num[$i];
			$value3='';

			$sql="select commentaire from commentaires where id_cat=".$value2." and id_livre=".$_GET['Livre']." limit 1 ;";
			//echo $sql;
			$comm=mysql_query($sql,$connectID) or die("Impossible d'accéder aux données2");
			while ($com=mysql_fetch_array($comm,MYSQL_ASSOC)) {
				
				$value3=$com['commentaire'];}

			print'<span class="libelle">';
			print '<label>Rubrique :</label>';
			print'</span>';

			print'<span class="champs">';
			print '<input type="text" name="'.$product.'" size="50" value="'.$value.'" readonly="readonly"  / >';
			print '<input type="hidden" name="'.$product2.'" value="'.$value2.'"   / >';
			print'</span>';
			print '<br/>';
			print '<br/>';

		//------------ Edition du champ n° livre en sélection pré-remplie
		 
		$b='commentaire'.$i;

		print'<span class="libelle">';
		print '<label>Commentaire associé :</label>';
		print'</span>';
		print '<br/>';
		print '<br/>';
		print'<span class="libelle">';
		print'<textarea name="'.$b.'" rows="5" cols="100" >';
		print $value3;
		print'</textarea>';
		print'</span>';

		print'<br/>';
		print'<br/>';


			$i++;}}

else {

$connectID=Connexion();
$sqli="select rubrique.num,rubrique.titre as title from rubrique inner join liv_rubrique on rubrique.num=liv_rubrique.id_cat where liv_rubrique.id_livre=".$_GET['Livre']." ;";
//echo $sqli;
$Choix= mysql_query($sqli,$connectID) or die("Impossible d'accéder aux données");
				
	while ($row=mysql_fetch_array($Choix,MYSQL_ASSOC)) {
		$rub[]=$row['title'];
		$num[]=$row['num'];
		$nomb++;}

print '<div class="princi">';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=19&Livre='.$_GET['Livre'].$_SESSION['URL'].'" method="POST">';

$i=0;

while($i<$nomb) {
		$a=$i+1;
		print'<span class="libelle" >';
		echo 'Commentaire n° '.$a.' : ---------------------------------------------------------------------------------------------------------------------------------';
		print'</span>';

		echo '<br/>';
		echo '<br/>';
		
		//------------ Edition du libellé du champ rubrique

			$product='P_num_'.$i;
			$product2='P_nim_'.$i;
			$value=$rub[$i];
			$value2=$num[$i];
			$value3='';
			$value4='Rentrez votre commentaire ou résumé du livre associé à la rubrique '.$value;

			print'<span class="libelle">';
			print '<label>Rubrique :</label>';
			print'</span>';

			print'<span class="champs">';
			print '<input type="text" name="'.$product.'" size="50" value="'.$value.'" readonly="readonly"  / >';
			print '<input type="hidden" name="'.$product2.'" value="'.$value2.'"   / >';
			print'</span>';
			print '<br/>';
			print '<br/>';

		//------------ Edition du champ n° livre en sélection pré-remplie
		 
		$b='commentaire'.$i;

		print'<span class="libelle">';
		print '<label>Commentaire associé :</label>';
		print'</span>';
		print '<br/>';
		print '<br/>';
		print'<span class="libelle">';
		print'<textarea name="'.$b.'" rows="5" cols="100" id="com_id"  >';
		print $value3;
		print'</textarea>';
		print'</span>';

		print'<br/>';
		print'<br/>';


			$i++;}}


mysql_close($connectID);
$_SESSION['N_Commentaire']=$i;

print'<span class="libelle">';
print '<input type="submit" name="submited" value="Enregistrer les commentaires" />';
print'</span>';

print '<br/>';
print '<br/>';

print'</form>';

print'</div>';

?>



