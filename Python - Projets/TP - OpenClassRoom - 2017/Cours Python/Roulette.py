# -*- coding: utf-8 -*-
"""
Created on Sun Mar 26 14:44:42 2017

@author: fmonnery
"""

import random

gain = 0

roulette = input('Votre chiffre ? ')
rouletteI = int(roulette)
mise = input('Votre mise ? ')
miseI = int(mise)

assert rouletteI >=0
assert rouletteI < 49
assert miseI >0

try:
    hasard = random.randrange(6)
    if rouletteI == hasard:
        gain = 3 * miseI
    elif rouletteI%2 == hasard%2:
        gain = 0.5 * miseI
    print('Votre gain : ',gain,' - le gagnant était : ',hasard)
    
except AssertionError:
    print("Valeur saisie incorrecte")
    

    