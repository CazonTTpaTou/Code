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

from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.svm import LinearSVC


raw_data = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/Dataset_feuilles_1.csv")

labelencoder=LabelEncoder()

Espece = raw_data.iloc[:,1]
Proprietes = raw_data.iloc[:,2:raw_data.shape[1]]

Espece = labelencoder.fit_transform(Espece)

Features_train, Features_test, Label_train, Label_test = train_test_split(Proprietes, Espece, test_size=0.33)

Classification_OVR = OneVsRestClassifier(SVC(kernel="linear",probability =True))
#Classification_OVR = OneVsRestClassifier(SVC(kernel="polynomial",probability =True))
#Classification_OVR = OneVsRestClassifier(SVC(kernel="rbf",probability =True))
#Classification_OVR = OneVsRestClassifier(SVC(kernel="sigmoid",probability =True))
Classification_OVR.fit(Features_train,Label_train)

Vecteur_Prediction = Classification_OVR.predict_proba(Features_test)
Estimateur = Classification_OVR.estimators_[0]
Prediction = Classification_OVR.predict(Features_test)

"""
lr = LogisticRegression()
lr.fit(Features_train,Label_train)

# On récupère la prédiction de la valeur positive
Vecteur_Prediction = lr.predict_proba(Features_test)
y_prob = lr.predict_proba(Features_test)[:,1] 

# On créé un vecteur de prédiction à partir du vecteur de probabilités
y_pred = np.where(y_prob > 0.5, 1, 0) 

false_positive_rate, true_positive_rate, thresholds = roc_curve(Label_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

print (roc_auc)
"""





    






