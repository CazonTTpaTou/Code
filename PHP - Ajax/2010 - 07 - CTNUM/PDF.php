<?php

$largeur=495;
$hauteur=742;
$pdf=pdf_new();
pdf_open_file($pdf);
$logopdf=pdf_open_image_file($pdf,"png","logo.png","",0);
$miseEnPage=pdf_begin_template($pdf,$largeur-100,$hauteur-100);
$font=pdf_findfont($pdf,"Courier","host",FALSE);
if($font) {
	pdf_setfont($pdf,$font,15);}
	else {die("Police d'écriture introuvable");}
pdf_set_value($pdf,"textrendering",1);
pdf_show_xy($pdf,"Bible PHP",175,$hauteur-125);
pdf_setfont($pdf,$font,8);
pdf_set_value($pdf,"textrendering",0);
pdf_show_boxed($pdf,"Bible PHP\r\nChemin des acacias\r\n20876 Germantown\r\n","Tel:02 00 00 00 00",0,$hauteur-100-100,100,100,"fulljustify");

pdf_place_image($pdf,$logopdf,$largeur-100-50,$hauteur-100-50,0.5);
pdf_setfont($pdf,$font,8);
pdf_show_boxed($pdf,"Copyright.SARL Capital 0 Euros",0,0,$largeur-100,15,"center");
pdf_end_template($pdf);
pdf_close_image($pdf,$logopdf);

pdf_begin_page($pdf,$largeur,$hauteur);
pdf_place_image($pdf,$miseEnPage,50,50,1);
$font=pdf_findfont($pdf,"Courier","host",FALSE);
if($font) {pdf_setfont($pdf,$font,10);}
	else {die("Police d\'écriture introuvable");}
pdf_set_value($pdf,"textrendering",0);
pdf_show_boxed($pdf,"Pour: Monsieur Caiman"."\r\nFax: ",$largeur-200,$hauteur-300,150,100,"right","");
pdf_setfont($pdf,$font,14);
pdf_set_value($pdf,"textrendering",0);
$texte="Vous etes un vilain reptile,\r\n"."Bienvenue au vivarium";
pdf_show_boxed($pdf,$texte,50,100,$largeur-100,400,"justify","");
pdf_end_page($pdf);

?>
	