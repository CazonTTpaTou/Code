# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors, metrics

data = pd.read_csv('E:\Data\RawData\winequality-white.csv', sep=";")
print(data.head())

X = data.as_matrix(data.columns[:-1])
y = data.as_matrix([data.columns[-1]])

y = y.flatten()

fig = plt.figure(figsize=(16, 12))

for feat_idx in range(X.shape[1]):
    ax = fig.add_subplot(3,4, (feat_idx+1))
    h = ax.hist(X[:, feat_idx], bins=50, color='steelblue',
                density=True, edgecolor='none')
    ax.set_title(data.columns[feat_idx], fontsize=14)

y_class = np.where(y<6, 0, 1)

X_train, X_test, y_train, y_test = model_selection.train_test_split(
                                                                    X,
                                                                    y_class,
                                                                    test_size=0.3)

std_scale = preprocessing.StandardScaler().fit(X_train)
X_train_std = std_scale.transform(X_train)
X_test_std = std_scale.transform(X_test)

fig = plt.figure(figsize=(16, 12))

for feat_idx in range(X_train_std.shape[1]):
    ax = fig.add_subplot(3,4, (feat_idx+1))
    h = ax.hist(X_train_std[:, feat_idx],
                bins=50, 
                color='steelblue',
                density=True, 
                edgecolor='none')
    ax.set_title(data.columns[feat_idx], fontsize=14)

# Fixer les valeurs des hyperparamètres à tester
param_grid = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15]}
# Choisir un score à optimiser, ici l'accuracy (proportion de prédictions correctes)
score = 'accuracy'
# Créer un classifieur kNN avec recherche d'hyperparamètre par validation croisée
clf = model_selection.GridSearchCV(neighbors.KNeighborsClassifier(), # un classifieur kNN
                                   param_grid, # hyperparamètres à tester
                                   cv=5, # nombre de folds de validation croisée
                                   scoring=score # score à optimiser
                                   )


# Optimiser ce classifieur sur le jeu d'entraînement
clf.fit(X_train_std, y_train)
# Afficher le(s) hyperparamètre(s) optimaux
print("Meilleur(s) hyperparamètre(s) sur le jeu d'entraînement:{}".format(clf.best_params_))
# Afficher les performances correspondantes
print("Résultats de la validation croisée :")

for mean, std, params in zip(clf.cv_results_['mean_test_score'], 
                             clf.cv_results_['std_test_score'], # écart-type du score
                             clf.cv_results_['params'] # valeur de l'hyperparamètre
                             ):
    print("\t{}s = {}0.3f (+/-{}0.03f) for {}r".format(
                        score, # critère utilisé
                        mean, # score moyen
                        std * 2, # barre d'erreur
                        params # hyperparamètre
                        ))

y_pred = clf.predict(X_test_std)
print("\nSur le jeu de test : %0.3f" % metrics.accuracy_score(y_test, y_pred))


