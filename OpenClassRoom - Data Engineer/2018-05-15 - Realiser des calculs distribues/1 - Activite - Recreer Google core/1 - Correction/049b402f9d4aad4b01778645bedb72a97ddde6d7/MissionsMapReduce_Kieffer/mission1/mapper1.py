#! /usr/bin/env python3
import sys
import os
import re


# Get list of stopwords from external file (into a set data structure)
stopwords = set()
try:
    f = open('stopwords_en.txt', 'r')
    for stopword in f:
        stopwords.add(stopword.strip())
    f.close()
except:
    print('ERROR: list of stopwords not loaded', file=sys.stderr)
    pass


doc_id = None

for line in sys.stdin:

    # Get document name
    doc_id = os.getenv('mapreduce_map_input_file').split('/')[-1]

    # Filters
    line = line.lower() #set to lower case
    line = re.sub('[,!?@#$\'"-.:;`/’%{}\[\]()<>°~€=]', ' ', line) #remove punctuation
    line = re.sub(r'[0-9]+', '', line) #remove numbers
    line = re.sub(r'\b\w{1,2}\b', '', line) #remove words < 3 characters
    line = line.strip() #remove multiple spaces and tabs

    # Get list of words from line
    words = line.split()

    # For each word, generate key-value pair ((word, doc_id), 1)
    for word in words:
        if word not in stopwords:
            print("%s\t%s\t%d" % (word, doc_id, 1))
