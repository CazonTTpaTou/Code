#! /usr/bin/env python

import json
import time
from six.moves import urllib

# Run `pip install kafka-python` to install this package
from kafka import KafkaProducer

# merci d ajouter votre cle avant de lancer 
API_KEY = "" # FIXME
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

producer = KafkaProducer(bootstrap_servers="localhost:9092")
# le dictionnaire contient comme cle la ville et comme valeur la liste des stations vides
dict_vide = {}
response = urllib.request.urlopen(url)
stations = json.loads(response.read().decode('utf-8'))
# creation du dictinnaire avec des listes vides
for station in stations:
	dict_vide[station["contract_name"]] = []	

while True:
	response = urllib.request.urlopen(url)
	stations = json.loads(response.read().decode('utf-8'))
	for station in stations:
		if station["number"] in dict_vide[station["contract_name"]]:
			# message quand une station n est plus vide
			if station["available_bikes"] > 0:
				dict_vide[station["contract_name"]].remove(station["number"])
				producer.send("empty-stations", json.dumps(station).encode('utf-8'),
					key=str(station["number"]).encode('utf-8'))
				print("Produced {} station records".format(len(stations)))

		else:
			# message quand une station devient vide
			if station["available_bikes"] == 0:
				dict_vide[station["contract_name"]].append(station["number"])
				producer.send("empty-stations", json.dumps(station).encode('utf-8'),
					key=str(station["number"]).encode('utf-8'))
				print("Produced {} station records".format(len(stations)))
	time.sleep(1)
