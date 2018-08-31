## 1. Connection String ##

import psycopg2

conn = psycopg2.connect("dbname=dq user=postgres password=abc123")

print(conn)



## 2. Creating a User ##


import psycopg2

conn = psycopg2.connect("dbname=dq user=postgres password=abc123")

cur = conn.cursor()

query = "CREATE USER data_viewer WITH PASSWORD 'somepassword' NOSUPERUSER"
cur.execute(query)

conn.commit()



## 3. User Privileges ##

conn = psycopg2.connect(dbname="dq", user="dq")
cur = conn.cursor()

query = "REVOKE SELECT,INSERT,UPDATE on user_accounts FROM data_viewer"

cur.execute(query)

conn.commit()


## 4. Granting Privileges ##

conn = psycopg2.connect(dbname="dq", user="dq")
cur = conn.cursor()

query = "GRANT SELECT ON user_accounts TO data_viewer"

cur.execute(query)

conn.commit()



## 5. Postgres Groups ##

conn = psycopg2.connect(dbname="dq", user="dq")
cur = conn.cursor()

query = "CREATE GROUP readonly NOLOGIN"
cur.execute(query)

query = "REVOKE SELECT,INSERT,UPDATE on user_accounts FROM readonly"
cur.execute(query)

query = "GRANT SELECT ON user_accounts TO readonly"
cur.execute(query)

query="GRANT readonly TO data_viewer"
cur.execute(query)

conn.commit()




## 6. Creating a database ##

conn = psycopg2.connect(dbname="dq", user="dq")
# Connection must be set to autocommit.
conn.autocommit = True
cur = conn.cursor()

query = "CREATE DATABASE user_accounts OWNER data_viewer"
cur.execute(query)



## 7. Putting It All Together ##

conn = psycopg2.connect(dbname="dq", user="dq")
conn.autocommit = True
cur = conn.cursor()
cur.execute("CREATE DATABASE top_secret OWNER dq")
conn = psycopg2.connect(dbname="top_secret", user="dq")
cur = conn.cursor()
cur.execute("""
CREATE TABLE documents(id INT, info TEXT);
CREATE GROUP spies NOLOGIN;
REVOKE ALL ON documents FROM spies;
GRANT SELECT, INSERT, UPDATE ON documents TO spies;
CREATE USER double_o_7 WITH CREATEDB PASSWORD 'shakennotstirred' IN GROUP spies;
""")
conn.commit()
conn_007 = psycopg2.connect(dbname='top_secret', user='double_o_7', password='shakennotstirred')