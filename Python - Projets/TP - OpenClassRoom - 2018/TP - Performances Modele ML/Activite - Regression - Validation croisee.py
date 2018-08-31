## -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import pylab as pl
import collections

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors
from sklearn import metrics
from sklearn import dummy

# Importation de notre classe personnelle de classification par validation croisée
from Validation_Croisee_Regression import ValidationCroiseeRegression

# Configuration des paramètres
filePath = 'E:\Data\RawData\ClassificationVin\winequality-red.csv'
nombre_Folds = 5
hyperparametres = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15, 18, 21]}

# Classification avec notre propre bibliothèque de validation croisée de classification
print('--------------------------------------------------------------------------------')
print('------- Validation croisée avec notre propre bibliothèque ----------------------')
print('--------------------------------------------------------------------------------')
validation_Custom = ValidationCroiseeRegression(filePath,5,hyperparametres)
Classifieur_Custom = validation_Custom.evaluation_HyperParametres()
print('--------------------------------------------------------------------------------')
print('Les hyper-paramètres donnant le meilleur score sont les suivants : {}'.format(validation_Custom.renvoyer_Meilleur_Parametre()))
print('--------------------------------------------------------------------------------')
print('Le meilleur RMSE obtenu après validation croisée des K-folds et hyperparamètres est le suivant : {}'.format(validation_Custom.renvoyer_Meilleur_Score()[0]))
print('--------------------------------------------------------------------------------')
print('Le meilleur coefficient de détermination obtenu avec cet hyperparamètre est le suivant : {}'.format(validation_Custom.renvoyer_Meilleur_Score()[1]))
print('--------------------------------------------------------------------------------')
print('Le meilleur coefficient de corrélation de Pearson obtenu avec cet hyperparamètre est le suivant : {}'.format(validation_Custom.renvoyer_Meilleur_Score()[2]))
print('--------------------------------------------------------------------------------')

###############################################################################################

# On récupère les résultats pour chacun des hyperparamètres testés
resultats = validation_Custom.renvoyer_Resultats()

abscisse = np.array([3, 5, 7, 9, 11, 13, 15,18,21])

ordonnee_RMSE = np.array(resultats['RMSE'])
ordonnee_Coeff_R2 = np.array(resultats['R-carré'])
ordonnee_Coeff_Pearson = np.array(resultats['Coefficient-Pearson'])

# On trace une courbe pour chacun des indictateurs observés
plt.plot(abscisse,ordonnee_RMSE,linestyle='--',color='blue',label="RMSE")
plt.plot(abscisse,ordonnee_Coeff_R2,"b:o",color='red',label="R-carré")
plt.plot(abscisse,ordonnee_Coeff_Pearson,"-",color='green',label="Coef Pearson")

plt.plot([9, 9], [0, 1],"-.",color='black')

# On intègre les légendes et les titres des axes
plt.title('Comportement RMSE - R-carré - coefficient de Pearson selon hyperparamètres')
axes = plt.gca()
axes = axes.set(xlabel='Nombre des n voisins considérés pour la régression KNN', 
                ylabel='Valeur obtenue après évaluation du modèle')

plt.legend(loc='upper left')
pl.xticks(range(0,22))

plt.show()

################################################################################################

# Import du dataset de notation du vin rouge
data = pd.read_csv('E:\Data\RawData\ClassificationVin\winequality-white.csv', sep=";")

X = data.as_matrix(data.columns[:-1])
y = data.as_matrix([data.columns[-1]])
y = y.flatten()

X_train, X_test, y_train, y_test = model_selection.train_test_split(
                                                                    X, 
                                                                    y,
                                                                    test_size=0.3)

std_scale = preprocessing.StandardScaler().fit(X_train)
X_train_std = std_scale.transform(X_train)
X_test_std = std_scale.transform(X_test)

################################################################################################

# Simulation d'une régression naïve totalement aléatoire
y_pred_random = np.random.randint(np.min(y),np.max(y),y_test.shape[0])
RMSE_random = np.sqrt(
               metrics.mean_squared_error(y_test,y_pred_random))

# Simulation d'une régression naïve avec la bibliothèque Sklearn DummyRegressor - stratégie moyenne
dumMean = dummy.DummyRegressor(strategy='mean')
dumMean.fit(X_train,y_train)
prediction = dumMean.predict(X_test)

RMSE_dumMean = np.sqrt(
               metrics.mean_squared_error(y_test,prediction))

# Simulation d'une régression naïve avec la bibliothèque Sklearn DummyRegressor - stratégie médiane
dumMedian = dummy.DummyRegressor(strategy='median')
dumMedian.fit(X_train,y_train)
prediction = dumMedian.predict(X_test)

RMSE_dumMedian = np.sqrt(
               metrics.mean_squared_error(y_test,prediction))

# Simulation d'une régression naïve avec la bibliothèque Sklearn DummyRegressor - stratégie quantile 25%
dumQuant25 = dummy.DummyRegressor(strategy='quantile',quantile=0.25)
dumQuant25.fit(X_train,y_train)
prediction = dumQuant25.predict(X_test)

RMSE_dumQuant25 = np.sqrt(
               metrics.mean_squared_error(y_test,prediction))

