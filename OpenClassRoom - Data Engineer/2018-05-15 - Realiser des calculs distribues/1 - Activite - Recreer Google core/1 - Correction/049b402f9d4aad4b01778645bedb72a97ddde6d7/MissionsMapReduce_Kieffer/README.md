# Cours OpenClassroom - Réalisez des calculs distribués sur des données massives - Exercices MapReduce

**Note importante :** tous les scripts map/reduce on été écrits en Python 3 et testés avec Hadoop Streaming 3.0.0 sur un cluster Hadoop 3.0.0 installé sur ma machine locale Linux (VirtualBox Ubuntu)


## Mission 1 : TF-IDF

### Enoncé

L'exercice consiste à évaluer l'importance des termes contenus dans un document, relativement à un corpus. Ici le corpus est constitué de deux documents/livres:
- The Call of the Wild (Jack London)
- Robinson Crusoe (Daniel Defoe)

Le but est, à partir de ces deux documents, de renvoyer un ensemble de paires `((mot, doc_id), TF-IDF)`, où `TF-IDF` représente l'importance accordée à un `mot` donné d'un document `doc_id` relativement au corpus. Le TF-IDF se calcule de la manière suivante:

`w_t,d = (tf_t,d / n_d) × log(N/df_t)`

avec:
- `tf_t,d` qui représente la fréquence d'un mot `t` dans un document `d`
- `n_d` qui représente le nombre de mots dans un document `d`
- `df_t` qui représente la fréquence du terme dans la collection, soit le nombre de documents dans lequel le mot `t` est présent (dans notre cas, ce sera 1 ou 2)
- `N` est le nombre de documents dans notre collection, soit ici 2.


### Solution proposée

**Nombre de tâches map/reduce impliquées : 3**

