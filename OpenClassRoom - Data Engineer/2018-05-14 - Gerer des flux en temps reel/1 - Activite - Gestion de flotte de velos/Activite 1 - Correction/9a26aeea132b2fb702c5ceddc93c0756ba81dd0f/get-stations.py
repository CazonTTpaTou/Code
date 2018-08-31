import json
import time
import urllib.request

from datetime import datetime
from kafka import KafkaProducer

API_KEY = "1048ec0006fed768fcad88814aeb6f5dd5824262"
url = "https://api.jcdecaux.com/vls/v1/stations?apiKey={}".format(API_KEY)

stations_map = {}
producer = KafkaProducer(bootstrap_servers=['localhost:9092', 'localhost:9093', 'localhost:9094'])
topic_name = "empty-stations"

while True:
  response = urllib.request.urlopen(url)
  stations = json.loads(response.read().decode())

  for station in stations:
    contract = station["contract_name"]
    station_number = station["number"]
    available_bikes = station["available_bikes"]
    #partion_key = contract + "_" + str(station_number)
    
    #print("{} - station with contract_name = {} and id = {} and available_bikes={}".format(str(datetime.now()), contract, station_number, available_bikes))
    
    if(available_bikes == 0):
      if contract not in stations_map:
        stations_map[contract] = {}
        city_stations = stations_map[contract]
        if station_number not in city_stations:
          city_stations[station_number] = available_bikes
          producer.send(topic_name, json.dumps(station).encode(), key=str(contract).encode())
          print("{} - station with contract_name = {} and id = {} and available_bikes = {}".format(str(datetime.now()), contract, station_number, available_bikes))
    else:
      if contract in stations_map:
        city_stations = stations_map[contract]
        if station_number in city_stations:
          del city_stations[station_number]
          producer.send(topic_name, json.dumps(station).encode(), key=str(contract).encode())
          print("{} - station with contract_name = {} and id = {} and available_bikes = {}".format(str(datetime.now()), contract, station_number, available_bikes))

  time.sleep(1)

