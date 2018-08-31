<?php

/* PHP lit le contenu du cookie PHPSESSID sur le serveur qui contient l'identifiant assign� � l'utilisateur
   si ce cookie n'existe pas, un nouvel identifiant est cr�� de mani�re al�atoire et est envoy� au navigateur client.
   PHP ouvre alors un fichier sur le serveur, qui a l'identifiant utilisateur comme nom, et qui contient d�j� les 
   variables d�j� stock�es dans la session (tableau $_SESSION[]). */

			session_start();

/* On s'assure que la variable sauvegarde a bien �t� d�finie. En effet, si l'utilisateur clique sur le bouton Restaurer
   avant d'avoir cliqu� sur le bouton Sauvegarder, la variable n'aura pas �t� encore cr��e, donc PHP ne pourra pas r�cup�rer
   sa valeur dans le tableau $_SESSION des variables de session */

			if (isset( $_SESSION['sauvegarde'] )) $sauv = $_SESSION['sauvegarde'];
				else $sauv = 'Pas d\'enregistrement!';

/* PHP renvoie du code XHTML qui imprime sur l'�cran du navigateur un champ r�sultat agr�ment� de la valeur de la variable de session
   enregistr�e lors de l'appel du script de sauvegarde script1.php. */

			print('<input id="ftw" type="text" name="result" value="'.$sauv.'">');		
							
		?>