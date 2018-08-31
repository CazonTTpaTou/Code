#! /usr/bin/env python3
import json
from kafka import KafkaConsumer

# On ouvre le fichier JSON dans lequel sont sérialisées les stations vides
with open('Liste_Empty_Stations.json') as f:
    empty_stations = json.load(f)

# Initilisation des dictionnaires de données
nouvelles_stations_vides = {}
villes = {}

# On importe les nouveaux éléments intégrés au topic "empty-stations"
consumer = KafkaConsumer("empty-stations", 
                        bootstrap_servers='localhost:9092',
                        group_id="velib-monitor-stations")

# On parcourt tous les éléments du topic "empty-stations"
for message in consumer:
    station = json.loads(message.value.decode())

    # On récupère les informations relatives à chacune des stations envoyées dans le topic "empty-stations"
    name = station["name"]
    available_bikes = station["available_bikes"]

    # Cas n° 1 - la station n'est plus vide alors qu'elle l'était auparavant:
    if available_bikes != 0:
        for station_vide in empty_stations:
            if station_vide["name"] == name:
                empty_stations.remove(une_station)

    # Cas n° 2 - la station est devenue vide alors qu'elle ne l'était pas auparavant
    if available_bikes == 0 :
        nouvelles_stations_vides.append(station)
        empty_stations.append(station)

# On enregistre la nouvelle liste des stations vides au format JSON
with open('Liste_Empty_Stations', 'w') as outfile:
    json.dump(empty_stations, outfile)

# Agrégation du nombre de stations vides par ville
for stations in empty_stations:
    city = stations["contract_name"] 
    if city not in villes:
        villes[city]={'nombre-station-vide':1}
    else:
        villes[city]['nombre-station-vide']+=1

# Envoi du message pour avertir qu'une nouvelle station est vide sachant qu'elle ne l'était pas auparavant
for station in nouvelles_stations_vides:
    print('La station {} située à l\'adresse {} à {} est vide !! {} station(s) sont actuellement vides cette ville....'.format(
            station["name"],
            station["address"],
            station["contract_name"],
            villes["contract_name"]['nombre-station-vide']
            )







