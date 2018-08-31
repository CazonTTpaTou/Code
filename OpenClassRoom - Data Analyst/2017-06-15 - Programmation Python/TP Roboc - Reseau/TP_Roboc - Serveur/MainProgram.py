# -*- coding: utf-8 -*-
"""
Created on Tue Jun 13 17:40:48 2017
Module principale du jeu par lequel on lance le programme
@author: fmonnery
"""

import sys
from Fichier import fichier
from Partie import Partie

""" On instancie une classe fichier pour pouvoir manipuler les template sources contenant les grilles de jeu """
fichiers = fichier()

""" Fonction proposant de choisir une grille de départ en tapant juste un des numéros proposés """  
def IntroProposerNouvelleGrille():
    try:
        fichiers.AfficherListeGrille()    
        return fichiers.GetGrille(input("Entrez votre numéro de grille :"))
    except:
        print ("La valeur que vous avez saisie est incorrecte et a généré l'exception suivante :", sys.exc_info()[0])
        PropositionReChoisirGrille()

""" Fonction pour offrir une nouvelle tentative de chois de grille en cas d'un premier échec """        
def PropositionReChoisirGrille():
    if((input('Voulez vous tenter de choisir à nouveau une grille ?'))=='O'):
        IntroProposerNouvelleGrille()

    else:
        print('Au revoir ! Merci  pour votre participation!!')
        return None

"""On lance le jeu en proposant de choisir une grille de jeu """
partie = Partie(IntroProposerNouvelleGrille())  

"""Une fois la grille choisir, on lance l'inscription des joueurs puis le jeu en réseau """
if (partie != None):    
    partie.InscriptionJoueurs()
    partie.JouerPartieReseau()








    
    





