#! /usr/bin/env python3
import json
from kafka import KafkaConsumer

stations = {}
consumer = KafkaConsumer("empty-stations",bootstrap_servers=['localhost:9092', 'localhost:9093'] ,
                         group_id="velib-monitor-stations")
for message in consumer:
    station = json.loads(message.value.decode())
    station_number = station["number"]
    contract = station["contract_name"]
    available_bikes = station["available_bikes"]
    address = station["address"]

    if contract not in stations:
        stations[contract] = {}
    city_stations = stations[contract]

    if available_bikes == 0:
        city_stations[station_number] = 1
    else:
        city_stations[station_number] = 0
        
    count_empties = 0
    for int_empty in city_stations.values():
        count_empties += int_empty
    
    if available_bikes == 0 :
        print("{}, ({}) number of empty stations {} ".format(
            station["address"], contract, count_empties
        ))

