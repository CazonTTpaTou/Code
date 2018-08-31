#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

for line in sys.stdin:
    key, num = line.strip().split("\t")
    word,doc = key.split(",")

    print("%s\t%s,%s" % (doc, word, num))
