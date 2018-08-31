import numpy as nps
import pandas as pd

import matplotlib.pyplot as plt
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score

from DataWrangling import WranglingData

class regressionLineaire:

    def __init__(self,cleanData,Ratio):
        self.data = cleanData
        self.ratio = Ratio

    def apercuDonnees(self):
        print(self.data.head())

    def renvoyerNombreMesures(self):
        return self.data.shape[0]

    def CreationEchantillon(self):
        
        taille_echantillon_training = int(self.renvoyerNombreMesures() * (1-self.ratio))
        
        self.Training_Variable_Explicative = self.data.loc[:taille_echantillon_training,"distance"].to_frame()
        self.Training_Variable_Expliquee = self.data.loc[:taille_echantillon_training,"recession_velocity"].to_frame()
        
        self.Test_Variable_Explicative = self.data.loc[:taille_echantillon_training,"distance"].to_frame()
        self.Test_Variable_Expliquee = self.data.loc[:taille_echantillon_training:,"recession_velocity"].to_frame()     
        
    def CalculRegressionLineaire(self):
        self.regr = linear_model.LinearRegression()
        self.regr.fit(self.Training_Variable_Explicative,self.Training_Variable_Expliquee)
        self.Predictions = self.regr.predict(self.Test_Variable_Explicative)
        self.Coefficient = pd.DataFrame([[self.regr.intercept_[0],self.regr.coef_[0][0]]],columns=['Intersection','Coefficient'])
        """
        self.Coefficient = [[self.regr.intercept_],[self.regr.coef_]]        
        
        print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy')
        print(self.regr.coef_)
        print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy')
        fg = [self.regr.intercept_[0],self.regr.coef_[0][0]]
        print(fg)
        """

    def AfficherResultatsRegression(self):
        print('Les coefficients de la régression sont de la forme Vitesse = {} x Distance + {}'.format(self.Coefficient.Coefficient.values[0],self.Coefficient.Intersection.values[0]))
        print('Erreur carrée moyenne : {}'.format(mean_squared_error(self.Predictions,self.Test_Variable_Expliquee)))
        print('Variance expliquée : %.2f' % r2_score(self.Predictions,self.Test_Variable_Expliquee))
        print('Coefficient de détermination : ',self.regr.score(self.Predictions,self.Test_Variable_Expliquee))

    def AfficherDetailPredictions(self):
        delta = self.Test_Variable_Expliquee - self.Predictions
        delta.index = range(0,self.renvoyerNombreMesures() - self.ratio)
        self.Test_Variable_Expliquee.index = range(0,self.renvoyerNombreMesures() - self.ratio)
        
        self.predictionsDetail = pd.concat([self.Test_Variable_Expliquee,pd.DataFrame(self.Predictions),delta],axis=1,ignore_index=True)
        self.predictionsDetail.columns=['Valeurs','Prédictions','Delta']
        print(self.predictionsDetail)

    def RenvoyerVecteurExplicatifTraining(self):
        return self.Training_Variable_Explicative

    def RenvoyerVecteurExpliqueTraining(self):
        return self.Training_Variable_Expliquee

    def RenvoyerVecteurExplicatifTest(self):
        return self.Test_Variable_Explicative

    def RenvoyerVecteurExpliqueTest(self):
        return self.Test_Variable_Expliquee

    def RenvoyerVecteurPredictions(self):
        return self.Predictions

    def RenvoyerCoefficientsRegression(self):
        return self.Coefficient

    def RenvoyerDetailRegression(self):
        return self.predictionsDetail

    def RenvoyerResultatsRegression(self):
        results=[]        
        results.append(self.regr.intercept_[0])
        results.append(self.regr.coef_[0][0])
        results.append(mean_squared_error(self.Predictions,self.Test_Variable_Expliquee))
        results.append(r2_score(self.Predictions,self.Test_Variable_Expliquee))
        results.append(self.regr.score(self.Predictions,self.Test_Variable_Expliquee))
        
        Libelle = ['Intersection','Coefficient','Erreur_carree_moyenne','Variance_expliquee','Coefficient_determination']
        
        self.Resultats = pd.DataFrame([results],columns=Libelle)
        
        return self.Resultats

d = WranglingData("E:/Data/RawData/hubble_data.csv")
d.GetListColumns()
d.GetMissingData()
d.GiveStatisticsSummary()
d.RemoveMissingData()

reg = regressionLineaire(d.SendCleanData(),0)
reg.apercuDonnees()
reg.CreationEchantillon()
reg.CalculRegressionLineaire()
reg.AfficherResultatsRegression()
reg.AfficherDetailPredictions()

"""
print('**********************************')
print(reg.RenvoyerResultatsRegression())
print('**********************************')
a = reg.RenvoyerCoefficientsRegression()
print(a)
print(a.Intersection.Values)
print(a.Coefficient.Values)
print('**********************************')
print(reg.RenvoyerDetailRegression())
print('**********************************')
print(reg.RenvoyerVecteurExplicatifTest())
print('**********************************')
print(reg.RenvoyerVecteurExplicatifTraining())
print('**********************************')
print(reg.RenvoyerVecteurExpliqueTest())
print('**********************************')
print(reg.RenvoyerVecteurExpliqueTraining())
print('**********************************')
print(reg.RenvoyerVecteurPredictions())
"""









