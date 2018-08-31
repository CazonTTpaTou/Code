<?php

$connectID=Connexion();

	$req0="delete from genere0;";
	$succes=mysql_query($req0,$connectID) or die("Impossible d'accéder aux données5");
	$req00="delete from genere00;";
	$succes=mysql_query($req00,$connectID) or die("Impossible d'accéder aux données5");
	$req000="delete from genere000;";
	$succes=mysql_query($req000,$connectID) or die("Impossible d'accéder aux données5");

if (isset($_GET['Livraison'])) {$liv=$_GET['Livraison'];}
	else {$liv=Last_Insertion_Liv();}

print '<div class="princ">';

$req0="drop temporary table num_liv;drop temporary table num_rea;drop temporary table cores;";

$req="insert into genere0 select ll.numero_livre,ll.quantite from livraison as li inner join ligne_livraison as ll on ll.numero_com=li.numero_com where li.numero_com=".$liv." group by ll.numero_livre;";

$req1="insert into genere00 select lr.numero_livre,ll.quantite from ligne_reassortiment as lr where numero_com in ((select catalogue from livraison where numero_com=".$liv." union select catalogue_2 from livraison where numero_com=".$liv." union select catalogue_3 from livraison where numero_com=".$liv." group by lr.numero_livre);";

$req2="insert into genere000 select r_livre,r.somme as demande,l.somme as reception from genere00 as r left join genere0 as l on r.numero_livre=l.numero_livre;";

$req="insert into genere0 select lr.numero_com,lr.numero_livre,sum(lr.quantite) as ";
$req.=" somme from ligne_reassortiment as lr where numero_com in (";
$req.="select catalogue from livraison where numero_com=".$liv;
$req.=" union select catalogue_2 from livraison where numero_com=".$liv; 
$req.=" union select catalogue_3 from livraison where numero_com=".$liv;
$req.=") group by lr.numero_livre;";

//echo $req.'<br/>';
$success=mysql_query($req,$connectID) or die ("impossible d'accéder aux données1");;

$req1="insert into genere00 select ll.numero_livre,sum(ll.quantite) as ";
$req1.=" somme from livraison as li inner join ligne_livraison as ll ";
$req1.=" on ll.numero_com=li.numero_com where li.numero_com=".$liv;
$req1.=" group by ll.numero_livre;";

//echo $req1.'<br/>';
$success=mysql_query($req1,$connectID) or die ("impossible d'accéder aux données2");;

$req2="insert into genere000 select r.numero_com,r.numero_livre,li.isbn,li.titre,r.somme as demande,";
$req2.="l.somme as reception,(r.somme-coalesce(l.somme,0)) as reliquat from genere0 as r ";
$req2.="left join genere00 as l on r.numero_livre=l.numero_livre inner join livres as li on r.numero_livre=li.numero;";

//echo $req2.'<br/>';
$success=mysql_query($req2,$connectID) or die ("impossible d'accéder aux données3");;

$req3=" select * from genere000 order by numero_livre;";

//echo $req3.'<br/>';
$succes=mysql_query($req3,$connectID) or die ("impossible d'accéder aux données4");

$i=0;

while($row = mysql_fetch_array($succes,MYSQL_ASSOC)) {
	$liste[]='<li>Réssortiment n° '.$row['numero_com'].' - Livre n° '.$row['isbn'].' - '.$row['titre'].' - Quantité manquante - '.$row['reliquat'].'</li>';
	$i++;}	
		
if($i!=0) {

	   print'<span class="libelle">';
	   print'<label>Liste des livres demandés en réassort qui n\'ont pas été livrés : </label>';
	   print'</span>';
	   print'<br/>';
       	   print'<br/>';
		
	   print '<ol>';
	   	foreach($liste as $key => $value) {print $value;}
	   print '</ol>';

	   print '<br/>';
	   print '<br/>';

	   print'<span class="libelle">';
	   print '<a href="Intro.php?Operation=39&Crea=0" >';
           print '<input type="button" value="Retour Page Principale" />';
           print '</a>';
           print'</span>';

           print'<span class="champs">';
           print '<a href="Intro.php?Operation=39&Crea=1&Livraison='.$liv.'" >';
           print '<input type="button" value="Générer un nouveau réassortiment" />';
           print '</a>';

	   print '</div>';
	   mysql_close($connectID);
            }

else {
        //$succes=mysql_query($req0,$connectID);
	
	print 'Les réassortiments associés ont été complètement soldés';
        mysql_close($connectID);
        $adresse='Intro.php?Operation=0';
        //header('Location: '.$adresse);

	   print '<br/>';
	   print '<br/>';
	   print'<span class="libelle">';
	   print '<a href="Intro.php?Operation=39&Crea=0" >';
           print '<input type="button" value="Retour Page Principale" />';
           print '</a>';
           print'</span>';
	   print '</div>';}

?>