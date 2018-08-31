# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np

from sklearn import model_selection
from sklearn import preprocessing
from sklearn import neighbors, metrics

data = pd.read_csv('E:\Data\RawData\winequality-white.csv', sep=";")

X = data.as_matrix(data.columns[:-1])
y = data.as_matrix([data.columns[-1]])

y = y.flatten()

y_class = np.where(y<6, 0, 1)

X_train, X_test, y_train, y_test = model_selection.train_test_split(
                                                                    X,
                                                                    y_class,
                                                                    test_size=0.3)

std_scale = preprocessing.StandardScaler().fit(X_train)
X_train_std = std_scale.transform(X_train)
stdt_scale = preprocessing.StandardScaler().fit(X_test)
X_test_std = stdt_scale.transform(X_test)

classification = neighbors.KNeighborsClassifier(n_neighbors=3)
classification.fit(X_train_std, y_train)

y_pred = classification.predict(X_test_std)

print("\nSur le jeu de test : %0.3f" % metrics.accuracy_score(y_test, y_pred))



