# encoding: utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import json
from kafka import KafkaConsumer

stations = {}
consumer = KafkaConsumer("empty-stations", bootstrap_servers='localhost:9092')
for message in consumer:
    station = json.loads(message.value.decode())
    station_number = station["number"]
    contract = station["contract_name"]
    available_bike_stands = station["available_bike_stands"]

    if contract not in stations:
        stations[contract] = {}
    city_stations = stations[contract]

    if station_number not in city_stations:
        city_stations[station_number] = available_bike_stands

    #count_diff = available_bike_stands - city_stations[station_number]
    #if count_diff != 0:
    #    city_stations[station_number] = available_bike_stands

    if available_bike_stands == 0:
      print("Station qui devient vide {} ({})".format(
              station["address"], contract
          ))
