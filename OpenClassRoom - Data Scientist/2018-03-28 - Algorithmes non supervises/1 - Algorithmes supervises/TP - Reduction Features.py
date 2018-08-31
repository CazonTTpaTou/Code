# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np 
import math
import matplotlib.pyplot as plt

from sklearn import preprocessing
from sklearn import decomposition
from sklearn import linear_model

############################# Non linéaire #########################################
x = np.linspace(1,10,10)
y = [1,2,6,3,4,8,2,4,6,2]
x_augmented = np.array([x, x**2, x**3, x**4, x**5]).T
regr = linear_model.LinearRegression()
regr.fit(x_augmented, y)

plt.plot(x_augmented[:,0], y, 'o', color='black', markersize=2)
plt.plot(x_augmented[:,0], regr.predict(x_augmented), '-', color='red')
plt.axis('off')
plt.show()

########################### ACP à noyau ############################################

#from sklearn import KernelPCA
#kpca = KernelPCA(n_components=1, kernel='rbf', gamma=10)
#X_spca = kpca.fit_transform(X)

############################# Logarithmique  #########################################
x = np.linspace(1,20,20)
y = [6,5,4,6,3,2,3,1,1,0,10,9,8,7,6,8,9,8,7,6]
x_augmented = np.array([x, x**2, x**3, x**4, x**5]).T
#x_log = np.array([np.log(x)]).T
#x_log = x_augmented
x_log = np.array([np.log(x)]).T
regr = linear_model.LinearRegression()
regr.fit(x_log, y)

plt.plot(x_augmented[:,0], y, 'o', color='black', markersize=2)
plt.plot(x_augmented[:,0], regr.predict(x_log), '-', color='orange')
plt.axis('off')
plt.show()

############################# Polynomial + Logarithmique  #########################################
x = np.linspace(1,20,20)
y = [6,5,4,6,3,2,3,1,1,0,10,9,8,7,6,8,9,8,7,6]
#x = np.log(s)
x_augmented = np.array([x, x**2, x**3, x**4, x**5]).T
#x_log = np.array([np.log(x)]).T
#x_log = x_augmented
x_log = np.array([x, np.log(x**2)]).T
regr = linear_model.LinearRegression()
regr.fit(x_log, y)

plt.plot(x_augmented[:,0], y, 'o', color='black', markersize=2)
plt.plot(x_augmented[:,0], regr.predict(x_log), '-', color='blue')
plt.axis('off')
plt.show()

############################# Logarithmique + Polynomial #########################################
s = np.linspace(1,20,20)
y = [6,5,4,6,3,2,3,1,1,0,10,9,8,7,6,8,9,8,7,6]
x = np.log(s)
x_augmented = np.array([s, x**2]).T
#x_log = np.array([np.log(x)]).T
x_log = x_augmented
#x_log = np.array([x, np.log(x**2), np.log(x**3), np.log(x**4), np.log(x**5)]).T
regr = linear_model.LinearRegression()
regr.fit(x_log, y)

plt.plot(x_augmented[:,0], y, 'o', color='black', markersize=2)
plt.plot(x_augmented[:,0], regr.predict(x_log), '-', color='green')
plt.axis('off')
plt.show()

############################# Polynomial #########################################
x = np.linspace(1,20,20)
y = [6,5,4,6,3,2,3,1,1,0,10,9,8,7,6,8,9,8,7,6]
#x = np.log(s)
x_augmented = np.array([x, x**2]).T
#x_log = np.array([np.log(x)]).T
x_log = x_augmented
#x_log = np.array([x, np.log(x**2), np.log(x**3), np.log(x**4), np.log(x**5)]).T
regr = linear_model.LinearRegression()
regr.fit(x_log, y)

plt.plot(x_augmented[:,0], y, 'o', color='black', markersize=2)
plt.plot(x_augmented[:,0], regr.predict(x_log), '-', color='purple')
plt.axis('off')
plt.show()



