# ~/anaconda2/bin/python2.7
# -*- coding:utf-8 -*-
# la première ligne de ce script et à modifier suivant le home de votre python contenant les modules fastavro, hdf, etc ...
import json
import fastavro
# pour imprimer à l'écran des objets json sous un format lisible
from pprint import pprint

schema = json.load(open("plat.avsc"))

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

# fonction pour réencoder en unicode les données
def coder(record):
	new_record = []
	# on boucle sur les dictionnaires de la liste
	for d in record:
		new_dict = {}
		# on boucle sur les keys du dictionnaire courant
		for k in d:
			# si la clé est un string, on l'encode, sinon on l'ajoute directement
			if type(k) == str:
				new_dict[unicode(k, "utf-8")] = d[k]
			else:
				new_dict[k] = d[k]
		# on reboucle sur les keys du nouveau dictionnaire
		for k in new_dict:	
			# si la valeur est un string, on l'eencode
			if type(new_dict[k]) == str:
				new_dict[k] = unicode(d[k], "utf-8")
			# si c'est une liste, on encode ses éléments qui ont des strings
			if type(new_dict[k]) == list:
				new_dict[k] = [unicode(e, "utf-8") if (type(e) == str) else e for e in new_dict[k]]		
		# on ajoute les nouveaux dictionnaires à la nouvelle liste, qu'on renvoie						 
		new_record.append(new_dict)
	return new_record
	

records = coder(records)

fastavro.writer(open("plats.avro", "wb"), schema, records)

# encode en utf-8 à la main
records_unicode = [
    {
        "nom": u"饺子",
        "origine": u"北京", 
        "ingredients": ["chou", "porc", "farine"],
        "prix": 4,
        "type": "plat"
    },
    {
        "nom": u"方便面",
        "ingredients": ["piment", "nouilles"],
        "prix": 1.5,
        "type": "plat",
    },
    {
        "nom": u"宫保鸡丁",
        "origine": u"四川", 
        "ingredients": ["poulet", "cacahuetes"],
        "prix": 8,
        "type": "plat"
    },
    {
        "nom": u"米饭",
        "ingredients": ["riz"],
        "prix": 1,
        "type": "accompagnement"
    },
    {
        "nom": u"冰水",
        "prix": 0.5,
        "type": "accompagnement"
    }
]


fastavro.writer(open("plats_unicode.avro", "wb"), schema, records_unicode)

# fonction de lecture des fichiers avro
def reader_avro(my_file):
	with open(my_file, 'rb') as avro_file:
		# Création d'un reader pour lire les données
		reader = fastavro.reader(avro_file)
		# Affichage du schéma des données
		print("========================\nLe schéma est :\n========================\n")
		pprint(reader.schema)
		# Itération sur tous les personnages
		print("========================\nLes données sont :\n========================\n")
		for plat in reader:
		    pprint(plat)

# on lit nos deux fichiers avro
reader_avro("plats.avro")
reader_avro("plats_unicode.avro")  
        
# lancer python avec le module fastavro installé   
# copier-coller ce script sur le shell python
# ou 
# execfile("script.py") in python shell
# ou
# sur le terminal linux
# chmod a+x script.py
# ./script..py in terminal
