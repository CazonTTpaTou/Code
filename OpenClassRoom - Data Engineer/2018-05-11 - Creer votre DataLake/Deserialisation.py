import json
import os
import sys
import fastavro


#src = sys.argv[1]
src = "C:\\Users\\monne\\Desktop\\DataSerialized\\Avro_File"
directory = "C:\\Users\\monne\\Desktop\\DataSerialized\\"

schema = json.load(open(os.path.join(os.path.dirname(__file__), "node.avsc")))

with open(src, 'rb') as avro_file:
    reader = fastavro.reader(avro_file, reader_schema=schema)
    for node in reader:
        print(node)



        