# -*- coding: utf-8 -*-
"""
Created on Sun Jun 11 16:44:40 2017
Classe principale hébergeant la grille de labyrinthe et les différents déplacements des robots
@author: fmonnery
"""
import numpy as np
import random

from Grille import grille

class labyrinthe(grille):    
    
    """Méthode d'initialisation de la classe labyrinthe """ 
    def __init__(self,MaGrille):
        grille.__init__(self,MaGrille) 
        self.InitialiserPositionsRobots()
        self.robotActif = 0
        self.robotGagnant = 0
        
    """Méthode pour désigner le robot actif en mouvement dans la grille """
    def DesignerRobotActif(self,NumRobot):
        self.robotActif = NumRobot
        self.PositionRobotLigne, self.PositionRobotColonne = self.ListeRobot[NumRobot-1].getPositionRobot()
        
    """Méthode pour renvoyer le numéro du robot qui est en train de se déplacer dans la grille """    
    def NumeroRobotActif(self):
        return self.robotActif
    
    """Méthode renvoyant la position dans la grille du robot en train de jouer """
    def DefinirPositionRobotActif(self,ligne,colonne):
        self.ListeRobot[self.NumeroRobotActif()-1].setPositionRobot(ligne,colonne)
        self.PositionRobotLigne, self.PositionRobotColonne = self.ListeRobot[self.NumeroRobotActif()-1].getPositionRobot()
        
    """Méthode pour permettre au robot actif de murer un des accès du labyrinthe """
    def RobotActionMurer(self,Lig,Col):
        if (self.RenvoyerContenuPosition(self.RenvoyerPositionRobot()[1]+Lig,self.RenvoyerPositionRobot()[0]+Col) == ' '):
           self.MyGrid[self.RenvoyerPositionRobot()[1]+Lig][self.RenvoyerPositionRobot()[0]+Col]='X' 
                       
    """Méthode pour permettre au robot actif de percer un accès bloqué ou muré """    
    def RobotActionPercer(self,Lig,Col):
        if (self.RenvoyerContenuPosition(self.RenvoyerPositionRobot()[1]+Lig,self.RenvoyerPositionRobot()[0]+Col) == 'X'):
           self.MyGrid[self.RenvoyerPositionRobot()[1]+Lig][self.RenvoyerPositionRobot()[0]+Col]=' '
           
    """Méthode pour déplacer le robot dans la grille de labyrinthe """    
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
            
    """Sous méthode spécifique à un déplacement vers l'est """
    def AvancerRobotEst(self,Source,Cible):   
        if not (self.RencontrerSortie(self.PositionRobotLigne,Source)):
            if (Source==Cible) or (self.RencontreObstacle(self.PositionRobotLigne,Source+1)) :
                self.TracerPositionRobot(self.PositionRobotLigne,Source)            
            else:
                self.AvancerRobotEst(Source+1,Cible)
        else:
            self.TracerPositionRobot(self.PositionRobotLigne,Source)
            
    """Sous méthode spécifique à un déplacement vers l'ouest """        
    def AvancerRobotOuest(self,Source,Cible):      
        if not (self.RencontrerSortie(self.PositionRobotLigne,Source)):
            if (Source==Cible) or (self.RencontreObstacle(self.PositionRobotLigne,Source-1)):
                self.TracerPositionRobot(self.PositionRobotLigne,Source)            
            else:
                self.AvancerRobotOuest(Source-1,Cible)
        else:
            self.TracerPositionRobot(self.PositionRobotLigne,Source)
            
    """Sous méthode spécifique à un déplacement vers le sud """        
    def AvancerRobotSud(self,Source,Cible):     
        if not (self.RencontrerSortie(Source,self.PositionRobotColonne)):
            if (Source==Cible) or (self.RencontreObstacle(Source+1,self.PositionRobotColonne)):
                self.TracerPositionRobot(Source,self.PositionRobotColonne)            
            else:
                self.AvancerRobotSud(Source+1,Cible)
        else:
            self.TracerPositionRobot(Source,self.PositionRobotColonne)
            
    """Sous méthode spécifique à un déplacement vers le nord """        
    def AvancerRobotNord(self,Source,Cible):     
        if not (self.RencontrerSortie(Source,self.PositionRobotColonne)):
            if (Source==Cible) or (self.RencontreObstacle(Source-1,self.PositionRobotColonne)):
                self.TracerPositionRobot(Source,self.PositionRobotColonne)            
            else:
                self.AvancerRobotNord(Source-1,Cible)
        else:
            self.TracerPositionRobot(Source,self.PositionRobotColonne)
            
    """Méthode pour tracer dans la grille de labyrinthe dans la nouvelle position du robot après déplacement """            
    def TracerPositionRobot(self,Lig,Col):
        self.AtteindreSortie(Lig,Col)
        self.MyGrid[self.RenvoyerPositionRobot()[1]][self.RenvoyerPositionRobot()[0]]=' '
        self.MyGrid[Lig][Col] = str(self.NumeroRobotActif())
        self.DefinirPositionRobotActif(Lig,Col) 
        
    """Méthode pour renvoyer le contenu d'une case du labyrinthe """    
    def RenvoyerContenuPosition(self,Lig,Col):
        if (self.EstPositionDansLesLimites(Lig,Col)):
            return self.MyGrid[Lig][Col]
        else:
            return 'X'
            
    """Méthode pour déterminer si le déplacement du robot aboutit à une intersection avec la sortie """
    def RencontrerSortie(self,lig,col):
        if(self.RenvoyerContenuPosition(lig,col)=='U'):
            return True
        else:
            return False
        
    """Méthode permettant de désigner le robot gagnant ayant atteint la sortie """    
    def AtteindreSortie(self,Lig,Col):       
        if(self.RenvoyerContenuPosition(Lig,Col)=='U'):
            self.SortieAtteinte = True   
            self.robotGagnant = self.robotActif
            
    """Méthode pour déterminer si le déplacement sur la case est possible ou non """
    def RencontreObstacle(self,Lig,Col):            
        if(self.RenvoyerContenuPosition(Lig,Col)==' ') or (self.RenvoyerContenuPosition(Lig,Col)=='U'):
            return False
        else:
            return True
    
    """Méthode pour déterminer si la case est vide et permet le déplacement du robot """        
    def EstContenuPositionVide(self,Lig,Col):        
        if(self.RenvoyerContenuPosition(Lig,Col)==' '):
            return True
        else:
            return False
    """Méthode pour vérifier si une position correspond à l'emplacement du robot dans la grille """    
    def EstEgalePositionRobot(self,Lig,Col):        
        if(self.RenvoyerPositionRobot()[0]==Col) and (self.RenvoyerPositionRobot()[1]==Lig):
            return True
        else:
            return False
        
    """Méthode pour vérifier si la position est bien dans les limites de la grille """
    def EstPositionDansLesLimites(self,lig,col):        
        if (col>self.LimiteHorizontale) or (col<0) or (lig>self.LimiteVerticale) or (lig<1):
            return False
        else:
            return True
        
    """Méthode pour déterminer si l'avancement du robot est possible ou non """
    def EstAvancementRobotPossible(self,Lig,Col):          
        if (self.EstContenuPositionVide(Lig,Col-1)):
            return True
        else:
            return False
        
    """Méthode pour savoir si la partie a un gagnant ou non """
    def EstPartieTerminee(self):
        return self.SortieAtteinte
    
    """Méthode pour renvoyer un déplacement tronqué aux limites de la grille """
    def RenvoyerPositionHorizontaleDansLimite(self,Lig):
        Y = np.array([np.array([0,Lig]).max(),self.LimiteHorizontale])
        return Y.min()
    
    """Méthode pour renvoyer un déplacement tronqué aux limites de la grille """
    def RenvoyerPositionVerticaleDansLimite(self,Col):
        X = np.array([np.array([1,Col]).max(),self.LimiteVerticale])
        return X.min()   
    
    """Méthode pour placer les robots de façon aléatoire dans la grille """    
    def InitialiserPositionsRobots(self):
        self.ListerPositionLibre()
        
        for rob in self.ListeRobot:
            numPosition = random.randint(0,len(self.ListePositionLibre)-1)
            rob.setPositionRobot(self.ListePositionLibre[numPosition][0],self.ListePositionLibre[numPosition][1])
            self.MyGrid[rob.PositionRobotLigne][rob.PositionRobotColonne] = str(rob.NumeroRobot)
            del self.ListePositionLibre[numPosition]            
    
    """Méthode pour renvoyer la position du robot actif """
    def RenvoyerPositionRobot(self):
        position = []
        
        for ligne,colonne in enumerate(self.MyGrid):
            try :           
                if(colonne.index(str(self.NumeroRobotActif()))>=0):
                    position.append(colonne.index(str(self.NumeroRobotActif())))
                    position.append(ligne)
            except:
                pass
            
        return position 
    
    """Méthode pour renvoyer le numéro du robot gagnant si celui est déjà déterminé """
    def RenvoyerRobotGagnant(self):
        if (self.EstPartieTerminee()):
            return self.robotGagnant
        else:
            return 0
        
     


