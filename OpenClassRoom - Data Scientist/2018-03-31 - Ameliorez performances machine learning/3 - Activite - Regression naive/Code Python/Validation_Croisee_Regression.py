# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors
from sklearn import metrics

class ValidationCroiseeRegression:
    
    def __init__(self,cheminFichier,nombreFold,hyperParametre):  
        """Initialisation de l'objet validation croisée de classification K-neighbors"""              
        self.ensembleFold = []
        self.nombreFolds = nombreFold
        self.hyperParametres = []
        self.modele = neighbors.KNeighborsRegressor()
        
        self.data = pd.read_csv(cheminFichier, sep=";") 
        self.Decoupage_Fold(self.returnData(),nombreFold)  
        self.initialisationParametres(hyperParametre)

    def initialisationParametres(self,hyperParametre):
        """Initialisation des hyperparamètres possibles au format de l'objet de classification"""
        for parametre in hyperParametre:
            for parametreValeur in hyperParametre[parametre]:
                valeur = parametre + "=" + str(parametreValeur)
                self.hyperParametres.append(valeur) 
        
        self.resultat = pd.DataFrame(np.zeros(len(self.hyperParametres)),
                                     index=self.hyperParametres,
                                     columns=['RMSE'])
        
    def returnData(self):
        """Retourne les données brutes passées en paramètre à la création de la classe"""
        return self.data

    def returnFeatures(self,donnees):
        """Renvoie les varaibles explicatives d'un dataset passé en paramètre"""
        raw_data = donnees[:,:-1]
        data_scale = preprocessing.StandardScaler().fit(raw_data)
        return data_scale.transform(raw_data)
             
    def returnClassification(self,donnees):
        """Renvoie la variable expliquée d'un dataset passé en paramètre"""
        data = donnees[:,-1] 
        y = np.asarray(data.reshape(-1,1))
        return y.squeeze()
    
    def returnEnsembleFold(self):
        """Retourne l'ensemble des jeux de données partagés en K-fold"""
        return self.ensembleFold

    def returnSetTraining(self):
        """Renvoie les K-fold dévolus à l'apprentissage des données"""
        return self.SetTraining
    
    def returnSetTest(self):
        """Renvoie les K-fold dévolus au test des données"""
        return self.SetTest
    
    def returnClassificationTraining(self):
        """Renvoie les variables expliquées des K-fold dévolus à l'apprentissage des données"""
        return self.returnClassification(self.returnSetTraining())
    
    def returnClassificationTest(self):
        """Renvoie les variables expliquées des K-fold dévolus au test des données"""
        return self.returnClassification(self.returnSetTest())
 
    def returnFeaturesTraining(self):
        """Renvoie les variables explicatives des K-fold dévolus à l'apprentissage des données"""
        return self.returnFeatures(self.returnSetTraining())
    
    def returnFeaturesTest(self):
        """Renvoie les variables explicatives des K-fold dévolus au test des données"""
        return self.returnFeatures(self.returnSetTest())
    
    def Decoupage_Fold(self,Dataset,nombre_Folds):
        """ Découpe le jeu de données complet en un nombre pré-défini de K-folds non stratifiés"""
        nombreIndividus = Dataset.shape[0]
        Taille_Fold = int(nombreIndividus / nombre_Folds) + 1
        debutFold = 0
        finFold = 0
        
        for numeroFold in range(0,nombre_Folds) :
            debutFold = numeroFold * Taille_Fold
            finFold = min((numeroFold+1) * Taille_Fold,nombreIndividus)
            self.ensembleFold.append(Dataset.iloc[debutFold:finFold,:])

    def CombinaisonFold(self,numeroFoldTest):
        """ Renvoie la combinatoire des numéros de K-fold dévolus au test et à l'apprentissage"""
        combinaisonFold = []
        for indice in range(0,self.nombreFolds):
            if indice!=numeroFoldTest:
                combinaisonFold.append(indice)
        return combinaisonFold
    
    def Separation_Test_Training(self,numeroFoldTest):
        """ Sépare le jeu de données en folds d'apprentissage et folds de test"""
        combinaisonFold = self.CombinaisonFold(numeroFoldTest)
        self.SetTraining = np.matrix(self.returnEnsembleFold()[combinaisonFold[-1]])
        combinaisonFold.pop()
        
        for numero_fold in combinaisonFold:
            self.SetTraining = np.vstack([self.SetTraining,self.ensembleFold[numero_fold]])
        
        self.SetTest = np.matrix(self.ensembleFold[numeroFoldTest])

    def decomposition_Parametres(self,parametres):     
        """ Transforme le libellé des hyperparamètres en dictionnaire de paramètres"""
        params = {}
        param= parametres[:parametres.find('=')]
        params[param]=int(parametres[-1])
        return params

    def entrainement_Modele(self,hyperParametres):
        """Entraine le modèle sur toutes les combinaisons de K-folds selon des hyperparamètres fixés"""
        self.erreur = []
        classification = neighbors.KNeighborsRegressor()
        classification.set_params(**self.decomposition_Parametres(hyperParametres))
        
        for numeroFoldTest in range(0,self.nombreFolds):            
            self.Separation_Test_Training(numeroFoldTest)            
            classification.fit(self.returnFeaturesTraining(),
                               self.returnClassificationTraining())
            
            self.calcul_Erreur_Modele(
                                        classification.predict(
                                                                self.returnFeaturesTest()))         
            
        self.modele = classification
                                
        return (np.array(self.erreur)).mean()
                        
    def calcul_Erreur_Modele(self,prediction):
        """Calcul le Root Mean Squared Error en comparant prédiction du modèle et données de test"""
        classification_test = self.returnClassificationTest()
        
        RMSE = np.sqrt(
               metrics.mean_squared_error(classification_test,prediction))
        
        self.erreur.append(RMSE)
        
        return (np.array(self.erreur)).mean()

    def evaluation_HyperParametres(self):
        """Performe l'ensemble des évaluations du modèle pour chaque combinaison d'hyperparamètres"""
        for hyper_parametres in self.hyperParametres:
            self.resultat.loc[hyper_parametres] = self.entrainement_Modele(hyper_parametres)
        
        self.resultat['R-carré'] = 1 - self.resultat['RMSE']
        self.resultat['Coefficient-Pearson'] = np.sqrt(1 - self.resultat['RMSE'])
        print(self.resultat)
        
        return self.renvoyer_Meilleur_Modele()

    def renvoyer_Meilleur_Parametre(self):
        """Renvoie les hyperparamètres permettant d'obtenir le meilleur score de classification"""
        return self.resultat.idxmin()[0]
        
    def renvoyer_Meilleur_Score(self):
        """Renvoie le meilleur score obtenu après exécution de toutes les combinaisons d'hyperparamètres"""
        meilleurRMSE = self.resultat.loc[self.renvoyer_Meilleur_Parametre()][0]
        meilleurRcarre = self.resultat.loc[self.renvoyer_Meilleur_Parametre()][1]
        meilleurCoefPearson = self.resultat.loc[self.renvoyer_Meilleur_Parametre()][2]

        return round(meilleurRMSE,4), round(meilleurRcarre,4), round(meilleurCoefPearson,4)                   
        
    def renvoyer_Meilleur_Modele(self):
        """Renvoie l'objet du modèle de classification entraîné ayant le meilleur score"""
        self.entrainement_Modele(self.resultat.idxmin()[0])
        return self.modele
    
    def renvoyer_Resultats(self):
        """Renvoie l'ensemble des résultats pour toutes les simulations avec les hyperparamètres"""
        return self.resultat
    
"""
hyperparametres = {'n_neighbors':[3, 5, 7, 9, 11, 13, 15,18,21]}
validation = ValidationCroiseeRegression('E:\Data\RawData\ClassificationVin\winequality-red.csv',5,hyperparametres)
#validation = ValidationCroiseeRegression('E:\Data\RawData\ClassificationVin\winequality-white.csv',5,hyperparametres)
validation.evaluation_HyperParametres()
print(validation.renvoyer_Meilleur_Parametre())
print(validation.renvoyer_Meilleur_Score())
"""



