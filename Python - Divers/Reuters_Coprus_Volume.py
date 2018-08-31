# -*- coding: utf-8 -*-

from sklearn.datasets import fetch_rcv1
from sklearn.model_selection import train_test_split

from sklearn.model_selection import GridSearchCV

from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier

from sklearn.multiclass import OneVsRestClassifier
from sklearn.svm import SVC
from sklearn import preprocessing

import pandas as pd
import numpy as np

# Fonction pour importer les données depuis la fonction packagée fecth_rcv1
def Importer_Donnees_Reuters(Action, nombreLignes):
    # On exécute l'action qu'une seule fois pour préserver les ressources mémoire
    if(Action):
        data = fetch_rcv1(
            data_home="E:\\Data\\RawData\\Exploit_data_texte\\Reuters",
            subset='train')
        
        Index = [data.sample_id]
        Labels = [data.target_names]
        
        # On réduit les datasets à 300 lignes en raison de ressources mémoire limitées
        Features = pd.DataFrame(data.data.A)
        Features_Slice = Features.iloc[:nombreLignes,:]        
        
        Classifications = pd.DataFrame(data.target.A,columns=Labels)
        Classifications_Slice = Classifications.iloc[:nombreLignes,:]
        
        # On libère la mémoire en supprimant les variables contenant les données source
        del data
        del Features
        del Classifications

        # On exporte les 2 datasets vers des fichiers CSV enregistrés en local
        Features_Slice.to_csv('Features')
        Classifications_Slice.to_csv('Classifications')

# Création dujeu de test d'apprentissage et de test
def Construction_Jeu_Donnees():
    # On importe les données depuis des fichiers plats stockés en local pour éviter les "Error Memory"
    Classifications_Slice = pd.read_csv("E:\Data\RawData\Exploit_data_texte\Reuters\Classifications")
    Features_Slice = pd.read_csv("E:\Data\RawData\Exploit_data_texte\Reuters\Features")

    # On expurge le libellé des index insérés par la fonction d'export en CSV
    Features = Features_Slice.iloc[:,1:]
    Classifications = Classifications_Slice.iloc[:,1:]

    # On construit les jeux de données de test et de training
    Features_Train, Features_Test, Labels_Train, Labels_Test = train_test_split(
                                                            Features, 
                                                            Classifications, 
                                                            test_size=0.30)
    
    return Features_Train,Features_Test,Labels_Train,Labels_Test

# Création d'un classifieur de type Arbre de décision
def Classifieur_Arbre_Decision(Features_Train,Features_Test,Labels_Train,Labels_Test):
    # Classification Simple
    Classification = DecisionTreeClassifier(random_state=0)

    Classification.fit(Features_Train,Labels_Train)
    Score = Classification.score(Features_Test,Labels_Test)
    print("Le score lambda de la classification par arbre de décision est de : {} ".format(Score))
    
    # Classification avec validation croisée des différents paramètres
    parameters = {"max_depth": range(3,20), 
                  "random_state":[0]}
    
    grid_obj = GridSearchCV(
            estimator=Classification,
            param_grid=parameters)
    
    grid_fit =grid_obj.fit(Features_Train,Labels_Train)
    print("Les paramètres optimums sont : {} ".format(grid_fit.best_params_))
    
    ScoreCV = grid_fit.score(Features_Test,Labels_Test)
    print("Le score de la classification avec validation croisée par arbre de décision est de : {} ".format(ScoreCV))

# Création d'un classifieur de type KNeighbors
def Classifieur_KNeighbors(Features_Train,Features_Test,Labels_Train,Labels_Test):
    # Classification Simple
    Classification = KNeighborsClassifier(n_neighbors=3)

    Classification.fit(Features_Train,Labels_Train)
    Score = Classification.score(Features_Test,Labels_Test)
    print("Le score lambda de la classification par KNeighbors est de : {} ".format(Score))
    
    # Classification avec validation croisée des différents paramètres
    parameters = {"n_neighbors": range(2,10), 
                  "weights":['uniform','distance'],
                  "algorithm":['ball_tree','kd_tree','brute','auto'],
                  "p":[1,2]}
    
    grid_obj = GridSearchCV(
            estimator=Classification,
            param_grid=parameters)
    
    grid_fit =grid_obj.fit(Features_Train,Labels_Train)
    print("Les paramètres optimums sont : {} ".format(grid_fit.best_params_))
    
    ScoreCV = grid_fit.score(Features_Test,Labels_Test)
    print("Le score de la classification avec validation croisée par KNeighbors est de : {} ".format(ScoreCV))
    
