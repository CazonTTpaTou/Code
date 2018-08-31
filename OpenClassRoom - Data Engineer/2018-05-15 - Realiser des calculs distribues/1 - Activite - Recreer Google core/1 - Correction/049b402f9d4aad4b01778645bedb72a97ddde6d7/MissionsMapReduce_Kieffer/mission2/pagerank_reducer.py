#! /usr/bin/env python3
import sys


# Get teleport probability from 
# command line argument (default = 0.15)
s = 0.15
if len(sys.argv) >= 2:
    if float(sys.argv[1]) is not None:
        s = float(sys.argv[1])

# Get size of the PageRank vector from 
# command line argument (to avoid using len(x) 
# which is an O(n) operation)
n = 0
if len(sys.argv) >= 3:
    if int(sys.argv[2]) is not None:
        n = float(sys.argv[2])

# Get size of the PageRank vector if not set from command line
if n == 0:
    with open('iter_pagerank.txt', 'r') as f:
        x = f.readlines()[-1].strip().split()
        n = float(len(x))


lastlink = None
total = 0.0


for line in sys.stdin:

    # Get key-value pair (link, value)
    # and convert value into a float
    link, value = line.strip().split()
    value = float(value)

    # Initialization
    if lastlink is None:
        lastlink = link

    # Incrementation of the sum of values for current link
    if link == lastlink:
        total += value

    # Write (lastlink, total) to stdout 
    # whenever reaching a new link
    else:
        pagerank = (1.0-s)*total + s/n
        print("%s\t%f" % (lastlink, pagerank))
        total = value
        lastlink = link
    

if lastlink is not None:
    pagerank = (1.0-s)*total + s/n
    print("%s\t%f" % (lastlink, pagerank))
