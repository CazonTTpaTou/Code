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
        self.ensembleFold = []
        self.nombreFolds = nombreFold
        self.hyperParametres = []
        
        self.data = pd.read_csv(cheminFichier, sep=";") 
        self.Decoupage_Fold(self.returnData(),nombreFold)  
        self.initialisationParametres(hyperParametre)

    def initialisationParametres(self,hyperParametre):
        for parametre in hyperParametre:
            for parametreValeur in hyperParametre[parametre]:
                valeur = parametre + "=" + str(parametreValeur)
                self.hyperParametres.append(valeur) 
        
        self.resultat = pd.DataFrame(np.zeros(len(self.hyperParametres)),
                                     index=self.hyperParametres,
                                     columns=['Erreur'])
        
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
    
    def returnClassificationTraining(self):
        return self.returnClassification(self.returnSetTraining())
    
    def returnClassificationTest(self):
        return self.returnClassification(self.returnSetTest())
 
    def returnFeaturesTraining(self):
        return self.returnFeatures(self.returnSetTraining())
    
    def returnFeaturesTest(self):
        return self.returnFeatures(self.returnSetTest())
    
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

    def decomposition_Parametres(self,parametres):     
        params = {}
        param= parametres[:parametres.find('=')]
        params[param]=int(parametres[-1])
        return params

    def entrainement_Modele(self,hyperParametres):
        self.erreur = []
        classification = neighbors.KNeighborsClassifier()
        classification.set_params(**self.decomposition_Parametres(hyperParametres))
        
        for numeroFoldTest in range(0,self.nombreFolds):            
            self.Separation_Test_Training(numeroFoldTest)            
            classification.fit(self.returnFeaturesTraining(),
                               self.returnClassificationTraining())
            
            self.calcul_Erreur_Modele(
                                        classification.predict(
                                                                self.returnFeaturesTest()))
            
        return (np.array(self.erreur)).mean()
                        
    def calcul_Erreur_Modele(self,prediction):
        valeurs_reelles = self.returnClassificationTest()
        delta = np.where((valeurs_reelles - prediction)==0,0,1)
        erreur_moyenne = delta.mean()
        self.erreur.append(erreur_moyenne)
        return (np.array(self.erreur)).mean()

    def evaluation_HyperParametres(self):
        for hyper_parametres in self.hyperParametres:
            self.resultat.loc[hyper_parametres] = self.entrainement_Modele(hyper_parametres)
        
        print(self.resultat)
        self.renvoyer_Meilleur_Parametre()
        self.renvoyer_Meilleur_Score()

    def renvoyer_Meilleur_Parametre(self):
        return self.resultat.idxmin()[0]
        
    def renvoyer_Meilleur_Score(self):
        meilleurScore = 1 - self.resultat.loc[self.renvoyer_Meilleur_Parametre()][0]
        return meilleurScore                    
        
hyperparametres = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15]}
validation = ValidationCroisee('E:\Data\RawData\winequality-white.csv',5,hyperparametres)

validation.evaluation_HyperParametres()

"""
validation.Decoupage_Fold(validation.returnData(),
                          5)

validation.Separation_Test_Training(1)
validation.estimation_erreur_modele(validation.entrainement_Modele_KFold(1,1))

print('Erreur du modèle n° {} : {}'.format(numeroFoldTest,
                                                        self.calcul_Erreur_Modele(
                                                                classification.predict(
                                                                        self.returnFeaturesTest()
                    ))))
    
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
        
"""




