#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import math

last_doc = None
doc_data = []

def print_best_tfidf(doc, list_tfidf):
    list_tfidf.sort(reverse=True)

    for word,tfidf in list_tfidf[0:20]:
        print("%s\t%s,%s" % (doc, word, tfidf))

for line in sys.stdin:
    doc, value = line.split("\t")
    word, tfidf = value.split(",")
    tfidf = float(tfidf)

    if doc != last_doc:
        if last_doc is not None:
            print_best_tfidf(last_doc, doc_data)

        last_doc = doc
        doc_data = []

    doc_data.append((tfidf, word))

print_best_tfidf(last_doc, doc_data)
