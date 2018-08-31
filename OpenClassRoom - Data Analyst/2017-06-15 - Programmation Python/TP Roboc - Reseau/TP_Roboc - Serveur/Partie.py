# -*- coding: utf-8 -*-
"""
Created on Tue Jun 13 12:27:40 2017
Classe permettant de piloter une partie de jeu du labyrinthe et coordonnant l'ensemble des classes de l'application
@author: fmonnery
"""
import re
from Mouvement import mouvement
from Labyrinthe import labyrinthe
from Serveur import serveur

class Partie:
    
    """Expressions régulières permettant de vérifier la cohérences des 3 types d'instruction possibles dans le jeu """
    ExpressionRegDeplacement=r"^[NESOneso]{1}[0-9]{1}$"
    ExpressionRegPercer=r"^[Pp]{1}[NESOneso]{1}$"
    ExpressionRegMurer=r"^[Mm]{1}[NESOneso]{1}$"
    
    """ Méthode d'initialisation de la classe """                          
    def __init__(self,nomGrille):
        self.GrilleLabyrinthe = labyrinthe(nomGrille)
        self.FinPartie = False
        self.Gagnant = 0
        self.serv = serveur('',12800) 

    """ Méthode permettant de gérer l'inscription des joueurs au fur à mesure des connexions clients"""                                  
    def InscriptionJoueurs(self):    
        ListeJoueur = list(set(self.serv.InscriptionConnexion()))
        self.ListeJoueurRobot = {}
        
        for joueur in ListeJoueur:
            self.ListeJoueurRobot[joueur] = self.GrilleLabyrinthe.AjouterRobot(joueur[0],joueur[1])        
        
        self.GrilleLabyrinthe.InitialiserPositionsRobots()
        self.GrilleLabyrinthe.ImprimerGrille()
        self.serv.EnvoyerMessageClient(str.encode(self.GrilleLabyrinthe.EnvoyerGrille()))        
        
    """ Méthode permettent de lancer la partie de labyrinthe roboc en réseau """                              
    def JouerPartieReseau(self):
        instructionJeu = ''
        
        while((instructionJeu != 'fin') and (not self.EstPartieFinie())):
            instructionJoueur = self.serv.EcouteInstructionJoueur()
            NumRobot = self.ListeJoueurRobot[instructionJoueur[0]]
            instructionJeu = instructionJoueur[1]
            self.SaisieJoueur(NumRobot,instructionJeu)
        
        if (self.GrilleLabyrinthe.RenvoyerRobotGagnant() == 0):
            messageFin = 'Pas de gagnant - Merci pour votre aimable participation !!!'
            
        else:
            messageFin = '--------------- Notre grand gagnant est le robot ' + str(self.GrilleLabyrinthe.RenvoyerRobotGagnant())
            messageFin += '\n'
            messageFin += '-------------- Bravo Robot ' + str(self.GrilleLabyrinthe.RenvoyerRobotGagnant()) + ' !!! ------------------------------'
            
        print(messageFin)
        self.serv.EnvoyerMessageClient(str.encode(messageFin))
        self.FinPartieReseau()        
    
    """ Méthode permettant de gérer proprement les déconnexions en fin de partie """                              
    def FinPartieReseau(self):
        MsgFinal = self.serv.EcouteInstructionJoueur()
        
        if (MsgFinal[1] == 'fin'):
                self.serv.FermetureConnexion()
        else:
                self.serv.EnvoyerMessageClient(str.encode('Veuillez taper fin pour quitter le jeu : '))
                self.FinPartieReseau()
        
    """ Méthode permettant de router les actions en fonction des instructions saisies par le joueur"""                              
    def SaisieJoueur(self,joueur,texte):

        self.GrilleLabyrinthe.DesignerRobotActif(joueur)
        
        if (re.match(self.ExpressionRegDeplacement,texte)) :
            Deplacement = mouvement()
            Deplacement.SeDeplacer(texte)    
            
            self.GrilleLabyrinthe.FaireDeplacerRobot(Deplacement.RenvoyerLongitude(),Deplacement.RenvoyerLatitude())            
            self.GrilleLabyrinthe.ImprimerGrille()
            self.serv.EnvoyerMessageClient(str.encode(self.GrilleLabyrinthe.EnvoyerGrille()))

            self.FinPartie = self.GrilleLabyrinthe.EstPartieTerminee()
            self.Gagnant = self.GrilleLabyrinthe.RenvoyerRobotGagnant()
            
        elif (re.match(self.ExpressionRegPercer,texte)):
            ActionPercer = mouvement()
            ActionPercer.PercerMurer(texte) 
            
            self.GrilleLabyrinthe.RobotActionPercer(ActionPercer.RenvoyerLongitude(),ActionPercer.RenvoyerLatitude())
            self.GrilleLabyrinthe.ImprimerGrille()
            self.serv.EnvoyerMessageClient(str.encode(self.GrilleLabyrinthe.EnvoyerGrille()))
            
        elif (re.match(self.ExpressionRegMurer,texte)):            
            ActionMurer = mouvement()
            ActionMurer.PercerMurer(texte) 
            
            self.GrilleLabyrinthe.RobotActionMurer(ActionMurer.RenvoyerLongitude(),ActionMurer.RenvoyerLatitude())
            self.GrilleLabyrinthe.ImprimerGrille()
            self.serv.EnvoyerMessageClient(str.encode(self.GrilleLabyrinthe.EnvoyerGrille()))
            
        elif (texte.upper()=='Q'):
            self.FinPartie = True
            
        else:
            message = 'Instructions non reconnues - en conséquence aucune action effectuée...'
            print(message)
            self.serv.EnvoyerMessageClient(str.encode(message))
            self.serv.EnvoyerMessageClient(str.encode(self.GrilleLabyrinthe.EnvoyerGrille()))
    
    """ Méthode renvoyant un snapchot du labyrinthe en cours de jeu"""                                                                  
    def GetLabyrinthe(self):
        return self.GrilleLabyrinthe
    
    """ Méthode permettant de déterminer si la partie est terminée ou non"""                          
    def EstPartieFinie(self):
        self.FinPartie = self.GrilleLabyrinthe.EstPartieTerminee()
        return self.FinPartie
    
    """ Méthode permettant de déterminer le numéro du robot ayant gagné la partie"""                          
    def GetRobotGagnant(self):
        return self.Gagnant
    


        
        
    
    

        

    
 



