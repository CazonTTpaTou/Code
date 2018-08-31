# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 09:34:14 2017

@author: fmonnery
"""

import pandas as pd
import timeit

from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.feature_selection import SelectFromModel

train = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/test.csv")
test  = pd.read_csv("C:/Users/fmonnery/Documents/Python Scripts/Data/train.csv")

train_x = train.iloc[:,:-2]
train_y = train['Activity']

test_x = test.iloc[:,:-2]
test_y = test['Activity']

rfc = RandomForestClassifier(n_estimators=500)
model = rfc.fit(train_x, train_y)

start_time0 = timeit.default_timer()

pred = rfc.predict(test_x)

elapsed0 = timeit.default_timer() - start_time0
time0 = elapsed0

accuracy0 = accuracy_score(test_y, pred)

print(accuracy0)
print(time0)

select = SelectFromModel(rfc, prefit=True, threshold=0.005)
train_x2 = model.transform(train_x)

print(train_x2.shape)

rfc2 = RandomForestClassifier(n_estimators=500, oob_score=True)
rfc2 = rfc2.fit(train_x2, train_y)

test_x2 = model.transform(test_x)

start_time = timeit.default_timer()
pred = rfc2.predict(test_x2)
elapsed = timeit.default_timer() - start_time
time = elapsed
accuracy = accuracy_score(test_y, pred)

print(accuracy)
print(time)

DeltaPerformance = accuracy0 - accuracy
DeltaTemps = time - time0

print(DeltaPerformance)
print(DeltaTemps)