# Simulation d'une régression naïve avec la bibliothèque Sklearn DummyRegressor - stratégie quantile 75%
dumQuant75 = dummy.DummyRegressor(strategy='quantile',quantile=0.75)
dumQuant75.fit(X_train,y_train)
prediction = dumQuant75.predict(X_test)

RMSE_dumQuant75 = np.sqrt(
               metrics.mean_squared_error(y_test,prediction))

# Simulation d'une régression naïve avec la bibliothèque Sklearn DummyRegressor - stratégie valeur la plus fréquente
data = collections.Counter(y_test)
mode_y_test = data.most_common(1)
valeur_frequente = mode_y_test[0][0]

dumMode = dummy.DummyRegressor(strategy='constant',constant=valeur_frequente)
dumMode.fit(X_train,y_train)
prediction = dumMode.predict(X_test)

RMSE_dumMode = np.sqrt(
               metrics.mean_squared_error(y_test,prediction))

print('--------------------------------------------------------------------------------')
print('Valeur du Root Mean Squared Error pour simulation aléatoire : {}'.format(round(RMSE_random,4)))
print('Valeur du Root Mean Squared Error pour simulation dummy moyenne : {}'.format(round(RMSE_dumMean,4)))
print('Valeur du Root Mean Squared Error pour simulation dummy médiane : {}'.format(round(RMSE_dumMedian,4)))
print('Valeur du Root Mean Squared Error pour simulation dummy quantile 25% : {}'.format(round(RMSE_dumQuant25,4)))
print('Valeur du Root Mean Squared Error pour simulation dummy quantile 75% : {}'.format(round(RMSE_dumQuant75,4)))
print('Valeur du Root Mean Squared Error pour simulation dummy fréquence modale : {}'.format(round(RMSE_dumMode,4)))
print('--------------------------------------------------------------------------------')

################################################################################################

# On trace un graphique pour comparer résultats de RMSE et classifieurs naïfs
# On trace une courbe pour chacun des indictateurs observés
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

plt.plot(abscisse,ordonnee_RMSE,"b:o",color=listeCouleurs[0],label="RMSE KNN")

plt.plot([0, 21], [RMSE_random, RMSE_random],"-.",color=listeCouleurs[1],label="Modèle aléatoire")
plt.plot([0, 21], [RMSE_dumMean, RMSE_dumMean],"-.",color=listeCouleurs[2],label="Dummy moyenne")
plt.plot([0, 21], [RMSE_dumMedian, RMSE_dumMedian],"-.",color=listeCouleurs[3],label="Dummy médiane")
plt.plot([0, 21], [RMSE_dumQuant25, RMSE_dumQuant25],"-.",color=listeCouleurs[5],label="Dummy quantile 25%")
plt.plot([0, 21], [RMSE_dumQuant75, RMSE_dumQuant75],"-.",color=listeCouleurs[6],label="Dummy quantile 75%")
plt.plot([0, 21], [RMSE_dumMode, RMSE_dumMode],"-.",color=listeCouleurs[7],label="Dummy fréquence modale")

plt.plot([9, 9], [0, 2],"--",color='black')

# On intègre les légendes et les titres des axes
plt.title('Comparaison RMSE KNN et RMSE de modélisations naïves')
axes = plt.gca()
axes = axes.set(xlabel='Nombre des n voisins considérés pour la régression KNN', 
                ylabel='Valeur obtenue après évaluation du modèle')

plt.legend(loc='upper right')
pl.xticks(range(0,22))

plt.show()

################################################################################################

# On représente les points avec une régression KNN avec n_neighbor=9
# et la prédiction avec une régression naïve de type moyenne (celle-ci a la meilleure performance)
Classifieur_Custom.fit(X_train_std,y_train)
y_pred = Classifieur_Custom.predict(X_test_std)

dumMean = dummy.DummyRegressor(strategy='mean')
dumMean.fit(X_train,y_train)
prediction = dumMean.predict(X_test)


sizes = {} # clé : coordonnées ; valeur : nombre de points à ces coordonnées

for (yt, yp) in zip(list(y_test), list(y_pred)):
    if (yt, yp) not in sizes:
        sizes[(yt, yp)] = 1
    else:
         sizes[(yt, yp)] += 1

keys = sizes.keys()

plt.scatter([k[0] for k in keys], 
            [k[1] for k in keys], 
            s=[sizes[k] for k in keys], 
            color='blue')

sizes2 = {} # clé : coordonnées ; valeur : nombre de points à ces coordonnées

for (yt, yp) in zip(list(y_test), list(prediction)):
    if (yt, yp) not in sizes2:
        sizes2[(yt, yp)] = 1
    else:
         sizes2[(yt, yp)] += 1

keys2 = sizes2.keys()

plt.scatter([k[0] for k in keys2], 
            [k[1] for k in keys2], 
            s=[sizes2[k] for k in keys2], 
            color='green')

# On insère la bissectrice de la régression parfaite
plt.plot([3,9],[3,9],linestyle='--',color='red')

# On intègre les légendes et les titres des axes
plt.title('Juxtaposition des régressions KNN et de la régression naïve par moyenne')
axes = plt.gca()
axes = axes.set(xlabel='Classification réelle du vin rouge noté par les juges', 
                ylabel='Valeur obtenue avec modèles régression')

# Affichage du graphique
plt.show()


"""
x = np.linspace(0, 2*np.pi, 30)
y = np.cos(x)
"""


