# -*- coding: utf-8 -*-
"""
Created on Sun Jun 11 16:44:40 2017

@author: fmonnery
"""
import numpy as np

from Grille import grille
from Robot import robot

class labyrinthe(grille):    
     
    def __init__(self,MaGrille):
        grille.__init__(self,MaGrille) 
        positionRobot = self.RenvoyerPositionRobot()
        self.PositionRobotLigne = positionRobot[1]
        self.PositionRobotColonne = positionRobot[0] 
        
    def FaireDeplacerRobot(self,ligne,colonne):
        positionCibleHorizontale = self.RenvoyerPositionHorizontaleDansLimite(self.PositionRobotColonne+colonne)        
        positionCibleVerticale = self.RenvoyerPositionVerticaleDansLimite(self.PositionRobotLigne+ligne)        

        if (ligne==0) and (colonne>0):            
            self.AvancerRobotEst(self.PositionRobotColonne,positionCibleHorizontale)
        if (ligne==0) and (colonne<0):            
            self.AvancerRobotOuest(self.PositionRobotColonne,positionCibleHorizontale)
        if (ligne<0) and (colonne==0):
            self.AvancerRobotNord(self.PositionRobotLigne,positionCibleVerticale)
        if (ligne>0) and (colonne==0):
            self.AvancerRobotSud(self.PositionRobotLigne,positionCibleVerticale)

    def AvancerRobotEst(self,Source,Cible):        
        if (Source==Cible) or (self.RencontreObstacle(self.PositionRobotLigne,Source+1)):
            self.TracerPositionRobot(self.PositionRobotLigne,Source)            
        else:
            self.AvancerRobotEst(Source+1,Cible)
        
    def AvancerRobotOuest(self,Source,Cible):        
        if (Source==Cible) or (self.RencontreObstacle(self.PositionRobotLigne,Source-1)):
            self.TracerPositionRobot(self.PositionRobotLigne,Source)            
        else:
            self.AvancerRobotOuest(Source-1,Cible)
        
    def AvancerRobotSud(self,Source,Cible):          
        if (Source==Cible) or (self.RencontreObstacle(Source+1,self.PositionRobotColonne)):
            self.TracerPositionRobot(Source,self.PositionRobotColonne)            
        else:
            self.AvancerRobotSud(Source+1,Cible)
        
    def AvancerRobotNord(self,Source,Cible):        
        if (Source==Cible) or (self.RencontreObstacle(Source-1,self.PositionRobotColonne)):
            self.TracerPositionRobot(Source,self.PositionRobotColonne)            
        else:
            self.AvancerRobotNord(Source-1,Cible)
                
    def TracerPositionRobot(self,Lig,Col):
        self.MyGrid[self.RenvoyerPositionRobot()[1]][self.RenvoyerPositionRobot()[0]]=' '
        self.AtteindreSortie(Lig,Col)
        self.MyGrid[Lig][Col] = 'O'
        self.PositionRobotLigne = Lig
        self.PositionRobotColonne = Col
      
    def RenvoyerContenuPosition(self,Lig,Col):
        if (self.EstPositionDansLesLimites(Lig,Col)):
            return self.MyGrid[Lig][Col]
        else:
            return 'X'

    def AtteindreSortie(self,Lig,Col):        
        if(self.RenvoyerContenuPosition(Lig,Col)=='U'):
            print('---------------------------------')
            print('---------------------------------')
            print('Félicitations, vous avez gagné !!')
            print('---------------------------------')
            print('---------------------------------')
            self.SortieAtteinte = True            

    def RencontreObstacle(self,Lig,Col):            
        if(self.RenvoyerContenuPosition(Lig,Col)=='X'):
            return True
        else:
            return False
        
    def EstContenuPositionVide(self,Lig,Col):        
        if(self.RenvoyerContenuPosition(Lig,Col)==' '):
            return True
        else:
            return False
        
    def EstEgalePositionRobot(self,Lig,Col):        
        if(self.RenvoyerPositionRobot()[0]==Col) and (self.RenvoyerPositionRobot()[1]==Lig):
            return True
        else:
            return False
    
    def EstPositionDansLesLimites(self,lig,col):        
        if (col>self.LimiteHorizontale) or (col<=0) or (lig>self.LimiteVerticale) or (lig<=1):
            return False
        else:
            return True
    
    def EstAvancementRobotPossible(self,Lig,Col):          
        if (self.EstContenuPositionVide(Lig,Col-1)):
            return True
        else:
            return False

    def EstPartieTerminee(self):
        return self.SortieAtteinte

    def RenvoyerPositionHorizontaleDansLimite(self,Lig):
        Y = np.array([np.array([0,Lig]).max(),self.LimiteHorizontale])
        return Y.min()
    
    def RenvoyerPositionVerticaleDansLimite(self,Col):
        X = np.array([np.array([1,Col]).max(),self.LimiteVerticale])
        return X.min()

    def RenvoyerPositionRobot(self):
        position = []
        
        for ligne,colonne in enumerate(self.MyGrid):
            try :           
                if(colonne.index('O')>=0):
                    position.append(colonne.index('O'))
                    position.append(ligne)
            except:
                pass
            
        return position
    
