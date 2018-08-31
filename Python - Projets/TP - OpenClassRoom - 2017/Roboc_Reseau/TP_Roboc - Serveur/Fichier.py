# -*- coding: utf-8 -*-
"""
Created on Fri Jun 16 09:49:28 2017
Classe permettant de gérer les fichiers texte des grilles de jeu de labyrinthe
@author: fmonnery
"""

import os 

class fichier:
    
    ListeGrille = []
    ListePartie = []
    
    def __init__(self):       
        CurrentDirectory = os.getcwd()
        self.repertoireGrille = CurrentDirectory + '\\ListeGrille\\'        
        self.repertoirePartie = CurrentDirectory + '\\ListePartie\\'
    
    def GetListeFichiers(self,repertoire):
        return os.listdir(repertoire)
        
    def SetListeGrille(self):
        self.ListeGrille = self.GetListeFichiers(self.repertoireGrille)
    
    def GetListeGrille(self):
        return self.ListeGrille
    
    def SetListePartie(self):
        self.ListePartie = self.GetListeFichiers(self.repertoirePartie)
    
    def GetListePartie(self):
        return self.ListeGrille
        
    def GetPartie(self,numero):
        return self.ListePartie[int(numero)]
    
    def GetGrille(self,numero):
        return self.ListeGrille[int(numero)]

    def AfficherListeGrille(self):
        self.SetListeGrille()
        for numero,nomGrille in enumerate(self.GetListeGrille()):
            print(numero,' - ',nomGrille)

    def AfficherListePartie(self):
        print(self.repertoirePartie)
        os.listdir(self.repertoirePartie)
        self.SetListePartie()
        for numero,nomPartie in enumerate(self.GetListePartie()):
            print(numero,' - ',nomPartie)
    



