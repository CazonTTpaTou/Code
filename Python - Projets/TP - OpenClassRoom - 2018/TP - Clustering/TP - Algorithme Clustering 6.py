# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

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

# Réalisation de la classificattion par K-means
KM = KMeans(n_clusters=10,init='k-means++')

KM.fit(X)
labels = KM.labels_

# Initialisation de la matrice de représentation des points
coordonnees = np.zeros((y.shape[0],1))

# Sur le modèle des BoxPlot à nuage de points 
# On ajoute un bruit aléatoire à chacun des points 
# Pour pouvoir les différencier sur un plan euclidien    
for (x), value in np.ndenumerate(y):
    #coordonnees[x][0] =  x[0]
    coordonnees[x][0] = value 

# Intégration dans un DataFrame
coordonneesPoints = pd.DataFrame(coordonnees,columns=['Groupe'])
#coordonneesPoints.drop(['Numero'],axis=1)

# On affecte les classes prédites dans le DataFrame
coordonneesPoints["Classification"] = labels

# On va utiliser legroupe d'origine comme nouvel index de nos données
ClassementGroupe = coordonneesPoints.set_index('Groupe')

# On va désormais calculer la variabilité des affectations cluster au sein de chaque groupe
# Cette dispersion doit être faible si la classification est homogène et donc pertinente
print('Variance des affectations de clusters par groupe : ')
print(ClassementGroupe.var(axis=0,level='Groupe'))

print('Ecart-type des affectations de clusters par groupe : ')
print(ClassementGroupe.std(axis=0,level='Groupe'))

abscisse = []
ordonnee = []

for data in ClassementGroupe.std(axis=0,level='Groupe').iterrows():
    abscisse.append(data[0])
    ordonnee.append(data[1][0])

#Affichage des éartts types par groupe d'origine
plt.barh(abscisse,
              ordonnee,
              color="#318CE7")

# Définition des légendes
plt.title("Variabilité des affectations de cluster au sein de chaque classe")
axes = plt.gca()
axes = axes.set(xlabel='Ecart type des numéros de cluster affecté au sein du groupe', 
                ylabel='N° des groupes d\'origine (chiffre reprsenté)')

pl.yticks(range(0,10))

#Affichage du graphique
plt.show()




       

