<?php 
      include("Fonct.php");
      Opération();
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script src="fonctions_JS.js" type="text/javascript"></script>   

<link rel="stylesheet" type="text/css" href="Presentation2.css">
</link>
<title>CTNUM</title>

</head>

<body>

<?php

$req="SELECT distinct menu from menu;";

$connectID=Connexion();

$selection = mysql_query($req,$connectID) or die ("Vous n\'êtes pas autorisés à vous connecter sur cet espace !!!");

print '<div id="Menu_M" class="Intro" >';

print '<table id="tableau" color:#000000 height=100% width=100% background-color:#FFFFFF border=0px  cellpadding=2px >';

while($rows = mysql_fetch_array($selection,MYSQL_ASSOC)) {
	print'<tr>';
	print'<td id="'.$rows['menu'].'" class="tabl" onClick="choix(this.id)" >'.$rows['menu'].'</td>';
	print'<td id="'.$rows['menu'].'1" class="tabl1" " >--------------------------------</td>';	
	print'</tr>';
	}

print '</table>';

print '</div>';

print '<div class="Message">';
print '<a href="Chat/">Messagerie</a>';
print '</div>';

if(!(@$_POST['submited'])) {
				switch(@$_SESSION['Operation']) {
					case '0':if($_SESSION['Message']!='') {message();}break;
					case '1';include('Commande.php');break;
					case '2':include('Lig_commande.php');break;
					case '3':include('Recherche_client.php');break;
					case '4':include('Client.php');break;
					case '5':include('Modif_lig_com.php');break;
					case '6':include('Recherche_commande.php');break;
					case '7':include('Recherche_commande.php');break;
					case '8':include('Modif_client.php');break;
					case '9':include('Modif_commande.php');break;
					case '10':include('Recherche_commande.php');break;
					case '11':include('Avoir.php');break;
					case '12':include('Modif_Client.php');break;
					case '13':include('Recherche_client.php');break;
					case '14':include('Creation_Livre.php');break;
					case '15':include('Ajoute_Auteur.php');break;
					case '16':include('Creation_Livre_Cl.php');break;
					case '17':include('Mots_cles.php');break;
					case '18':include('Commentaires.php');break;
					case '19':include('Creation_Auteur.php');break;
					case '20':include('Recherche_Auteur.php');break;
					case '21':include('Recherche_Livre.php');break;
					case '22':include('Menu_Livre.php');break;
					case '23':include('Recherche_Livre_2.php');break;
					case '24':include('Recherche_Livre_3.php');break;
					case '25':include('Recherche_Livre_4.php');break;
					case '26':include('Consultation_Livre.php');break;
					case '27':include('Gestion_Categorie.php');break;
					case '28':include('Modif_Categorie.php');break;
					case '29':include('Consultation_stock.php');break;
					case '30':include('Reassortiment.php');break;
					case '31':include('Ligne_Reassortiment.php');break;
					case '32':include('Livraison.php');break;
					case '33':include('NPAI.php');break;
					case '34':include('Modif_Livraison.php');break;
					case '35':include('Ligne_Livraison.php');break;
					case '36':include('Modif_Ligne_Livraison.php');break;
					case '37':include('Consultation_reassortiment.php');break;
					case '38':include('Auto_reassortiment.php');break;
					case '39':include('Reassort_Again.php');break;
					case '40':include('Expediable.php');break;
					case '41':include('En_Attente.php');break;
					case '42':include('Stock.php');break;
					case '43':include('Stock_manquant.php');break;
					case '44':include('Recherche_Envoi.php');break;
					case '45':include('Annule_Expedition.php');break;
					case '46':include('Recherche_Expedition.php');break;
					case '47':include('Creation_catalogue.php');break;
					case '48':include('Chemin_Fer.php');break;
					case '49':include('Chemin_Fer_livre.php');break;
					case '50':include('Export_XML.php');break;
					case '51':include('Modif_Catalogue.php');break;
					case '52':include('Creation_Fichier.php');break;
					case '53':include('Liste_Fichier.php');break;
					case '54':include('Dedoublonnage.php');break;
					case '55':include('Dedoublonnage_dual.php');break;
					case '56':include('Statistiques_Clients.php');break;
					case '57':include('Top_Client.php');break;
					case '58':include('Statistiques_Client_R.php');break;
					case '59':include('Statistiques_Livres.php');break;
					case '60':include('Statistiques_Livres_R.php');break;
					case '61':include('Statistiques_Catalogue.php');break;
					case '62':include('Statistiques_Catalogues_R.php');break;
					case '63':include('Statistiques_Globales.php');break;
					case '64':include('Fidelisation.php');break;
					case '65':include('Segmentation.php');break;
					case '66':include('Edouard.php');break;
					case '67':include('Recherche_Edouard.php');break;
				}}

if(@$_POST['submited']) {
				switch(@$_SESSION['Operation']) {
					case '0':if($_SESSION['Message']!='') {message();}break;
					case '1':include('Commande_R.php');break;
					case '2':include('Lig_commande_r.php');break;
					case '3':include('Commande_R.php');break;
					case '4':include('Client_R.php');break;
					case '5':include('Modif_lig_com_R.php');break;
					case '6':include('Modif_Client_R.php');break;
					case '7':include('Creation_Livre_R.php');break;
					case '8':include('Ajoute_Auteur_R.php');break;
					case '9':include('Creation_Livre_Cl_R.php');break;
					case '10':include('Mots_cles_R.php');break;
					case '11':include('Creation_Auteur_R.php');break;
					case '12':include('Creation_Auteur_M.php');break;
					case '13':include('Recherche_Livre_2_R.php');break;
					case '14':include('Recherche_Livre_3_R.php');break;
					case '15':include('Gestion_Categorie_R.php');break;
					case '16':include('Modif_Categorie_R.php');break;
					case '17':include('Reassortiment_R.php');break;
					case '18':include('Ligne_Reassortiment_R.php');break;
					case '19':include('Commentaires_R.php');break;
					case '20':include('Livraison_R.php');break;
					case '21':include('Ligne_Livraison_R.php');break;
					case '22':include('Modif_Ligne_Livraison_R.php');break;
					case '23':include('NPAI_R.php');break;
					case '24':include('Expediable_R.php');break;
					case '25':include('Creation_catalogue_R.php');break;
					case '26':include('Chemin_Fer_R.php');break;
					case '27':include('Chemin_Fer_livre_R.php');break;
					case '28':include('Modif_Catalogue_R.php');break;
					case '29':include('Modif_Catalogue_R_R.php');break;
					case '30':include('Creation_Fichier_R.php');break;
					case '31':include('Dedoublonnage_R.php');break;
				        case '32':include('Dedoublonnage_R_R.php');break;
					case '33':include('Dedoublonnage_dual_R.php');break;
					case '34':include('Dedoublonnage_dual_R_R.php');break;	
					case '35':include('Segmentation_R.php');break;	
					case '36':include('Edouard_R.php');break;
				}}



?>
</body>
</html>