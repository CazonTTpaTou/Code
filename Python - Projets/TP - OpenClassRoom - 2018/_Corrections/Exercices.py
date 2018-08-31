import pandas as pd
import scipy.stats as st
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import statsmodels.api as sm

# Chargement
iris = pd.read_csv("iris_dataset.csv")

# On renomme les colonnes
iris.columns = ["id","sepal_length","sepal_width","petal_length","petal_width","species"]

# On supprime l'identifiant des iris
del iris["id"]

# On supprime les individus contenant au moins une valeur manquante
iris_dna = iris.dropna(axis=0, how='any')
print("iris : {} individus, iris_dna : {} individus".format(len(iris),len(iris_dna)))

# Affichage des diagrammes de dispersion
#sns.pairplot(iris_dna,hue="species")

iris_setosa = iris_dna[iris_dna["species"] == "setosa"]
iris_virginica = iris_dna[iris_dna["species"] == "virginica"]
iris_versicolor = iris_dna[iris_dna["species"] == "versicolor"]

#Question Q1
#Coefficient de correlation petal_width en fonction de petal_length
correlation1 = st.stats.pearsonr(iris_dna['petal_width'],iris_dna['petal_length'])
#Coefficient de correlation sepal_width en fonction de petal_width
correlation2 = st.stats.pearsonr(iris_dna['sepal_width'],iris_dna['petal_width'])
print(correlation1,correlation2)

#Question Q3
Y = iris_dna['petal_width']
X = iris_dna[['petal_length']]
X = X.copy()
X['intercept'] = 1.
result = sm.OLS(Y, X).fit()
a1,b1 = result.params['petal_length'],result.params['intercept']

Y = iris_setosa['sepal_width']
X = iris_setosa[['petal_width']]
X = X.copy()
X['intercept'] = 1.
result = sm.OLS(Y, X).fit()
a2,b2 = result.params['petal_width'],result.params['intercept']

Y = iris_virginica['sepal_width']
X = iris_virginica[['petal_width']]
X = X.copy()
X['intercept'] = 1.
result = sm.OLS(Y, X).fit()
a3,b3 = result.params['petal_width'],result.params['intercept']

Y = iris_versicolor['sepal_width']
X = iris_versicolor[['petal_width']]
X = X.copy()
X['intercept'] = 1.
result = sm.OLS(Y, X).fit()
a4,b4 = result.params['petal_width'],result.params['intercept']

result = np.array([[a1,a2,a3,a4],[b1,b2,b3,b4]])
tab = pd.DataFrame(result,index=['Coefficient a','Coefficient b'],columns=['global','setosa','virginica','versicolor'])
print(tab)

# Question Q4
coeffs = {
    "cas 1" : {'a': a4 , 'b':b4},
    "cas 2" : {'a': a2 , 'b':b2},
    "cas 3" : {'a': a3 , 'b':b3},
    "cas 4" : {'a': a4 , 'b':b4},
}
lignes_modifiees = []

for (i,individu) in iris.iterrows(): # pour chaque individu de iris,...
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
        if individu['species'] == 'setosa':
            a=coeffs["cas 2"]['a']
            b=coeffs["cas 2"]['b']
        elif individu['species'] == 'virginica':
            a=coeffs["cas 3"]['a']
            b=coeffs["cas 3"]['b']
        elif individu['species'] == 'versicolor':
            a=coeffs["cas 4"]['a']
            b=coeffs["cas 4"]['b']
        Y =a*X + b
        iris.loc[i,"sepal_width"] = Y # on remplace la valeur manquante par Y
        lignes_modifiees.append(i)
        print("On a complété sepal_width par {} a partir de l'espece:{} et de petal_width={}".format(Y,espece,X))
