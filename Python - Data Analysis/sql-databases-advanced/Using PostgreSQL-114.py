## 3. Psycopg2 ##

import psycopg2

string_connexion = "dbname=dq user=dq"
conn = psycopg2.connect(string_connexion)

Cursor = conn.cursor()

print(Cursor)

conn.close()




## 4. Creating a table ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)

cur = conn.cursor()

query = """CREATE TABLE notes(
                id INTEGER PRIMARY KEY,
                body TEXT,
                title TEXT);
        """

cur.execute(query)

conn.close()





## 5. SQL Transactions ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)

cur = conn.cursor()

query = """CREATE TABLE notes(
                id INTEGER PRIMARY KEY,
                body TEXT,
                title TEXT);
        """

cur.execute(query)

conn.commit()
conn.close()


## 6. Autocommitting ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)
conn.autocommit = True

cur = conn.cursor()

query = """CREATE TABLE facts(
                id INTEGER PRIMARY KEY,
                country TEXT,
                value INTEGER);
        """

cur.execute(query)

conn.close()


## 7. Executing queries ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)
conn.autocommit = True

cur = conn.cursor()

query = """INSERT INTO notes
            (id,body,title)
            VALUES
            (1,'Do more missions on Dataquest.','Dataquest reminder');
        """

#cur.execute(query)

query = """SELECT *
                FROM
                notes
                ;
        """

cur.execute(query)

rows = cur.fetchall()
print(rows)

conn.close()

## 8. Creating a database ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)
conn.autocommit = True

cur = conn.cursor()

query = """CREATE DATABASE income OWNER dq;"""

cur.execute(query)

conn.close()



## 9. Deleting a database ##

sting_connection = "dbname=dq user=dq"
conn = psycopg2.connect(sting_connection)
conn.autocommit = True

cur = conn.cursor()

query ="DROP DATABASE income;"

cur.execute(query)

conn.close()

