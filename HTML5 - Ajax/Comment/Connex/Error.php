<?php

//-------Si le tableau des messages d'erreur n'est pas vide, c'est qu'il y a un probl�me
	
		//-------Impression �cran des diff�rents message d'erreur sous forme de liste � puce
		print'<div class="erreur">';
		echo '<ul>'; 
		   // echo "<li>Un des mots de passe est incorrect.</li>\n";
		  foreach ($Erreur_msg as $err) { 
	 	  echo "<li>".$err."</li>\n";
		  }
		echo "</ul>\n"; 
		echo '</div>';
	
?>