# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from sklearn import model_selection
from sklearn import preprocessing
from sklearn import svm
from matplotlib import pyplot as plt
from sklearn import metrics

# charger les données
data = pd.read_csv('E:\Data\RawData\winequality-white.csv', sep=';')

# créer la matrice de données
X = data.as_matrix(data.columns[:-1])

# créer le vecteur d'étiquettes
y = data.as_matrix([data.columns[-1]])
y = y.flatten()

# transformer en un problème de classification binaire
y_class = np.where(y<6, 0, 1)

X_train, X_test, y_train, y_test = model_selection.train_test_split(X,                                                                     
                                                                    y_class, 
                                                                    test_size=0.3)
# standardiser les données
std_scale = preprocessing.StandardScaler().fit(X_train)

X_train_std = std_scale.transform(X_train)
X_test_std = std_scale.transform(X_test)

# Créer une SVM avec un noyau gaussien de paramètre gamma=0.01
classifier = svm.SVC(kernel='rbf', gamma=0.01)
# Entraîner la SVM sur le jeu d'entraînement
classifier.fit(X_train_std, y_train)
# prédire sur le jeu de test
y_test_pred = classifier.decision_function(X_test_std)

# construire la courbe ROC
fpr, tpr, thr = metrics.roc_curve(y_test, y_test_pred)
# calculer l'aire sous la courbe ROC
auc = metrics.auc(fpr, tpr)

# créer une figure
fig = plt.figure(figsize=(6, 6))
# afficher la courbe ROC
plt.plot(fpr, tpr, '-', lw=2, label='gamma=0.01, AUC=%.2f' % auc)
# donner un titre aux axes et au graphique
plt.xlabel('False Positive Rate', fontsize=16)
plt.ylabel('True Positive Rate', fontsize=16)
plt.title('SVM ROC Curve', fontsize=16)
# afficher la légende
plt.legend(loc="lower right", fontsize=14)
# afficher l'image
plt.show()

############################################################################################

# choisir 6 valeurs pour C, entre 1e-2 et 1e3
C_range = np.logspace(-2, 3, 6)
# choisir 4 valeurs pour gamma, entre 1e-2 et 10
gamma_range = np.logspace(-2, 1, 4)
# grille de paramètres
param_grid = {'C': C_range, 'gamma': gamma_range}
# critère de sélection du meilleur modèle
score = 'roc_auc'
# initialiser une recherche sur grille
grid = model_selection.GridSearchCV(svm.SVC(kernel='rbf'), 
                                    param_grid, 
                                    cv=5, # 5 folds de validation croisée  
                                    scoring=score)

# faire tourner la recherche sur grille
grid.fit(X_train_std, y_train)
# afficher les paramètres optimaux
print("The optimal parameters are %s with a score of %.2f" % \
      (grid.best_params_, grid.best_score_))

############################################################################################
# prédire sur le jeu de test avec le modèle optimisé
y_test_pred_cv = grid.decision_function(X_test_std)
# construire la courbe ROC du modèle optimisé
fpr_cv, tpr_cv, thr_cv = metrics.roc_curve(y_test, y_test_pred_cv)
# calculer l'aire sous la courbe ROC du modèle optimisé
auc_cv = metrics.auc(fpr_cv, tpr_cv)
# créer une figure
fig = plt.figure(figsize=(6, 6))
# afficher la courbe ROC précédente
plt.plot(fpr, tpr, '-', lw=2, label='gamma=0.01, AUC=%.2f' % auc)
# afficher la courbe ROC du modèle optimisé
plt.plot(fpr_cv, 
         tpr_cv, 
         '-', 
         lw=2, 
         label='gamma=%.1e, AUC=%.2f' % (grid.best_params_['gamma'], auc_cv))
# donner un titre aux axes et au graphique
plt.xlabel('False Positive Rate', fontsize=16)
plt.ylabel('True Positive Rate', fontsize=16)
plt.title('SVM ROC Curve', fontsize=16)
# afficher la légende
plt.legend(loc="lower right", fontsize=14)
# afficher l'image
plt.show()

################################################################################################
import matplotlib.cm as cm

kmatrix = metrics.pairwise.rbf_kernel(X_train_std, gamma=0.01)
kmatrix100 = kmatrix[:100, :100]

# dessiner la matrice
plt.pcolor(kmatrix100,cmap=cm.PuRd) 
# rajouter la légende
plt.colorbar()
# définir les axes
#◙plt.xlim([0, X.shape[0]])
#plt.ylim([0, X.shape[0]])
# retourner l'axe des ordonnées
plt.gca().invert_yaxis()
plt.gca().xaxis.tick_top()
# afficher l'image
plt.show()




