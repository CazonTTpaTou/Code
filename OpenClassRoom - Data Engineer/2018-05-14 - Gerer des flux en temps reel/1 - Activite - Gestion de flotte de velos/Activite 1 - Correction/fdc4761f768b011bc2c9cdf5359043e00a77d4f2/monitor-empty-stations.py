#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    Course OC: Gérez des flux de données temps réel
    Activity : Gérez des flottes de vélos comme un·e pro
    
    Consumer script
    
    Created on Wed Jan 31 17:20:52 2018

@author: MD
"""

import json
import ast
import time
from kafka import KafkaConsumer

stations = {}
consumer = KafkaConsumer("empty-stations", bootstrap_servers=['localhost:9092', 'localhost:9093'],
                         group_id="velib-monitor-stations")

for message in consumer:
    station = json.loads(message.value.decode())

    # convert byte key to list (message key is station_number+contract)
    station_id = message.key
    station_id = ast.literal_eval(station_id.decode())
    station_id = [i.strip() for i in station_id]
    #print(station_id)

    station_number = station["number"]
    address = station['address']
    contract_name = station["contract_name"]
    available_bikes = station["available_bikes"]

    # update contracts (cities) list with current contract station
    if contract_name not in stations:
        stations[contract_name] = {}
        
    # get updated list of available stands per city
    city_stations = stations[contract_name]
    if station_number not in city_stations:
        city_stations[station_number] = available_bikes
    #print("city stations:", [sorted(city_stations.items(), key=lambda x: x[0])])
    
    if station_id[1] == "empty":
        # number of empty stations in city
        nb_empty_stations_in_city = sum(x == 0 for x in city_stations.values())
        print("{} station is empty: {} {}. # of empty stations in city: {}"
              .format(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()), 
                      address, contract_name, nb_empty_stations_in_city))
