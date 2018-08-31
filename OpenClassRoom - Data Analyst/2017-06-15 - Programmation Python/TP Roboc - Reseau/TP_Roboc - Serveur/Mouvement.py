# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 19:42:30 2017
Classe pour gérer les mouvements des robots à partir des instructions envoyées per les joueurs clients
@author: fmonnery
"""

class mouvement:
    
    latitude:0
    longitude:0
    
    """Méthode d'initialisation """
    def __init__(self):
        self.latitude=0
        self.longitude=0
    
    """Méthode pour transcrire un déplacement du robot en coordonnées dans la grille """    
    def SeDeplacer(self,commande):        
        if(commande[0].upper()=='E'):
            self.Coordonnees(int(commande[1]),0)
        
        if(commande[0].upper()=='O'):
            self.Coordonnees(int(commande[1])*(-1),0)
        
        if(commande[0].upper()=='S'):
            self.Coordonnees(0,int(commande[1]))
        
        if(commande[0].upper()=='N'):
            self.Coordonnees(0,int(commande[1])*(-1))
    
    """Méthode pour transcrire une action de perceuse / colmatage du robot en coordonnées dans la grille """    
    def PercerMurer(self,commande):        
        if(commande[1].upper()=='E'):
            self.Coordonnees(1,0)
        
        if(commande[1].upper()=='O'):
            self.Coordonnees(-1,0)
        
        if(commande[1].upper()=='S'):
            self.Coordonnees(0,1)
        
        if(commande[1].upper()=='N'):
            self.Coordonnees(0,-1)

    """Méthode renvoyant les coordonnées de l'instruction de déplacement du joueur """
    def Coordonnees(self,lat,long):
        self.latitude = lat
        self.longitude = long
    
    """Méthode renvoyant les coordonnées de l'instruction de déplacement du joueur """
    def RenvoyerLatitude(self):
        return self.latitude

    """Méthode renvoyant les coordonnées de l'instruction de déplacement du joueur """
    def RenvoyerLongitude(self):
        return self.longitude


