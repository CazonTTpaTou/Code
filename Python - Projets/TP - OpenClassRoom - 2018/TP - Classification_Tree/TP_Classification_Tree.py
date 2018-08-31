# -*- coding: utf-8 -*-
"""
Created on Mon Jan 15 13:03:32 2018

@author: fmonnery
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.multiclass import OneVsRestClassifier
from sklearn.multiclass import OneVsOneClassifier
from sklearn.svm import LinearSVC

from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.svm import LinearSVC

def CourbeVisualisation(Abscisse,Ordonnee,Maximum,indexOptimum,Titre):
    plt.figure(figsize=(10,10))
    plt.title(Titre)
    plt.plot(Abscisse.loc[0:99],Ordonnee.loc[0:99], color='red',label = 'Noyau Linéaire')
    plt.plot(Abscisse.loc[100:199],Ordonnee.loc[100:199], color='green',label = 'Noyau rbf')
    plt.plot(Abscisse.loc[200:299],Ordonnee.loc[200:299], color='purple',label = 'Noyau sigmoïde')
    plt.legend(loc = 'lower right')
    plt.plot([0, 300], [Maximum, Maximum],linestyle='--')
    plt.axis('tight')
    plt.plot([indexOptimum, indexOptimum], [0, 1],linestyle='--')
    plt.ylabel('Score de la classification')
    plt.xlabel('Combinaison des paramètres Coefficient - Degré - Noyau')
    plt.show()  
    
#Imporation des données
raw_data = pd.read_csv("E:/Data/RawData/Dataset_feuilles_1.csv")
#Encodage des données
labelencoder=LabelEncoder()
Espece = raw_data.iloc[:,1]
Proprietes = raw_data.iloc[:,2:raw_data.shape[1]]
Espece = labelencoder.fit_transform(Espece)
#Création des datasets
Features_train, Features_test, Label_train, Label_test = train_test_split(Proprietes, Espece, test_size=0.33)
#Préparation des paramètres
DegreePlage = np.arange(0,10,1)
CoefficientPlage = np.arange(0,10,1)
TypeKernel = ["linear","rbf","sigmoid"]
#Resultats = np.empty(400)
resultats = pd.DataFrame([[0,0]])
#Calcul des scores pour les différentes combinaisons de paramètres 
for indiceKernel in TypeKernel:
    for indicePlage in CoefficientPlage:
        for indiceDegre in DegreePlage:
            Classification_OVR = OneVsRestClassifier(SVC(C=indicePlage+1,kernel=indiceKernel,degree=indiceDegre,probability =True,max_iter=-1))
            Classification_OVR.fit(Features_train,Label_train)            
            Abscisse = (TypeKernel.index(indiceKernel)*100) + (indicePlage*10) + (indiceDegre*1)
            result=pd.DataFrame([[Abscisse,Classification_OVR.score(Features_test,Label_test)]])
            resultats = resultats.append(result,ignore_index=True)

# Affichage des résultats pour classification OVA
Titre = 'Resultats One Versus All - Score maximal de %0.2f'%resultats[1].max()
AbscisseOptimum = resultats.at[(np.where(resultats[1] >= resultats[1].max()))[0][0],0]
CourbeVisualisation(resultats[0],resultats[1],resultats[1].max(),AbscisseOptimum,Titre)            

#Initialisation des paramètres pour la classification OVO
DegreePlage = np.arange(0,10,1)
CoefficientPlage = np.arange(10,40,1)
TypeKernel = ["linear"]#,"rbf","sigmoid"]
resultats = pd.DataFrame([[0,0]])

#Calcul des scores pour les différentes combinaisons de paramètres 
for indiceKernel in TypeKernel:
    for indicePlage in CoefficientPlage:    
        Classification_OVO = OneVsOneClassifier(SVC(C=indicePlage+1,kernel=indiceKernel,degree=indiceDegre,probability =True,max_iter=-1))
        Classification_OVO.fit(Features_train,Label_train)
        Score = Classification_OVO.score(Features_test,Label_test)
        for indiceDegre in DegreePlage:
            Abscisse = (TypeKernel.index(indiceKernel)*100) + ((indicePlage-20)*10) + (indiceDegre*1)
            result=pd.DataFrame([[Abscisse,Score]])
            resultats = resultats.append(result,ignore_index=True)

# Affichage des résultats pour classification OVO
Titre = 'Resultats One Versus One - Score maximal de %0.2f'%resultats[1].max()
AbscisseOptimum = resultats.at[(np.where(resultats[1] >= resultats[1].max()))[0][0],0]
CourbeVisualisation(resultats[0],resultats[1],resultats[1].max(),AbscisseOptimum,Titre)            

#Initialisation des paramètres pour la classification SVM
DegreePlage = np.arange(0,10,1)
CoefficientPlage = np.arange(0.05,0.20,0.01)
TypeKernel = ["l1","l2"]
resultats = pd.DataFrame([[0,0]])

#Calcul des scores pour les différentes combinaisons de paramètres 
for indiceKernel in TypeKernel:
    for indicePlage in CoefficientPlage:    
        SVM_MultiClasse = LinearSVC(
                                 C=indicePlage,                                  
                                 intercept_scaling=10, 
                                 verbose=1,
                                 penalty=indiceKernel, 
                                 loss='linge',
                                 multi_class="crammer_singer",
                                 dual=True,
                                 max_iter=100)

        SVM_MultiClasse.fit(Features_train,Label_train)
        Score = SVM_MultiClasse.score(Features_test,Label_test)
        
        for indiceDegre in DegreePlage:
            Abscisse = (TypeKernel.index(indiceKernel)*100) + ((indicePlage)*1000) + (indiceDegre*1)
            result=pd.DataFrame([[Abscisse,Score]])
            resultats = resultats.append(result,ignore_index=True)

# Affichage des résultats pour classification SVM
Titre = 'Resultats Support Vector Machine - Score maximal de %0.2f'%resultats[1].max()
AbscisseOptimum = resultats.at[(np.where(resultats[1] >= resultats[1].max()))[0][0],0]
CourbeVisualisation(resultats[0],resultats[1],resultats[1].max(),AbscisseOptimum,Titre)            


