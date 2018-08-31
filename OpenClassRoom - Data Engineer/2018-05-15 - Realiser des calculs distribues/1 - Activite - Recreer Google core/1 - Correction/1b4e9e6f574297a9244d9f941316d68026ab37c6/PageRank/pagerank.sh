hdfs dfs -rm -f -r /pagerank/output/*

hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.TransMatrixDriver /pagerank/input/adj_list /pagerank/output/step_1

hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.InitVectorDriver  /pagerank/input/adj_list /pagerank/output/step_2
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_01

hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 1
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_02
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 2
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_03
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 3
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_04
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 4
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_05
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 5
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_06
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 6
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_07
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 7
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_08
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 8
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_09
hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.NextStepDriver    /pagerank/output/step_1 /pagerank/output/step_2 9
hdfs dfs -cp -f /pagerank/output/step_2/part-* /pagerank/resources/vector_10

hdfs dfs -copyToLocal -f /pagerank/resources/*

hadoop jar ./pagerank.jar ocr.hadoop.lab.pagerank.SortVectorDriver /pagerank/output/step_2 /pagerank/output/step_3

hdfs dfs -copyToLocal -f /pagerank/output/step_3/part-r-*
head -20 ./part-r-00000
