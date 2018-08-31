## 2. Introduction ##

import sqlite3
conn = sqlite3.connect("factbook.db")

query = "EXPLAIN QUERY PLAN "
query+= "SELECT * from facts where population > 1000000 "
query+= "AND population_growth < 0.05"

query_plan_one = conn.execute(query).fetchall()
print(query_plan_one)


## 3. Query plan for multi-column queries ##

conn = sqlite3.connect("factbook.db")

query_one = "CREATE INDEX IF NOT EXISTS pop_idx ON facts(population);"
query_two = "CREATE INDEX IF NOT EXISTS pop_growth_idx ON facts(population_growth);"

conn.execute(query_one)
conn.execute(query_two)

query = "EXPLAIN QUERY PLAN "
query+= "SELECT * from facts where population > 1000000 "
query+= "AND population_growth < 0.05"

query_plan_two = conn.execute(query).fetchall()

print(query_plan_two)


## 6. Creating a multi-column index ##

conn = sqlite3.connect("factbook.db")

query = "CREATE INDEX IF NOT EXISTS pop_pop_growth_idx ON facts(population,population_growth)"

conn.execute(query)

query = "EXPLAIN QUERY PLAN SELECT * FROM facts "
query+= "WHERE population > 1000000 "
query+= "AND population_growth < 0.05;"

query_plan_three = conn.execute(query).fetchall()

print(query_plan_three)



## 7. Covering index ##

conn = sqlite3.connect("factbook.db")
conn.execute("create index if not exists pop_pop_growth_idx on facts(population, population_growth);")

query = "EXPLAIN QUERY PLAN "
query+= "SELECT population,population_growth FROM facts "
query+= "WHERE population > 1000000 AND population_growth < 0.05;"

query_plan_four = conn.execute(query).fetchall()

print(query_plan_four)



## 8. Covering index for single column ##

conn = sqlite3.connect("factbook.db")
conn.execute("create index if not exists pop_pop_growth_idx on facts(population, population_growth);")

query = "EXPLAIN QUERY PLAN "
query+= "SELECT population FROM facts "
query+= "WHERE population > 1000000;"

query_plan_five = conn.execute(query).fetchall()

print(query_plan_five)

