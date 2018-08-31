# -*- coding: utf-8 -*-

import numpy as np
import scipy as sp

from scipy import fftpack
from scipy import interpolate
from matplotlib import pyplot as plt

###################################################################################
# Résolution équation linéaire
# A x = b

## x + 2 y = 1
## 3 x + 4 y = 2

b = np.array([1, 2])
A = np.array([[1, 2], [3, 4]])
print(b)
print(A)

A_inverse = np.linalg.inv(A)
print(A_inverse)

x = np.dot(A_inverse,b)
print(x)

#### Méthode alternative
x = np.linalg.solve(A, b)
print(x)

###################################################################################
#### Transformée de Fourier
# fréquence d’échantillonnage en Hz
fe = 100
# durée en seconde
T = 10
# Nombre de point :
N = T*fe
# Array temporel :
t = np.arange(1.,N)/fe
# fréquence du signal : Hz
f0 = 0.5
# signal temporel
sinus = np.sin(2*np.pi*f0*t)
# ajout de bruit
bruit = np.random.normal(0,0.5,N-1)
sinus2 = sinus + bruit
# signal fréquentiel : on divise par la taille du vecteur pour normaliser la fft
fourier = fftpack.fft(sinus2)/np.size(sinus2)
# axe fréquentiel:
axe_f = np.arange(0.,N-1)*fe/N
# On plot
plt.figure()
plt.subplot(121)
plt.plot(t,sinus2,'-')
plt.plot(t,sinus,'r-')
plt.xlabel('axe temporel, en seconde')
plt.subplot(122)
plt.plot(axe_f,np.abs(fourier),'x-')
plt.xlabel('axe frequentiels en Hertz')
plt.show()

###################################################################################
###### Interpolation
# 1ère courbe
t = np.arange(11)
sinus = np.sin(t)
# création de notre sous-fonction d'interpolation quadratique
F_sinus = interpolate.interp1d(t,sinus,kind='quadratic')
# second axe de temps sur lequel on interpolera
t2 = np.arange(0, 10, 0.5)
# Interpolation
sinus2 = F_sinus(t2)
# Affichage:
plt.plot(t, sinus, 'rx-') # RED
plt.plot(t2, sinus2, 'bd-') # BLUE
plt.show()


