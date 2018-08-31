## 1. Alter Table Statement ##

# The `cur` object is provided for you.
conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()
cur.execute('ALTER TABLE old_ign_reviews RENAME TO ign_reviews')
conn.commit()
cur.execute('SELECT * FROM ign_reviews LIMIT 0')
print(cur.description)

## 2. Removing a Column ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query = 'ALTER TABLE ign_reviews DROP COLUMN full_url'

cur.execute(query)

conn.commit()









## 3. Changing a Column Datatype ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query = 'ALTER TABLE ign_reviews ALTER COLUMN id TYPE BIGINT'
cur.execute(query)

conn.commit()




## 4. Renaming Columns ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query='ALTER TABLE ign_reviews RENAME COLUMN title_of_game_review TO title'
cur.execute(query)

conn.commit()




## 5. Adding a Column ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query='ALTER TABLE ign_reviews ADD COLUMN release_date DATE'
cur.execute(query)

conn.commit()




## 6. Update the Release Dates ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query="UPDATE ign_reviews SET release_date = to_date(release_day || '-' || release_month || '-' || release_year,'DD-MM-YYYY')"

cur.execute(query)

conn.commit()



## 7. Remove Redundant Rows ##

conn = psycopg2.connect("dbname=dq user=dq")
cur = conn.cursor()

query = "ALTER TABLE ign_reviews DROP COLUMN release_day"
cur.execute(query)
query = "ALTER TABLE ign_reviews DROP COLUMN release_month"
cur.execute(query)
query = "ALTER TABLE ign_reviews DROP COLUMN release_year"
#cur.execute(query)

conn.commit()


