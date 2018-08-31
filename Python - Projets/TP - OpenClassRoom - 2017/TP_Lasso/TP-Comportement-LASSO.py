# -*- coding: utf-8 -*-
"""
Created on Thu Dec 14 16:00:10 2017

@author: fmonnery
"""

import pandas as pd
import numpy as np
import sklearn as sk
import matplotlib.pyplot as plt

from sklearn import linear_model

raw_data = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/Data.csv",delimiter='\t')

X_train = raw_data.iloc[:60,1:-3]
y_train = raw_data.iloc[:60,-2]
X_test = raw_data.iloc[60:,1:-3]
y_test = raw_data.iloc[60:,-2]

lr = linear_model.LinearRegression()
lr.fit(X_train,y_train)
baseline_error = np.mean((lr.predict(X_test) - y_test)**2)

print(baseline_error)
   
n_alphas = 200
alphas = np.logspace(-5, 5, n_alphas)

coefs = []
errors = []
for a in alphas:
    sk.linear_model.ridge.set_params(alpha=a)
    sk.linear_model.ridge.fit(X_train, y_train)
    coefs.append(sk.linear_model.ridge.coef_)
    errors.append([baseline_error, np.mean((sk.linear_model.ridge.predict(X_test) - y_test) ** 2)])
    
ax = plt.gca()

ax.plot(alphas, coefs)
ax.set_xscale('log')
plt.xlabel('alpha')
plt.ylabel('weights')
plt.title('Ridge coefficients as a function of the regularization')
plt.axis('tight')
plt.show()    




