# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 16:09:57 2017
Classe de test pour vérifier le bon fonctionnement de la classe Mouvement
@author: fmonnery
"""

import unittest
from Mouvement import mouvement

class MouvementTest(unittest.TestCase):        
        
     def test_SeDeplacerEst(self):
        instruction = 'E5'
        MouvEst = mouvement()
        MouvEst.SeDeplacer(instruction)
        Deplacement = MouvEst.RenvoyerLatitude() + MouvEst.RenvoyerLongitude()
        self.assertEqual(5,Deplacement) 

     def test_SeDeplacerOuest(self):
        instruction = 'O7'
        MouvEst = mouvement()
        MouvEst.SeDeplacer(instruction)
        Deplacement = MouvEst.RenvoyerLatitude() + MouvEst.RenvoyerLongitude()
        self.assertEqual(-7,Deplacement) 

     def test_SeDeplacerNord(self):
        instruction = 'N3'
        MouvEst = mouvement()
        MouvEst.SeDeplacer(instruction)
        Deplacement = MouvEst.RenvoyerLatitude() + MouvEst.RenvoyerLongitude()
        self.assertEqual(-3,Deplacement) 

     def test_SeDeplacerSud(self):
        instruction = 'S6'
        MouvEst = mouvement()
        MouvEst.SeDeplacer(instruction)
        Deplacement = MouvEst.RenvoyerLatitude() + MouvEst.RenvoyerLongitude()
        self.assertEqual(6,Deplacement) 
                
unittest.main()



        
        
        