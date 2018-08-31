# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import linear_model
from sklearn.cross_validation import train_test_split
from mpl_toolkits.mplot3d import Axes3D

datas = pd.read_csv('D:\WorkSpace\_Machine_Learning\house_data.csv')

data = datas.dropna()
Z = data.isnull().sum().sum() 

t=data['surface'].as_matrix()
x=data['price'].as_matrix()
y=data['arrondissement'].as_matrix()

Facteurs = np.matrix([t,y])
XX = (np.asarray(Facteurs)).transpose()
YY = (x.reshape(1,-1)).transpose()

xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.8)

regr = linear_model.LinearRegression()
regr.fit(xtrain,ytrain)

Pred = regr.predict(xtest)
Delta = np.sqrt((ytest - Pred)**2)

print("------------Données de training--------------------")
print ("Coefficient de détermination : ",  regr.score(xtrain,ytrain))

print("------------Données de test--------------------")
print("Score : ", regr.score(xtest,ytest))
print("Somme des résidus : ",  Delta.sum())
print("Moyenne des résidus : ",  Delta.mean())

print("------------Données de test sur 20 échantillonnages--------------------")

Scoring = []
for i in range(0,20):
    xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.8)
    regr = linear_model.LinearRegression()
    regr.fit(xtrain,ytrain)
    Scoring.append(regr.score(xtest,ytest))

plt.plot(range(0,20),Scoring,'o-')
plt.show()
print ("Coeficient de détermination moyen : ",np.asarray(Scoring).mean())
print ("Coeficient de détermination écart type : ",np.asarray(Scoring).std())

print("--------------------------------------------------------------")
print("------------Amélioration : Méthode n° 1--------------------")
print("------------Filtre sur les données extrêmes--------------------")
print("------------Valeur du loyer au 95ième centile : ", np.percentile(np.asarray(YY.T[0]),95))

DataFiltre = data[(data < np.percentile(np.asarray(YY.T[0]),95) ).any(1)]
print("------------Nombre de lignes purgées : ", DataFiltre.count())

t=DataFiltre['surface'].as_matrix()
x=DataFiltre['price'].as_matrix()
y=DataFiltre['arrondissement'].as_matrix()

Facteurs = np.matrix([t,y])
XX = (np.asarray(Facteurs)).transpose()
YY = (x.reshape(1,-1)).transpose()

xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.8)

regr = linear_model.LinearRegression()
regr.fit(xtrain,ytrain)

Pred = regr.predict(xtest)
Delta = np.sqrt((ytest - Pred)**2)

print("------------Données de training--------------------")
print ("Coefficient de détermination : ",  regr.score(xtrain,ytrain))

print("------------Données de test--------------------")
print("Score : ", regr.score(xtest,ytest))
print("Somme des résidus : ",  Delta.sum())
print("Moyenne des résidus : ",  Delta.mean())

print("------------Données de test sur 20 échantillonnages--------------------")

Scoring = []
for i in range(0,20):
    xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.8)
    regr = linear_model.LinearRegression()
    regr.fit(xtrain,ytrain)
    Scoring.append(regr.score(xtest,ytest))

plt.plot(range(0,20),Scoring,'o-')
plt.show()
print ("Coeficient de détermination moyen : ",np.asarray(Scoring).mean())
print ("Coeficient de détermination écart type : ",np.asarray(Scoring).std())


print("--------------------------------------------------------------")
print("------------Amélioration : Méthode n° 2--------------------")
print("------------Augmentation de la base de training à 90%--------------------")    


datas = pd.read_csv('D:\WorkSpace\_Machine_Learning\house_data.csv')

data = datas.dropna()
Z = data.isnull().sum().sum() 

t=data['surface'].as_matrix()
x=data['price'].as_matrix()
y=data['arrondissement'].as_matrix()

Facteurs = np.matrix([t,y])
XX = (np.asarray(Facteurs)).transpose()
YY = (x.reshape(1,-1)).transpose()

xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.90)

regr = linear_model.LinearRegression()
regr.fit(xtrain,ytrain)

Pred = regr.predict(xtest)
Delta = np.sqrt((ytest - Pred)**2)

print("------------Données de training--------------------")
print ("Coefficient de détermination : ",  regr.score(xtrain,ytrain))

print("------------Données de test--------------------")
print("Score : ", regr.score(xtest,ytest))
print("Somme des résidus : ",  Delta.sum())
print("Moyenne des résidus : ",  Delta.mean())

print("------------Données de test sur 20 échantillonnages--------------------")

Scoring = []
for i in range(0,20):
    xtrain, xtest, ytrain, ytest = train_test_split(XX, YY, train_size=0.8)
    regr = linear_model.LinearRegression()
    regr.fit(xtrain,ytrain)
    Scoring.append(regr.score(xtest,ytest))

plt.plot(range(0,20),Scoring,'o-')
plt.show()
print ("Coeficient de détermination moyen : ",np.asarray(Scoring).mean())
print ("Coeficient de détermination écart type : ",np.asarray(Scoring).std())

