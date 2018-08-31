#! /usr/bin/env python3
import sys

lines = []
n_d = {}  
lastDocId = None

# First loop over lines to compute the total number of words n_d in each document
for line in sys.stdin:
    
    line = line.strip()
    lines.append(line)

    doc_id, word, count = line.split()
    count = int(count)

    #As long as we stay on the same document we increment n_d
    if doc_id == lastDocId:
        n_d[doc_id] += count

    #Otherwise we reinitialize n_d for the next document
    else:
        n_d[doc_id] = count 
        lastDocId = doc_id


# Second loop over the same lines (lines have been stored in a list because sys.stdin can only be iterated once) and write information to stdout
for line in lines:
    doc_id, word, count = line.split()
    print("%s\t%s\t%s\t%d" % (word, doc_id, count, n_d[doc_id]))
    