Les fichiers sont organisés de la manière suivante dans le .zip fourni (à l'intérieur du répertoire `/mission1`):
- `input/` contient les deux documents/livres téléchargés (à déposer dans HDFS dans un dossier `input/`)
- `output/` contient les fichiers de résultats des opérations map et reduce successives (récupérés en local depuis HDFS et renommés `output1.txt`, `output2.txt` et `output3.txt`, respectivement) ainsi que le fichier `results.txt` qui contient la liste des 20 mots qui ont la plus forte pondération TF-IDF
- `mapper*.py` correspond aux scripts map successifs (3 en tout)
- `reducer*.py` correspond aux scripts reduce successifs (3 en tout)
- `driver.sh` est un script shell permettant de lancer les 3 tâches map/reduce successives avec Hadoop Streaming
- `sortResults.py` est un script python classique qui doit prendre en entrée le fichier `output3.txt` et renvoie la liste des 20 mots qui ont la plus forte pondération TF-IDF (cette liste est présente dans `output/results.txt`)


#### Etape 1 - calcul de tf_t,d
- **Map**
	- lecture du fichier `stopwords_en.txt` et chargement des mots dans une structure `set()`
	- lecture de chaque ligne de texte issue des deux documents/livres
	- pour chaque ligne:
		- récupération du nom du document `doc_id` via `os.getenv('mapreduce_map_input_file')`
		- filtrage du texte brut (mise en minuscules, retrait de la ponctuation, des caractères numériques, des mots < 3 caractères et des espaces multiples/tabulations)
		- écriture de la paire clé-valeur `((word, doc_id), 1)` dans `stdout` pour chaque mot restant après filtrage

- **Reduce**
	- lecture de chaque paire clé-valeur `((word, doc_id), 1)` issue de l'opération map
	- pour chaque paire:
		- récupération des données `word`, `doc_id` et `count` (=1) dans des variables
		- incrémentation du compteur d'occurrences tant que la paire `(word, doc_id)` est identique à la précédente
		- écriture des données dans `stdout` sous la forme `word\tdoc_id\tcount` dès que l'on passe à un nouveau mot ou document, puis réinitialisation du compteur. `count` correspond à la fréquence du mot `word` dans le document `doc_id`, c'est-à-dire au terme `tf_t_d` dans la formule de TF-IDF

**Notes :**
Le fichier `stopwords_en.txt` doit être placé sur chaque noeud de calcul via l'option `-file` dans la commande de lancement de Hadoop Streaming.
D'autre part l'option `-D stream.num.map.output.key.fields=2` doit être spécifiée dans la commande de lancement de Hadoop Streaming pour que l'algorithme SHUFFLE/SORT comprenne que la clé à traiter correspond aux deux champs `(word, doc_id)`


#### Etape 2 - Calcul de n_d 
- **Map**
	- lecture des données `word\tdoc_id\tcount` issues du reducer de l'étape 1
	- pour chaque ligne:
		- récupération des données `word`, `doc_id` et `count` dans des variables
		- écriture de la paire clé-valeur `(doc_id, (word, count))` dans `stdout`, la clé étant ici `doc_id`

- **Reduce**
	- lecture de chaque paire clé-valeur `(doc_id, (word, count))` issue de l'opération map
	- pour chaque paire:
		- stockage de la paire dans une liste `lines[]` (servira plus tard)
		- récupération des données `doc_id`, `word` et `count` dans des variables
		- stockage et incrémentation de la valeur de `n_d` pour chaque document dans un dictionnaire `{doc_id: n_d}`. `n_d` correspond au nombre total de mots dans le document `doc_id`
	- lecture de chaque paire clé-valeur une seconde fois (ces données ont été stockées dans `lines[]` car `sys.stdin` ne peut pas être parcourue deux fois) 
	- pour chaque paire:
		- écriture des données dans `stdout` sous la forme `word\tdoc_id\tcount\tn_d`, la valeurs de `n_d` étant récupérée dans le dictionnaire `{doc_id: n_d}`


#### Etape 3 - Calcul de df_t puis TF-IDF
- **Map**
	- ici l'opération map ne fait rien de particulier, elle recopie simplement les données `word\tdoc_id\tcount\n_d` issues du reducer de l'étape 2 sur `stdout`, la paire clé-valeur étant `(word, (doc_id, count, n_d))`

- **Reduce**
	- lecture de chaque paire clé-valeur `(word, (doc_id, count, n_d))` issue de l'opération map
	- pour chaque paire:
		- stockage de la paire dans une liste `lines[]` (servira plus tard)
		- récupération des données `doc_id`, `word`, `count`, `n_d` dans des variables
		- stockage et incrémentation de la valeur de `tf_d` pour chaque mot dans un dictionnaire `{word: tf_d}`. `tf_d` correspond au nombre total de documents contenant le mot `word`
	- lecture de chaque paire clé-valeur une seconde fois (ces données ont été stockées dans `lines[]` car `sys.stdin` ne peut pas être parcourue deux fois) 
	- pour chaque paire:
		- calcul de TF-IDF (`w_t`) via la formule `w_t = (count / n_d) * log10(N / df_t)`. la valeur de `df_t` est récupérée dans le dictionnaire `{word: df_t}`. La valeur de `N` est fixée dans le programme et correspond au nombre total de documents (doit être connu à l'avance, ici `N = 2`) 
		- écriture des données dans `stdout` sous la forme `word\tdoc_id\tw_t`


#### Résultats
La sortie finale des 3 opérations map/reduce (`output/outpu3.txt` dans le .zip) contient des données sous la forme `word\tdoc_id\tw_t` où `w_t` correspond à la pondération TF-IDF associée au mot `word` dans le document `doc_id` et relativement au corpus consitué des deux documents.
Le script `sortResults.py` prend en entrée le fichier `output3.txt`, stocke les données dans un DataFrame (librairie `Pandas`), trie les lignes par ordre décroissant de `w_t` et affiche les 20 premiers résultats. Les résultats sont les suivants:

classement | mot      | document               | TF-IDF
---------- | -------- | ---------------------- | --------
1          | buck     | callwild               | 0.007931 
2          | dogs     | callwild               | 0.002599
3          | thornton | callwild               | 0.002247
4          | friday   | defoe-robinson-103.txt | 0.001513
5          | spitz    | callwild               | 0.001432
6          | sled     | callwild               | 0.001388
7          | francois | callwild               | 0.001322
8          | thoughts | defoe-robinson-103.txt | 0.000908
9          | trail    | callwild               | 0.000903
10         | john     | callwild               | 0.000881
11         | perrault | callwild               | 0.000859
12         | hal      | callwild               | 0.000815
13         | team     | callwild               | 0.000749
14         | sol      | callwild               | 0.000639
15         | leks     | callwild               | 0.000617
16         | traces   | callwild               | 0.000617
17         | ice      | callwild               | 0.000617
18         | board    | defoe-robinson-103.txt | 0.000581
19         | dave     | callwild               | 0.000551
20         | corn     | defoe-robinson-103.txt | 0.000507

Ces résultats sont également présents dans le fichier `output/results.txt` (dans le .zip).

Les mots dans le haut du classement correspondent à des mots particulièrement significatifs et spécifiques de l'un ou l'autre des deux livres, ce qui semble indiquer le bon fonctionnement de l'algorithme mapreduce pour le calcule de TF-IDF. Par exemple (buck, thornton) et friday sont respectivement des personnages centraux de "The Call of the Wild" et "Robinson Crusoe".



## Mission 2 : Le page rank

### Enoncé

Le PageRank est une mesure de l'importance d'une page sur le web et correspond à la probabilité qu'un "marcheur" (surfeur sur le web) arrive sur cette page web en supposant que le marcheur se comporte de la manière suivante:
- Soit la page consultée ne pointe vers aucune autre page et le marcheur choisit au hasard une des `n` pages du web
- Soit la page consultée pointe vers `k` autres pages et le marcheur:
	- Va sur n'importe laquelle des `n` pages du web avec la probabilité `s`
	- Va sur l'une des `k` pages accessibles avec la probabilité `(1-s)` 

Au final, la somme des PageRank de toutes les pages web est égale à 1.

Le PageRank s'obtient en multipliant un vecteur `x_i` de dimension `n` représentant notre "marcheur" par une matrice `P` de dimension `n*n` contenant les liens de parenté entre les pages. Au départ notre vecteur "marcheur" est un vecteur ligne `x_0` dont chaque élément a comme valeur `1/n` (car la première étape est de choisir l'une des `n` pages web au hasard). 
Après une première étape de navigation le marcheur est représenté par le vecteur `x_1 = x_0*P`. Les valeurs contenues dans `x_1` représentent le PageRank associé à chacune des pages. Cette opération de multiplication doit ensuite être répétée un certain nombre de fois pour affiner les valeurs du PageRank :

`x_i+1 = x_i*P`

avec:

- `P = (1-s)*T + s/n`

	- `T[k,l] = G[k,l]/n_k`

		- `G[k,l] = 1` si la page `k` pointe vers la page l, et 0 sinon

		- `n_k` le nombre de liens sortants de la page `k`
	- `s = 0.15` la probabilité de téléportation (marcheur qui choisit une page au hasard sur l'ensemble du web au lieu de suivre les liens)

Le nombre d'itérations `i` peut être définit à l'avance ou bien dépendre d'un seuil en-dessous duquel on considère que le PageRank n'évolue plus significativement (`||x_i+1 - x_i|| <= seuil`). Il est par exemple précisé dans l'énoncé que `9` itérations suffisent pour `n=10^9`.

Après `i` itérations chaque composante du vecteur `x_i` représente le PageRank associé à la page web donnée.

Le but de l'exercice est de calculer ce PageRank avec mapreduce en limitant ici le web aux seules pages issues du jeu de données "_movies" qui correspond à des pages web retrouvées par la requête "movies" (7967 pages au total, contre plusieurs milliards voir centaines de milliards pour la totalité du web accessible aux moteurs de recherche). On utilisera le fichier `_movies/adj_list` comme données d'entrée de notre algorithme, qui contient les lignes de la matrice `G` au format suivant:
`pid: pid1 pid2 ... pidN -1`
avec `pid1 ... pidN` les `N` liens associés à la page `pid` et `-1` le marqueur de fin de ligne.


### Solution proposée

**Nombre de tâches map/reduce impliquées >= 2**

Les fichiers sont organisés de la manière suivante dans le .zip fourni (à l'intérieur du répertoire `/mission2`):
- `input/` contient les données d'entrée `adj_list` (à déposer dans HDFS dans un dossier `input/`)
- `output/` contient le fichier `pagerank.txt` (valeurs finales du PageRank) ainsi que `iter_pagerank.txt` qui recense les valeurs successives du PageRank à chaque itération, et enfin `results.txt` qui contient la liste des 20 pages ayant le plus grand PageRank
- `driver.py` est le script principal de calcul du PageRank, où sont définis les chemins d'accès aux différents fichiers, les valeurs de s et du seuil, et d'où sont lancés et supervisés les jobs mapreduce successifs avec Hadoop Streaming
- `linecount_mapper.py` et `linecount_reducer.py` sont des scripts map/reduce permettant de calculer le nombre total de pages `n` à partir de `adj_list`
- `pagerank_mapper` et `pagerank_reducer.py` sont les scripts map/reduce permettant de calculer le PageRank (utilisés plusieurs fois de manière itérative)

**Note:** Il faut au préalable créer des répertoires `input/` et `output/` dans HDFS pour accueillir respectivement les données d'entrée (`adj_list` à déposer soi-même dans `input/`) et les résultats des opérations mapreduce (déposés automatiquement dans `output/`).
Il suffit ensuite d'exécuter le script `driver.py` qui gère l'ensemble des étapes du calcul du PageRank et renvoi les résultats dans le fichier `pagerank.txt`.


#### driver.py

La structure de `driver.py` est la suivante:

1) Définition des paramètres: chemin absolu vers les différents fichiers, valeur de `s`, valeur du seuil (`epsilon`)

2) Calcul de `n` avec une opération mapreduce sur le fichier `adj_list`. 
Bien sûr on pourrait directement lire l'intégralité du fichier, stocker les lignes dans une liste `l` et récupérer `n = len(l)` mais j'ai préféré généraliser le programme au cas où le fichier `adj_list` est trop grand pour pouvoir être stocké sur une seule machine (ici `n = 7967` est petit donc on peut se passer de cette opération mapreduce). Le détail de l'algorithme est le suivant:
	- **Map**
		- lecture de chaque ligne de `adj_list`
		- incrémentation d'un compteur pour chaque ligne parcourue
		- écriture de la paire clé-valeur `(1, compteur)` dans `stdout` une fois la lecture terminée
		
	- **Reduce**
		- lecture de chaque paire clé-valeur `(1, compteur)` issue de l'opération map
		- somme des valeurs de tous les compteurs (possible car `clé = 1` pour toutes les lignes)
		- écriture du résultat de cette somme dans `stdout`, qui est égal à `n`
	
    Note: Si l'on pousse le raisonnement encore plus loin, il faudrait également tenir compte de la taille du vecteur PageRank qui pourrait ne pas rentrer en mémoire d'un noeud map si `n` est trop grand. Dans ce cas il faudrait revoir l'ensemble de l'algorithme map/reduce (ce cas n'est pas traité ici)

3) Création du fichier `iter_pagerank.txt` en local pour pouvoir y stocker les valeurs successives du vecteur PageRank

4) Ecriture du vecteur PageRank initial dans `iter_pagerank.txt` (vecteur ligne `x_0` dont chaque élément a comme valeur `1/n`)

