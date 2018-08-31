# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split

raw_data = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/TP_2_datset_mushrooms.csv")

labelencoder=LabelEncoder()

for col in raw_data.columns:

    raw_data[col] = labelencoder.fit_transform(raw_data[col])
 
# On récupère les features d'un côté...
X = raw_data.iloc[:,1:23]
# et les labels de l'autre
y = raw_data.iloc[:,0] 

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33)

lr = LogisticRegression()
lr.fit(X_train,y_train)

# On récupère la prédiction de la valeur positive

Prediction = lr.predict_proba(X_test)
y_prob = lr.predict_proba(X_test)[:,1] 

# On créé un vecteur de prédiction à partir du vecteur de probabilités

y_pred = np.where(y_prob > 0.5, 1, 0) 

false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
roc_auc = auc(false_positive_rate, true_positive_rate)

print (roc_auc)



