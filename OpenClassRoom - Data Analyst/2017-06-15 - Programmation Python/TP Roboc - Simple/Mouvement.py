# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 19:42:30 2017

@author: fmonnery
"""

class mouvement:
    
    latitude:0
    longitude:0
    
    def __init__(self):
        self.latitude=0
        self.longitude=0
        
    def SeDeplacer(self,commande):        
        if(commande[0]=='E'):
            self.Coordonnees(int(commande[1]),0)
        
        if(commande[0]=='O'):
            self.Coordonnees(int(commande[1])*(-1),0)
        
        if(commande[0]=='S'):
            self.Coordonnees(0,int(commande[1]))
        
        if(commande[0]=='N'):
            self.Coordonnees(0,int(commande[1])*(-1))
                
    def Coordonnees(self,lat,long):
        self.latitude = lat
        self.longitude = long
        
    def RenvoyerLatitude(self):
        return self.latitude

    def RenvoyerLongitude(self):
        return self.longitude


