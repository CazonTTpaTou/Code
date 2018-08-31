#! /usr/bin/env python3
import json
import time
import urllib.request

# Run `pip install kafka-python` to install this package
from kafka import KafkaProducer

API_KEY = "57735d54c68dc1ae567fe3c0fe4aeb7c9997d146" # FIXME
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

producer = KafkaProducer(bootstrap_servers=['localhost:9092', 'localhost:9093'])
stationsPrec = {} 
while True:
    response = urllib.request.urlopen(url)
    stations = json.loads(response.read().decode())
    if (len(stationsPrec) > 0):
	    for station in stations:
	        for stationPrec in stationsPrec:
	            if (station["number"] == stationPrec["number"] and station["contract_name"] == stationPrec["contract_name"] ):
	                if ((station["available_bikes"] == 0 and stationPrec["available_bikes"] > 0)
	                    or (stationPrec["available_bikes"] == 0 and station["available_bikes"] > 0)): 
	                    producer.send("empty-stations", json.dumps(station).encode(),
	                              key=str(station["number"]).encode())
	                    print("{},  station {}, ville {}, passage de {}  places dispos à {} ".format( station["number"], station["name"], station["contract_name"], stationPrec["available_bikes"], station["available_bikes"]))
    stationsPrec= stations
    time.sleep(1)

