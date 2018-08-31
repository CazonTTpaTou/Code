## 1. Introduction ##

import sqlite3
conn = sqlite3.connect("factbook.db")

query = "PRAGMA table_info(facts);"

cur = conn.cursor()
schema = list(cur.execute(query))

for shem in schema:
    print(shem)
    
    

## 3. Explain query plan ##

query="EXPLAIN QUERY PLAN SELECT * FROM facts where area > 40000;"

query_plan_one = conn.execute(query).fetchall()
print(query_plan_one)

query="EXPLAIN QUERY PLAN SELECT area FROM facts where area > 40000;"

query_plan_two = conn.execute(query).fetchall()
print(query_plan_two)

query="EXPLAIN QUERY PLAN SELECT * FROM facts where name = 'Czech Republic';"

query_plan_three = conn.execute(query).fetchall()
print(query_plan_three)



## 5. Time complexity ##

query = "EXPLAIN QUERY PLAN SELECT id FROM facts WHERE id=20;"

query_plan_four = conn.execute(query).fetchall()

print(query_plan_four)



## 9. All together now ##

query = "EXPLAIN QUERY PLAN SELECT * FROM facts where population > 10000;"

query_plan_six = conn.execute(query).fetchall()
print(query_plan_six)

query_index = "CREATE INDEX IF NOT EXISTS pop_idx ON facts(population);"
conn.execute(query_index)

query_plan_seven = conn.execute(query).fetchall()
print(query_plan_seven)

