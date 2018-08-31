# -*- coding: utf-8 -*-
"""
Created on Thu Jun 22 11:23:57 2017
Classe permettant de gérer la connexion à la socket du serveur de jeu de labyrinthe Roboc
@author: fmonnery
"""
     
from EcouteurSocket import ecouteurSocket 
from ProviderSocket import providerSocket 

""" Propriétés du serveur hôte de la socket """ 
HOST = "fmonnery-srv"
PORT = 12800

""" Possibilité de modifier les caractéristiques de connexion en fonction de son propre réseau personnel """ 
HOST = input('Veuillez saisir une adresse de serveur host :')

""" Création de 2 threads distincts pour ne pas être bloqué par l'attente de réponse à une demande d'envoi d'instruction """  
thread_ecouteur = ecouteurSocket(HOST,PORT)
thread_saisie = providerSocket(HOST,PORT)

""" Les 2 threads s'exécutent en parallèle, ce qui permet à la fois d'écouter la socket et de lui envoyer du contenu """
thread_ecouteur.start()
thread_saisie.start()

""" On désactive proprement les 2 threads instanciés"""
thread_ecouteur.join()
thread_saisie.join()

     




