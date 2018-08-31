#! /usr/bin/env python3
import sys
from math import log10


lines = []
df_t = {}  
lastword = None

# Number of documents (have to be set manually as it cannot be computed into mapreduce processes)
N = 2

# First loop over lines to compute the term-frequency of each word in the collection
for line in sys.stdin:
    
    line = line.strip()
    lines.append(line)

    word, doc_id, count, n_d = line.split()

    #As long as we stay on the same word we increment df_t
    if word == lastword:
        df_t[word] += 1

    #Otherwise we reinitialize df_t for the next word
    else:
        df_t[word] = 1 
        lastword = word


# Second loop over the same lines (lines have been stored in a list because sys.stdin can only be iterated once) and compute TF-IDF
for line in lines:

    word, doc_id, count, n_d = line.split()
    count = float(count)
    n_d = float(n_d)

    w_t = (count / n_d) * log10(N / float(df_t[word]))
    print("%s\t%s\t%f" % (word, doc_id, w_t))

