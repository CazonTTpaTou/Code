# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 18:27:10 2017

@author: fmonnery
"""
import pickle
import os

class grille:    
    
    MyGrid = [[]]
    
    PositionRobotLigne = 1
    PositionRobotColonne = 0 
    
    LimiteHorizontale = 0
    LimiteVerticale = 0
    
    SortieAtteinte = False
    
    def __init__(self, MaGrille):
        self.ChargerGrille(MaGrille)
           
    def ChargerGrille(self,NomGrille):
        CurrentDirectory = os.getcwd()
        os.chdir(CurrentDirectory + '\\ListeGrille\\')
        
        with open(NomGrille,'r') as MyFile:
            Tampon = MyFile.read()
        
            Ligne = [] 
      
            for carac in Tampon:
                if carac=='\n': 
                    self.MyGrid.append(Ligne)
                    
                    if(self.LimiteVerticale==0):
                        self.LimiteHorizontale = len(Ligne)
                    
                    if(len(Ligne)>0):               
                        self.LimiteVerticale += 1  
                    
                    Ligne = []
                else:
                    Ligne.append(carac)
                    
                    if(carac=='O'):
                        self.PositionRobotInitialeHorizontale = self.LimiteHorizontale 
                        self.PositionRobotInitialeVerticale = self.LimiteVerticale 
                
    def ImprimerGrille(self):
        for ligne,colonne in enumerate(self.MyGrid):            
            Lig_Horizontale=''
            
            for caractere in self.MyGrid[ligne]:
                Lig_Horizontale += caractere 
                
            print (Lig_Horizontale)
   
    def SauvegarderGrille(self,NomSauvegarde):    
        with open(NomSauvegarde,"wb") as myFichier:
            monPickler = pickle.Pickler(myFichier)
            monPickler.dump(self.MyGrid)
    
    def ChargerGrilleEnCours(self,Nomfichier):
        with open(Nomfichier,"rb") as myFichiers:
            monDe_Pickler = pickle.Unpickler(myFichiers)
            self.MyGrid =  monDe_Pickler.load()
                     
            