# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors
from sklearn import metrics
from sklearn.metrics import roc_curve, auc

# Importation des deux classes de classification par validation croisée
from Voisins_KNN_Sklearn import VerificationCroiseeSKearn
from Voisins_KNN_Validation_croisee import ValidationCroisee

"""Afin d'avoir les mêmes données de référence, nous n'aurons pas recours à la bibliothèque Sklearn-Model """
""" Nous utiliserons deux fichiers de test et d'apprentissage que nous avons découpés en amont"""
""" Le decoupage entre données d'apprentissage et de test s'est fait selon un ratio de 80%-20%"""

# Configuration des paramètres
filePath = 'E:\Data\RawData\ClassificationVin\winequality-white-Training.csv'
nombre_Folds = 5
hyperparametres = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15]}

# Classification avec la bibliothèque Sklearn
print('--------------------------------------------------------------------------------')
print('------- Validation croisée avec la bibliothèque Sklearn-------------------------')
print('--------------------------------------------------------------------------------')
validation_SK = VerificationCroiseeSKearn(filePath)
Classifieur_SKLearn = validation_SK.renvoyer_Meilleur_Score()
print('--------------------------------------------------------------------------------')

# Classification avec notre propre bibliothèque de validation croisée de classification
print('--------------------------------------------------------------------------------')
print('------- Validation croisée avec notre propre bibliothèque ----------------------')
print('--------------------------------------------------------------------------------')
validation_Custom = ValidationCroisee(filePath,5,hyperparametres)
Classifieur_Custom = validation_Custom.evaluation_HyperParametres()
print('--------------------------------------------------------------------------------')
print('Les hyper-paramètres donnant le meilleur score sont les suivants : {}'.format(validation_Custom.renvoyer_Meilleur_Parametre()))
print('--------------------------------------------------------------------------------')
print('Le meilleur score obtenu après validation croisée des K-folds et hyperparamètres est le suivant : {}'.format(validation_Custom.renvoyer_Meilleur_Score()))
print('--------------------------------------------------------------------------------')

# Importation des données de test 
data = pd.read_csv('E:\Data\RawData\ClassificationVin\winequality-white-Test.csv', sep=";")

# Séparation des Features et des données de Classification 
X = data.as_matrix(data.columns[:-1])
y = data.as_matrix([data.columns[-1]])

# Binarisation des données de classification
y = y.flatten()
y_test = np.where(y<6, 0, 1)

# Prédiction avec la bibliothèque Sklearn
print('--------------------------------------------------------------------------------')
print('--------------- Prédiction avec la bibliothèque Sklearn-------------------------')
print('--------------------------------------------------------------------------------')
y_pred = Classifieur_SKLearn.predict(X)
score_predicition = metrics.accuracy_score(y_test, y_pred)
print("La qualité de prédiction est la suivanta : %0.4f" % score_predicition)
print('--------------------------------------------------------------------------------')

# Prédiction avec notre propre bibliothèque de validation croisée de classification
print('--------------------------------------------------------------------------------')
print('------- Validation croisée avec notre propre bibliothèque ----------------------')
print('--------------------------------------------------------------------------------')
y_pred = Classifieur_Custom.predict(X)
score_predicition = metrics.accuracy_score(y_test, y_pred)
print("La qualité de prédiction est la suivanta : %0.4f" % score_predicition)
print('--------------------------------------------------------------------------------')

# Représentation des résultats de prédiction à l'aide d'une courbe ROC
# Calcul des prédictions sous forme probabilisée 
y_prob = Classifieur_Custom.predict_proba(X)[:,1] 

# Calcul des faux et vrais positifs
false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

# Affichage de la courve ROC        
plt.figure(figsize=(10,10))
plt.title('Receiver Operating Characteristic')
plt.plot(false_positive_rate,true_positive_rate, color='red',label = 'AUC = %0.2f' % roc_auc)
plt.legend(loc = 'lower right')
plt.plot([0, 1], [0, 1],linestyle='--')
plt.axis('tight')
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.show()

# Affichage des histogrammes des sets de données
# Jeu de données d'apprentissage
data = pd.read_csv('E:\Data\RawData\ClassificationVin\winequality-white-Training.csv', sep=";")

Training = data.as_matrix(data.columns[:-1])

fig = plt.figure(figsize=(16, 12))

for feat_idx in range(Training.shape[1]):
    ax = fig.add_subplot(3,4, (feat_idx+1))
    h = ax.hist(Training[:, feat_idx],
                bins=50, 
                color='green',
                density=True, 
                edgecolor='none')
    ax.set_title(data.columns[feat_idx], fontsize=14)

# Affichage des histogrammes des sets de données
# Jeu de données de test
data = pd.read_csv('E:\Data\RawData\ClassificationVin\winequality-white-Test.csv', sep=";")

Test = data.as_matrix(data.columns[:-1])

fig = plt.figure(figsize=(16, 12))

for feat_idx in range(Test.shape[1]):
    ax = fig.add_subplot(3,4, (feat_idx+1))
    h = ax.hist(Test[:, feat_idx],
                bins=50, 
                color='red',
                density=True, 
                edgecolor='none')
    ax.set_title(data.columns[feat_idx], fontsize=14)




