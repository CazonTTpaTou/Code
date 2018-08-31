#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

for line in sys.stdin:
    key, value = line.strip().split("\t")
    word, doc = key.split(",")
    word_count, doc_count = value.split(",")

    print("%s\t%s,%s,%s" % (word, doc, word_count, doc_count))
