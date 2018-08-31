import numpy as np
from enum import Enum

# Ici nous définissons une sous-classe de Enum, qui contiendra 
# les stratégies possibles.
class Strategie(Enum):
    CHANGER = 1
    GARDER = 2

def play(strategie, nb_tours):
    # On choisit au hasard la bonne porte
    bonne_porte = np.random.randint(3,size=nb_tours)
    # On choisit au hasard le premier choix
    premier_choix = np.random.randint(3,size=nb_tours)
    # On definit des masques egalite et nonegalite
    egalite   = (bonne_porte == premier_choix)
    nonegalite = (bonne_porte != premier_choix)
    # Cas: On garde sur le premier choix
    if strategie == Strategie.GARDER:
        # Astuce : Conversion tableau de booleen en tableau d'entier par la multiplication par 1
        tableau_des_gains = egalite * 1
    # Cas: On change de choix
    # Dans le cas, si le premier_choix était bon, le second sera forcement mauvais
    # Par contre si le premier_choix était mauvais, le second sera forcement bon car
    # comme une des deux portes contient la bonne porte et que la mauvaise est ouverte
    # il ne reste que la bonne porte
    elif  strategie == Strategie.CHANGER:
        # Astuce : Conversion tableau de booleen en tableau d'entier par la multiplication par 1
        tableau_des_gains = nonegalite * 1
    else:
        raise ValueError("Stratégie non reconnue!")
    return tableau_des_gains
