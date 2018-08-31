#import numpy as np
import pandas as pd
import math as mt

class WranglingData:

    def __init__(self,nomFichier):
        self.rawData = pd.read_csv(nomFichier)
        self.columns = []    
        self.DefineListColumns()
    
    def DefineListColumns(self):
        for column in self.rawData.iteritems():
            self.columns.append(column[0])

    def GetListColumns(self):
        return self.columns

    def SendCleanData(self):
        return self.rawData

    def GiveStatisticsSummary(self):

        for column in self.GetListColumns():
            
            print ('Variable : ',column)
            print('Effectif de la colonne {} : {}'.format(column,self.rawData[column].count()))
            print('Moyenne de la colonne {} : {}'.format(column,self.rawData[column].mean()))
            print('Médiane de la colonne {} : {}'.format(column,self.rawData[column].median()))
            print('Ecart type de la colonne {} : {}'.format(column,self.rawData[column].std()))            
            print('Minimum de la colonne {} : {}'.format(column,self.rawData[column].min()))
            print('Maximum de la colonne {} : {}'.format(column,self.rawData[column].max()))
            print('Coefficient de variation de la colonne {} : {}'.format(column,(self.rawData[column].std())/(self.rawData[column].mean())))
            print('-------------------------')
    
    def GetMissingData(self):
        for column in self.GetListColumns():

            print ('Variable : ',column)
            print('Nombre de valeurs manquantes pour la variable {} : {}'.format(column,self.rawData[column].isnull().sum()))
            print('-------------------------')

    def RemoveMissingData(self):        
        for column in self.GetListColumns():
            newData = self.rawData[self.rawData[column].notnull()]
        
        return newData
        
        
        """
        print(newData)
        for column, row in self.rawData.iterrows():  
            if(mt.isnan(row[0]) or mt.isnan(row[1])):

            print(mt.isnan(row[1]))

            for data in row:
                if(mt.isnan(data)):
                    print(data)
                    print('Donnée manquante')
                else: 
                    print(data)
                    print('OK')"""




