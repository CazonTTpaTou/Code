## 1. Describing a Table ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query = 'SELECT * FROM ign_reviews LIMIT 0'
cur.execute(query)

print(cur.description)






## 2. Adding the id Field ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query = 'CREATE TABLE ign_reviews '
query+= '(id BIGINT PRIMARY KEY)'

cur.execute(query)

conn.commit()




## 3. Finding the Max Length ##

import csv

with open('ign.csv','r') as f:
    unique_word=set([words[1] for words in list(csv.reader(f))[1:]])

max_score = len(max(unique_word,key=lambda x:len(x)))



## 4. Max String-like Datatypes ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
cur.execute('DROP TABLE IF EXISTS ign_reviews')
conn.commit()

# Add your field and type here.
# Uncomment the following.
cur.execute("""
    CREATE TABLE ign_reviews (
        id BIGINT PRIMARY KEY,
        score_phrase VARCHAR(11)
    )
""")

conn.commit()


## 5. Creating the Other String Fields ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

def scan_variable(number):
    with open('ign.csv','r') as f:
        unique_word=set([words[number] for words in list(csv.reader(f))[1:]])

    max_score = len(max(unique_word,key=lambda x:len(x)))
    
    return max_score,unique_word

libelle =['score_phrase','title','url','platform','genre']

for var,label in zip([1,2,3,4,6],libelle):
    length,words = scan_variable(var)
    
    print('---'*20)
    print('{} - max length : {} '.format(label,length))
    print(list(words)[:10])
    print('---'*20)

# Add your fields and types here.
cur.execute("""
    CREATE TABLE ign_reviews (
        id BIGINT PRIMARY KEY,
        score_phrase VARCHAR(11),
         title TEXT,
         url TEXT,
         platform VARCHAR(20),
         genre VARCHAR(25)
    )
""")

conn.commit()



## 6. Float-like Types ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
# Add your field and type here.
#cur.execute("""
#    CREATE TABLE ign_reviews (
#        id BIGINT PRIMARY KEY,
#        score_phrase VARCHAR(11),
#        title TEXT,
#        url TEXT,
#        platform VARCHAR(20),
#        genre TEXT
#    )
#""")
cur.execute("""
    CREATE TABLE ign_reviews (
        id BIGINT PRIMARY KEY,
        score_phrase VARCHAR(11),
        title TEXT,
        url TEXT,
        platform VARCHAR(20),
        genre TEXT,
        score DECIMAL(3, 1)
    )
""")
conn.commit()

## 7. Boolean Types ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
# Add your fields and types here.
cur.execute("""
    CREATE TABLE ign_reviews (
        id BIGINT PRIMARY KEY,
        score_phrase VARCHAR(11),
        title TEXT,
        url TEXT,
        platform VARCHAR(20),
        score DECIMAL(3, 1),
        genre TEXT,
        editors_choice BOOLEAN
    )
""")
conn.commit()



## 8. Date Type ##

from datetime import date

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

cur.execute('DROP TABLE IF EXISTS ign_reviews')
# Add your field here.
cur.execute("""
    CREATE TABLE ign_reviews (
        id BIGINT PRIMARY KEY,
        score_phrase VARCHAR(11),
        title TEXT,
        url TEXT,
        platform VARCHAR(20),
        score DECIMAL(3, 1),
        genre TEXT,
        editors_choice BOOLEAN,
        release_date DATE
   )
""")

with open('ign.csv','r') as f:
    next(f)
    rows = [row for row in list(csv.reader(f))]
   
for row in rows :
    updated_rows = row[:8]
    updated_rows.append(date(int(row[8]),
                             int(row[9]),
                             int(row[10])))  
    
    cur.execute("INSERT INTO ign_reviews VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)", updated_rows)

conn.commit()

                              
                              

        