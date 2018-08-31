class porte:

    EstPorteGagnante = False
    EstPorteFerme = True

    def __init__(self,estGagnante):
        self.EstPorteGagnante = estGagnante
        self.EstPorteFerme = True
    
    def OuvrirPorte(self):
        self.EstPorteFerme = False

    def RenvoyerSiEstPorteFerme(self):
        return self.EstPorteFerme

    def RenvoyerSiEstPorteGagnante(self):
        return self.EstPorteGagnante

