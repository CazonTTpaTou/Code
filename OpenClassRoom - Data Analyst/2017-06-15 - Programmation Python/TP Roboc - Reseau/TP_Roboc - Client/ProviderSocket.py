# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 17:16:11 2017
Classe permettant de créer un thread qui enverra des instructions à la socket du serveur de jeu Roboc
@author: fmonnery
"""

from threading import Thread,RLock
import socket

verrou = RLock()

class providerSocket(Thread):

    """Thread chargé d'envoyer des messages sur la socket"""

    def __init__(self, host,port):
        Thread.__init__(self)
        self.SocketActive = True
        self.ConnexionServeur = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.ConnexionServeur.connect((host, port))
        self.CommunicationActive = True
        
        print("Connexion établie avec le serveur sur le port {}".format(port))
      
    def DesactiverSocket(self):
        self.SocketActive = False
        self.ConnexionServeur.Close()
        
    def run(self):
        while self.CommunicationActive:

            with verrou:
            
                messageEnvoi = input(">Votre instruction : ")
                
                self.ConnexionServeur.send(messageEnvoi.encode())
                messageReception = self.ConnexionServeur.recv(1024)
                print(messageReception.decode()) 
                
                if(messageEnvoi=='fin'):
                    print('Fin de la partie - ')
                    self.stop()                    
                            
    def stop(self):
         self.CommunicationActive = False          
            
