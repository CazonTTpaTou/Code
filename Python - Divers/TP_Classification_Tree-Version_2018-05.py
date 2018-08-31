# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
from matplotlib import pyplot as plt

from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import GridSearchCV

from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score, confusion_matrix

from sklearn.multiclass import OneVsRestClassifier
from sklearn.multiclass import OneVsOneClassifier


from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import cross_val_score

##################################################################
#Imporation des données
raw_data = pd.read_csv("E:/Data/RawData/Dataset_feuilles_1.csv")

# Aperçu du jeu de données
snapshot = raw_data.groupby('species').size()
snapshot.head(5)
snapshot.tail(5)

print('Nombre espèces distinctes : {} '.format(len(snapshot)))
print('Nombre de feuille moyenne par espèces : {} '.format(snapshot.mean()))

##################################################################
# Synthèse par famille
syntheseFamille = snapshot 
# On ne conserve que le premier mot du nom avant le underscore
syntheseFamille.index = syntheseFamille.index.map(lambda x:x[0:x.find('_')])
# On agrège pour obtenir le nombre d'occurences de chaque famille
nombre_famille = len(syntheseFamille.sum(level=0))

ratio_3_premiers = (syntheseFamille.sum(level=0).sort_values(ascending=False)[:3].sum() 
                    /
                    syntheseFamille.sum())

ratio_3_autres = (syntheseFamille.sum(level=0).sort_values(ascending=False)[3:].sum()
                    /
                    syntheseFamille.sum())

print('{} % des observations appartiennent à 3 familles de feuilles.'.
      format(100*np.round(ratio_3_premiers,4)))

print('{} % des observations appartiennent à {} familles de feuilles.'.
      format(100*np.round(ratio_3_autres,4),nombre_famille-3))

##################################################################
# Affichage des familles de feuille les plus représentées
print(syntheseFamille.sum(level=0).sort_values(ascending=False)[:5])
syntheseFamille.sum(level=0).plot()

##################################################################
#Encodage des données
labelencoder=LabelEncoder()
Espece = raw_data.iloc[:,1]
Proprietes = raw_data.iloc[:,2:raw_data.shape[1]]
especeEncode = labelencoder.fit_transform(Espece)
# Normalisaton - Réduction des données
scaler = StandardScaler().fit(Proprietes)
proprietesNR = scaler.transform(Proprietes)
# Construction des jeux d'entrainement et de test
cluster_inferieur_cinq = True
# On vérifie qu'on ait aucune classe d'effectif inférieur à 5
while (cluster_inferieur_cinq):
    
    Features_train, Features_test, Label_train, Label_test = train_test_split(proprietesNR, 
                                                                              especeEncode, 
                                                                              test_size=0.2)
    distribution_classe = pd.Series(np.ones(Label_train.shape[0]),
                                    index=Label_train)
    cluster_inferieur_cinq = (distribution_classe.sum(level=0).min()  < 5)

print('Effectif minimal dans le jeu d\'entrainement {}'
      .format(distribution_classe.sum(level=0).min()))
                                   
##################################################################
# Création de le baseline KNN
parametres_knn = {'n_neighbors': np.arange(1, 10),
                  'metric':["euclidean",
                            "manhattan",
                            "chebyshev",
                            "minkowski"],
                   'weights' : ['uniform',
                                'distance']}

baseLineKNN = GridSearchCV(
                        estimator=KNeighborsClassifier(),
                        param_grid=parametres_knn,
                        cv=5,
                        scoring='accuracy')   

baseLineKNN.fit(Features_train,
                Label_train)      

print('Les paramètres optimaux pour la base KNN sont les suivants : {}'.
      format(baseLineKNN.best_params_))

##################################################################
# Création d'un classifieur avec les paramètres par défaut

SVM_Base =LinearSVC()

SVM_Base.fit(Features_train,
             Label_train)

##################################################################
# Création d'un classifieur SVM multi-class avec différents paramètres


parametres_grid_svm = {'multi_class': ['ovr', 
                                       'crammer_singer'],
                       'C': 10**np.linspace(-3,3,num=7),
                       'penalty': ['l1','l2']}

SVM_MultiClass = GridSearchCV(estimator=LinearSVC(dual=False),
                              param_grid=parametres_grid_svm,
                              cv=5,
                              scoring='accuracy')
        
SVM_MultiClass.fit(Features_train,
                   Label_train)                   

print('Les paramètres optimaux pour le SVM multi-classe sont les suivants : {}'.
      format(SVM_MultiClass.best_params_))               

##################################################################
# Ensemble des modèles comparés
Modeles = {'KNN': SVM_Base, #baseLineKNN
           'SVM_Base': SVM_Base,
           'SVM_Multi_Classe': SVM_Base #SVM_MultiClass
           }

for title,model in Modeles.items():
    # Calcul des prédictions du modèle
    predictions = model.predict(Features_test)
    c_matr = confusion_matrix(Label_test, predictions)
    
    print(' ' + '-' * 80)
    print('          Performance du modèle {0}'.format(title.upper()))
    print(' ' + '-' * 80)    
    
    # Tableau des erreurs :
    erreur=0
    # En tête du tableau
    print('\nDétail des erreurs :\n\n {0:37s}| {1:37s}| {2:s}'
          .format('Classe réelle (n°)', 
                  'Classe prédite (n°)',
                  'Qté'))
    print(' ' + '-' * 80)
    # Détail des erreurs de prédiction 
    for i in np.arange(0,c_matr.shape[0]):
        if np.sum(c_matr[i, :]):
            for j in np.arange(0,c_matr.shape[1]):
                # Parcours de la matrice de confusion hors diagonale
                if (c_matr[i, j]) & (j!=i):
                    erreur += c_matr[i, j]
                    print(' {0:37s}| {1:37s}| {2:>2d}'                      
                           .format(Espece[i], 
                                   Espece[j], 
                                   c_matr[i, j]))
    # Revue des performances
    score=(1-accuracy_score(Label_test, predictions))*len(Features_test)
    
    print(' ' + '-' * 80)
    
    print('Score de la prédiction {0} : {1:.2f}%'.
          format(title,
                  100*accuracy_score(Label_test, 
                                             predictions)))
    
    print('--- soit {0} prédictions correctes sur {1}).'.
         format(len(Label_test) - erreur, len(Label_test)))
    
    print('--- soit {0} erreurs de prédicition sur {1}).'.
         format(erreur, len(Label_test)))
    
    print(' ' + '-' * 80)
    print('')

##################################################################
# Détermination du meilleur modèle

Models = []    
Performance = []

for title, model in Modeles.items():
    Models.append(title)
    Performance.append(accuracy_score(Label_test, 
                                 model.predict(Features_test)))
    
visualisation = pd.Series(Performance,index=Models)

#visualisation.plot()

# Affichage des résultats pour classification OVO
Titre = 'Resultats des performances des modèles de classification'

#AbscisseOptimum = visualisation.at[(np.where(visualisation.values >= visualisation.max()))[0][0],0]
AbscisseOptimum = visualisation.idxmax()

fig = plt.figure(figsize=(8,8))
ax = fig.add_subplot(1,1,1)

ax.set_title(Titre)
ax.set_ylim([0.8,1.05])
ax.plot(visualisation.index,visualisation.values,
        'ko--',
        color='blue',
        label = 'Performances des modèles')

ax.plot([AbscisseOptimum, AbscisseOptimum], 
        [0.90, 1.05],
        linestyle='--',
        color='red',
        label='Meilleur modèle')

plt.legend(loc = 'lower right')
plt.ylabel('Score de la classification')
plt.xlabel('Modèle de classification')
plt.show()  



