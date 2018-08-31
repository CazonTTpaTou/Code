#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

last_word = None
cur_sum = 0
doc = None

for line in sys.stdin:
    key, _ = line.split("\t")
    word,doc = key.split(",")

    if word != last_word:
        # On a fini avec le mot précédent
        if last_word is not None:
            print("%s,%s\t%s" % (last_word, doc, cur_sum))
        last_word = word
        cur_sum = 0

    cur_sum += 1

print("%s,%s\t%s" % (last_word, doc, cur_sum))
