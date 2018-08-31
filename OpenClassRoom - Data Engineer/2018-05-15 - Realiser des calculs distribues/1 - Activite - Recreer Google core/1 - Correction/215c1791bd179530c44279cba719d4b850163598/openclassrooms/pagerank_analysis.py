#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import re

#nombre total de noeuds. On pourrait le lire comme la première ligne du fichier nodes
nbr_nodes = 7967
X = [1.0/nbr_nodes] * nbr_nodes
old_X = [1.0/nbr_nodes] * nbr_nodes

if os.path.exists("/tmp/pagerank_old_x"):
    with open("/tmp/pagerank_old_x") as f:
        for line in f:
            i,v = line.strip().split("\t")
            i = int(i)
            v = float(v)
            old_X[i] = v

if os.path.exists("/tmp/pagerank_x"):
    with open("/tmp/pagerank_x") as f:
        for line in f:
            i,v = line.strip().split("\t")
            i = int(i)
            v = float(v)
            X[i] = v

diff = sum([(a - b)**2 for a,b in zip(old_X, X)])

print(sum(X))
print(sum(old_X))
print("La différence entre les deux vecteur est %s" % diff)

# On prend les 20 meilleurs sites
best = sorted([(v,i) for i,v in enumerate(X)], reverse=True)[0:20]

for value,index in best:
    print("Le site %s a le score %s" % (index, value))
    with open("/home/cloudera/nodes") as f:
        print_next_line = False
        for line in f:
            if print_next_line:
                print("\t" + line.strip())
                print_next_line = False
            if re.match(str(index) +" .*\[.\]", line):
                print_next_line = True
