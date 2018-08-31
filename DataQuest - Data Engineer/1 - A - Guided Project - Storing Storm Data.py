import io
from urllib import request
import csv

import psycopg2

# Connection BDD

conn = psycopg2.connect(dbname="postgres", user="postgres", password ="administrator")
cursor = conn.cursor()

# Création table Huricane

query = "DROP TABLE IF EXISTS Huricane"
cursor.execute(query)

query = """
    CREATE TABLE Huricane (
    fid INTEGER PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    ad_time TIME with time zone,
    btid INTEGER,
    name TEXT,
    lat DECIMAL(3,1),
    long DECIMAL(4,1),
    wind_kts INTEGER,
    pressure INTEGER,
    cat VARCHAR(2),
    basin TEXT,
    shape_leng DECIMAL(8,6))
"""
cursor.execute(query)
conn.commit()

# Creation User

query = "CREATE USER analysts WITH PASSWORD 'somepassword' NOSUPERUSER"
cursor.execute(query)

query = "GRANT SELECT,UPDATE,INSERT ON Huricane TO analysts"
cursor.execute(query)

# Lecture du fichier CSV
response = request.urlopen('https://dq-content.s3.amazonaws.com/251/storm_data.csv')
reader = csv.reader(io.TextIOWrapper(response))

# Copie du CSV vers la BDD
with io.TextIOWrapper(response) as f:
    cursor.copy_expert('COPY Huricane FROM STDIN WITH CSV HEADER', f)
conn.commit()


