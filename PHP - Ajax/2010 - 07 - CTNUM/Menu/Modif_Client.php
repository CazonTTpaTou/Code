<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';

			$qualite='';
			$nom='';
			$prenom='';
			$adresse_1='';
			$adresse_2='';
			$code_postal='';
			$ville='';
			$telephone='facultatif';
			$e_mail='facultatif';
			$npai='';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

if((isset($_GET['Client'])!=0) || (isset($_GET['Client'])!='')) {

	$_SESSION['URL']="&Client=".$_GET['Client'];
	$req="select * from clients where numero=".$_GET['Client']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$qualite=$row['Qualite'];
			$nom=$row['Nom'];
			$prenom=$row['Prenom'];
			$adresse_1=$row['Adresse_1'];
			$adresse_2=$row['Adresse_2'];
			$code_postal=$row['Code_Postal'];
			$ville=$row['Ville'];
			$telephone=$row['telephone'];
			$e_mail=$row['e_mail'];
			$npai=$row['NPAI'];

			$etat1='';
			$etat2='';
			$etat3='';
			$etat4='';

			switch($npai) {case 'NPAI':$etat2='checked';break;
				       case 'Refuse':$etat3='checked';break;
				       case 'DCD':$etat4='checked';break;
				       default:$etat1='checked';}
		}}

print '<form onsubmit="return filtre(\'nom_id\',\'CP_Client\',\'ville_id\');" action="'.$_SERVER['PHP_SELF'].'?Operation=6&Client='.$_GET['Client'].'" method="POST">';

print'<span class="libelle">';
print '<input type=radio name="etat" value="actif" '.$etat1.' >Actif';
print '<input type=radio name="etat" value="NPAI" '.$etat2.' >NPAI';
print '<input type=radio name="etat" value="Refuse" '.$etat3.' >Refusé';
print '<input type=radio name="etat" value="DCD" '.$etat4.' >Décédé';
print '</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Qualité :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Qualite" value="'.$qualite.'" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Nom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="nom_id" name="Nom" value="'.$nom.'" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Prénom :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Prenom" value="'.$prenom.'" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Adresse principale :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="ad_princ" size="70" value="'.$adresse_2.'"  / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Adresse complémentaire :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Ad_comp" size="70" value="'.$adresse_1.'" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Code Postal :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" name="Code_Postal" value="'.$code_postal.'" maxlength=5 id="CP_Client" onkeypress="return numbers(event);" onBlur="CP(this.id);" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>Ville :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" id="ville_id" name="Ville" value="'.$ville.'" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Téléphone :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="facultatif" id="telephone_id" value="'.$telephone.'" name="telephone" maxlength=10 onFocus="eff(this.id);" onkeypress="return numbers(event);" / >';
print'</span>';
print '<br/>';

print'<span class="libelle">';
print '<label>E-mail :</label>';
print'</span>';
print'<span class="champs">';
print '<input type="text" value="facultatif" id="e_mail_id" value="'.$e_mail.'" name="e_mail" onFocus="eff(this.id);" / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Enregistrer les modifications"/>';
print'</span>';

print'</form>';
print'</div>';

?>