# Création d'un classifieur de type Random Forest
def Classifieur_Random_Forest(Features_Train,Features_Test,Labels_Train,Labels_Test):
    # Classification Simple
    Classification = RandomForestClassifier(bootstrap=True, 
                                             class_weight=None, 
                                             criterion='gini',
                                             max_depth=2,
                                             random_state=0)             

    Classification.fit(Features_Train,Labels_Train)
    Score = Classification.score(Features_Test,Labels_Test)
    print("Le score lamda de la classification par Random Forest est de : {} ".format(Score))
    
    # Classification avec validation croisée des différents paramètres
    parameters = {"n_estimators": range(5,15), 
                  "criterion":['gini','entropy'],
                  "max_depth": range(3,10),
                  "bootstrap":[True,False],
                  "random_state":[0]}
    
    grid_obj = GridSearchCV(
            estimator=Classification,
            param_grid=parameters)
    
    grid_fit =grid_obj.fit(Features_Train,Labels_Train)
    print("Les paramètres optimums sont : {} ".format(grid_fit.best_params_))
    
    ScoreCV = grid_fit.score(Features_Test,Labels_Test)
    print("Le score de la classification avec validation croisée par Random Forest est de : {} ".format(ScoreCV))

# Fonction permettant de transformer une sortie multi_labels binaires en sortie encodée en base 10
def Transformation_Base_2_Vers_Base_10(Octets):
    valeur_base_10 = []
    
    for octet in Octets.iterrows():
        valeur_octet = 0
        position_bit = 0
        
        for bit in octet[1]:
            valeur_octet += (2**position_bit)*(int(bit))
            position_bit += 1
        
        valeur_base_10.append(valeur_octet)
    
    return valeur_base_10

# Création d'un classifieur de type Random Forest
def Classifieur_One_Versus_All(Features_Train,Features_Test,Labels_Train,Labels_Test):
    # Classification Simple
    Classification = OneVsRestClassifier(
                            SVC(
                                    C=10,
                                    kernel="linear",
                                    degree=1,
                                    probability =True,
                                    max_iter=-1))
              
    Classification.fit(Features_Train,Labels_Train)
    Score = Classification.score(Features_Test,Labels_Test)
    print("Le score lamda de la classification One Versus Rest est de : {} ".format(Score))
    
    # Classification avec validation croisée des différents paramètres
    parameters = {"C": np.arange(1,10,1), 
                  "kernel":["linear","rbf","sigmoid"],
                  "degree": range(1,5)}
    
    grid_obj = GridSearchCV(
            estimator=Classification,
            param_grid=parameters)
    
    grid_fit =grid_obj.fit(Features_Train,Labels_Train)
    print("Les paramètres optimums sont : {} ".format(grid_fit.best_params_))
    
    ScoreCV = grid_fit.score(Features_Test,Labels_Test)
    print("Le score de la classification avec validation croisée par One Versus Rest est de : {} ".format(ScoreCV))


# Programme principal
Importer_Donnees_Reuters(False,300)

Features_Train,Features_Test,Labels_Train,Labels_Test = Construction_Jeu_Donnees()

# On va choisir 3 types de classifieurs distints
# A noter que le jeu de données nous contraint dans le choix des types de classifieur
# Nous devons choisir un classifieur acceptant des sorties multi labels
# En effet, un document peut avoir plusieurs labels d'apartenance en sortie
print("1 - Classifieur Arbre de décision")
#Classifieur_Arbre_Decision(Features_Train,Features_Test,Labels_Train,Labels_Test)

print("2 - Classifieur KNeighbors")
#Classifieur_KNeighbors(Features_Train,Features_Test,Labels_Train,Labels_Test)

print("3 - Classifieur Random Forest")
#Classifieur_Random_Forest(Features_Train,Features_Test,Labels_Train,Labels_Test)

# Transformation problème multi-classes et multi-labels en problème multi-classes mais label unique
# Pour cela, on transforme le vecteur binaire en valeur entière en base 10
# Cela nous permet alors d'utiliser d'autres types de classifieurs

print("4 - Classifieur Régression logistique")
# On initialise un encodage pour s'affranchir des avertissements sur les labels absents dans les datasets de training
le = preprocessing.LabelEncoder()

Labels_Train_Binarisee = le.fit_transform(Transformation_Base_2_Vers_Base_10(Labels_Train))
Labels_Test_Binarisee = le.fit_transform(Transformation_Base_2_Vers_Base_10(Labels_Test))

#Labels_Train_Binarisee = Transformation_Base_2_Vers_Base_10(Labels_Train)
#Labels_Test_Binarisee = Transformation_Base_2_Vers_Base_10(Labels_Test)


Classifieur_One_Versus_All(Features_Train,Features_Test,Labels_Train_Binarisee,Labels_Test_Binarisee)


