<?php

$date=date("Y-m-j");
$connectID=Connexion();

$req3="select count(*) as number from clients where nature_client like '%client%' and npai like '%actif%';";

$success=mysql_query($req3,$connectID) or die ("Impossible d'accéder aux données");

while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
	
	$stat=$row['number'];}

print '<div class="princ_livre" >';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=57&Stats=RFM&Fournisseur=1" >';
print '<input type="button" value="Consulter les scoring - pros inclus" />';
print '</a>';
//print'</span>';

//print'<span class="champs">';
print '<a href="Intro.php?Operation=57&Stats=RFM&Fournisseur=0" >';
print '<input type="button" value="Consulter les scoring - pros exclus" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=35" method="POST">';

print'<span class="libelle">';
print '<label>Segmentation RFM du fichier client :</label>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Au jour du '.$date.' '.$stat.', clients sont suceptibles de constituer le coeur de cible :</label>';
print'</span>';
print '<br/>';
print '<br/>';

			print'<span class="libelle">';
			print '<label>Choisissez le degré du coeur de cible : </label></span>';
						
		//------------ Edition du champ quantité livre en sélection pré-remplie
		 	print '<span class="champs">';

			//----- début de la liste déroulante
			print'<select name="quantite" size ="1">';

			print'<option value ="" name="none">Proportion</option>';

			$a=0;
			//----- Insertion des différentes lignes du menu déroulant à partir des résultats de la requête
			while ($a<=10) {

				$b=(($a/10))*100;
				$num=round($stat*$b,0);
				$a++;

				//----- hormis dans le cas d'une insertion, le champ sera pré-sélectionné sur une valeur
				$selec="";

				//----- on affiche le couple (identifiant,nom) pour chaque ligne de la table correspondante
				print'<option value="'.$num.'" '.$selec.' >'.$b.' % </option>';
				}
				
			//----- fin de la liste déroulante
			print'</select>';
			print'</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print '</form>';

print '</div>';

mysql_close($connectID);

?>