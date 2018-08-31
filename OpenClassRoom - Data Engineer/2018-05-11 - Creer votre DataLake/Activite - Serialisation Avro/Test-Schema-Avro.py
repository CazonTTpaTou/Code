import json
import fastavro
import os

# Configuration du répertoire courant
directory = "C:\\Users\\monne\\Desktop"
os.chdir(directory)

# Chargement du schéma AVRO
schema = json.load(open("plat.avsc"))

# Liste des menus
records = [
    {
        "nom": "饺子",
        "origine": "北京", 
        "ingredients": ["chou", "porc", "farine"],
        "prix": 4,
        "type": "plat"
    },
    {
        "nom": "方便面",
        "ingredients": ["piment", "nouilles"],
        "prix": 1.5,
        "type": "plat",
    },
    {
        "nom": "宫保鸡丁",
        "origine": "四川", 
        "ingredients": ["poulet", "cacahuetes"],
        "prix": 8,
        "type": "plat"
    },
    {
        "nom": "米饭",
        "ingredients": ["riz"],
        "prix": 1,
        "type": "accompagnement"
    },
    {
        "nom": "冰水",
        "prix": 0.5,
        "type": "accompagnement"
    }
]


# Serialisation des menus
fastavro.writer(open("plats.avro", "wb"), schema, records)

with open("plats.avro", "wb") as avroFile:
    fastavro.writer(avroFile,schema,records)

# Désérialisation des menus
with open("plats.avro","rb") as avro_File:
    reader = fastavro.reader(avro_File,reader_schema=schema)
    
    with open("Liste_Menu.txt","w") as text_file:
        for menu in reader:
            print(menu)        
            
            try:
                print('Prix du menu : {} € '.format(menu['prix']), file=text_file)     
            except:
                pass
            




