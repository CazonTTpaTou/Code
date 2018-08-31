import fastavro

# Définition des personnages
characters = [
    {
        "id": 1,
        "name": "Martin Riggs"
    },
    {
        "id": 2,
        "name": "John Wick"
    },
    {
        "id": 3,
        "name": "Ripley"
    }
]

# Définition du schéma des données
schema = {
    "type": "record",
    "namespace": "com.badassmoviecharacters",
    "name": "Character",
    "doc": "Seriously badass characters",
    "fields": [
        {"name": "name", "type": "string"},
        {"name": "id", "type": "int"}
    ]
}

# Ouverture d'un fichier binaire en mode écriture
with open("C:\\Users\\monne\\Desktop\\characters.avro", 'wb') as avro_file:
    # Ecriture des données
    fastavro.writer(avro_file, schema, characters,codec="deflate")

# Ouverture du fichier binaire en mode lecture
with open("C:\\Users\\monne\\Desktop\\characters.avro", 'rb') as avro_file:
    # Création d'un reader pour lire les données
    reader = fastavro.reader(avro_file)

    # Affichage du schéma des données
    print(reader.schema)

    # Itération sur tous les personnages
    for character in reader:
        print(character)



