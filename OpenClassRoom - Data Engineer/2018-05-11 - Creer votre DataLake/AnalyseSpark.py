import os
from pyspark import SparkContext
from pyspark.sql import SparkSession, Row

from io import BytesIO
import json
import fastavro

sc = SparkContext()
spark = SparkSession.builder.getOrCreate()

# Load files
rdd = sc.binaryFiles('hdfs://localhost:9000/data/paris/master/full/*.avro') # (filename, content)
# If it takes too long to process all files, you may want to reduce the number
# of processed files. E.g:
# rdd = sc.binaryFiles('hdfs://localhost:9000/data/paris/master/full/2.250182*.avro') # (filename, content)

# Parse avro files
nodes = rdd.flatMap(lambda args: fastavro.reader(BytesIO(args[1])))

# Convert to a resilient distributed dataset (RDD) of rows
rows = nodes.map(lambda node: Row(**node))

# Convert to a Spark dataframe
df = spark.createDataFrame(rows)

# Cache data to avoid re-computing everything
df.persist()

print("There are %d nodes in the dataset" % df.count())
print("There are %d restaurants in Paris" % df.filter(df.tags.getItem("amenity") == "restaurant").count())

print("Here are the most active users:")
df.groupBy("username").count().orderBy("count", ascending=False).limit(10).show()





