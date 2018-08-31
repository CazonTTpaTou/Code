hadoop jar ./tfidf.jar ocr.hadoop.lab.tfidf.WordCountDriver /input /output/step_1 /resources/
hadoop jar ./tfidf.jar ocr.hadoop.lab.tfidf.WordPerDocDriver /output/step_1 /output/step_2
hadoop jar ./tfidf.jar ocr.hadoop.lab.tfidf.WordTFIDFDriver /output/step_2 /output/step_3 /input/
hadoop jar ./tfidf.jar ocr.hadoop.lab.tfidf.GetTopK /output/step_3 20

