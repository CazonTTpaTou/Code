import json
from kafka import KafkaConsumer

stations = {}
topic_name = "empty-stations"
consumer = KafkaConsumer(topic_name, bootstrap_servers=['localhost:9092', 'localhost:9093', 'localhost:9094'], group_id="velib-monitor-stations")

for message in consumer:
  station = json.loads(message.value.decode())
    
  contract = station["contract_name"]
  station_number = station["number"]
  available_bikes = station["available_bikes"]
  address = station["address"]
    
  if available_bikes == 0:
    if contract not in stations:
      stations[contract] = 1
    else:
      stations[contract] = stations[contract] + 1
  else:
    stations[contract] = stations[contract] - 1
    
  print("{} - {} , total empty stations = {}".format(contract, address, stations[contract]))
    
    