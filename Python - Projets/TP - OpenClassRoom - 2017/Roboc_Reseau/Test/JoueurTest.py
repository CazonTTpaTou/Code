# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 16:47:23 2017
Classe de test pour vérifier le bon fonctionnement de la classe Joueur
@author: fmonnery
"""

import unittest
from Joueur import joueur

class JoueurTest(unittest.TestCase):
        
     def test_renvoyerIdentifiantJoueur(self):    
        player = joueur('100.122.4.4',52000) 
        numID = player.renvoyerIdentifiantJoueur()
        
        self.assertEqual('100.122.4.4-52000',numID)  
        
unittest.main()

        