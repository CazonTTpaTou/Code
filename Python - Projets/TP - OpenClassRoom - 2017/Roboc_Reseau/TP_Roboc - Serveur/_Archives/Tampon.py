# -*- coding: utf-8 -*-
"""
Created on Sun Jun 11 16:44:40 2017

@author: fmonnery
"""

class Labyrinthe:    
    
    def __init(self):
           self.MyGrid = [[]]
        
    def ChargerGrille(self,NomGrille):

        with open(NomGrille,'r') as MyFile:
            Tampon = MyFile.read()
        
        Ligne = [] 
  
        for carac in Tampon:
            if carac=='\n': 
                self.MyGrid.append(Ligne)
                Ligne = []
            else:
                Ligne.append(carac)
        
    def ImprimerGrille(self):
        for ligne,colonne in enumerate(self.MyGrid):
            print(self.MyGrid[ligne])
            
    def TracerPositionRobot(self,Ligne,Colonne):
        self.MyGrid[Ligne,Colonne] = 'O'
        
                   
Laby = Labyrinthe()
Laby.ChargerGrille('Grille.txt')
Laby.TracerPositionRobot(1,5)
Laby.ImprimerGrille()

                   
                   