# -*- coding: utf-8 -*-
"""
Created on Fri Jun 16 09:30:23 2017

@author: fmonnery
"""

class robot:
    
    PositionRobotColonne=0
    PositionRobotLigne=0
    
    def __init(self,ligne,colonne):
        self.setPositionRobot(ligne,colonne)
        
    def setPositionRobot(self,ligne,colonne):
        self.PositionRobotLigne = ligne
        self.PositionRobotColonne = colonne
        
    def getPositionRobot(self,ligne,colonne):
        return [self.PositionRobotLigne,self.PositionRobotColonne]
    
    def getPositionLigneRobot(self,ligne):
        return self.PositionRobotLigne
    
    def getPositionColonneRobot(self,ligne):
        return self.PositionRobotColonne
    
    