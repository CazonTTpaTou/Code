## 1. Prepared Insert ##

import datetime

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

with open('ign.csv','r') as f:
    next(f)
    ign = list(csv.reader(f))
    for row in ign:
        updated_rows = row[:9]       
        
        cur.execute('INSERT INTO ign_reviews VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)',updated_rows)
        
conn.commit()








## 2. Faster Inserts ##

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
with open('ign.csv', 'r') as f:
    next(f)
    reader = csv.reader(f)
    mogrified = [ 
        cur.mogrify("(%s, %s, %s, %s, %s, %s, %s, %s, %s)", row).decode('utf-8')
        for row in reader
    ] 

mogrified_values = ",".join(mogrified) 
cur.execute('INSERT INTO ign_reviews VALUES ' + mogrified_values)
conn.commit()

## 3. Advanced COPY Statement ##

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

with open('ign.csv','r') as f:
    next(f)
    cur.copy_expert("COPY ign_reviews FROM STDIN WITH CSV DELIMITER ','",f)
    
conn.commit()


    

## 4. Which method is faster? ##

import time

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

# Multiple single insert statements.
start = time.time()
with open('ign.csv', 'r') as f:
    next(f)
    reader = csv.reader(f)
    for row in reader:
        cur.execute(
            "INSERT INTO ign_reviews VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
            row
        )
conn.rollback()
print("Single statment insert: ", time.time() - start)
        
# Multiple mogrify insert.
start = time.time()
with open('ign.csv', 'r') as f:
    next(f)
    reader = csv.reader(f)
    mogrified = [ 
        cur.mogrify("(%s, %s, %s, %s, %s, %s, %s, %s, %s)", row).decode('utf-8')
        for row in reader
    ] 
    mogrified_values = ",".join(mogrified) 
    cur.execute('INSERT INTO ign_reviews VALUES ' + mogrified_values)
conn.rollback()
print("Multiple mogrify insert: ", time.time() - start)

        
# Copy expert method.
start = time.time()
with open('ign.csv', 'r') as f:
    cur.copy_expert('COPY ign_reviews FROM STDIN WITH CSV HEADER', f)
conn.rollback()
print("Copy expert method: ", time.time() - start)

## 5. Extracting Table to CSV File ##

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

with open('old_ign_reviews.csv', 'w') as f:
    cur.copy_expert('COPY old_ign_reviews TO STDOUT WITH CSV HEADER', f)

## 6. Transform an Old Table to a New Table ##

import csv
from datetime import date

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
with open('old_ign_reviews.csv', 'r+') as f:
    cur.copy_expert('COPY old_ign_reviews TO STDOUT WITH CSV HEADER', f)
    f.seek(0)
    reader = csv.reader(f)
    next(reader)
    for row in reader:
        updated_row = row[:8]
        updated_row.append(date(2012,9,12))
        cur.execute("INSERT INTO ign_reviews VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)", updated_row)
    conn.commit()
    
    

## 7. Insert Into with Select ##

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
cur.execute("""
INSERT INTO ign_reviews (
    id, score_phrase, title, url, platform, score,
    genre, editors_choice, release_date
)
SELECT id, score_phrase, title_of_game_review as title,
    url, platform, score, genre, editors_choice,
    to_date(release_day || '-' || release_month || '-' || release_year, 'DD-MM-YYYY') as release_date
FROM old_ign_reviews
""")
conn.commit()