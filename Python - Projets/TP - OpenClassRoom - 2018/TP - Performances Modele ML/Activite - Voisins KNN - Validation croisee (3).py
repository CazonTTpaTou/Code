# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors
from sklearn import metrics

class ValidationCroisee:
    
    def __init__(self,cheminFichier,nombreFold,hyperParametre):
        self.data = pd.read_csv(cheminFichier, sep=";")        
        self.ensembleFold = []
        self.nombreFolds = nombreFold
        self.hyperParametres = hyperParametre
        self.score = 'accuracy'
        self.erreur = []

    def returnData(self):
        return self.data

    def returnFeatures(self,donnees):
        return donnees[:,:-1]
    
    def returnClassification(self,donnees):
        y = donnees[:,-1]       
        y = np.asarray(y.reshape(-1,1))
        return y.squeeze()
    
    def returnEnsembleFold(self):
        return self.ensembleFold

    def returnSetTraining(self):
        return self.SetTraining
    
    def returnSetTest(self):
        return self.SetTest
    
    def Decoupage_Fold(self,Dataset,nombre_Folds):
        nombreIndividus = Dataset.shape[0]
        Taille_Fold = int(nombreIndividus / nombre_Folds) + 1
        debutFold = 0
        finFold = 0
        
        for numeroFold in range(0,nombre_Folds) :
            debutFold = numeroFold * Taille_Fold
            finFold = min((numeroFold+1) * Taille_Fold,nombreIndividus)
            self.ensembleFold.append(Dataset.iloc[debutFold:finFold,:])

    def CombinaisonFold(self,numeroFoldTest):
        combinaisonFold = []
        for indice in range(0,self.nombreFolds):
            if indice!=numeroFoldTest:
                combinaisonFold.append(indice)
        return combinaisonFold
    
    def Separation_Test_Training(self,numeroFoldTest):
        combinaisonFold = self.CombinaisonFold(numeroFoldTest)
        self.SetTraining = np.matrix(self.returnEnsembleFold()[combinaisonFold[-1]])
        combinaisonFold.pop()
        
        for numero_fold in combinaisonFold:
            self.SetTraining = np.vstack([self.SetTraining,self.ensembleFold[numero_fold]])
        
        self.SetTest = np.matrix(self.ensembleFold[numeroFoldTest])
    
    def entrainement_Modele_KFold(self,numeroFold,hyperParametres):
        self.Separation_Test_Training(numeroFold)
        classification = neighbors.KNeighborsClassifier(n_neighbors=5)
        
        classification.fit(
                           self.returnFeatures(self.returnSetTraining()),
                           self.returnClassification(self.returnSetTraining()))

        print(classification.score(
                                    self.returnFeatures(self.returnSetTest()),
                                    self.returnClassification(self.returnSetTest())))
        
        return classification.predict(self.returnFeatures(self.returnSetTest()))

    def estimation_erreur_modele(self,prediction):
        valeurs_reelles = self.returnClassification(self.returnSetTest())
        #delta = valeurs_reelles - prediction
        
        #boolean = np.where(delta==0,0,1)
        delta = np.where((valeurs_reelles - prediction)==0,0,1)
        #print(boolean)
        erreur_moyenne = 1-delta.mean()
        #print(erreurs)
        print('-------------------')
        print('Erreur Moyenne : {}'.format(erreur_moyenne))
        erreur_sk = metrics.accuracy_score(self.returnClassification(self.returnSetTest()), prediction)
        print('-------------------')
        print('Erreur sklearn : {}'.format(erreur_sk))
        
hyperparametres = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15]}
validation = ValidationCroisee('E:\Data\RawData\winequality-white.csv',5,hyperparametres)

validation.Decoupage_Fold(validation.returnData(),
                          5)

validation.Separation_Test_Training(1)
validation.estimation_erreur_modele(validation.entrainement_Modele_KFold(1,1))


