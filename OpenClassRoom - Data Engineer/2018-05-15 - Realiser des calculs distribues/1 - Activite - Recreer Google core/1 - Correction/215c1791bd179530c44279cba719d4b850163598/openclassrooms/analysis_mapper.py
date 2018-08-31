#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

for line in sys.stdin:
    key, tfidf = line.strip().split("\t")
    word, doc = key.split(",")

    if float(tfidf) != 0:
        print("%s\t%s,%s" % (doc, word, tfidf))
