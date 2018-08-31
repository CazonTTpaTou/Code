<?php

header('Content-type: text/html; charset=iso-8859-1'); 
$clause='';

//session_start();

include("Fonct.php");

$ligne=0;

if(($_POST['Annee']!='inconnu')&&($_POST['Annee']!=''))  {$clause="".$_POST['Annee']."";}

if(($_POST['Mois']!='inconnu') && ($_POST['Mois']!='')) {$clause.="-".$_POST['Mois']."";}

if(($_POST['Jour']!='inconnu')&&($_POST['Jour']!='')) {$clause.="-".$_POST['Jour']."";}

echo $clause;

?>