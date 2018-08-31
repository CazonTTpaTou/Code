# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np 
import math
import matplotlib.pyplot as plt

from sklearn import preprocessing
from sklearn import decomposition
from sklearn import linear_model

# charger les données
data = pd.read_csv('E:\\Data\\RawData\\ACP\\Decathlon_C.txt', sep="\t",encoding = "ISO-8859-1")

# éliminer les colonnes que nous n'utiliserons pas
my_data = data.drop(['Points', 'Rank', 'Competition'], axis=1)
my_data = my_data.iloc[:,1:]
# transformer les données en array numpy
X = my_data.values

# Standardisation  des données
std_scale = preprocessing.StandardScaler().fit(X)
X_scaled = std_scale.transform(X)

# Calcul des deux premières composantes principales
pca = decomposition.PCA(n_components=2)
pca.fit(X_scaled)

print (pca.explained_variance_ratio_)
print (pca.explained_variance_ratio_.sum())


def Projection_CP():
    # projeter X sur les composantes principales
    X_projected = pca.transform(X_scaled)
    
    # afficher chaque observation
    # colorer en utilisant la variable 'Rank'
    plt.scatter(X_projected[:, 0], X_projected[:, 1], c=data.get('Rank'))
    
    plt.xlim([-5.5, 5.5])
    plt.ylim([-4, 4])
    plt.colorbar()

def Representation_CP():
# Représentation des composantes avec les coordonnées dans l'espace initial à 10 variables
    pcs = pca.components_
    
    for i, (x, y) in enumerate(zip(pcs[0, :], pcs[1, :])):
    
        # Afficher un segment de l'origine au point (x, y)
        plt.plot([0, x], [0, y], color='k')
    
        # Afficher le nom (data.columns[i]) de la performance
        plt.text(x, y, data.columns[i], fontsize='14')
    
    # Afficher une ligne horizontale y=0
    plt.plot([-0.7, 0.7], [0, 0], color='grey', ls='--')
    # Afficher une ligne verticale x=0
    plt.plot([0, 0], [-0.7, 0.7], color='grey', ls='--')
    
    plt.xlim([-0.7, 0.7])
    plt.ylim([-0.7, 0.7])
    
    axes = plt.axes()
    axes = axes.set(xlabel='PC1', ylabel='PC2')
    
#Projection_CP()
#Representation_CP()

# Calcul de composante principale
X = np.array([[0, 0], [1, 1], [2, 2], [3, 3], [0.5, 0.5], [1.5, 1.5], [2.5, 2.5]])

pca = decomposition.PCA(n_components=1)
pca.fit(X)

print (pca.components_)

