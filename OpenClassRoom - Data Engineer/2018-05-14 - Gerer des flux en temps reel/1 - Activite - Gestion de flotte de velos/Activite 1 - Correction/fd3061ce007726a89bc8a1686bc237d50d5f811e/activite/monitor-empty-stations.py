#! /usr/bin/env python
# encoding: utf-8

import json
from six.moves import urllib
from kafka import KafkaConsumer

# merci d ajouter votre cle avant de commencer
API_KEY = "" # FIXME
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)
# le dictionnaire contient comme cle la ville et comme valeur la liste des stations vides
dict_vides = {}
response = urllib.request.urlopen(url)
stations = json.loads(response.read().decode('utf-8'))
# creation du dictinnaire avec des listes vides
for station in stations:
	dict_vides[station["contract_name"]] = []

consumer = KafkaConsumer("empty-stations", bootstrap_servers='localhost:9092',
                         group_id="velib-monitor-stations")

for message in consumer:
	station = json.loads(message.value.decode('UTF-8'))
	station_number = station["number"]
    	contract = station["contract_name"]
    	available_bikes = station["available_bikes"]
	adresse = station["address"]

	if available_bikes > 0 and (station_number in dict_vides[contract]):
		dict_vides[contract].remove(station_number)
	else:
		dict_vides[contract].append(station_number)
		print("+ La station {} à {} est vide, il y a aussi {} stations vides dans cette ville".format(adresse.encode('utf-8'), contract.encode('utf-8'), len(dict_vides[contract])))
        	
