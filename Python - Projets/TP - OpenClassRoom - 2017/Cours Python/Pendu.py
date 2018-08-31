# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 10:52:23 2017

@author: fmonnery
"""
import donnee
import fonctions
import random

def Login():
    nom=input("Votre nom")
    fonctions.PrecedentScore(nom)
    score = random.randint(0,10)
    print("Votre score est de ",score)
    fonctions.EnregistrementScore(fonctions.GetNomUtilisateur,score)
    donnee.Test(nom)
    
Login()





    
        