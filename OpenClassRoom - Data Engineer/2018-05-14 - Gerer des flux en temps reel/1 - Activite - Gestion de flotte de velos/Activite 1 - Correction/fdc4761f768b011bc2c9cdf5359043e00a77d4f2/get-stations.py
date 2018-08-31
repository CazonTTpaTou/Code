#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
    Course OC: Gérez des flux de données temps réel
    Activity : Gérez des flottes de vélos comme un·e pro
    
    Producer script
    
    Created on Wed Jan 31 16:46:54 2018

@author: MD
"""

import json
import time
import urllib.request
from urllib.error import URLError

from kafka import KafkaProducer

API_KEY = "229b15b9790f5912d257c3152eb9cd7dca0a474c" # Set your own API key here
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

producer = KafkaProducer(bootstrap_servers=['localhost:9092', 'localhost:9093'])

# init last stations record
last_stations = []

while True:
    begin_time = time.time()

    # init counters
    nb_stations_become_empty = 0
    nb_stations_no_more_empty = 0

    try:
        # get current stations
        response = urllib.request.urlopen(url)
        stations = json.loads(response.read().decode())
        #print("-- HTTP time", time.time()-begin_time)
    except URLError as e:
        print(str(e))
        continue

    if last_stations == []:
        last_stations = stations
    else:
        for station in stations:
            # key indice is supposed to be (station_number+contract_name) 
            #       => I found one contract in double in the message, so I add the station_number to build the key
            station_id = str(station['number'])+station['contract_name']
            station_is_empty = station['available_bikes'] == 0

            # get the old record for this station
            #print("-- BEFORE old_station_record time", time.time()-begin_time)
            old_station_record = [station for station in last_stations
                                  if station_id == str(station['number'])+station['contract_name']]
            #print("-- AFTER old_station_record time", time.time()-begin_time)
            if len(old_station_record) == 1: # if old record for station exists, there's only one
                station_was_empty = old_station_record[0]['available_bikes'] == 0
            else:
                station_was_empty = True
            
            # the key parameter guarantees us that all the messages concerning the same station_id will be processed 
            # by the same consumer
            if station_is_empty and not station_was_empty:
                # station is empty
                producer.send("empty-stations", json.dumps(station).encode(), key=str([station_id, 'empty']).encode())
                nb_stations_become_empty += 1
            elif station_was_empty and not station_is_empty:
                # station is no more empty
                producer.send("empty-stations", json.dumps(station).encode(), key=str([station_id, 'not empty']).encode())
                nb_stations_no_more_empty += 1

        last_stations = stations

        if nb_stations_become_empty + nb_stations_no_more_empty > 0:
            print("{} Produced {} station records: {} become empty, {} are no more empty"
                  .format(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
                      nb_stations_become_empty + nb_stations_no_more_empty,
                      nb_stations_become_empty, nb_stations_no_more_empty))

    print("Loop time", time.time()-begin_time)

    time.sleep(1)
# end-while