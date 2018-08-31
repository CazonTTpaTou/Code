# -*- coding: utf-8 -*-
"""
Created on Fri Mar 16 13:13:33 2018

@author: monne
"""

import nltk

test = "Bonjour, je suis un texte d'exemple pour le cours d'Openclassrooms. Soyez attentifs à ce cours !"

by = bytes(test,'utf-8')
textDecode = by.decode('utf-8').lower()
tokenizer = nltk.RegexpTokenizer(r'\w+')
tokenisation = tokenizer.tokenize(textDecode)
texteSansStopWords = []
texteSansStopWords += [word for word in tokenisation]

print(texteSansStopWords)
print("Longueur texte origine : {}".format(len(texteSansStopWords)))
print(list(nltk.bigrams(texteSansStopWords)))
print("Longueur bigrammes : {}".format(len(list(nltk.bigrams(texteSansStopWords)))))

exercice = "La seconde partie de du cours de traitement de texte traite de la transformation des données textuelles"

by = bytes(exercice,'utf-8')
textDecode = by.decode('utf-8').lower()
tokenizer = nltk.RegexpTokenizer(r'\w+')
tokenisation = tokenizer.tokenize(textDecode)
texteSansStopWords = []
texteSansStopWords += [word for word in tokenisation]

print('-------------------------------------------------')
print(texteSansStopWords)
print("Longueur texte origine : {}".format(len(texteSansStopWords)))
print(list(nltk.bigrams(texteSansStopWords)))
print("Longueur bigrammes : {}".format(len(list(nltk.ngrams(texteSansStopWords,2)))))
print(list(nltk.ngrams(texteSansStopWords,3)))
print("Longueur trigrammes : {}".format(len(list(nltk.ngrams(texteSansStopWords,3)))))





