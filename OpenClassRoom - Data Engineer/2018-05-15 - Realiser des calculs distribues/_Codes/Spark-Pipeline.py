from pyspark.ml import Pipeline

vectorizer = CountVectorizer(inputCol="words", outputCol="bag_of_words")
label_indexer = StringIndexer(inputCol="label", outputCol="label_index")

classifier = NaiveBayes(
    labelCol="label_index", featuresCol="bag_of_words", predictionCol="label_index_predicted",
)

pipeline = Pipeline(stages=[vectorizer, label_indexer, classifier])
pipeline_model = pipeline.fit(train_data)

test_predicted = pipeline_model.transform(test_data)

################################################################################################
################## RDD of labeledPoints

from pyspark.mllib.classification import LabeledPoint

dataframe.rdd.map(lambda row: LabeledPoint(row.label_index, row.bag_of_words.toArray()))

