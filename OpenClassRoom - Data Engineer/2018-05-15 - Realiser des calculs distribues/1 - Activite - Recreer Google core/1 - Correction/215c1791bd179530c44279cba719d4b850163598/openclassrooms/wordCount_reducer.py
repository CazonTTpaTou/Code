#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

last_doc = None
cur_sum = 0
words = []

for line in sys.stdin:
    doc, value = line.strip().split("\t")
    word, num  = value.split(",")
    num = int(num)

    if doc != last_doc:
        # On a fini avec le doc précédent
        if last_doc is not None:
            for word,count in words:
                print("%s,%s\t%s,%s" % (word, last_doc, count, cur_sum))
        last_doc = doc
        cur_sum = 0
        words = []

    cur_sum += num
    words.append( (word, num) )

for word,count in words:
    print("%s,%s\t%s,%s" % (word, last_doc, count, cur_sum))
