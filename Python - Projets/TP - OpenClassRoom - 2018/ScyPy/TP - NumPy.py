# -*- coding: utf-8 -*-

import numpy as np

tableau_de_zero = np.zeros((2, 3), dtype='i')
print("Tableau de zeros : {}".format(tableau_de_zero))

tableau_de_zero = np.zeros((2, 3), dtype='f')
print("Tableau de zeros : {}".format(tableau_de_zero))

tableau_de_un = np.ones((2, 3), dtype='f')
print("Tableau de un : {}".format(tableau_de_un))

tableau_de_vide = np.empty((3, 3), dtype='f')
print("Tableau de vide : {}".format(tableau_de_vide))

matrice_identite = np.identity((3), dtype='f')
print("Matrice identité : {}".format(matrice_identite))

# Tableau sur 3 lignes
tableau = np.array([[3, 2, 1], [4, 5, 6], [9, 8, 7]]) 
print (tableau)

# Conversion liste en array
liste = [1,2,3]
print(liste)
n = np.array(liste)
print(n)

# Création d'intervalles
intervalle = np.arange(1,21,1)
print(intervalle)

# Valeurs réparties
repartition = np.linspace(0,20,3)
print(repartition)

# Valeurs aléatoires
tab = np.random.normal(0,1,(4,4))
print(tab)
print(tab.shape)
print(tab.size)

# Opérations sur tableaux
add = tab + 2
print(add)
mult = add * tab
print(mult)
expo = np.exp(tab)
print(expo)
sinus = np.sin(tab)
print(sinus)
maxi=np.max(tab)
print(maxi)
mini=np.min(tab)
print(mini)

# Produit matriciel
mat = np.dot(tab,add)
print(mat)

# Tri du tableau
tri = np.sort(mat)
print(tri)

# Transposition
print(tab.transpose())
print(tab.T)

# Applatissement
print(tab.flat[:])

# Redimmensionnement
print(tab.reshape(2,8))




