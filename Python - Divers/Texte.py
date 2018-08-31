# -*- coding: utf-8 -*-
"""
Created on Wed Mar 14 13:56:40 2018

@author: monne
"""

import nltk
import pandas as pd
from operator import itemgetter

class Texte:
    
    def __init__(self,stringData):
        self.textContent = stringData
        
        self.textContentNormalized = self.Suppression_StopWords(
                                        self.Suppression_Ponctuation(
                                                    self.decodage_UTF8(
                                                            self.returnText())))

    def returnText(self):
        return self.textContent

    def returnTextNormalised(self):
                
        return self.textContentNormalized
    
    def returnStatistiques(self):
        self.Frequence_Mots()
        
        return self.statsMots
        
    def decodage_UTF8(self,text):
        by = bytes(text,'utf-8')
        textDecode = by.decode('utf-8').lower()
        
        return textDecode

    def Suppression_Ponctuation(self,text):
        tokenizer = nltk.RegexpTokenizer(r'\w+')
        tokenisation = tokenizer.tokenize(text)
        
        return tokenisation        
        
    def Suppression_StopWords(self,text):
        texteSansStopWords = []
        nltk.download('stopwords')
        
        listeStopWord = nltk.corpus.stopwords.words('english')
        listeStopWord.append('â')
        listeStopWord.append('n')
        listeStopWord.append('xc2')
        listeStopWord.append('xc3')
        listeStopWord.append('000')
        
        texteSansStopWords += [word for word in text if not word in listeStopWord]
        
        return texteSansStopWords
    
    def Frequence_Mots(self):
        stats = nltk.FreqDist(self.textContentNormalized)
        self.NombreMots = len(self.textContentNormalized)
        self.NombreMotsUniques = len(stats)
        self.ListeMotsTriee = sorted(stats.items(),key=itemgetter(1),reverse=True)
        self.statsMots = stats
        
    def AfficherStatistiques(self):
        self.Frequence_Mots()
        
        print('--------------------------------------')
        print('Le texte comporte {} mot(s) '.format(self.NombreMots))
        print('--------------------------------------')
        print('Le texte comporte {} mot(s) unique(s) '.format(self.NombreMotsUniques))
        print('--------------------------------------')
        
        for occurence in self.ListeMotsTriee:
            print('Le mot {} a {} occurrence(s)'.format(occurence[0],occurence[1]))
        print('--------------------------------------')

    def AfficherHistogramme(self):
        donnees = pd.Series(self.returnStatistiques())
        
        donneesTop = donnees.nlargest(20)
        donneesTrieesTop = donneesTop.sort_values(ascending=True)
        
        donneesTrieesTop.plot.barh(color="#318CE7",title="Distribution des 20 occurrences de mots les plus fréquentes")
                                      



