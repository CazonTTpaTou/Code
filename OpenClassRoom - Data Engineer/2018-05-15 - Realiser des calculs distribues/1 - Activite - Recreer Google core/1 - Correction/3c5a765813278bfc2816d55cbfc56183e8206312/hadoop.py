import sys
from pyspark import SparkContext
import pyspark.sql
from pyspark.sql.session import SparkSession
from pyspark.sql import Row

sc=SparkContext()
spark=SparkSession(sc)
rdd = sc.textFile("test.txt");

words = lines.flatMap(lamda line:line.split(''))\
	.map(lambda word: word.strip(",.;:?\"'-"))\
	.filter(lambda word: len(word) > 0 and '@' not in word and "\" not in word))\
	.map(lambda word: Row(not = word, longueur = low(word)))

df = spark.createDataFrame(rdd)
df = df.groupeBy("not").count()
df.createTempView("df_table")
spark.sql("").show()