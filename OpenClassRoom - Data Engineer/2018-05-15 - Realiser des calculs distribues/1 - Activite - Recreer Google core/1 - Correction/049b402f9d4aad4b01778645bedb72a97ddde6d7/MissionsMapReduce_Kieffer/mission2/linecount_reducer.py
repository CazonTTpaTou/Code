#! /usr/bin/env python3
import sys

count = 0

for line in sys.stdin:
    count += int(line.strip().split()[1])

print(count)
