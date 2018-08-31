# -*- coding: utf-8 -*-
"""
Created on Fri May 12 12:02:57 2017

@author: fmonnery
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

datas = pd.read_csv('D:\WorkSpace\_Machine_Learning\house_data.csv')

data = datas.dropna()
Z = data.isnull().sum().sum() 
          
t=data['surface']
x=data['price']
y=data['arrondissement']

print("----------------------Calcul des coefficients---------")
Xi=np.matrix([np.ones(data.shape[0]),data['surface'].as_matrix(),y.as_matrix()]).T
Yi=np.matrix(data['price']).T

Thetus = np.linalg.inv(Xi.T.dot(Xi)).dot(Xi.T).dot(Yi)

Abscisse=[0,400]
Ordonnee=[Thetus.item(0)+Abscisse[0]*Thetus.item(1),Thetus.item(0)+Abscisse[1]*Thetus.item(1)]
Dim_Z = [Thetus.item(0)+Abscisse[0]*Thetus.item(2),Thetus.item(0)+Abscisse[1]*Thetus.item(2)]

print("Origine : ",Thetus.item(0))
print("Coefficient n° 1 : ",Thetus.item(1))
print("Coefficient n° 2 : ",Thetus.item(2))

print("----------------------Représentation en 3 dimensions---------")
ax = plt.subplot(111, projection='3d')
ax.scatter(t,x,c=y)
ax = plt.plot(Abscisse,Ordonnee,Dim_Z,linestyle='--',c='#000000')

plt.legend(y)
plt.show()

print("----------------------Représentation sur 2 dimensions---------")
asc = plt.scatter(t,x,c=y)
asc = plt.plot(Abscisse,Ordonnee,linestyle='--',c='#000000')
plt.show()

print("----------------------Calcul de la qualité du modèle---------")
Mat = np.matrix([t.as_matrix(),y.as_matrix(),x.as_matrix()])
i=0
prediction  = np.empty(data.shape[0])
erreur = np.empty(data.shape[0])

while i < data.shape[0]:
    prediction[i] = Thetus.item(0) + Mat[0].item(i)*Thetus.item(1) + Mat[1].item(i)*Thetus.item(2)
    erreur[i] = np.sqrt((prediction[i] - Mat[2].item(i))**2)
    i += 1    

residu = erreur.mean()  

print ("Erreur de prédiction moyenne : ",residu) 
print ("Erreur de prédiction cumulée : ",erreur.sum()) 

donnees = np.asarray(Yi).reshape(-1)

Compare = np.matrix([donnees,prediction,erreur])

print("----------------------Prédiction sur données---------")
print("Prix du loyer pour une surface de 50 m² : ",Thetus.item(0) + 50*Thetus.item(1) + 10*Thetus.item(2))






    
    
  

           



