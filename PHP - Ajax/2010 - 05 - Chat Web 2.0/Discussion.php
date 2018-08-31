<?php 	error_reporting(E_ALL^E_WARNING);
	include("Fonctions.php");?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 

	<link rel="stylesheet" type="text/css" href="Presentation.css" ></link>
	<script src="Func.js" type="text/javascript"></script>  

	<title>TellMeMore.com</title>

</head>

<body onload="boucle();">

<?php include("interface.php");?>


<?php 

	if(isset($_SERVER['HTTP_REFERER'])) {the_last_ten();}
					
?>



</body>

</html>




