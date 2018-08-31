import json

empty = ["9087-GARE","9087-MAZARGUES"]

with open('C:\\Users\\monne\\Desktop\\data.json', 'w') as outfile:
    json.dump(empty, outfile)

with open('C:\\Users\\monne\\Desktop\\Liste_Stations.json') as data_file:
    data_loaded = json.load(data_file)

for data in data_loaded:
    if data["name"]=="CROCO":
        print('Data found...')
        data_loaded.remove(data)

with open('C:\\Users\\monne\\Desktop\\Liste_Stations.json', 'w') as outfile:
    json.dump(data_loaded, outfile)




"""
with io.open('data.json', 'w', encoding='utf8') as outfile:
    str_ = json.dumps(empty,
                      indent=4, 
                      sort_keys=True,
                      separators=(',', ':'), 
                      ensure_ascii=False)
    outfile.write(to_unicode(str_))

"""

