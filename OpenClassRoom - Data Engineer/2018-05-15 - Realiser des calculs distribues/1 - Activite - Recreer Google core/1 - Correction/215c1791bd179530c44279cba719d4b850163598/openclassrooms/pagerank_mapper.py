#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

#nombre total de noeuds. On pourrait le lire comme la première ligne du fichier nodes
nbr_nodes = 7967
X = [1.0/nbr_nodes] * nbr_nodes

# Si un ancien x existe, on le lit pour initialiser X
if os.path.exists("/tmp/pagerank_old_x"):
    with open("/tmp/pagerank_old_x") as f:
        for line in f:
            i,v = line.strip().split("\t")
            i = int(i)
            v = float(v)
            X[i] = v

for line in sys.stdin:
    if not line.strip(): continue #ignore empty lines

    i, value_list = line.strip().split(':')
    i = int(i)

    values = value_list.strip().split(' ')
    values = values[:-1] # On retire le dernier élement qui est -1
    values = [int(v) for v in values]
    
    if len(values) == 0:
        # Il n'y a aucun lien sortant. On veut alors choisir au hasard une page
        for j in range(nbr_nodes):
            T = 1.0/nbr_nodes
            print("%s\t%s" % (j, T*X[i]))
    else:
        for j in values:
            T = 1.0/len(values)
            print("%s\t%s" % (j, T*X[i]))

