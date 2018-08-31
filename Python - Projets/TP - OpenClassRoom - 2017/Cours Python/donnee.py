# -*- coding: utf-8 -*-
"""
Created on Thu Mar 30 10:12:57 2017

@author: fmonnery
"""

ListeMot = ["Crocodile","Gavial","Alligator","Caïman","Batracien","Grenouille"]
NombreChance = 10
ListeJoueur ={}

def RetourneMot(Nombre):
    assert Nombre <=5
    assert Nombre >=0
    
    try:
        return ListeMot[Nombre]
    
    except AssertionError:
        ("Index de liste incorrect")
    
def Chance():
    global NombreChance
    return NombreChance

def SetListeJoueur(liste):
    global ListeJoueur 
    ListeJoueur = liste

def GetListeJoueur():
    return ListeJoueur

def AjouterListeJoueur(joueur,score):
    ListeJoueur[joueur] = score
       
def GetScore(nom):
    global JoueurActif
    JoueurActif = nom   
    try: 
        return ListeJoueur[nom]
    except:
        return "Première participation !! pour " + JoueurActif 

def Test(nom):
    print("Bonjour ",nom)

             
