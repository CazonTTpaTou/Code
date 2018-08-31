# -*- coding: utf-8 -*-
"""
Created on Tue Mar  6 19:07:55 2018

@author: monne
"""
import pandas as pd

raw_data = pd.read_csv("E:/Data/RawData/hubble_data.csv")
data = [[1,2],[10,20]]
dataF = pd.DataFrame(data,columns=['Distance','Vitesse'])

for nom, donnee in dataF.iteritems(): 
    #print(nom)
    #print(donnee)
    print(dataF[nom])    

    




