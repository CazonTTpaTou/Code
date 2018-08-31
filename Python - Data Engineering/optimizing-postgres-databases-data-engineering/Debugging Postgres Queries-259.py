## 1. The EXPLAIN Query ##

import pprint as pp
conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN SELECT * FROM homeless_by_coc")
pp.pprint(cur.fetchall())

## 2. The Path of a Query ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN SELECT COUNT(*) FROM homeless_by_coc WHERE year > '2012-01-01'")
pp.pprint(cur.fetchall())

## 3. Additional Output Formats ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN (format json) SELECT COUNT(*) FROM homeless_by_coc WHERE year > '2012-01-01'")
pp.pprint(cur.fetchall())

## 4. Describing EXPLAIN Output ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()


## 5. Adding the ANALYZE Option ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN (ANALYZE, FORMAT json) SELECT COUNT(*) FROM homeless_by_coc WHERE year > '2012-01-01'")
pp.pprint(cur.fetchall())

## 6. Test and Rollback ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN (ANALYZE, FORMAT json) DELETE FROM state_household_incomes")
conn.rollback()
pp.pprint(cur.fetchall())

## 7. ANALYZE a Join Statement ##

conn = psycopg2.connect(dbname="dq", user="hud_admin", password="abc123")
cur = conn.cursor()
cur.execute("EXPLAIN (ANALYZE, FORMAT json) SELECT hbc.state, hbc.coc_number, hbc.coc_name, si.name FROM homeless_by_coc as hbc, state_info as si WHERE hbc.state = si.postal")
pp.pprint(cur.fetchall())