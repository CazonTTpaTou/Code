#!/bin/bash

# Cleaning output directories on HDFS
hdfs dfs -rm -r /user/darkmatther/ExoMapReduce_1/output*

# Creating local output directory if it does not exist yet, otherwise clean the directory
test -d output;
test=`echo $?`;
if [ "$test" == '1' ]
then
    mkdir output
else
    rm output/output*.txt
fi

# Step 1
echo 'Step 1 - calculation of tf_t,d ...'
mapred streaming -D stream.num.map.output.key.fields=2 -input /user/darkmatther/ExoMapReduce_1/input -output /user/darkmatther/ExoMapReduce_1/output1 -mapper ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/mapper1.py -reducer ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/reducer1.py  -file ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/stopwords_en.txt;

# Step 2
echo 'Step 2 - calculation of n_d ...'
mapred streaming -input /user/darkmatther/ExoMapReduce_1/output1/part-00000 -output /user/darkmatther/ExoMapReduce_1/output2 -mapper ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/mapper2.py -reducer ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/reducer2.py;

# Step 3
echo 'Step 3 - calculation of TF-IDF ...'
mapred streaming -input /user/darkmatther/ExoMapReduce_1/output2/part-00000 -output /user/darkmatther/ExoMapReduce_1/output3 -mapper ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/mapper3.py -reducer ~/hadoop/mapreduce/tuto/OpenClassroomExamples/ExoMapReduce_1/reducer3.py;

# Get mapreduce output files locally
hdfs dfs -copyToLocal /user/darkmatther/ExoMapReduce_1/output1/part-00000 output/output1.txt;
hdfs dfs -copyToLocal /user/darkmatther/ExoMapReduce_1/output2/part-00000 output/output2.txt;
hdfs dfs -copyToLocal /user/darkmatther/ExoMapReduce_1/output3/part-00000 output/output3.txt;

# List the 20 highest TF-IDF
./sortResults.py output/output3.txt > output/results.txt;
echo 'Results written in results.txt';
