#! /usr/bin/env python3
import json
import time
import urllib.request

# Run `pip install kafka-python` to install this package
from kafka import KafkaProducer

# Configuration de l'appel à l'API JC Decaux
API_KEY = "XXX" # FIXME
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

# On ouvre le fichier JSON dans lequel sont sérialisées les stations vides
with open('Liste_Empty_Stations.json') as f:
    data = json.load(f)

empty_stations = []

# On créé la liste des stations qui étaient enregistrées comme vide au moment de l'appel à l'API JC Decaux
for element in data:
    # On considère le champ Name car il est unique - concaténation du numéro de station et du premier mot de l'adresse
    empty_stations.append(element["name"])

# On crée un flux producteur Kafka sur le cluster ZooKeeper configuré à cette fin
producer = KafkaProducer(bootstrap_servers="localhost:9092")

while True:
    # On fait un appel à l'API JC Decaux qui nous renvoie un fichier JSON de données
    response = urllib.request.urlopen(url)
    stations = json.loads(response.read().decode())

    # On parcourt chaque ligne du fichier correspondant à une station distincte
    for station in stations:

        producer.send("velib-stations", 
                    json.dumps(station).encode(),
                    key=str(station["number"]).encode())

        # Si le champ "available bike" du fichier JSON transmis par l'API JC Decaux est à 0, 
        # Et que la station n'est pas encore enregistrée comme station vide
        # Alors, on ajoute la station au topic "empty-station"
        if station["available_bikes"]==0 & station["name"] not in empty_stations:
            producer.send("empty-stations",
                        json.dumps(station).encode(),
                        # Pour éviter les doublons d'identifiants entre villes, on utilise le champ name qui est une concaténation du nom de laville et de l'identifiant
                        key=str(station["name"]).encode())
        
        # Si le champ "available bike" du fichier JSON transmis par l'API JC Decaux est différent de 0, 
        # Et que la station était enregistrée comme station vide
        # Alors, on ajoute la station au topic "empty-station"
        if station["available_bikes"]!=0 & station["name"] in empty_stations:
            producer.send("empty-stations",
                        json.dumps(station).encode(),
                        # Pour éviter les doublons d'identifiants entre villes, on utilise le champ name qui est une concaténation du nom de laville et de l'identifiant
                        key=str(station["name"]).encode())

    # On affiche le nombre de lignes qui ont été traités et envoyés aux différents topics Kafka
    print("Produced {} station records".format(len(stations)))
    time.sleep(1)





