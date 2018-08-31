import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score

from DataWrangling import WranglingData
from RegressionLineaire import regressionLineaire
from Visualisation import visualisation

# Constitution de la base de données
d = WranglingData("E:/Data/RawData/hubble_data.csv")
d.GetMissingData()
d.GiveStatisticsSummary()
d.RemoveMissingData()

# Calcul de la régression linéaire
reg = regressionLineaire(d.SendCleanData(),0)
reg.CreationEchantillon()
reg.CalculRegressionLineaire()
reg.AfficherResultatsRegression()
reg.AfficherDetailPredictions()

# Visualisation des données

v = visualisation()
        
v.Afficher_Distribution(reg.RenvoyerVecteurExplicatifTraining().values,
                        np.linspace(0,2,6),
                        ['0-0.4', '0.4-0.8', '0.8-1.2', '1.2-1.6', '1.6-2'],
                        "Distribution des vélocités",
                        '#EE6666')

v.Afficher_Distribution(reg.RenvoyerVecteurExpliqueTraining().values,
                        np.linspace(-400,1200,6),
                        ['-400-80', '-80-240', '240-560', '560-880', '880-1200'],
                        "Distribution des distances",
                        '#2C75FF')

v.Afficher_Distribution_Normale(reg.RenvoyerVecteurExplicatifTraining().values)

v.Afficher_Distribution_Normale(reg.RenvoyerVecteurExpliqueTraining().values)

v.Afficher_Courbe_Simple('point',
                         reg.RenvoyerVecteurExplicatifTraining().values,
                         reg.RenvoyerVecteurExpliqueTraining().values)

v.Afficher_Courbe_Simple('courbe',
                         reg.RenvoyerVecteurExplicatifTraining().values,
                         reg.RenvoyerVecteurExpliqueTraining().values)

v.Afficher_Courbe_Simple('errorpoint',
                         reg.RenvoyerVecteurExplicatifTraining().values,
                         reg.RenvoyerVecteurExpliqueTraining().values)

v.Afficher_Courbe_Simple('errorpointbrut',
                         reg.RenvoyerVecteurExplicatifTraining().values,
                         reg.RenvoyerVecteurExpliqueTraining().values)

reg.AfficherResultatsRegression()

v.Afficher_Courbe_Regression(reg.RenvoyerVecteurExplicatifTest().values,
                             reg.RenvoyerVecteurExpliqueTest().values,
                             reg.RenvoyerVecteurPredictions())

v.Afficher_Detail_Regression(reg.RenvoyerResultatsRegression())

v.Afficher_Representation_Appariee(d.SendCleanData())

v.Afficher_Courbe_Regression_Lineaire(d.SendCleanData())



