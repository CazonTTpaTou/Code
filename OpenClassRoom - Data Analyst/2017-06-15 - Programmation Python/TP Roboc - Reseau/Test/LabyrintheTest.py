# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 17:01:36 2017
Classe de test pour vérifier le bon fonctionnement des différentes méthodes de la classe Labyrinthe
@author: fmonnery
"""


import unittest
from Labyrinthe import labyrinthe

class labyrintheTest(unittest.TestCase):
        
     def test_DesignerRobotActif(self):    
        laby = labyrinthe("Grille Facile.txt") 
        
        laby.AjouterRobot('100.122.4.4',52000)
        laby.AjouterRobot('100.122.4.4',52001)
        laby.AjouterRobot('100.122.4.4',52002)
        
        laby.DesignerRobotActif(2)        
        
        self.assertEqual(2,laby.NumeroRobotActif())  

     def test_NumerotationRobot(self):
         laby = labyrinthe("Grille Facile.txt") 
         
         laby.AjouterRobot('100.122.4.4',52000)
         laby.InitialiserPositionsRobots()
         laby.DesignerRobotActif(1)      
         laby.FaireDeplacerRobot(0,-1)
         laby.RobotActionMurer(0,1)
         
         positionX = laby.RenvoyerPositionRobot()[1]
         positionY = laby.RenvoyerPositionRobot()[0]
         
         Obstacle = laby.RenvoyerContenuPosition(positionX,positionY)
         
         self.assertEqual('1',Obstacle) 

     def test_RobotActionMurer(self):
         laby = labyrinthe("Grille Facile.txt") 
         
         
         
         laby.AjouterRobot('100.122.4.4',52000)
         laby.InitialiserPositionsRobots()
         laby.DesignerRobotActif(1)      
         laby.TracerPositionRobot(5,5)
         
         positionX = laby.RenvoyerPositionRobot()[1]
         positionY = laby.RenvoyerPositionRobot()[0]
         
         Contenu = laby.RenvoyerContenuPosition(positionX,positionY)
         
         laby.RobotActionMurer(0,1)
         laby.RobotActionMurer(0,-1)
         laby.RobotActionMurer(1,0)
         laby.RobotActionMurer(-1,0)

         Obstacle = laby.RenvoyerContenuPosition(positionX,positionY)
                  
         self.assertEqual(Contenu,Obstacle) 

     def test_RobotActionPercer(self):
         laby = labyrinthe("Grille Facile.txt") 
         
         laby.AjouterRobot('100.122.4.4',52000)
         laby.InitialiserPositionsRobots()
         laby.DesignerRobotActif(1)      
         laby.TracerPositionRobot(5,5)
         
         positionX = laby.RenvoyerPositionRobot()[1]
         positionY = laby.RenvoyerPositionRobot()[0]
         
         Contenu = laby.RenvoyerContenuPosition(positionX,positionY)
         
         laby.RobotActionMurer(0,1)
         laby.RobotActionMurer(0,-1)
         laby.RobotActionMurer(1,0)
         laby.RobotActionMurer(-1,0)
         
         laby.RobotActionPercer(0,1)
         laby.RobotActionPercer(0,-1)
         laby.RobotActionPercer(1,0)
         laby.RobotActionPercer(-1,0)         
         
         Obstacle = laby.RenvoyerContenuPosition(positionX,positionY)
         
         self.assertEqual(Contenu,Obstacle) 
                 
unittest.main()




