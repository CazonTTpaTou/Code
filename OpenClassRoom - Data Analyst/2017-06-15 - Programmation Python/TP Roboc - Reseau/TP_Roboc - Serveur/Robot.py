# -*- coding: utf-8 -*-
"""
Created on Fri Jun 16 09:30:23 2017
Classe permettant de gérer les différentes propriétés du robot ainsi que ses positions
@author: fmonnery
"""

from Joueur import joueur

class robot:
    
    PositionRobotColonne=0
    PositionRobotLigne=0
    NumeroRobot=0    
    NbreRobotCree = 0 

    def __init__(self,adresse,port):
        robot.NbreRobotCree += 1
        self.NumeroRobot = robot.NbreRobotCree
        self.joueur = joueur(adresse,port)    
        
    def setPositionRobot(self,ligne,colonne):
        self.PositionRobotLigne = ligne
        self.PositionRobotColonne = colonne
        
    def getPositionRobot(self):
        return [self.PositionRobotLigne,self.PositionRobotColonne]
    
    def getPositionLigneRobot(self):
        return self.PositionRobotLigne
    
    def getPositionColonneRobot(self):
        return self.PositionRobotColonne
    
    def renvoyerNumeroRobot(self):
        return self.NumeroRobot
    
    def renvoyerIdentifiantRobot(self):
        return self.joueur.renvoyerIdentifiantJoueur()
    



    

    