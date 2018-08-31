# -*- coding: utf-8 -*-

from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer, TfidfVectorizer
import pandas as pd
import numpy as np
import nltk
from tokenize import tokenize

Phrases = []
Phrases.append("je suis à la maison")
Phrases.append("la maison est dans la prairie")
Phrases.append("je suis à la plage")

cvec = CountVectorizer(
        lowercase=True,        # passage en minuscules
        tokenizer=None,        # on garde le tokenizer par défaut de scikit-learn
        token_pattern=r'\w+')  

print('----------- Solution n° 1 -----------')

term_freq = cvec.fit_transform(Phrases)
phrases_tfidf = TfidfTransformer().fit_transform(term_freq)
print(phrases_tfidf.A)

print('----------- Solution n° 2 -----------')

tfidf = TfidfVectorizer(tokenizer=None, stop_words=None)
values = tfidf.fit_transform(Phrases)
print(values.A)




