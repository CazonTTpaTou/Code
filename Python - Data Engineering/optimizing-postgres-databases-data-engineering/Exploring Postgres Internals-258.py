## 1. Introduction ##


import psycopg2

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
print(conn)

## 2. Investigating the Tables ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
cur.execute("SELECT table_name FROM information_schema.tables ORDER BY table_name")
table_names = cur.fetchall()
for name in table_names:
    print(name)

## 3. Working with Schemas ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='public' ORDER BY table_name")
for table_name in cur.fetchall():
    name = table_name[0]
    print(name)
    
    

## 4. Describing the Tables ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()

cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='public'")
#for table in cur.fetchall(): 
    # Enter your code here...
from psycopg2.extensions import AsIs

cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='public'")
for table in cur.fetchall():
    table = table[0]
    cur.execute("SELECT * FROM %s LIMIT 0", [AsIs(table)])
    print(cur.description, "\n")

## 5. Type Code Mappings ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
cur.execute("SELECT oid, typname FROM pg_catalog.pg_type")
type_mappings = {
    int(oid): typname
    for oid, typname in cur.fetchall()
}

## 6. Readable Description Types ##

from psycopg2.extensions import AsIs
conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
# You have `table_names` and `type_mappings` provided for you.
readable_description = {}
for table in table_names:
    cur.execute("SELECT * FROM %s LIMIT 0", [AsIs(table)])
    readable_description[table] = dict(
        columns=[
            dict(
                name=col.name,
                type=type_mappings[col.type_code],
                length=col.internal_size
            )
            for col in cur.description
        ]
    )
print(readable_description)

## 7. Number of Rows ##

from psycopg2.extensions import AsIs
conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
for table in readable_description.keys():
    cur.execute("SELECT COUNT(*) FROM %s", [AsIs(table)])
    readable_description[table]["total"] = cur.fetchone()

## 8. Sample Rows ##

from psycopg2.extensions import AsIs
conn = psycopg2.connect(dbname="dq", user="hud_admin", password="eRqg123EEkl")
cur = conn.cursor()
for table in readable_description.keys():
    cur.execute("SELECT * FROM %s LIMIT 100", [AsIs(table)])
    readable_description[table]["sample_rows"] = cur.fetchall()