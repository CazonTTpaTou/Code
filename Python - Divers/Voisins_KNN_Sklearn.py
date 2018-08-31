# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors, metrics

class VerificationCroiseeSKearn:
    
    def __init__(self,path):
        self.data = pd.read_csv(path, sep=";")        

    def renvoyer_Meilleur_Score(self):
        X = self.data.as_matrix(self.data.columns[:-1])
        y = self.data.as_matrix([self.data.columns[-1]])
        
        y = y.flatten()
        
        y_class = np.where(y<6, 0, 1)
        
        X_train, X_test, y_train, y_test = model_selection.train_test_split(
                                                                            X,
                                                                            y_class,
                                                                            test_size=0.3)
        
        std_scale = preprocessing.StandardScaler().fit(X_train)
        X_train_std = std_scale.transform(X_train)
        stdt_scale = preprocessing.StandardScaler().fit(X_test)
        X_test_std = stdt_scale.transform(X_test)
        
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
        print('------------------------------------')
        print("Résultats de la validation croisée :")
        
        for mean, std, params in zip(clf.cv_results_['mean_test_score'], 
                                     clf.cv_results_['std_test_score'], # écart-type du score
                                     clf.cv_results_['params'] # valeur de l'hyperparamètre
                                     ):
            
            print("Paramètres {} : Score moyen = {} - intervalle erreur : {}".format(
                                params, # hyperparamètre
                                round(mean,4), # score moyen
                                round(std * 2,4), # barre d'erreur
                                ))
        
        y_pred = clf.predict(X_test_std)
        print("\nLe meilleur score obtenu est le suivant : %0.4f" % metrics.accuracy_score(y_test, y_pred))
        
        return clf
        



