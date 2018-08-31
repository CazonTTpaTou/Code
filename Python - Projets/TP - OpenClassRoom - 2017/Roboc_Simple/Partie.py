# -*- coding: utf-8 -*-
"""
Created on Tue Jun 13 12:27:40 2017

@author: fmonnery
"""
import os
import re
import pickle

from Mouvement import mouvement
from Labyrinthe import labyrinthe

class Partie:
    
    ExpressionReg=r"^[NESOneso]{1}[0-9]{1}$"
    Score =0
    
    def __init__(self,nomGrille):
        self.GrilleLabyrinthe = labyrinthe(nomGrille)
    
    def SaisieJoueur(self,texte):

        if (re.match(self.ExpressionReg,texte)) :
            Deplacement = mouvement()
            Deplacement.SeDeplacer(texte) 
            self.Score += 1
            
            print('Action de déplacement transmise au robot :' + texte)             
            deplacementColonne = Deplacement.RenvoyerLatitude()
            deplacementLigne = Deplacement.RenvoyerLongitude()
            
            print('Demande de déplacement latéral du robot de : ',deplacementColonne,' unité(s)')
            print('Demande de déplacement vertical du robot de : ',deplacementLigne,' unité(s)')
            self.GrilleLabyrinthe.FaireDeplacerRobot(deplacementLigne,deplacementColonne)
            
            self.GrilleLabyrinthe.ImprimerGrille()
            
            if(self.GrilleLabyrinthe.EstPartieTerminee()):
                return 'F'
            else :
                return 'O'
        else:
            if (texte=='Q') or (texte=='q'):
                print('Vous allez quitter la partie !!')
                return 'N'
            else :
                print('Saisie incorrecte - Pour rappel : Une lettre + Un chiffre...')                
                return 'O'                
    
    def RenvoyerDeplacementHauteur(self):
        hauteur = self.Deplacement.RenvoyerLongitude()
        return hauteur
    
    def RenvoyerDeplacementLargeur(self):
        largeur = self.Deplacement.RenvoyerLatitude()
        return largeur
    
    def GetLabyrinthe(self):
        return self.GrilleLabyrinthe
    
    def SauvegarderPartie(self,NomSauvegarde):   
        CurrentDirectory = os.getcwd()
        os.chdir(CurrentDirectory + '\\ListePartie\\')
        
        with open(NomSauvegarde,"wb") as myFichier:
            monPickler = pickle.Pickler(myFichier)
            monPickler.dump(self.GrilleLabyrinthe)
    
    def ChargerPartie(self,Nomfichier):
        CurrentDirectory = os.getcwd()
        os.chdir(CurrentDirectory + '\\ListePartie\\')
        
        with open(Nomfichier,"rb") as myFichiers:
            monDe_Pickler = pickle.Unpickler(myFichiers)
            self.GrilleLabyrinthe =  monDe_Pickler.load()
        

    
 



