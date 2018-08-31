#! /usr/bin/env python3
import sys


# Exchange first and second elements of each line 
# (the idea is to have doc_id as the key and (word, count) as the values)

for line in sys.stdin:
     word, doc_id, count = line.strip().split()
     print("%s\t%s\t%s" % (doc_id, word, count)) 
