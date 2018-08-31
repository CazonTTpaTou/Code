from numpy import random as rand

class presentateur:

    def __init__(self):
        self.ChoisirUnePorteAuHasard()

    def ChoisirUnePorteAuHasard(self):
        self.ChoixPortePresentateur = rand.randint(2)
    
    def RenvoyerPorteChoisie(self):
        return self.ChoixPortePresentateur



