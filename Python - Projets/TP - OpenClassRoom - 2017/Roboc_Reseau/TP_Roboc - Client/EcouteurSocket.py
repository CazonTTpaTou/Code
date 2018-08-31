# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 17:16:11 2017
Classe permettant d'instancier un thread qui va écouter les messages envoyés par la socket du jeu de labyrinthe en réseau Roboc
@author: fmonnery
"""

from threading import Thread,RLock
import socket

verrou = RLock()

class ecouteurSocket(Thread):

    """Thread chargé d'écouter les messages envoyés sur la socket"""

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
            
                message = self.ConnexionServeur.recv(1024)
                MsgDecode = message.decode()
                
                if(len(message)>0):
                    print(message.decode()) 
                
                try:
                    MsgDecode.index("fin")
                except:
                    pass
                else:
                    self.stop()
     
    def stop(self):
         self.CommunicationActive = False  

