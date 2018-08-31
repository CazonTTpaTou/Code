# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 18:27:10 2017
Classe permettant de transformer un template de grille au format fichier texte en environnement de jeu labyrinthe
@author: fmonnery
"""
import os
import os.path
from Robot import robot
 
class grille:    
    
    """Propriétés structurelles de la classe grille """
    MyGrid = [[]]
    ListePositionLibre = []
    ListeRobot = []
    
    PositionRobotLigne = 1
    PositionRobotColonne = 0 
    
    LimiteHorizontale = 0
    LimiteVerticale = 0
    
    SortieAtteinte = False
    
    LigneSortie = 0
    LigneColonne = 0
    
    """Méthode d'initialisation de la classe """
    def __init__(self, MaGrille):
        self.MyGrid = [[]]
        self.ChargerGrille(MaGrille)
    
    """ Méthode pour déterminer le répertoire où rechercher les templates de grille de jeu """
    @staticmethod
    def PositionnerRepertoireCourant():
        CurrentDirectory = os.getcwd()
        RepertoryGrille = CurrentDirectory + '\\ListeGrille\\'
        if os.path.exists(RepertoryGrille):
            os.chdir(RepertoryGrille)
        else:
            os.chdir(CurrentDirectory)
    
    """Méthode pour charger les grilles de jeu de labyrinthe à partir d'un fichier texte"""
    def ChargerGrille(self,NomGrille):
        self.PositionnerRepertoireCourant()
                
        with open(NomGrille,'r') as MyFile:
            Tampon = MyFile.read()
        
            Ligne = [] 
      
            for carac in Tampon:                
                if carac=='\n': 
                    self.MyGrid.append(Ligne)
                    
                    if(self.LimiteVerticale==0):
                        self.LimiteHorizontale = len(Ligne)
                    
                    if(len(Ligne)>0):               
                        self.LimiteVerticale += 1  
                    
                    Ligne = []
                else:
                    Ligne.append(carac)                                           
    
    """ Méthode pour afficher à l'écran d'ordinateur la grille complète du labyrinthe de jeu """
    def ImprimerGrille(self):
        for ligne,colonne in enumerate(self.MyGrid):            
            Lig_Horizontale=''
            
            for caractere in colonne:
                Lig_Horizontale += caractere
                
            print (Lig_Horizontale)
   
    """Méthode pour envoyer une trame contenant le contenu de la grille par le biais d'une socket réseau """
    def EnvoyerGrille(self):
        Message=''
        for ligne,colonne in enumerate(self.MyGrid):            
            Lig_Horizontale=''
            
            for caractere in colonne:
                Lig_Horizontale += caractere
            
            Lig_Horizontale += '\n'
            Message += Lig_Horizontale
        
        return Message
    
    """Méthode pour lister les positions de départ possibles des robots pour de l'initialisation """
    def ListerPositionLibre(self):        
        for ligne,col in enumerate(self.MyGrid):     
            for colonne, elt in enumerate(col):
                if(self.MyGrid[ligne][colonne] == ' '):
                    self.ListePositionLibre.append([ligne,colonne])

    """Méthode permettant d'ajouter un robot dans la grille de jeu du début """
    def AjouterRobot(self,adresse,port):
        self.ListeRobot.append(robot(adresse,port))
        return len(self.ListeRobot)
    
    """Méthode permettant de renvoyer le numéro du robot associé à des identifiants de connexion adresse / n° de port """
    def RenvoyerNumeroRobotClient(self,adresse,port):
        identifiant = adresse + '-' + str(port)
        for rob in self.ListeRobot:
            if (rob.renvoyerIdentifiantRobot == identifiant):
                return identifiant
        
    
            
    
    
    
    