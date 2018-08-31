<?php
$_SESSION['Operation']=0;
$_SESSION['Message']='';
$_SESSION['URL']='';

$client='';
$date=date("Y-m-j");
if(strlen($date)!=10) {$jour=substr($date,8);$jour='0'.$jour;$dat=substr($date,0,8);$date=$dat.$jour;}
$port='0.00';
$catalogue='NO';
$catalogue2='NO';
$catalogue3='NO';
$livraison='19335';

print '<div class="princ">';

print'<span class="libelle">';
print '<a href="Intro.php" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
print'</span>';

print'<span class="champs">';
print '<a href="Intro.php?Operation=34" >';
print '<input type="button" value="Modifier une livraison" />';
print '</a>';
print'</span>';

print '<br/>';
print '<br/>';

if((isset($_GET['Livraison'])!=0) || (isset($_GET['Livraison'])!='')) {

	$_SESSION['URL']="&Livraison=".$_GET['Livraison'];
	$req="select * from livraison where numero_com=".$_GET['Livraison']." ;";
	$connectID=Connexion();
	$result = mysql_query($req,$connectID);

		while($row = mysql_fetch_array($result,MYSQL_ASSOC)) {
			$client=$row['Numero_Client'];
			$date=$row['date'];
			$port=$row['port'];
			$catalogue=$row['catalogue'];
			$catalogue2=$row['catalogue_2'];
			$catalogue3=$row['catalogue_3'];
			$livraison=$row['livraison'];}

		$req="update reassortiment set etat=0 where numero in (select catalogue from livraison where numero_com=".$_GET['Livraison']." union select catalogue_2 from livraison where numero_com=".$_GET['Livraison']." union select catalogue_3 from livraison where numero_com=".$_GET['Livraison']." );";
		//echo $req;
		$success=mysql_query($req,$connectID) or die("Impossible d'accéder aux données");}
			
print '<form onsubmit="" action="'.$_SERVER['PHP_SELF'].'?Operation=20'.$_SESSION['URL'].'" method="POST">';

print'<span class="libelle">';
print '<label>Numéro de fournisseur :</label>';
print'</span>';
print'<span class="champs">';
Extraction('Fournisseur','fournisseurs',$client,'numero','Qualite','Nom','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print '<label>Date de la livraison :</label>';
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
print '<label>Réassortiment associé n°1 :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Reas1','reas',$catalogue,'numero','nom','date','');
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Réassortiment associé n°2 :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Reas2','reas',$catalogue2,'numero','nom','date','');
print'</span>';
print'<br/>';
print'<span class="libelle">';
print '<label>Réassortiment associé n°3 :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Reas3','reas',$catalogue3,'numero','nom','date','');
print'</span>';
print'<br/>';;
print'<br/>';

print'<span class="libelle">';
print '<label>Adresse de livraison :</label>';
print'</span>';
print '<span class="champs">';
Extraction('Livraison','ad_livraison',$livraison,'numero_l','ville','nom','');
print'</span>';
print '<br/>';
print '<br/>';

print'<span class="libelle">';
print'<input type="submit" name="submited" value="Enregistrer Livraison"/>';
print'</span>';

print'</form>';
print'</div>';

mysql_close($connectID);

?>