from MontyHall_Joueur import joueur
from MontyHall_Presentateur import presentateur
from MontyHall_Portes import portes
from numpy import random as rand

class partie:

    PartieGagnante = 0
    StrategieSuivie = False
    NumeroPorteGagnante = 0

    def __init__(self,joueur,presentateur):
        self.Joueur = joueur
        self.Presentateur = presentateur
        self.DefinitionPorteGagnante()

    def DefinitionPorteGagnante(self):
        self.NumeroPorteGagnante = rand.randint(3)

    def RenvoyerNumeroPorteGagnante(self):
        return self.NumeroPorteGagnante

    def DemarrerPartie(self):
        #print ("Le joueur a choisi la porte n° {}".format(self.Joueur.RenvoyerPorteChoisie()))
        part = portes(self.RenvoyerNumeroPorteGagnante())
        if(self.Joueur.RenvoyerDecisionChangerChoix()):
            part.ChoisirUnePortePerdanteFermee(self.Joueur.RenvoyerPorteChoisie(),self.Presentateur.RenvoyerPorteChoisie())
            part.ChoisirUneNouvellePorte(self.Joueur.RenvoyerPorteChoisie())
            self.PartieGagnante = int(part.EstChoixPorteJoueurGagnant())
        else:
            if(self.RenvoyerNumeroPorteGagnante()==self.Joueur.RenvoyerPorteChoisie()):
                self.PartieGagnante = 1
            else : self.PartieGagnante = 0

    def RenvoyerResultatPartie(self):
        #print("La partie a pour résultat: {}".format(self.PartieGagnante))
        return self.PartieGagnante

"""
p = partie(joueur(True),presentateur())
print("La porte gagnante est : {}".format(p.RenvoyerNumeroPorteGagnante()))
p.DemarrerPartie()
p.RenvoyerResultatPartie()

p = partie(joueur(False),presentateur())
print("La porte gagnante est : {}".format(p.RenvoyerNumeroPorteGagnante()))
p.DemarrerPartie()
p.RenvoyerResultatPartie()
"""





