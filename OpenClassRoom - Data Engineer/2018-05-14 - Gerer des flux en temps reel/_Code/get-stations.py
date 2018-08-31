#! /usr/bin/env python3

# encoding: utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import json
import time
import urllib

from kafka import KafkaProducer

API_KEY = "1c73419278610dc60b99ecd3ffd2c9e8d85e6b1c"
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

producer = KafkaProducer(bootstrap_servers="localhost:9092")
mystations = {}

while True:
    response = urllib.urlopen(url)
    stations = json.loads(response.read().decode())

    for station in stations:

      station_number = station["number"]
      contract = station["contract_name"]
      available_bike_stands = station["available_bike_stands"]

      if contract not in mystations:
          mystations[contract] = {}
      city_stations = mystations[contract]

      if station_number not in city_stations:
          city_stations[station_number] = available_bike_stands

      if available_bike_stands == 0 and city_stations[station_number] > 0:
          city_stations[station_number] = available_bike_stands
          print("Station qui devient vide {} {} ({})".format(
              station["address"], station["number"], contract
          ))
          producer.send("empty-stations", json.dumps(station).encode(),
                      key=str(station["number"]).encode())

      if available_bike_stands > 0 and city_stations[station_number] == 0:
          city_stations[station_number] = available_bike_stands
          print("Station qui n'est plus vide {} {} ({})".format(
              station["address"], station["number"], contract
          ))
          producer.send("empty-stations", json.dumps(station).encode(),
                      key=str(station["number"]).encode())

    time.sleep(5)
