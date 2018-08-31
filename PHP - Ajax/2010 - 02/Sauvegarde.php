<?php

			/* PHP lit le contenu du cookie PHPSESSID sur le serveur qui contient l'identifiant assign� � l'utilisateur
			   si ce cookie n'existe pas, un nouvel identifiant est cr�� de mani�re al�atoire et est envoy� au navigateur client.
			   PHP ouvre alors un fichier sur le serveur, qui a l'identifiant utilisateur comme nom, et qui contient d�j� les 
			   variables d�j� stock�es dans la session (tableau $_SESSION[]). */

			session_start();

			/* Si c'est une premi�re sauvegarde, on cr�e la variable 'sauvegarde' dans le tableau des variables de session
			   On assigne alors � la variable sauvegarde la valeur qui se trouvait dans le champ r�sultat au moment o� l'utilisateur a cliqu�
			   sur le bouton Sauvegarder du formulaire. */

  			$_SESSION['sauvegarde'] = $_POST["result"];

			/* On redirige ensuite le navigateur sur une page vierge en appelant la page de d�part: WebCalc5.php . */
			
			header('location: WebCalc5.php');		
			
		?>

		
