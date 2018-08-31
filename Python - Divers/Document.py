# -*- coding: utf-8 -*-
"""
Created on Wed Mar 14 16:00:53 2018

@author: monne
"""

from Texte import Texte

class Document:

    numeroDocumentGlobal = 0
    
    @classmethod
    def IncrementIdentifiant(self):
        self.numeroDocumentGlobal += 1    
    
    def __init__(self, textArticle, textHighLights):
        self.IncrementIdentifiant()
        self.numeroDocument = self.numeroDocumentGlobal
        
        self.article = Texte(textArticle)        
        self.highLights = Texte(textHighLights)
        
        self.Afficher_Caracteristiques_Document()
        
    def Retourner_Numero_Document(self):
        return self.numeroDocument
   
    def Retourner_Article_Normalise(self):
        return self.article.returnTextNormalised()
        
    def Retourner_HighLigtht_Normalise(self):
        return self.highLights.returnTextNormalised()

    def Retourner_Article_Frequence(self):
        return self.article.returnStatistiques()
        
    def Retourner_HighLigtht_Frequence(self):
        return self.highLights.returnStatistiques()

    def Afficher_Caracteristiques_Document(self):
        print('--------------------------------------')
        print('Caractéristiques du document {}'.format(self.Retourner_Numero_Document()))
        print('--------------------------------------')
        print('HIGHLIGHTS du document {}'.format(self.Retourner_Numero_Document()))
        self.highLights.AfficherStatistiques()               
        print('ARTICLES du document {}'.format(self.Retourner_Numero_Document()))
        print('--------------------------------------')
        self.article.AfficherHistogramme()


        

