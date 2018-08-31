# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import random
import pylab as pl
from sklearn.cluster import KMeans

# Définition du répertoire par défaut
custom_data_home  = "E:\\Data\\RawData\\Clustering"

# Importation des données et mise en cache
from sklearn.datasets import fetch_mldata
mnist = fetch_mldata('MNIST original', data_home=custom_data_home)

# Restriction du dataset à une occurence sur 50
X = mnist.data[::50, :]
y = mnist.target[::50]

# Création de la liste des couleurs pour différencier les différents clusters
listeCouleurs = ['red',
                 'green',
                 'purple',
                 'yellow',
                 'pink',
                 'cyan',
                 'tomato',
                 'grey',
                 'goldenrod',
                 'darkkhaki']

# Initialisation de la matrice de représentation des points
coordonnees = np.zeros((y.shape[0],2))

# Sur le modèle des BoxPlot à nuage de points 
# On ajoute un bruit aléatoire à chacun des points 
# Pour pouvoir les différencier sur un plan euclidien    
for (x), value in np.ndenumerate(y):
    coordonnees[x][0] = random.random() + value
    coordonnees[x][1] = random.random() * 10 

# Intégration dans un DataFrame
coordonneesPoints = pd.DataFrame(coordonnees,columns=['Abscisse','Ordonnee'])

# Réalisation de la classificattion par K-means
KM = KMeans(n_clusters=10)

KM.fit(X)
labels = KM.labels_

# On affecte les classes prédites dans le DataFrame
coordonneesPoints["Classification"] = labels
coordonneesPoints["Couleur"] = coordonneesPoints["Classification"].map(lambda d: listeCouleurs[d])

# Définition de la légende des clusters affichés
print('-------------------- Légende des clusters représentés -------------------')
for (x),value in np.ndenumerate(np.array(listeCouleurs)):
    print('Le cluster {} est représentée par la couleur {}.'.format(x[0]+1,value))

# Afichage sous forme de nuage de points
plt.scatter(coordonneesPoints.Abscisse,
            coordonneesPoints.Ordonnee,
            color=coordonneesPoints.Couleur)

# Séparation de chaque catégorie de chiffre
for numero in range(1,10):
    plt.plot([numero, numero], [0, 10],
             color='black',
             linestyle='--',
             linewidth=2)

# Définition des légendes
plt.title("Représentation des points colorés selon leur cluster")
axes = plt.gca()
axes = axes.set(xlabel='N° du chiffre représentée par l\'image du point', 
                ylabel='Bruit aléatoire pour différencier les points')
pl.xticks(range(0,11))
plt.show()

# Calcul des scores
print('Le score de la classification K-mean est de {}'.format(round(KM.score(X,y),2)))
print('Le différentiel moyen par point de la classification K-mean est de {}.'.format(round(KM.score(X,y)/(y.shape[0]*128*128),2)))

    
    



