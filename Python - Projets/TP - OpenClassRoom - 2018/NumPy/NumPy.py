# -*- coding: utf-8 -*-
"""
Created on Tue Mar  6 16:18:08 2018

@author: monne
"""

import numpy as np

# Creation d'un tableau avec définition du type
np.array([1,2,3,4,5],dtype='float32')
# Remplissage d'un tableau 
np.array([range(i,i+3) for i in [2,4,6]])
# Un tableau de longueur 10, rempli d'entiers qui valent 0
np.zeros(10, dtype=int)
# Un tableau de taille 3x5 rempli de nombres à virgule flottante de valeur 1
np.ones((3, 5), dtype=float)
# Un tableau 3x5 rempli de 3,14
np.full((3, 5), 3.14)
# Un tableau rempli d'une séquence linéaire
# commençant à 0 et qui se termine à 20, avec un pas de 2
np.arange(0, 20, 2)
# Un tableau de 5 valeurs, espacées uniformément entre 0 et 1
np.linspace(0, 1, 5)
# Celle-ci vous la conaissez déjà! Essayez aussi "randint" et "normal"
np.random.randint(5,7,[2,5])
# La matrice identité de taille 3x3 
np.eye(3)

np.random.seed(0)
x1 = np.random.randint(10, size=6)  # Tableau de dimension 1
print("nombre de dimensions de x1: ", x1.ndim)
print("forme de x1: ", x1.shape)
print("taille de x1: ", x1.size)
print("type de x1: ", x1.dtype)

# Pour accéder au premier élément
print(x1[0])
# Pour accéder au dernier élément
print(x1[-1])
x2 = np.random.randint(10, size=(3, 4))  # Tableau de dimension 2
print(x2[0,1])

x1 = np.array([range(i,i+10) for i in [1]])
print(x1[:5])  # Les cinq premiers éléments
print(x1[5:])  # Les éléments à partir de l'index 5
print(x1[::2])  # Un élément sur deux

# Inversion du tableau
x1[::-1]

x2[0,:] # La première ligne
x2[:,0] # La première colonne

# Concaténation
x = np.array([1, 2, 3])
y = np.array([3, 2, 1])
np.concatenate([x, y])

#Opérations arithmétiques sur lestableaux
# Il y a tout d'abord des opération mathématiques simples
x = np.arange(4)
print("x     =", x)
print("x + 5 =", x + 5)
print("x - 5 =", x - 5)
print("x * 2 =", x * 2)
print("x / 2 =", x / 2)
print("x // 2 =", x // 2)  # Division avec arrondi

# Opérations mathématiques
x = [-2, -1, 1, 2]
print("La valeur absolue: ", np.abs(x))
print("Exponentielle: ", np.exp(x))
print("Logarithme: ", np.log(np.abs(x)))

# Opérations booléennes
np.random.rand(3,3)
np.where(x >0.5)

# Agrégation
L = np.random.random(100)
np.sum(L)
np.max(L)
np.min(L)

# Notez la syntax variable.fonction au lieu de # np.fonction(variable)
M = np.random.random((3, 4))
print(M)
print("La somme de tous les éléments de M: ", M.sum())
print("Les sommes des colonnes de M: ", M.sum(axis=0))
# Ecart Type
print(M.std())
# index du minimum
print(M.argmin())
# index du minimum pour chaque colonne
print(M.argmin(axis=0))
# index du minimum pour chaque ligne
print(M.argmin(axis=1))
# Calcul de percentiles
print(np.percentile(M,0.75))

# Broadcasting
M = np.ones((3, 3))
print("M vaut: \n", M)
print("M+ 5 vaut: \n", M+5)

# La ligne suivante crée une matrice de taille 3x1 avec trois lignes et une colonne.
a = np.arange(3)
b = np.arange(3)[:, np.newaxis]
print(a)
print(b)
print(a+b)

# Utilisation de masques
np.random.seed(3)
a = np.random.randint(0, 21, 15)
print(a)
(a % 3 == 0)
mask = (a % 3 == 0)
extract_from_a = a[mask] # or, a[a%3==0]
print(extract_from_a)  # extract a sub-array with the mask

# Assign new values to index
a[a % 3 == 0] = -1
print(a)




