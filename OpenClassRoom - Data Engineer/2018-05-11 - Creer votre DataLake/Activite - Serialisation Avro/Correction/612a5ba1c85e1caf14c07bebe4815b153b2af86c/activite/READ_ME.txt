READ_ME

Le schéma avro utilisé est le suivant
	un type record de namespace "lefabuleuxmandarindor" et de nom "Plat"
	dont le fields est une liste contenant 5 objets:
		un type string nommé "nom"
		un type array nommé "ingredients" dont les items sont de type string et la valeur par défaut []
		un type string nommé "origine" avec par défaut la valeur "null"
		un type float nommé "prix"
		un type enum nommé "type" dont  les symbols sont "plat" et "accompagnement"


{
	"type": "record",
	"namespace": "lefabuleuxmandarindor",
	"name": "Menu",
	"fields": [
		{"name": "nom", "type": "string"},
		{"name": "ingredients", "type": {"type": "array", "items": "string"}, "default": []},
		{"name": "origine", "type": "string", "default": "null"},
		{"name": "prix", "type": "float"},
		{"name": "type", "type": {"type": "enum", "name": "Type", "symbols": ["plat", "accompagnement"]}}
	]
}

Le script.py utilise le python contenant les modules installés fastavro, hdfs etc ... utiles à ce cours.
Chez moi, il est dans anaconda2. A vous de modifier la première ligne suivant votre environnement.
Ou bien vous copier-coller le code python sur le shell de votre python.
Le script script.py propose de télécharger ce schéma avro au format json.
Il propose ensuite un objet records sous forme d'une liste de dictionnaires.

records = [
    {
        "nom": "饺子",
        "origine": "北京", 
        "ingredients": ["chou", "porc", "farine"],
        "prix": 4,
        "type": "plat"
    },
    {
        "nom": "方便面",
        "ingredients": ["piment", "nouilles"],
        "prix": 1.5,
        "type": "plat",
    },
    {
        "nom": "宫保鸡丁",
        "origine": "四川", 
        "ingredients": ["poulet", "cacahuetes"],
        "prix": 8,
        "type": "plat"
    },
    {
        "nom": "米饭",
        "ingredients": ["riz"],
        "prix": 1,
        "type": "accompagnement"
    },
    {
        "nom": "冰水",
        "prix": 0.5,
        "type": "accompagnement"
    }
]

Lors de l'écriture de ces données sous format avro, python rencontre un problème d'encodage.

On propose donc deux solutions :
	La première consiste à écrire une fonction coder qui va réencoder tous les string de l'objet records en unicode. Cette fonction peut être améliorée si des tuples ou des sets apparaissent dans les données (ce qui n'est pas le cas ici).
	La seconde qui consiste à la main à ajouter devant chaque string entre guillemets une lettre u pour unicode. On a renommé l'objet records en records_unicode. C'est une méthode fastidieuse si les données sont massives. Donc la première est la meilleure.
	
Enfin les dernières lignes servent à écrire ces données réencodées en unicode dans un fichier avro (plats.avro et plats_unicode.avro). On utilise une fonction reader_avro pour lire nimporte quel fichier avro.

En bonus, vus avez les commandes shell (terminal linux bash) pour lancer le script ou les commandes pour le shell du python.
