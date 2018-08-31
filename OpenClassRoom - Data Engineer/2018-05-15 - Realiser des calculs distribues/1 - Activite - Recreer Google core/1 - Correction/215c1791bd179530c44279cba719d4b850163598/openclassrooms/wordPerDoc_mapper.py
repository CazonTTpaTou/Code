#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import re       
import os

stop_words = set()
with open("/home/cloudera/workspace/openclassrooms/stopwords_en.txt") as f:
    for stop_word in f:
        stop_words.add(stop_word.strip())

# On récupere le nom du document qui est en cours d'utilisation
if "mapreduce_map_input_file" in os.environ:
    filename = os.environ["mapreduce_map_input_file"].split("/")[-1]
else:
    filename = None

for line in sys.stdin:
    line = line.strip()

    # Retire les majuscules
    line = line.lower()

    for word in line.split(" "):
        # On retire les symboles de ponctuation aux extremites pour repérer les stopword
        word = word.strip(".,'!? \t")

        # on ignore les stopwords
        if word in stop_words: continue

        # elimine tout ce qui n'est pas un caractère alphabétique
        word = re.sub("[^a-zA-Z ]", "", word)

        #on ignore les mots de moins de 3 lettres
        if len(word) <= 3: continue

        # on ignore ce qui n'est pas un mot
        if word == "": continue

        print("%s,%s\t%s" % (word, filename, 1))
