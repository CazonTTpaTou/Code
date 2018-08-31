# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from sklearn import model_selection
from sklearn import preprocessing
from sklearn import svm
from matplotlib import pyplot as plt
from sklearn import metrics
from sklearn import kernel_ridge

# charger les données
data = pd.read_csv('E:\Data\RawData\winequality-white.csv', sep=';')

# créer la matrice de données
X = data.as_matrix(data.columns[:-1])

# créer le vecteur d'étiquettes
y = data.as_matrix([data.columns[-1]])
y = y.flatten()

# transformer en un problème de classification binaire
#y_class = np.where(y<6, 0, 1)

X_train, X_test, y_train, y_test = model_selection.train_test_split(X,                                                                     
                                                                    y, 
                                                                    test_size=0.3)
# standardiser les données
std_scale = preprocessing.StandardScaler().fit(X_train)

X_train_std = std_scale.transform(X_train)
X_test_std = std_scale.transform(X_test)

# initialiser un objet de classification par kRR
predicteur = kernel_ridge.KernelRidge(alpha=1.0, # valeur par défaut 
                                     kernel='rbf', # noyau Gaussien
                                     gamma=0.01)   # valeur de 1/(2 * sigma**2)
                                    
# entraîner le classifieur sur le jeu d'entrainement
predicteur.fit(X_train_std, y_train)
# prédire sur le jeu de test
y_test_predict = predicteur.predict(X_test_std)
# calculer la RMSE sur le jeu de test
rmse = np.sqrt(metrics.mean_squared_error(y_test, y_test_predict))
print("RMSE: %.2f" % rmse)

# créer une figure
fig = plt.figure(figsize=(6, 6))
# Compter, pour chaque paire de valeurs (y, y') où y est un vrai score et y' le score prédit,
# le nombre de ces paires.
# Ce nombre sera utilisé pour modifier la taille des marqueurs correspondants 
# dans un nuage de points
y_test_pred = np.around(np.array(y_test_predict) ,decimals=0)
sizes = {}

for (yt, yp) in zip(list(y_test), list(y_test_pred)):
    if (yt, yp) not in sizes:   
        sizes[(yt, yp)] = 1 
    else:        
        sizes[(yt, yp)] += 1
                     
keys = sizes.keys()
# afficher les prédictions
plt.scatter([k[0] for k in keys], 
            [k[1] for k in keys], 
            s=[sizes[k] for k in keys], 
            label='gamma = 0.01: RMSE = %0.2f' % rmse)
plt.plot([3,9],[3,9],linestyle='--',color='red')
# étiqueter les axes et le graphique
plt.xlabel('Vrai score', fontsize=16)
plt.ylabel(u'Score prédit', fontsize=16)
plt.title('kernel Ridge Regression', fontsize=16)
# limites des axes
plt.xlim([2.9, 9.1])
plt.ylim([2.9, 9.1])
# affichage
plt.legend(loc="lower right", fontsize=12)
plt.show()

##############################################################################################
# valeurs du paramètre C
alpha_range = np.logspace(-2, 2, 5)
# valeurs du paramètre gamma
gamma_range = np.logspace(-2, 1, 4)
# grille de paramètres
param_grid = {'alpha': alpha_range, 'gamma': gamma_range}
# score pour sélectionner le modèle optimal
score = 'neg_mean_squared_error'
# initialiser la validation croisée
grid_pred = model_selection.GridSearchCV(kernel_ridge.KernelRidge(kernel='rbf'),
                                    param_grid,
                                    cv=5, # 5 folds de validation croisée
                                    scoring=score)
# exécuter la validation croisée sur le jeu d'entraînement
grid_pred.fit(X_train_std, y_train)
# prédire sur le jeu de test avec le modèle sélectionné 
y_test_pred_cv = grid_pred.predict(X_test_std)
# calculer la RMSE correspondante
rmse_cv = np.sqrt(metrics.mean_squared_error(y_test, y_test_pred_cv))
print("RMSE: %.2f" % rmse_cv)




