#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pyspark import SparkContext

sc = SparkContext()

txt = sc.textFile("/user/cloudera/input_openclassrooms/iliad.mb.txt")

txt = txt.flatMap(lambda line: line.split()) # on sépare les mots
txt = txt.filter(lambda word: '@' not in word and '/' not in word) # on retire les mots avec @ ou /
txt = txt.map(lambda word: word.lower().strip(",.;:?!\"-'")) # passage en minuscule et retrait des ponctuations

txt.persist() # fin du nettoyage des données

# calcul du mot le plus long
size, word = txt.map(lambda word: (len(word), word)).sortByKey(False).first()
print("Le mot le plus long est %s avec une taille de %d)" % (word, size))

# Calcul du mot de 4 lettres le plus fréquent en plusieurs étapes:
#   - On filtre les mots de 4 lettres
#   - On emet (word, 1) pour chaque mot
#   - On compte le nombre d'instance de chaque mot. On a alors (word, count)
#   - On inverse la clé et la valeur. On a alors (count, word)
#   - On trie selon les clé pour avoir le mot le plus fréquent en premier
#   - Et finalement on prend le premier couple.
count, word = txt.filter(lambda word: len(word) == 4).map(lambda word: (word, 1)).reduceByKey(lambda x,y:x+y).map(lambda pair: (pair[1],pair[0])).sortByKey(False).first()
print("Le mot le plus frequent de 4 lettres est %s. Il apparait %d fois" % (word, count))

# Calcul du mot de 15 lettres le plus fréquent selon la même méthode
count, word = txt.filter(lambda word: len(word) == 15).map(lambda word: (word, 1)).reduceByKey(lambda x,y:x+y).map(lambda pair: (pair[1],pair[0])).sortByKey(False).first()
print("Le mot le plus frequent de 15 lettres  est %s. Il apparait %d fois" % (word, count))

# Finalement, le mot de 15 lettres le plus fréquent est 'many-fountained' avec 9 instances.
