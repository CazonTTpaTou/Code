# -*- coding: utf-8 -*-
"""
Created on Wed Mar 14 00:13:54 2018

@author: monne
"""
import pickle
import os
from Document import Document

class ETL:

    def __init__(self,path):
        self.path = path
        os.chdir(path)
        
        self.listeDocuments = []
        
    def retournerRepertoireSauvegarde(self):
        repertoireBackUp = self.path 
        return repertoireBackUp

    def Lecture_Fichiers(self):
        listeFichiers = os.listdir(self.path)
        
        for fichier in listeFichiers:
            self.Creer_Document(fichier)
    
    def read_File(self,nameFile):
        
        Content = {}
        
        with open(nameFile,"rb") as myFile:
            myString = str(myFile.read())
            Content['Texte'] = myString[:int(myString.find('@highlight'))]
            Content['HighLight'] = myString[int(myString.find('@highlight')):]
            
        return Content

    def Creer_Document(self,nomFichier):
        fichier = self.read_File(nomFichier)
        
        document = Document(
                        fichier['Texte'],
                        fichier['HighLight'])
        
        self.listeDocuments.append(document)

    def enregistrerListeFichiers(self):
        for document in self.listeDocuments:
            self.Enregistrer_Document(
                                document.Retourner_Numero_Document()) 

    def Enregistrer_Element(self,numeroDocument,contenu,suffixe):
        os.chdir(self.retournerRepertoireSauvegarde())
        
        nameFile = "Document_" + str(numeroDocument) + suffixe
        
        with open(nameFile,"wb") as myFichier:
            monPickler = pickle.Pickler(myFichier)
            monPickler.dump(contenu)

    def Enregistrer_Document(self,numeroDocument):       
        self.Enregistrer_Element(
                            numeroDocument,
                            self.listeDocuments[numeroDocument-1].Retourner_Article_Normalise(),
                            '_Article')
        
        self.Enregistrer_Element(
                            numeroDocument,
                            self.listeDocuments[numeroDocument-1].Retourner_HighLigtht_Normalise(),
                            '_HighLights')

    def Charger_Element(self,numeroDocument,suffixe):
        os.chdir(self.retournerRepertoireSauvegarde())
        
        nameFile = "Document_" + str(numeroDocument) + suffixe
        
        with open(nameFile,"rb") as myFichiers:
            monDe_Pickler = pickle.Unpickler(myFichiers)
            return  monDe_Pickler.load()

    def Charger_Document(self,numeroDocument):
        print('------------------------------')
        print('ARTICLE N° {} '.format(numeroDocument))
        print('------------------------------')
        print(
                self.Charger_Element(
                                    numeroDocument,
                                    '_Article'))
        
        print('------------------------------')
        print('HIGHLIGHTS N° {} '.format(numeroDocument))
        print('------------------------------')
        print(
                self.Charger_Element(
                                    numeroDocument,
                                    '_HighLights'))                

                          
imp = ETL("E:\\Data\\RawData\\Exploit_data_texte\\Test")
imp.Lecture_Fichiers()
imp.enregistrerListeFichiers()
imp.Charger_Document(2)

