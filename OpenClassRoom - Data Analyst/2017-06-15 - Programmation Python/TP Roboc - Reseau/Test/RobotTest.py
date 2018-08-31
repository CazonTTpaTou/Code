# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 15:32:23 2017
Classe de test pour vérifier le bon fonctionnement de la classe Robot
@author: fmonnery
"""

import unittest
from Robot import robot

class RobotTest(unittest.TestCase):
        
     def test_getPositionLigneRobot(self):    
        rob = robot('100.122.4.4',52000) 
        rob.setPositionRobot(10,15)
        self.assertEqual(10,rob.getPositionLigneRobot())    
        
     def test_getPositionColonneRobot(self):    
        rob = robot('100.122.4.4',52000) 
        rob.setPositionRobot(10,15)
        self.assertEqual(15,rob.getPositionColonneRobot())
        
     def test_renvoyerNumeroRobot(self):
        rob3 = robot('100.122.4.4',52002)  
        rob4 = robot('100.122.4.4',52003) 
        rob5 = robot('100.122.4.4',52004) 
        self.assertEqual(5,rob5.renvoyerNumeroRobot())
        
unittest.main()

