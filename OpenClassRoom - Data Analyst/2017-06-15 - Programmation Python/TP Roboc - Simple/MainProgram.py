# -*- coding: utf-8 -*-
"""
Created on Tue Jun 13 17:40:48 2017

@author: fmonnery
"""
import datetime
import pickle
import os
import sys

from Fichier import fichier
from Partie import Partie

fichiers = fichier()
        
def SauvegarderPartie(partie):  
    """os.chdir("..")
    CurrentDirectory = os.getcwd()
    os.chdir(CurrentDirectory + '\\ListePartie\\')"""
    
    a = datetime.datetime.now()
    NomSauvegarde = '%s-%s-%s-%s:%s' % (a.year,a.month, a.day, a.hour,a.minute)
        
    with open(NomSauvegarde,"wb") as myFichier:
            monPickler = pickle.Pickler(myFichier)
            monPickler.dump(partie)
            
    with open('PartieCourante',"wb") as myFichier:
            monPickler = pickle.Pickler(myFichier)
            monPickler.dump(partie)
    
def ChargerPartie():
    """os.chdir("..")
    CurrentDirectory = os.getcwd()
    os.chdir(CurrentDirectory + '\\ListePartie\\')"""
    
    with open('PartieCourante',"rb") as myFichiers:
        monDe_Pickler = pickle.Unpickler(myFichiers)
        partie =  monDe_Pickler.load() 
    return partie

def IntroProposerReprendrePartie():
        try:
            fichiers.AfficherListePartie()
            partie = fichier.GetPartie(input('Saississez le numéro de la partie ?'))
            return partie
        except:
            print('Désolé, nous ne retrouvons pas vos anciennes parties !!')
            return None
  
def IntroProposerNouvelleGrille():
    try:
        fichiers.AfficherListeGrille()    
        return fichiers.GetGrille(input("Entrez votre numéro de grille :"))
    except:
        print ("La valeur que vous avez saisie est incorrecte et a généré l'exception suivante :", sys.exc_info()[0])
        PropositionRejouer()
        
def PropositionRejouer():
    if((input('Voulez vous rejouer O/N ?'))=='O'):
        IntroProposerNouvelleGrille()
    else:
        print('Au revoir ! Merci  pour votre participation!!')
        return None
      
def JouerPartieLabyrinthe(partie):
    
    partie.GrilleLabyrinthe.ImprimerGrille()
    print('Position du robot : ',partie.GrilleLabyrinthe.RenvoyerPositionRobot())
    ContinuerPartie = 'O'
                        
    while(ContinuerPartie=='O'):
        ContinuerPartie = partie.SaisieJoueur(input("Tapez votre choix de déplacement pour le robot (E@ / O@ / S@ / N@) :"))
        
        if (ContinuerPartie == 'N'):
            print('Enregistrement de la partie')
            print('A bientôt ! N''oubliez pas de vous reconnecter pour finir cette partie')
            
        if (ContinuerPartie=='F'):
            print('La partie est terminée !!')
            PropositionRejouer()                

if(input('Voulez vous rejouer une ancienne partie enregistrée O/N ?')=='O'):
    partie = Partie(IntroProposerNouvelleGrille())
    JouerPartieLabyrinthe(partie)
else:
    partie = Partie(IntroProposerNouvelleGrille())
    JouerPartieLabyrinthe(partie)



    





