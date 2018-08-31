# -*- coding: utf-8 -*-
"""
Created on Tue Feb 27 08:26:59 2018

@author: Aladin

conda install pyspark
hadoop

understanding hadoop cluster and the network
"""

import sys
from pyspark import StarkContent

sc = StarkContent()
lines = sc.textFile("C:\Users\Aladin\Desktop\workpython\base.txt")
word_counts = line.FlatMap(lambda line:line.splite(' ')) \
    .map(lambda word: (word,1))\
    .reduceByKey(lambda count1, count2: count1 + count2)
    .collect()

for (word, count) in word_counts:
    print write.encode("utf8"),count
    if(count = '@' or count = '\'):
    filter(count)
    if(count = .upper)
    .lower
        
    
    
