from MontyHall_Porte import porte
import numpy as np
from numpy import random as rand

class portes:

    def __init__(self,numeroPorteGagnante):  

        if (numeroPorteGagnante) == 0:
                self.Porte1 = porte(True)
        else : self.Porte1 = porte(False)

        if (numeroPorteGagnante) == 1:
                self.Porte2 = porte(True)
        else : self.Porte2 = porte(False)

        if (numeroPorteGagnante) == 2:
                self.Porte3 = porte(True)
        else : self.Porte3 = porte(False)

        self.Les3Portes = np.array([[0,0,0],[0,0,0]])

    def ConversionBooleanInteger(self,bool):
        if bool :
            return 1
        else :
            return 0

    def ConversionDes3PortesEnTableau(self):
        self.Les3Portes[0,0] = self.ConversionBooleanInteger(self.Porte1.RenvoyerSiEstPorteGagnante())
        self.Les3Portes[0,1] = self.ConversionBooleanInteger(self.Porte2.RenvoyerSiEstPorteGagnante())
        self.Les3Portes[0,2] = self.ConversionBooleanInteger(self.Porte3.RenvoyerSiEstPorteGagnante())

        self.Les3Portes[1,0] = self.ConversionBooleanInteger(self.Porte1.RenvoyerSiEstPorteFerme())
        self.Les3Portes[1,1] = self.ConversionBooleanInteger(self.Porte2.RenvoyerSiEstPorteFerme())
        self.Les3Portes[1,2] = self.ConversionBooleanInteger(self.Porte3.RenvoyerSiEstPorteFerme())

    def ChoisirUnePortePerdanteFermee(self,numeroPorteJ,numeroPorteP):
        numeroPorteJoueur = numeroPorteJ + 1
        numeroPortePresentateur = numeroPorteP + 1

        if (numeroPorteJoueur==1):
            if(numeroPortePresentateur==1):
                if(self.Porte2.RenvoyerSiEstPorteGagnante()):
                    self.Porte3.OuvrirPorte()
                else: self.Porte2.OuvrirPorte()
            if(numeroPortePresentateur==2):
                if(self.Porte3.RenvoyerSiEstPorteGagnante()):
                    self.Porte2.OuvrirPorte()
                else: self.Porte3.OuvrirPorte()

        if (numeroPorteJoueur==2):
            if(numeroPortePresentateur==1):
                if(self.Porte1.RenvoyerSiEstPorteGagnante()):
                    self.Porte3.OuvrirPorte()
                else: self.Porte1.OuvrirPorte()
            if(numeroPortePresentateur==2):
                if(self.Porte3.RenvoyerSiEstPorteGagnante()):
                    self.Porte1.OuvrirPorte()
                else: self.Porte3.OuvrirPorte()

        if (numeroPorteJoueur==3):
            if(numeroPortePresentateur==1):
                if(self.Porte1.RenvoyerSiEstPorteGagnante()):
                    self.Porte2.OuvrirPorte()
                else: self.Porte1.OuvrirPorte()
            if(numeroPortePresentateur==2):
                if(self.Porte2.RenvoyerSiEstPorteGagnante()):
                    self.Porte1.OuvrirPorte()
                else: self.Porte2.OuvrirPorte()
                
        self.ConversionDes3PortesEnTableau()

    def ChoisirUneNouvellePorte(self,numeroPorteJoueur):
        if(numeroPorteJoueur==0):
            self.Porte1.OuvrirPorte()
        if(numeroPorteJoueur==1):
            self.Porte2.OuvrirPorte()  
        if(numeroPorteJoueur==2):
            self.Porte3.OuvrirPorte()   

        self.ConversionDes3PortesEnTableau()
        #self.impression()

    def EstChoixPorteJoueurGagnant(self):
        if(np.array([np.sum(self.Les3Portes[:,0]),np.sum(self.Les3Portes[:,1]),np.sum(self.Les3Portes[:,2])]).max()==2):
            return True
        else : return False

    def impression(self):
        print(self.Les3Portes)



