# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from scipy.cluster.hierarchy import dendrogram, linkage, fcluster

# Définition du répertoire par défaut
custom_data_home  = "E:\\Data\\RawData\\Clustering"

# Importation des données et mise en cache
from sklearn.datasets import fetch_mldata
mnist = fetch_mldata('MNIST original', data_home=custom_data_home)

# Vérification de la cohérence des données
print('Taille du dataset : {}'.format(mnist.data.shape))
print('Taille des prédictions : {}'.format(mnist.target.shape))
print('Nombre de valeurs uniques prédites : {}'.format(np.unique(mnist.target)))

# Restriction du dataset à une occurence sur 50
X = mnist.data[::50, :]
y = mnist.target[::50]

sample_idx = 42
sample_image = np.reshape(X[sample_idx, :], (28, 28))
#plt.imshow(sample_image, cmap='binary')

print(y[sample_idx])

#générer la matrice des liens
Z = linkage(X,method='ward',metric='euclidean')

#affichage du dendrogramme
plt.title("Classification Ascendante Hiérarchique")
dendrogram(Z,labels=y,orientation='left',color_threshold=0)
plt.plot([10500, 10500], [0, 14000],
         color='red',
         linestyle='--',
         linewidth=3,
         label="Intersection pour n=10")
plt.legend(loc='upper left');
plt.show()

# Détermination des groupes
groupes_cah = fcluster(Z,t=10500,criterion='distance')

# Création du tableau de données
df = pd.DataFrame({'population': y, 'groupe': groupes_cah-1})
df["Delta"] = df["population"]- df["groupe"]


# Calcul du taux de pertinence de classification
df["Deltas"] = [1 if data == 0 else 0 for data in df["Delta"]]
taux_classification_correcte = df["Deltas"].mean()*100

print('Le tauw de pertinence de la classification est de : {} % '.format(round(taux_classification_correcte,2)))

# Affichage des points en fonction de leur valeur d'origine et de leur groupe
plt.scatter(df.population,df.groupe,color='green')
plt.plot([0,9],[0,9],color='red',linestyle='--')
plt.show()

# Calcul des effectis de chaque paire (valeur origine , valeur classifiée )
df["Taille"] = df["Deltas"]
Resultats = np.zeros((10,10))

for ligne in df.iterrows():
    index_ligne = ligne[0]
    valeur_origine = int(ligne[1]["population"])
    valeur_groupe = int(ligne[1]["groupe"])
    Resultats[valeur_origine,valeur_groupe] += 1

print(Resultats)

# Assignation à chaque point de son effectif de classe
for ligne in df.iterrows():    
    index_ligne = ligne[0]
    valeur_origine = int(ligne[1]["population"])
    valeur_groupe = int(ligne[1]["groupe"])
    df.iloc[index_ligne,4] = Resultats[valeur_origine,valeur_groupe]
    #for (x,y), value in np.ndenumerate(Resultats):
    #df["Taille"][ = Resultats[x,y]    

# Représentation du graphique à bulles
plt.scatter(df.population, df.groupe, s=df.Taille*1, alpha=0.5)
plt.plot([0,9],[0,9],color='red',linewidth=2,linestyle='--')
plt.show()


"""
import plotly.plotly as py
import plotly.graph_objs as go

trace0 = go.Scatter(
    x=df.population,
    y=df.groupe,
    mode='markers',
    marker=dict(
        size=df.Taille,
    )
)

data = [trace0]
py.plot(data, filename='bubblechart-size')





#☺print(Z.shape)
#print(Z)

X = [[i] for i in [2, 8, 0, 4, 1, 9, 9, 0]]

Z = linkage(X, 'ward')
fig = plt.figure(figsize=(25, 10))
dn = dendrogram(Z,labels=X,orientation='left')
plt.show()
print(Z)

#découpage à la hauteur t = 7 ==> identifiants de 4 groupes obtenus
groupes_cah = fcluster(Z,t=2,criterion='distance')
print(groupes_cah)

#index triés des groupes
idg= np.argsort(groupes_cah)
#affichage des observations et leurs groupes
print(idg)
#print(X[idg])
print(groupes_cah[idg])

tab=[]

for i in X:
    tab.append(i[0])

df = pd.DataFrame({'population': tab, 'groupe': groupes_cah})
"""

