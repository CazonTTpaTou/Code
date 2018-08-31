<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';
$access='';

$client='';
$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}
$port='5.00';
$catalogue='NO';
$livraison='1';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=37" >';
print '<input type="button" value="Consulter les réassortiments" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

if((isset($_GET['Reassortiment'])!=0) || (isset($_GET['Reassortiment'])!='')) {

	$_SESSION['URL']="&Commande=".$_GET['Commande'];
	$access="readonly";
	$req="select * from commande where numero_com=".$_GET['Commande']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$client=$row['Numero_Client'];
			$date=$row['date'];
			$port=$row['port'];
			$catalogue=$row['catalogue'];
			$livraison=$row['livraison'];}}
			
print '<form onsubmit="return verif(this);" action="'.$_SERVER['PHP_SELF'].'?Operation=17'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Numéro de Fournisseur :</label>';
print'</span>';
print'<span class="champs">';
Extraction('N_Client','fournisseurs',19335,'numero','Nom','Prenom','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date du réassortiment :</label>';
print'</span>';
print '<span class="champs">';
print '<input type="text" name="date" value="'.$date.'" onkeypress="return numbers_dat(event);" onBlur="Datim(this.id);" />';
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Adresse de livraison :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Livraison','ad_livraison',$livraison,'numero_l','Code_Postal','nom','');
print'</span>';
print '<br/>';
print '<br/>';

print '<span class="libelle">';
print '<label>Type de réassortiment :</label>';
print '<input type=radio name="rea" value="automatique" '.$access.' >Automatique';
print '<input type=radio name="rea" value="manuel" checked '.$access.' >Manuel';
print '</span>';
print '<br/>';
print '<br/>';

print'<input type="submit" name="submited" value="Valider"/>';
print'</span>';

print'</form>';
print'</div>';

?>

