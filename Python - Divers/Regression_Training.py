# -*- coding: utf-8 -*-
"""
Created on Thu Jan  4 15:58:52 2018

@author: fmonnery
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.svm import LinearSVC

raw_data = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/TP_2_datset_mushrooms.csv")

labelencoder=LabelEncoder()

for col in raw_data.columns:
    raw_data[col] = labelencoder.fit_transform(raw_data[col])

"""print(raw_data.head())"""
 
 # On récupère les features d'un côté...
X = raw_data.iloc[:,1:23]
# et les labels de l'autre
y = raw_data.iloc[:,0] 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33)

lr = LogisticRegression()
lr.fit(X_train,y_train)

y_prob = lr.predict_proba(X_test)[:,1] 
y_pred = np.where(y_prob > 0.5, 1, 0) 
false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

print (roc_auc)

plt.figure(figsize=(10,10))
plt.title('Receiver Operating Characteristic')
plt.plot(false_positive_rate,true_positive_rate, color='red',label = 'AUC = %0.2f' % roc_auc)
plt.legend(loc = 'lower right')
plt.plot([0, 1], [0, 1],linestyle='--')
plt.axis('tight')
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.show()

lr = LogisticRegression()
params = {'C': np.logspace(-3, 3, 7) , 'penalty':['l1','l2'] }

# On récupère la prédiction de la valeur positive
y_prob = lr.predict_proba(X_test)[:,1] 

# On créé un vecteur de prédiction à partir du vecteur de probabilités
y_pred = np.where(y_prob > 0.5, 1, 0) 
false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

print (roc_auc)

svm = LinearSVC()
params = { 'C': np.logspace(-3, 3, 7) }
gs_svm = GridSearchCV(lr, params, cv=10)
gs_svm.fit(X_train, y_train)

print(gs_svm.best_params_)

false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

print (roc_auc)






