# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 15:30:08 2017
Classe de test pour vérifier le bon fonctionnement de la classe Partie
@author: fmonnery
"""
import unittest
from Partie import Partie

class PartieTest(unittest.TestCase):
        
     def test_InscriptionJoueurs(self):  
        PartieTest = Partie("Grille Facile.txt") 
        
        ListeJoueur = []
        ListeJoueur.append([1,['100.122.4.4',52000]])
        ListeJoueur.append([2,['100.122.4.4',52001]])
        
        PartieTest.ListeJoueurRobot = {}
        
        for joueur in ListeJoueur:
            NbreRobot = PartieTest.GrilleLabyrinthe.AjouterRobot(joueur[0],joueur[1])        
        
        PartieTest.GrilleLabyrinthe.InitialiserPositionsRobots()
        
        nbre_robot = len(PartieTest.GrilleLabyrinthe.ListeRobot)
        
        self.assertEqual(NbreRobot,nbre_robot) 
        
unittest.main()

