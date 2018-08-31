# -*- coding: utf-8 -*-
"""
Created on Fri Mar 30 17:36:03 2018

@author: monne
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import random
import pylab as pl
from sklearn.cluster import KMeans

from sklearn import preprocessing
from sklearn import decomposition
from sklearn import linear_model

# Définition du répertoire par défaut
custom_data_home  = "E:\\Data\\RawData\\Clustering"

# Importation des données et mise en cache
from sklearn.datasets import fetch_mldata
mnist = fetch_mldata('MNIST original', data_home=custom_data_home)

# Restriction du dataset à une occurence sur 50
X = mnist.data[::50, :]
y = mnist.target[::50]

# Réalisation de la classificattion par K-means
KM = KMeans(n_clusters=10)
KM.fit(X)

# On réalise une analyse en composantes principales
# pour pouvoir représenter nos points dans un espace en 2 dimensions

# Standardisation  des données
std_scale = preprocessing.StandardScaler().fit(X)
X_scaled = std_scale.transform(X)

# Calcul des deux premières composantes principales
pca = decomposition.PCA(n_components=2)
pca.fit(X_scaled)

# On projette les points sur les 2 axes des composantes principales
Dimensions = pca.transform(X_scaled)

# Intégration dans un DataFrame
coordonneesPoints = pd.DataFrame(Dimensions,columns=['Abscisse','Ordonnee'])
# On rajoute legrouped'origine (chiffre représenté) de chaque point
coordonneesPoints['Groupe'] = y

# Représentation des points projetés sur les 2 dimensions des composantes principales
# Définition des légendes
plt.title("Représentation des points projetés sur les 2 premiers axes de l'ACP")
axes = plt.gca()
axes = axes.set(xlabel='Première composante principale', 
                ylabel='Seconde composante principale')
# On affiche la représentation
plt.scatter(coordonneesPoints.Abscisse,coordonneesPoints.Ordonnee,c=coordonneesPoints.get('Groupe'))
plt.colorbar()
plt.show()

# On représente désormais chaque point avec ses coordonnées après ACP
# Avec comme libellé, le chiffre représenté
# Et en nuance de gris le numéro du cluster que la classification K-Man lui a affecté 

# Ajustement des limites des axes
plt.xlim([-0.5, 1])
plt.ylim([-0.751, 1])
plt.title('Représentation des points avec libellé du chiffre colorisé par son cluster d\'appartenance')
axes = plt.gca()
axes = axes.set(xlabel='Première composante principale', 
                ylabel='Seconde composante principale')

# Détermination dulibellé et de la couleur de chaque point
for ligne in range(0,Dimensions.shape[0]):
    plt.text(
            Dimensions[ligne][0]/25, 
            Dimensions[ligne][1]/25, 
            str('%d' % y[ligne]),  
            color=plt.cm.Set2(KM.labels_[ligne]/10.),
            fontsize=10
            )
plt.show()


