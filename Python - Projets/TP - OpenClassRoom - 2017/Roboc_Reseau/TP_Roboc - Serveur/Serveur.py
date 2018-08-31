# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 09:17:47 2017
Classe permettant de gérer le fonctionnement du serveur mettant à disposition une socket sur le réseau
@author: fmonnery
"""

import socket
import select

class serveur:

    """ Propriétés techniques de base du serveur"""
    hote = ''
    port = 12800
    
    """ Méthode d'initialisation de la classe"""
    def __init__(self,Host,Port):
        self.clientsConnectes = []
        self.ListeIdentifiants = []
        self.hote = Host
        self.port = Port
        self.LancementServeur()
    
    """ Méthode permettant d'iniatiliser la socket et de commencer à écouter les connexions entrantes"""
    def LancementServeur(self):
        self.ConnexionServeur = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.ConnexionServeur.bind((self.hote, self.port))
        self.ConnexionServeur.listen(10)    
    
        print("Serveur en écoute sur le port {}".format(self.port))
        self.serveurActif = True
    
    """ Méthode renvoyant la socket initialisée par le serveur"""
    def RenvoyerSocketServeur(self):
        return self.ConnexionServeur
    
    """ Méthode pour enregistrer toutes les connexions entrantes écoutant la socket sur le réseau"""    
    def InscriptionConnexion(self):
        InscriptionEnCours = True
    
        while InscriptionEnCours :
            
            ConnexionsEntrantes, wlist, xlist = select.select([self.ConnexionServeur],[], [], 0.05)
            
            for connexion in ConnexionsEntrantes:
                ConnexionClient, infos_connexion = connexion.accept()
                self.clientsConnectes.append(ConnexionClient)
                
            JoueursInscrits = []
        
            try:
                JoueursInscrits, wlist, xlist = select.select(self.clientsConnectes,[], [], 0.05)
        
            except select.error:
                pass
        
            else:
                for joueur in JoueursInscrits:
    
                    MsgRecu = joueur.recv(1024)
                    MsgRecu = MsgRecu.decode()
                    
                    if(MsgRecu.upper() != 'C'):                    
                        identifiant = joueur.getpeername()[0] + '-' + str(joueur.getpeername()[1])
                        self.ListeIdentifiants.append(identifiant)
                        print("Message reçu : {}".format(MsgRecu),' - Expediteur : ',joueur.getpeername())
                        joueur.send(b"Votre inscription est bien prise en compte...")
        
                    if MsgRecu.upper() == "C":
                        InscriptionEnCours = False
                        print("Fin des inscriptions !!")
                        return self.ListeIdentifiants
    
    """ Méthode pour écouter les instructions envoyées sur la socket par les différents clients joueurs"""
    def EcouteInstructionJoueur(self):
        InstructionRecue = False
        while(not InstructionRecue):
            
            JoueursInscrits = []
            
            try:
                    JoueursInscrits, wlist, xlist = select.select(self.clientsConnectes,[], [], 0.05)
            
            except select.error:
                    pass
            
            else:
                    for joueur in JoueursInscrits:
                        InstructionAtraiter = []
                        identifiant = joueur.getpeername()[0] + '-' + str(joueur.getpeername()[1])  
                        
                        MsgRecu = joueur.recv(1024)
                        MsgRecu = MsgRecu.decode()
                        
                        InstructionAtraiter = [identifiant,MsgRecu]
                        InstructionRecue = True
                        
                        return InstructionAtraiter
           
    """ Méthode permettant d'envoyer un message à l'ensemble des clients connectés sur la socket du serveur"""        
    def EnvoyerMessageClient(self,Message):        
        try:
            for client in self.clientsConnectes:
                client.send(Message)                            
        
        except select.error:
            pass
    
    """ Méthode permettant de fermer proprement et de façon encadrée l'ensemble des connexions clientes puis la socket principale"""
    def FermetureConnexion(self):
        for client in self.clientsConnectes:
            client.send(b"fin")
            client.close() 
        
        self.ConnexionServeur.close()
        
        
    

    
    

    
