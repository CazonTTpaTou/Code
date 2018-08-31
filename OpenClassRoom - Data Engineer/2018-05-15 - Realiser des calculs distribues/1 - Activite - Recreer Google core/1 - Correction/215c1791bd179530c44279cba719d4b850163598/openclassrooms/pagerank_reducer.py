#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

#nombre total de noeuds. On pourrait le lire comme la première ligne du fichier nodes
nbr_nodes = 7967


last_index = None
cur_sum = 0

s = 0.15

for line in sys.stdin:
    index, value = line.strip().split("\t")
    index = int(index)
    value = float(value)

    if index != last_index:
        # On a fini avec l'index précédent
        if last_index is not None:
            new_x = (1-s)*cur_sum + s/nbr_nodes
            print("%s\t%s" % (last_index, new_x))
        last_index = index
        cur_sum = 0.0

    cur_sum += value

new_x = (1-s)*cur_sum + s/nbr_nodes
print("%s\t%s" % (last_index, new_x))
