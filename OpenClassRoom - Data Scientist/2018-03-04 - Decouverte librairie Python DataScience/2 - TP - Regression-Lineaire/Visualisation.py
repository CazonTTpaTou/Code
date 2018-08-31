import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from DataWrangling import WranglingData
from RegressionLineaire import regressionLineaire

class visualisation:

    def __init__(self):
        pass    
    
    def Afficher_Courbe_Simple(self,typeGraph,abscisse,ordonnee):
        plt.style.use('seaborn-whitegrid')
        plan = plt.figure()
        axes = plt.axes()
        
        if(typeGraph=='courbe'):
            axes.plot(abscisse,ordonnee)
        
        if(typeGraph=='point'):
            axes.scatter(abscisse,ordonnee,s=10,c='red',marker='o',edgecolor='none')
        
        if(typeGraph=='errorpoint'):
            etendueErreur=float(150)
            plt.errorbar(abscisse, ordonnee, yerr=etendueErreur, fmt='.k')            
        
        if(typeGraph=='errorpointbrut'):
            etendueErreur=float(150)            
            plt.errorbar(abscisse, ordonnee, yerr=etendueErreur, fmt='o', 
                         color='black', ecolor='lightgray', elinewidth=3, capsize=0)
        
        # Définition des légendes
        plt.title("Relation entre vélocité et distance des nébuleuses galactiques")
        plt.legend(loc='lower left')
        axes = axes.set(xlabel='Distance en Km par sec', ylabel='Vélocité en Km par sec')        
        
    def Afficher_Distribution(self,data,classes,classesLabels,titre,couleur):
        plt.style.use('seaborn-whitegrid')
        plan = plt.figure()
        axes = plt.axes()
        
        # Définition des légendes
        plt.title(titre)
        plt.xticks(classes, classesLabels, rotation=30)
        plt.hist(data, edgecolor='#E6E6E6', color=couleur)

    def Afficher_Distribution_Normale(self,dataExpl):
        sns.set()
        sns.distplot(dataExpl, kde=True)    

    def Afficher_Courbe_Regression(self,abscisse,ordonnee,prediction):
        plt.style.use('seaborn-whitegrid')
        plan = plt.figure()
        axes = plt.axes()
        
        axes.plot(abscisse,prediction)
        axes.scatter(abscisse,ordonnee,s=10,c='red',marker='o',edgecolor='none')
        
        # Définition des légendes
        plt.title("Courbe de régression vélocité / distance nébuleuses galactiques")
        plt.legend(loc='lower left');
        axes = axes.set(xlabel='Distance en Km par sec', ylabel='Vélocité en Km par sec')
        
    def Afficher_Detail_Regression(self,detail):
        for column in detail:
            print('{} a pour valeur : {}'.format(column,detail[column][0]))
        
    def Afficher_Representation_Appariee(self,rawData):
        sns.set()
        sns.pairplot(rawData, size=2.5)

    def Afficher_Courbe_Regression_Lineaire(self,rawData):
        with sns.axes_style('white'):
            sns.jointplot("distance", "recession_velocity", data=rawData, kind='reg')


