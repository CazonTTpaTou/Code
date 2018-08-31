# -*- coding: utf-8 -*-
"""
Created on Sun Jun 11 18:17:45 2017

@author: fmonnery
"""

import os

Grille = [[]]

with open('Grille.txt','r') as MyFile:
    MyGrid = MyFile.read()

Ligne = [] 
  
for carac in MyGrid:
    if carac=='\n': 
        Grille.append(Ligne)
        Ligne = []
    else:
        Ligne.append(carac)

print(Grille)

for ligne,colonne in enumerate(Grille):
    print(Grille[ligne])
    
    

      


    