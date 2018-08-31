#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import math

last_word = None
doc_data = {}

def compute_tfidf(word, counts):
    """
    Etant donne un mot et un dictionnaire associant à chaque document la fréquence du mot et le nombre de mot,
    on peut calculer le tf_ifd

    On suppose que le nombre de document est toujours 2
    """
    for doc, data in counts.items():
        word_count, doc_count = data
        tfidf = math.log(2/len(counts), 10) * float(word_count) / float(doc_count)

        print("%s,%s\t%s" % (word, doc, tfidf))

for line in sys.stdin:
    word, value = line.split("\t")
    doc, word_count, doc_count = value.split(",")

    if word != last_word:
        if last_word is not None:
            compute_tfidf(last_word, doc_data)

        last_word = word
        doc_data = {}

    doc_data[doc] = (int(word_count), int(doc_count))

compute_tfidf(last_word, doc_data)
