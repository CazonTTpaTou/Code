<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';

$client='';
$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}
$port='5.00';
$catalogue='NO';
$livraison='1';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';
print '<br/>';
print '<br/>';

if((isset($_GET['Commande'])!=0) || (isset($_GET['Commande'])!='')) {

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
			
print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=1'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Numéro de client :</label>';
print'</span>';
print'<span class="champs">';
if((isset($_GET['Client'])) && ($_GET['Client']!=0)) {$client=$_GET['Client'];}
	
print '<input type="text" name="N_Client" id="C_client" value="'.$client.'" onkeypress="return numbers(event);" onBlur="num_c();" / >';
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
print '<label>Frais de port :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="port" value="'.$port.'" onkeypress="return numbers_dec(event);"/>';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Catalogue associé :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Catalogue','catalogue',$catalogue,'num_cat','nom','','');
print'</span>';
print '<br/>';
print'<br/>';

print'<span class="libelle">';
print '<label>Anciens numéros commandés :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="livres" value="Aucun" />';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>

