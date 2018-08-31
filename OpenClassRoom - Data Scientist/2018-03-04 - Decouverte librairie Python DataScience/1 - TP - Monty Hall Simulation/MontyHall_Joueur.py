from numpy import random as rand

class joueur:

    ChoixPorteInitial = 0
    DecisionChangerChoix = False

    def __init__(self, strategie):
        self.ChoisirStrategie(strategie)
        self.ChoisirPorteInitiale()

    def ChoisirStrategie(self,strategie):
        self.DecisionChangerChoix = strategie

    def ChoisirPorteInitiale(self):
        self.ChoixPorteInitial = rand.randint(3)
    
    def RenvoyerPorteChoisie(self):
        return self.ChoixPorteInitial

    def RenvoyerDecisionChangerChoix(self):
        return self.DecisionChangerChoix

