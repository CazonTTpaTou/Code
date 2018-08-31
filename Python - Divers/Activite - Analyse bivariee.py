# -*- coding: utf-8 -*-

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

import scipy.stats as st
import statsmodels.formula.api as sm

# Chargement
iris = pd.read_csv("E:\\Data\\RawData\\NettoyageDonnees\\iris_dataset.csv")

# On renomme les colonnes
iris.columns = ["id","sepal_length","sepal_width","petal_length","petal_width","species"]

# On supprime l'identifiant des iris
del iris["id"]

# On supprime les individus contenant au moins une valeur manquante
iris_dna = iris.dropna(axis=0, how='any')
print("iris : {} individus, iris_dna : {} individus".format(len(iris),len(iris_dna)))

# Affichage des diagrammes de dispersion
sns.pairplot(iris_dna,hue="species")

# Création des sous catégories
iris_setosa = iris_dna[iris_dna["species"] == "setosa"]
iris_virginica = iris_dna[iris_dna["species"] == "virginica"]
iris_versicolor = iris_dna[iris_dna["species"] == "versicolor"]

#### QUESTION 1 ##################################################################

coeffRelation1 = st.pearsonr(iris_dna["petal_width"],iris_dna["petal_length"])[0]
coeffRelation2 = st.pearsonr(iris_dna["sepal_width"],iris_dna["petal_width"])[0]
#cov = np.cov(depenses["solde_avt_ope"],-depenses["montant"],ddof=0)[1,0]
print('Coefficient de corrélation largeur pétale - longueur pétale : {}'.format(coeffRelation1.__round__(3)))
print('Coefficient de corrélation largeur sépale - largeur pétale : {}'.format(coeffRelation2.__round__(3)))

def Afficher_Courbe_Regression(abscisse,ordonnee,prediction, labelX,labelY):
        plt.style.use('seaborn-whitegrid')
        plan = plt.figure()
        axes = plt.axes()
        
        axes.plot(abscisse,prediction,label='Droite de régression')
        axes.scatter(abscisse,ordonnee,s=10,c='red',marker='o',edgecolor='none',label='Point des observations Iris')

        # Définition des légendes
        plt.title("Droite de régression linéaire")
        plt.legend(loc='lower right');
        axes = axes.set(xlabel=labelX, ylabel=labelY)  

regression = sm.ols(formula='petal_width ~ petal_length',data=iris_dna).fit()
prediction = regression.params['petal_length'] * iris_dna.petal_length + regression.params['Intercept'] 

Afficher_Courbe_Regression(iris_dna.petal_length,
                           iris_dna.petal_width,
                           prediction,
                           'petal_length',
                           'petal_width')

#### QUESTION 2 ##################################################################

regression = sm.ols(formula='sepal_width ~ petal_width',data=iris_dna).fit()
prediction = regression.params['petal_width'] * iris_dna.petal_width + regression.params['Intercept'] 

Afficher_Courbe_Regression(iris_dna.petal_width,
                           iris_dna.sepal_width,
                           prediction,
                           'petal_width',
                           'sepal_width')

Espece = ['iris_setosa','iris_virginica','iris_versicolor']

def Afficher_Regresion_Espece(Espece):
    regression = sm.ols(formula='sepal_width ~ petal_width',data=Espece).fit()
    prediction = regression.params['petal_width'] * Espece.petal_width + regression.params['Intercept'] 

    Afficher_Courbe_Regression(Espece.petal_width,
                           Espece.sepal_width,
                           prediction,
                           'petal_width',
                           'sepal_width')
 
#### QUESTION 3 ##################################################################
    
def Regresion_Espece(Espece, Explique, Explicatif):
    regression = sm.ols(formula='sepal_width ~ petal_width',data=Espece).fit()
    prediction = regression.params['petal_width'] * Espece.petal_width + regression.params['Intercept'] 

    print('La droite de régression a pour équation : {} = {} * {} + {} '.format(Explique,
                                                                                regression.params['petal_width'].__round__(3),
                                                                                Explicatif,
                                                                                regression.params['Intercept'].__round__(3)))

    Afficher_Courbe_Regression(Espece.petal_width,
                           Espece.sepal_width,
                           prediction,
                           'petal_width',
                           'sepal_width')

Regresion_Espece(iris_setosa,'sepal_width','petal_width')
Regresion_Espece(iris_virginica,'sepal_width','petal_width')
Regresion_Espece(iris_versicolor,'sepal_width','petal_width')

regression = sm.ols(formula='petal_width ~ petal_length',data=iris_dna).fit()
prediction = regression.params['petal_length'] * iris_dna.petal_length + regression.params['Intercept'] 

############ Question 4 ###########################################################

def Coefficient_Regresion_sepal_petal(Espece):
    regression = sm.ols(formula='sepal_width ~ petal_width',data=Espece).fit()
    
    return regression.params['petal_width'].__round__(3)
    
def Interception_Regression_sepal_petal(Espece):
    regression = sm.ols(formula='sepal_width ~ petal_width',data=Espece).fit()
    
    return regression.params['Intercept'].__round__(3)    

def Coefficient_Regresion_petal_sepal(Espece):
    regression = sm.ols(formula='petal_width ~ sepal_width',data=Espece).fit()
    
    return regression.params['sepal_width'].__round__(3)
    
def Interception_Regression_petal_sepal(Espece):
    regression = sm.ols(formula='petal_width ~ sepal_width',data=Espece).fit()
    
    return regression.params['Intercept'].__round__(3)    

coeffs = {    
    "cas 1" : {'a': [Coefficient_Regresion_petal_sepal(iris_versicolor)] , 'b':[Interception_Regression_petal_sepal(iris_versicolor)]},
    "cas 2" : {'a': [Coefficient_Regresion_sepal_petal(iris_setosa)] , 'b':[Interception_Regression_sepal_petal(iris_setosa)]},
    "cas 3" : {'a': [Coefficient_Regresion_sepal_petal(iris_versicolor)] , 'b':[Interception_Regression_sepal_petal(iris_versicolor)]},
    "cas 4" : {'a': [Coefficient_Regresion_sepal_petal(iris_virginica)] , 'b':[Interception_Regression_sepal_petal(iris_virginica)]}
}

lignes_modifiees = []

for (i,individu) in iris_dna.iterrows(): # pour chaque individu de iris,...
    if pd.isnull(individu["petal_width"]): #... on test si individu["petal_width"] est nul.
        a = coeffs["cas 1"]['a']
        b = coeffs["cas 1"]['b']
        
        X = individu["petal_length"]
        Y = a*X + b
        iris.loc[i,"petal_width"] = Y # on remplace la valeur manquante par Y
        
        lignes_modifiees.append(i)
        print("On a complété petal_width par {} a partir de petal_length={}".format(Y,X))
        
    if pd.isnull(individu["sepal_width"]):
        espece = individu["species"]
        X = individu["petal_width"]
        
        if(espece=='setosa'):
            a = coeffs["cas 2"]['a']
            b = coeffs["cas 2"]['b']
        
        if(espece=='versicolor'):
            a = coeffs["cas 3"]['a']
            b = coeffs["cas 3"]['b']
        
        if(espece=='virginica'):
            a = coeffs["cas 4"]['a']
            b = coeffs["cas 4"]['b']
        
        Y = a*X + b
        iris.loc[i,"sepal_width"] = Y # on remplace la valeur manquante par Y
        
        lignes_modifiees.append(i)
        print("On a complété sepal_width par {} a partir de l'espece:{} et de petal_width={}".format(Y,espece,X))

