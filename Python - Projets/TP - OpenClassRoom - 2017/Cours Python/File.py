# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 15:26:02 2017

@author: fmonnery
"""

import os
os.chdir("C:\\Users\\fmonnery\\Documents\\Python Scripts\\")

monFichier = open("fichier.txt","r")
monFichier.close

monFichier1 = open("fichier.txt","a")
monFichier1.write("Bonjour")
monFichier1.close

monFichier2 = open("fichiers.txt","w")
monFichier2.write("Bonjour !!")

monFichier2.close

with open("fichier.txt","r") as myFichier:
    texte=myFichier.read
    

        