5) Si le dossier HDFS `output/pagerank/` existe déjà, on le supprime et on le recrée (stocke les résultats des opérations mapreduce successives)

6) Algorithme mapreduce de calcul du PageRank:
	- **Map**
		- récupération du dernier vecteur PageRank dans `iter_pagerank.txt` 
		- pour chaque ligne du fichier `adj_list`:
			- récupération du `pid` de la page (premier élément de la ligne) dans une variable `page`
			- récupération des liens accessibles depuis la page (`pid1 ... pidN`) dans une liste `links`
			- calcul du nombre de liens `nl = len(links)`
			- écriture de la paire clé-valeur `(page, 0)` dans `stdout` (si cette page ne possède pas de parent alors une probabilité de `s/n` lui sera tout de même assignée dans le reducer)
			- pour chaque lien `link` de la liste `links`, on écrit la paire clé-valeur `(link, value)` dans `stdout` où `value` est le rapport entre la valeur du dernier PageRank calculé à l'indice `pid` et le nombre de liens `nl`
	
	- **Reduce**
		- récupération des valeurs de `s` et `n` définis dans `driver.py` grâce aux arguments passés en ligne de commande au reducer
		- lecture de chaque paire clé-valeur `(link, value)` issue de l'opération map
		- pour chaque paire:
			- récupération des données `link` et `value` dans des variables
			- incrémentation du compteur `total` tant que la clé `link` est identique à la précédente
			- calcul du PageRank `pagerank = (1-s)*total +s/n` dès que l'on passe à un nouveau lien, et écriture du résultat dans `stdout` sous la forme `(lastlink, pagerank)`
		- on obtient ainsi les différentes valeurs du vecteur PageRank `x_1`

