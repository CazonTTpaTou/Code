# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn import model_selection
from sklearn import neighbors
from sklearn import preprocessing
from sklearn import metrics
from sklearn import dummy

data = pd.read_csv('E:\Data\RawData\ClassificationVin\winequality-white.csv', sep=";")

X = data.as_matrix(data.columns[:-1])
y = data.as_matrix([data.columns[-1]])
y = y.flatten()

y_class = np.where(y<6,0,1)

X_train, X_test, y_train, y_test = model_selection.train_test_split(
                                                                    X, 
                                                                    y,
                                                                    test_size=0.3)

std_scale = preprocessing.StandardScaler().fit(X_train)
X_train_std = std_scale.transform(X_train)
X_test_std = std_scale.transform(X_test)

#####################################################################################

knn = neighbors.KNeighborsRegressor(n_neighbors=11)
knn.fit(X_train_std, y_train)

y_pred = knn.predict(X_test_std)

erreur = np.sqrt(
                metrics.mean_squared_error(y_test, y_pred))

plt.scatter(y_test, y_pred, color='coral')
plt.plot([3,9],[3,9],linestyle='--',color='red')
plt.show()

sizes = {} # clé : coordonnées ; valeur : nombre de points à ces coordonnées

for (yt, yp) in zip(list(y_test), list(y_pred)):
    if (yt, yp) not in sizes:
        sizes[(yt, yp)] = 1
    else:
         sizes[(yt, yp)] += 1

keys = sizes.keys()

plt.scatter([k[0] for k in keys], 
            [k[1] for k in keys], 
            s=[sizes[k] for k in keys], 
            color='blue')

plt.plot([3,9],[3,9],linestyle='--',color='red')
plt.show()

print ('La valeur de RMSE simple est de {}'.format(round(erreur,2)))

#####################################################################################

y_pred_random = np.random.randint(np.min(y),np.max(y),y_test.shape[0])
RMSE = np.sqrt(
               metrics.mean_squared_error(y_test,y_pred_random))
print('La valeur de RMSE randomisé est de {}'.format(round(RMSE,2)))

dum = dummy.DummyRegressor(strategy='mean')
# Entrainement du classifieur naïf
dum.fit(X_train,y_train)
#Prédiction du classifieur naïf
dum_pred = dum.predict(X_test_std)

# Estimation de l'erreur de la prédiction
RMSE = np.sqrt(
               metrics.mean_squared_error(y_test,dum_pred))

print('La valeur de RMSE naïf est de {}'.format(round(RMSE,2)))

#####################################################################################










