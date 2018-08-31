#! /usr/bin/env python3
import sys

count = 0

for line in sys.stdin:
    count += 1

print("1 %d" % (count))
