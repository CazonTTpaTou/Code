<?php

header('Content-type: text/html; charset=iso-8859-1'); 

//session_start();

include("Fonc.php");

//------- La variable nous servira pour �diter les en t�tes de champs
$ligne=0;

//------- On construit la requ�te s�lection correspondante � la table en cours de consultation
switch($_SESSION['Tab']) {

	case 'clients':$sq="SELECT numero,nom,prenom,code_postal,ville from clients ";            
                        break;

	case 'ad_livraison':$sq="SELECT numero,nom,prenom,code_postal,ville from clients ";            
                        break;

	case 'livres':$sq="SELECT numero,auteur,titre,prix from livres ";
                        break;	
	
	//----- pour la table client, on s�lectionne tous les champs hormis le pays
	//----- les donn�es seront s�par�es dans le tableau par les diff�rentes valeurs prises par le champ codepostal
	case 'commande':$sq="select c.numero_com,c.date,cl.nom,cl.code_postal,sum(lig.quantite) as Nb_Livre,sum(li.prix*lig.quantite) as Total ";
                        $sq.="from commande as c inner join clients as cl on c.numero_client=cl.numero inner join ";
			$sq.="ligne_commande as lig on c.numero_com=lig.numero_com ";
			$sq.="inner join livres as li on lig.numero_livre=li.numero ";
                       break;

	default: $sq="SELECT * from ".$_SESSION['Tab']."";}

//------- si l'instance de xtmlhttprequest ne nous transmet pas de valeur pour 'family', on n'op�re pas de tri sur la s�lection
if(isset($_POST['family'])) {$col=" order by ".$_POST['family'].";";}
	else {$col=";";}

//------- on rajoute la cl� de tri transmis par l'instance de xmlhttprequest � la requ�te de s�lection d�finie plus haut
$sq.=$col;

//------- Connexion � la BDD et lancement de la requ�te de tri-s�lection

$connectID=Connexion();
$success=mysql_query($sq,$connectID) or die ("impossible d'acc�der aux donn�es2");

$ligne=0;

//------- On initialise le tableau code qui va contenir toutes les instructions html qui seront renvoy�es par xmlhttprequet.responseText
$last="";
$Code[]="";

//------- On extrait chaque ligne de la requ�te pour la convertir en code html qu'on stocke dans le tableau code
while($row=mysql_fetch_array($success,MYSQL_ASSOC)) {
$colonne=0;

//------- Si la ligne est paire, la couleur de fond de la ligne sera verte, et blanche si impaire
if($ligne%2 == 0) {$couleur=' class="fond1" ';}
	else {$couleur=' class="fond2" ';}

//------- On �dite les en t�tes de champ qui doivent contenir le code javascript n�cessaires � l'appel de tri sans rechargement de la page
if ($ligne==0) {foreach($row as $key => $value) {$Code[]='<td id="'.$key.'" class="entete" onclick="tri(this.id)">'.$key.'</td>';}
		$Code[]='<td class="entete">Op�ration</td>';}

//------- Si il y a un changement de valeur sur la colonne de tri, on ins�re deux lignes de s�paration
//if(!($row[$_POST['family']]==$last)) {$Code[]='<tr></tr><tr><tr/><tr></tr><tr><tr/>';}
$Code[]='<tr>';

//------- On remplit la tableau code des commandes html qui permettront d'�diter le corps du tableau nouvellement tri�
foreach($row as $value) {if($colonne==0) {$identifiant=$value;}
		         $Code[]='<td'.$couleur.'>'.$value.'</td>';
			 ++$colonne;}

//------- Commandes htlm pour �diter le lien qui permettre une action sur la ligne correspondante du tableau
//------- On doit faire attention de bien saisir le nom de la page qui �dite le tableau avant son tri, dans le lien
//------- car si on fait appel � la variable serveur Php _self, le lien renverra � cette page qui sert uniquement de tampon
//------- pour l'objet XmlHttpRequest, appel�e par la fonction javascript
$Code[]='<td'.$couleur.'><a href="Menu.php?Operation='.$_SESSION['Requ'].'&Table='.$_SESSION['Tab'].'&id='.$identifiant.'">'.$_SESSION['Requ'].'</a></td>';
$Code[]='</tr>';

++$ligne;
$last=$row[$_POST['family']];}


//------- On �dite la succession de commandes html du tableau tri� que nous avons stock� dans le tableau code, 
//------- pour qu'elle soient lisible par la m�thode responseText et ex�cutable par la fonction javascript innerhtml
foreach($Code as $value) {echo $value;}

?>