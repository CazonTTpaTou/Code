# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 16:14:02 2017

@author: fmonnery
"""

import pickle
import os

os.chdir("C:\\Users\\fmonnery\\Documents\\Python Scripts\\")
    
Score = {
        "Joueur n°  1": 1,
        "Joueur n°  2": 2,
        "Joueur n°  3": 3,
        "Joueur n°  4": 4,
        "Joueur n°  5": 5,
        "Joueur n°  6": 6,
        "Joueur n°  7": 7,
        "Joueur n°  8": 8,
        "Joueur n°  9": 9,
        "Joueur n°  10": 10,
        "Joueur n°  11": 11,
        "Joueur n°  12": 12,
        "Joueur n°  13": 13,
        }

with open("donnees","wb") as myFichier:
    monPickler = pickle.Pickler(myFichier)
    monPickler.dump(Score)
    
with open("donnees","rb") as myFichiers:
    monDe_Pickler = pickle.Unpickler(myFichiers)
    Scores =  monDe_Pickler.load()


    
    

