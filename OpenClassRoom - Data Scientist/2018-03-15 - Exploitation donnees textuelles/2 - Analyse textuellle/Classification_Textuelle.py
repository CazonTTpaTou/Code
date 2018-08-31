# -*- coding: utf-8 -*-

import nltk
import os
from nltk.classify import NaiveBayesClassifier

def tokenisation(text):
    by = bytes(text,'utf-8')
    textDecode = by.decode('utf-8').lower()
    tokenizer = nltk.RegexpTokenizer(r'\w+')
    return tokenizer.tokenize(textDecode)
    
def format_sentence(sent):
    return ({ word: True for word in tokenisation(sent) })

def load_training_set():
    training = []

    for fichier in os.listdir('E:\\Data\\RawData\\Exploit_data_texte\\Positive'):
        #example = '{}/{}'.format(ap('E:\\Data\\RawData\\Exploit_data_texte\\Positive'), fp)
        os.chdir("E:\\Data\\RawData\\Exploit_data_texte\\Positive")
        with open(fichier,encoding="utf8") as myFile:
            myString = str(myFile.read())
            for i in tokenisation(myString):
                training.append([format_sentence(i), 'pos'])

    for fichier in os.listdir('E:\\Data\\RawData\\Exploit_data_texte\\Negative'):
        #example = '{}/{}'.format(ap('E:\\Data\\RawData\\Exploit_data_texte\\Negative'), fp)
        os.chdir("E:\\Data\\RawData\\Exploit_data_texte\\Negative")
        with open(fichier,encoding="utf8") as myFile:
            myString = str(myFile.read())
            for i in tokenisation(myString):
                training.append([format_sentence(i), 'neg'])

    return training

training = load_training_set()

classifier = NaiveBayesClassifier.train(training)
classifier.show_most_informative_features(n=25)


