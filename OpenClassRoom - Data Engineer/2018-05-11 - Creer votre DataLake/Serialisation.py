#! /usr/bin/env python3
# serialize.py
import json
import xml.etree.ElementTree as ET
import sys

import fastavro

# Read command line arguments
src = "C:\\Users\\monne\\Desktop\\creez-votre-data-lake-master\\2.250182,48.83921499999995,2.251182,48.84021499999995.osm"
dst = "C:\\Users\\monne\\Desktop\\DataSerialized\\Avro_File"

# Read schema
schema = json.load(open("C:\\Users\\monne\\Desktop\\DataSerialized\\node.avsc"))

tree = ET.parse(open(src))
nodes = []
for node in tree.iterfind("node"):
    id = int(node.get("id"))
    longitude = float(node.get("lon"))
    latitude = float(node.get("lat"))
    username = node.get("user")
    nodes.append({
        "id": id,
        "longitude": longitude,
        "latitude": latitude,
        "username": username
    })
    print(id, longitude, latitude, username)

with open(dst, "wb") as avro_file:
    fastavro.writer(avro_file, schema, nodes)



