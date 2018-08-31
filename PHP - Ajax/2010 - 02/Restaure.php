<?php

/* PHP lit le contenu du cookie PHPSESSID sur le serveur qui contient l'identifiant assigné à l'utilisateur
   si ce cookie n'existe pas, un nouvel identifiant est créé de manière aléatoire et est envoyé au navigateur client.
   PHP ouvre alors un fichier sur le serveur, qui a l'identifiant utilisateur comme nom, et qui contient déjà les 
   variables déjà stockées dans la session (tableau $_SESSION[]). */

			session_start();

/* On s'assure que la variable sauvegarde a bien été définie. En effet, si l'utilisateur clique sur le bouton Restaurer
   avant d'avoir cliqué sur le bouton Sauvegarder, la variable n'aura pas été encore créée, donc PHP ne pourra pas récupérer
   sa valeur dans le tableau $_SESSION des variables de session */

			if (isset( $_SESSION['sauvegarde'] )) $sauv = $_SESSION['sauvegarde'];
				else $sauv = 'Pas d\'enregistrement!';

/* PHP renvoie du code XHTML qui imprime sur l'écran du navigateur un champ résultat agrémenté de la valeur de la variable de session
   enregistrée lors de l'appel du script de sauvegarde script1.php. */

			print('<input id="ftw" type="text" name="result" value="'.$sauv.'">');		
							
		?>