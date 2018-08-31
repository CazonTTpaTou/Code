# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 10:37:35 2017

@author: fmonnery
"""

import donnee
import pickle

def EnregistrementListeJoueur(ListeJoueur):
    with open("donnees","wb") as myFichier:
        monPickler = pickle.Pickler(myFichier)
        monPickler.dump(ListeJoueur)
    
def ChargementListeJoueur():
     with open("donnees","rb") as myFichiers:
         monDe_Pickler = pickle.Unpickler(myFichiers)
         donnee.SetListeJoueur =  monDe_Pickler.load()
         
def EnregistrementScore(nom,score):
    donnee.AjouterListeJoueur(nom,score)
    EnregistrementListeJoueur

def PrecedentScore(nom):
    ChargementListeJoueur()    
    print("Votre précédent score était de :", donnee.GetScore(nom))

def GetNomUtilisateur():
    return donnee.JoueurActif


    