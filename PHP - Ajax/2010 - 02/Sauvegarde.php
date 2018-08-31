<?php

			/* PHP lit le contenu du cookie PHPSESSID sur le serveur qui contient l'identifiant assigné à l'utilisateur
			   si ce cookie n'existe pas, un nouvel identifiant est créé de manière aléatoire et est envoyé au navigateur client.
			   PHP ouvre alors un fichier sur le serveur, qui a l'identifiant utilisateur comme nom, et qui contient déjà les 
			   variables déjà stockées dans la session (tableau $_SESSION[]). */

			session_start();

			/* Si c'est une première sauvegarde, on crée la variable 'sauvegarde' dans le tableau des variables de session
			   On assigne alors à la variable sauvegarde la valeur qui se trouvait dans le champ résultat au moment où l'utilisateur a cliqué
			   sur le bouton Sauvegarder du formulaire. */

  			$_SESSION['sauvegarde'] = $_POST["result"];

			/* On redirige ensuite le navigateur sur une page vierge en appelant la page de départ: WebCalc5.php . */
			
			header('location: WebCalc5.php');		
			
		?>

		
