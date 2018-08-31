<?php include('Verification.php'); ?>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="stylesheet" type="text/css" href="Presentation1.css" ></link>
	<script src="Function.js" type="text/javascript"></script>   
	<meta name="robots" content="none" />
	<title>Messages</title>

</head>

<body>


<div><span class="title">Consultation des courriers</span>
<span class="global">Message</span>
</div>

<?php
	if($flag==3) {include('Liste.php');}
	
		else {include('Error.php');}
 ?>

</body>
</html>

