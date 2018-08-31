#! /usr/bin/env python3
import sys


# Load x (last iteration of the PageRank line-vector x_i)
x = []
with open('iter_pagerank.txt', 'r') as f:
    x = f.readlines()[-1].strip().split()


for line in sys.stdin:

    # Get list of webpage links from line
    line = line.strip().split()
    page = line[0][:-1]
    links = line[1:-1]

    # Get number of links
    nl = len(links)
   
    # Assign value = 0 to current webpage
    # (if that page has no parent link it would then 
    # be assigned a probability s/n in the reducer)
    print("%s\t0" % (page))
    
    # For each webpage link, generate key-value pair
    for link in links:
        value = float(x[int(page)]) / float(nl)
        print("%s\t%f" % (link, value))
