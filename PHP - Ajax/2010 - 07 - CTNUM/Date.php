<?php
//$date_j=date("Y-m-j");
$date_j = date_create(date("Y-m-j"));
date_sub($date_j, date_interval_create_from_date_string('1 day'));
echo date_format($date_j, 'Y-m-d');
print '<br/>';
print'<a href="PDF_tab.php" target="_blank" >Générer un PDF</a>';
print '<a href="Intro.php?Operation=0" >';
print '<input type="button" value="Retour Page Principale" />';
print '</a>';
?>
