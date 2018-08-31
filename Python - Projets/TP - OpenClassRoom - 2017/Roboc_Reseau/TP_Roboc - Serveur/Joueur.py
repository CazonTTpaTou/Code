# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 19:02:17 2017
Classe joueur qui permet de relier un joueur à ses identifiants de connexion socket
@author: fmonnery
"""
 
class joueur:
    
    adresseIP= ''
    portClient=0
    
    """Méthode d'initialisation de la classe"""
    def __init__(self,adresseIP,portClient):
        self.adresseIP = adresseIP
        self.portClient = portClient
    
    """Méthode permettant de renvoyer un identifiant unique du joueur inscrit au jeu"""    
    def renvoyerIdentifiantJoueur(self):
        identifiant = self.adresseIP + '-' + str(self.portClient)   
        return identifiant
        

    
    
    
    