# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from matplotlib import offsetbox

from sklearn.datasets import fetch_olivetti_faces
from sklearn import (datasets, decomposition, ensemble,discriminant_analysis, random_projection)
from sklearn.manifold import TSNE

# Définition du répertoire par défaut
custom_data_home  = "E:\\Data\\RawData\\Clustering"

# Importation des données et mise en cache
from sklearn.datasets import fetch_mldata
mnist = fetch_mldata('MNIST original', data_home=custom_data_home)

# Restriction du dataset à une occurence sur 50
X = mnist.data[::50, :]
y = mnist.target[::50]

# On assigne les données source aux différents datasets
targets = y
data = X
# On transforme chaque vecteur en matrice 28x28 pour pouvoir l'afficher comme image
images = []
for ligne in X:
    images.append(np.reshape(ligne, (28, 28)))

# fonction pour afficher une partie des images du dataset en visualisation en 2 dimensions
def plot_embedding(X, title=None):
    x_min, x_max = np.min(X, 0), np.max(X, 0)
    X = (X - x_min) / (x_max - x_min)

    plt.figure(figsize=(15, 15))
    ax = plt.subplot(111)

    if hasattr(offsetbox, 'AnnotationBbox'):
        shown_images = np.array([[1., 1.]])
        for i in range(data.shape[0]):
            dist = np.sum((X[i] - shown_images) ** 2, 1)
            if np.min(dist) < 2e-3:
                continue

            shown_images = np.r_[shown_images, [X[i]]]
            props=dict(boxstyle='round', edgecolor='white')
            imagebox = offsetbox.AnnotationBbox(offsetbox.OffsetImage(images[i], cmap=plt.cm.gray, zoom=0.5), X[i], bboxprops=props)
            ax.add_artist(imagebox)

    if title is not None:
        plt.title(title)

# On exécute une heuristique de type t-Stochastic Neighbour Embedding
X_tsne = TSNE(n_components=2).fit_transform(data)

# On affiche les résultats retournés par l'heuristique TSNE
plot_embedding(X_tsne, "Affichage des images des chiffres scannés")
plt.show()

# Afin d'améliorer le résultat de notre heuristique TSNE
# On modifie le paramètre d'initialisation qui permet de
# Générer une analyse en composante principale en phase d'amarçage
# car l'algorithme a tendance à privilégier les optimas locaux au détriment de la structure globale
X_tsne = TSNE(n_components=2,init="pca").fit_transform(data)

# On affiche les nouveaux résultats retournés par l'heuristique TSNE - PCA
plot_embedding(X_tsne, "Affichage des images des chiffres scannés - version PCA init")
plt.show()





