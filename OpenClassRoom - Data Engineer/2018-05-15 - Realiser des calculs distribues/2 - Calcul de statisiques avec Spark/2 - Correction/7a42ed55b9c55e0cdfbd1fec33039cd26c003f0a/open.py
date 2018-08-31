# coding=utf-8
import sys
from pyspark import SparkContext
from pyspark.sql.types import *
from pyspark.sql import SparkSession

spark = SparkSession \
	.builder \
	.appName("Python Spark SQL basic example") \
	.config("spark.some.config.option", "some-value") \
	.getOrCreate()

sc = spark.sparkContext

def load_text(text_path): 
	lines = sc.textFile(text_path)
	word_counts_rdd =lines.flatMap(lambda lines: lines.lower().split())\
	.flatMap(lambda word: word.split("."))\
	.flatMap(lambda word: word.split(";"))\
	.flatMap(lambda word: word.split(","))\
	.flatMap(lambda word: word.split(":"))\
	.flatMap(lambda word: word.split("!"))\
	.flatMap(lambda word: word.split("?"))\
	.flatMap(lambda word: word.split("'"))\
	.flatMap(lambda word: word.split("-"))\
	.flatMap(lambda word: word.split("\""))\
	.filter(lambda word: word is not None and len(word) > 0)\
        .filter(lambda word: "@" not in word)\
        .filter(lambda word: "/" not in word)\
	.map(lambda word: (word, 1))\
	.reduceByKey(lambda count1, count2: count1 + count2)
	
	fields=[StructField("mot",StringType(),True), StructField("occurence",IntegerType(),True)]
	schema = StructType(fields)
	DF=spark.createDataFrame(word_counts_rdd,schema)
	
	return DF
def main():
	DF=load_text(sys.argv[1])
	DF.createOrReplaceTempView("data")
	MaxMot=spark.sql("SELECT mot FROM data ORDER by LENGTH(mot) DESC LIMIT 10")
	MaxOccurencelength4=spark.sql("SELECT mot  FROM data WHERE LENGTH(mot)==4 ORDER BY occurence DESC LIMIT 1")
	MaxOccurencelength15=spark.sql("SELECT mot  FROM data WHERE LENGTH(mot)==15 ORDER BY occurence DESC LIMIT 1")
	print "le plus grand mot", MaxMot.show()
	print "le mot à 4 lettres qui a le plus d'occurences", MaxOccurencelength4.show()
	print "le mot à 15 lettres qui a le plus d'occurences", MaxOccurencelength15.show()
        # le mot à 15 lettres qui a le plus d'occurences est accomplishments
if __name__ == "__main__":
   main()