7) Conversion (parsing) du fichier de sortie du reducer `output/pagerank/part-00000` en vecteur PageRank grâce à une commande shell

8) Ecriture du vecteur PageRank à la suite du fichier `iter_pagerank.txt`

9) Calcul de `delta = ||x_1 - x_0||` (avec `numpy.linalg.norm`) et comparaison avec le seuil `epsilon`

10) Si `delta <= epsilon` alors le calcul du PageRank est terminé et on écrit la dernière valeur calculée du PageRank dans le fichier `pagerank.txt`

11) Si `delta > epsilon` on réitère le processus de calcul du PageRank avec mapreduce: `x_i+1 = x_i*P`

12) Une fois le calcul du PageRank terminé (après `i` itérations) les `pid` des 20 pages web ayant le plus grand PageRank sont affichés dans le terminal via une commande shell sur les données de `pagerank.txt`

13) Fin de l'algorithme


</br>
**Notes :**
- Le fichier `iter_pagerank.txt` est placé sur chaque noeud de calcul via l'option `-file` dans la commande de lancement de Hadoop Streaming (dans `driver.py`)
- L'utilisateur peut également spécifier l'argument `clean` lors de l'exécution de `driver.py`, ce qui aura pour effet de forcer le recalcul de `n` (si `n` a déjà été calculé par le passé, alors l'algorithme saute cette étape pour gagner du temps)


#### Résultats

Avec un seuil `epsilon = 0.001`, le calcul du PageRank converge en 8 itérations. Les 20 pages web ayant les plus grand PageRank sont les suivantes :

classement | page (pid) | PageRank
---------- | ---------- | --------
1          | 219        | 0.007943
2          | 2          | 0.002575
3          | 3000       | 0.002165
4          | 6681       | 0.002094
5          | 6231       | 0.001978
6          | 7831       | 0.001965
7          | 4231       | 0.001755
8          | 682        | 0.001742
9          | 1981       | 0.001718
10         | 7387       | 0.001592
11         | 165        | 0.001396
12         | 6898       | 0.001392
13         | 3938       | 0.001392
14         | 6897       | 0.001352
15         | 7253       | 0.001293
16         | 2127       | 0.001228
17         | 77         | 0.001168
18         | 2787       | 0.001143
19         | 4003       | 0.001140
20         | 6939       | 0.001103

Ces résultats sont également présents dans le fichier `results.txt` (dans le .zip).

