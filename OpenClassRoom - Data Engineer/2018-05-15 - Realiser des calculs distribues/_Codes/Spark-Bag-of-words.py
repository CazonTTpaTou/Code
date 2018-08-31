from pyspark import SparkContext
from pyspark.sql import SparkSession

sc = SparkContext()
spark = SparkSession.builder.getOrCreate()

from pyspark.ml.classification import NaiveBayes
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml.feature import CountVectorizer, StringIndexer
from pyspark.sql import Row

def load_dataframe(path):
    rdd = sc.textFile(path)\
        .map(lambda line: line.split())\
        .map(lambda words: Row(label=words[0], words=words[1:]))
    return spark.createDataFrame(rdd)

# Load train and test data
train_data = load_dataframe("20ng-train-all-terms.txt")
test_data = load_dataframe("20ng-test-all-terms.txt")

# Learn the vocabulary of our training data
vectorizer = CountVectorizer(inputCol="words", outputCol="bag_of_words")
vectorizer_transformer = vectorizer.fit(train_data)

# Create bags of words for train and test data
train_bag_of_words = vectorizer_transformer.transform(train_data)
test_bag_of_words = vectorizer_transformer.transform(test_data)

# Convert string labels to floats
label_indexer = StringIndexer(inputCol="label", outputCol="label_index")
label_indexer_transformer = label_indexer.fit(train_bag_of_words)
train_bag_of_words = label_indexer_transformer.transform(train_bag_of_words)
test_bag_of_words = label_indexer_transformer.transform(test_bag_of_words)

# Learn multiclass classifier on training data
classifier = NaiveBayes(
    labelCol="label_index", featuresCol="bag_of_words", predictionCol="label_index_predicted"
)
classifier_transformer = classifier.fit(train_bag_of_words)

# Predict labels on test data
test_predicted = classifier_transformer.transform(test_bag_of_words)

# Classifier evaluation
evaluator = MulticlassClassificationEvaluator(
    labelCol="label_index", predictionCol="label_index_predicted", metricName="accuracy"
)
accuracy = evaluator.evaluate(test_predicted)
print("Accuracy = {:.2f}".format(accuracy))





