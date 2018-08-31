import sys

from pyspark import SparkContext
import pyspark.sql
from pyspark.sql import SparkSession

sc = SparkContext()
spark = SparkSession.builder.getOrCreate()

lines = sc.textFile(sys.argv[1])
words = lines.flatMap(lambda line: line.split())\
    .map(lambda word: word.strip(",.;:?!\"'-"))\
    .filter(lambda word: len(word) > 0 and "@" not in word and "/" not in word)
df = spark.createDataFrame(words.map(lambda word: pyspark.sql.Row(length=len(word), word=word.lower())))
df.persist()

longest_word = df.orderBy("length", ascending=False).limit(1).collect()[0].word
most_frequent_4_letter_word = df.filter(df.length == 4).groupBy("word").count().orderBy("count", ascending=False).limit(1).collect()[0].word
most_frequent_15_letter_word = df.filter(df.length == 15).groupBy("word").count().orderBy("count", ascending=False).limit(1).collect()[0].word

print "Longest word:", longest_word
print "Most frequent 4-letter word:", most_frequent_4_letter_word
print "Most frequent 15-letter word:", most_frequent_15_letter_word
