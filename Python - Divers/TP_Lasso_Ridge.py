# -*- coding: utf-8 -*-
"""
Created on Wed Jan  3 13:44:51 2018

@author: fmonnery
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as mp
from sklearn import linear_model

raw_data = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/TP_1_prostate_dataset.txt", delimiter='\t')

X_train = raw_data.iloc[:60,1:-3]
y_train = raw_data.iloc[:60,-2]
X_test = raw_data.iloc[60:,1:-3]
y_test = raw_data.iloc[60:,-2]

# On crée un modèle de régression linéaire
lr = linear_model.LinearRegression()

# On entraîne ce modèle sur les données d'entrainement
lr.fit(X_train,y_train)

# On récupère l'erreur de norme 2 sur le jeu de données test comme baseline
baseline_error = np.mean((lr.predict(X_test) - y_test) ** 2)

print(baseline_error)

n_alphas = 200
alphas = np.logspace(-5, 5, n_alphas)

coefs = []
errors = []

lmr = linear_model.Ridge()

for a in alphas:
    lmr.set_params(alpha=a)
    lmr.fit(X_train, y_train)
    coefs.append(lmr.coef_)
    errors.append([baseline_error, np.mean((lmr.predict(X_test) - y_test) ** 2)])

ax = mp.gca()
ax.plot(alphas, coefs)
ax.set_xscale('log')
mp.xlabel('alpha')
mp.ylabel('weights')
mp.title('Ridge coefficients as a function of the regularization')
mp.axis('tight')
mp.show()

ay = mp.gca()
ay.plot(alphas, errors)
ay.set_xscale('log')
mp.xlabel('alpha')
mp.ylabel('error')
mp.axis('tight')
mp.show()

print(min(errors))

lcv = linear_model.RidgeCV()

coefsBis = []
errorsBis = []

lcv.fit(X_train, y_train)
coefsBis.append(lcv.coef_)
errorsBis.append([baseline_error, np.mean((lcv.predict(X_test) - y_test) ** 2)])

print(coefsBis)
print(errorsBis)

n_alphas = 300

alphas = np.logspace(-5, 1, n_alphas)
lasso = linear_model.Lasso(fit_intercept=False)

coefs = []
errors = []

for a in alphas:
    lasso.set_params(alpha=a)
    lasso.fit(X_train, y_train)
    coefs.append(lasso.coef_)
    errors.append([baseline_error, np.mean((lasso.predict(X_test) - y_test) ** 2)])

print(np.mean(coefs))
print(np.mean(errors))

az = mp.gca()
az.plot(alphas, coefs)
az.set_xscale('log')
mp.xlabel('alpha')
mp.ylabel('weights')
mp.axis('tight')
mp.show()

av = mp.gca()
av.plot(alphas, errors)
av.set_xscale('log')
mp.xlabel('alpha')
mp.ylabel('weights')
mp.axis('tight')
mp.show()

print(min(errors))

lassocv = linear_model.LassoCV()

coefsTiers = []
errorsTiers = []

lassocv.fit(X_train, y_train)
coefsTiers.append(lassocv.coef_)
errorsTiers.append([baseline_error, np.mean((lassocv.predict(X_test) - y_test) ** 2)])

print(coefsTiers)
print(errorsTiers)



