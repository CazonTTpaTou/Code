<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';

$selec1='';
$selec2='';
$client='';
$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}
$port='38.00';
$catalogue='NO';
$livraison='Aucun';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

if((isset($_GET['Commande']))) {

	$_SESSION['URL']="&Commande=".$_GET['Commande'];
	$req="select * from commande where numero_com=".$_GET['Commande']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);
	
		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$client=$row['Numero_Client'];
			$date=$row['date'];
			$port=$row['port'];
			$catalogue=$row['catalogue'];
			$livraison=$row['livraison'];}}
			
print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=36'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Numéro de client :</label>';
print'</span>';
print'<span class="champs">';
if((isset($_GET['Client']))) {$client=$_GET['Client'];}
	
print '<input type="text" name="N_Client" id="C_client" value="'.$client.'" onkeypress="return numbers(event);"  / >';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=3" >';
print '<input type="button" value="Recherche Client" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de la commande :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="date" value="'.$date.'" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" />';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Montant :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="port" value="'.$port.'" onkeypress="return numbers_dec(event);" />';
print'</span>';
print '<br/>';
print '<br/>';

//------------ Edition du libellé du champ quantité livre
			print'<span class="libelle">';
			print '<label>Durée Abonnement : </label></span>';
						
		//------------ Edition du champ quantité livre en sélection pré-remplie
		 	print '<span class="champs">';

			//----- début de la liste déroulante
			print'<select name="Catalogue" size ="1">';
			if($catalogue==1) {$selec1='selected';}
			if($catalogue==2) {$selec2='selected';}
			print'<option value ="" name="none">Durée</option>';
			print'<option value ="1" name="none" '.$selec1.'>6_mois</option>';
			print'<option value ="2" name="none" '.$selec2.'>1_an</option>';
			print'</select>';
			print '</span>';

print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Anciens numéros commandés :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="livres" id="livres" value="'.$livraison.'" onfocus="eff(this.id);" />';
print'</span>';
print '<br/>';
print '<br/>';


print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>

