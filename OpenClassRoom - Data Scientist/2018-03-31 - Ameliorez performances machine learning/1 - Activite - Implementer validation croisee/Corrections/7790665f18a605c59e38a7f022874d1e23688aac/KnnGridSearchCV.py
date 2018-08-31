import numpy as np
from sklearn import model_selection, neighbors


class KnnGridSearchCV:
    """
    Classe qui reproduit le comportement de la classe GridSearchCV de Scikit.

    Elle reproduit le comportement uniquement dans le cas d'une recherche du
    meilleur hyperparamètre sur un classification avec le modèle des k-plus proches voisins,
    et en se basant sur le score d'accuracy
    """

    def __init__(self, param_grid, nb_folds):
        """
        Initialisation de la classe.

        Prend en paramètres uniquement la liste des hyperparamètres et le nombre de folds
        """

        self.skf = model_selection.StratifiedKFold(nb_folds)    # Permet d'avoir les mêmes folds que dans le TP
        self.params = param_grid

    def fit(self, x, y):
        """
        Teste les différents hyperparamètres sur le jeu de données (X, y)

        Ne retourne rien mais enregistre les résultats dans cv_results_ et best_params_
        """

        self.accuracies = [[] for _ in self.params]     # Pour stocker le score de chaque param sur chaque fold
        self.cv_results_ = {}   # Pour enregistrer les résultats à la fin

        # Stockage du jeu de données pour être réutilisé dans la fonction predict
        self.X_train = x
        self.y_train = y

        for train_idx, test_idx in self.skf.split(x, y):    # La 1e boucle parcoure les différents folds
            for idx, param in enumerate(self.params):   # La 2e boucle teste chaque param sur un fold
                knn = neighbors.KNeighborsClassifier(param)
                knn.fit(x[train_idx], y[train_idx])
                self.accuracies[idx].append(knn.score(x[test_idx], y[test_idx]))

        # Pour chaque hyperparamètre, on garde la moyenne, l'écart-type et la valeur du paramètre
        self.cv_results_['mean_test_score'] = [np.mean(self.accuracies[i]) for i in range(len(self.params))]
        self.cv_results_['std_test_score'] = [np.std(self.accuracies[i]) for i in range(len(self.params))]
        self.cv_results_['params'] = [self.params[i] for i in range(len(self.params))]

        # Le meilleur choisi est celui qui a la meilleure moyenne
        self.best_params_ = self.cv_results_['params'][np.argmax(self.cv_results_['mean_test_score'])]

    def predict(self, x):
        """
        Fait des prédictions sur le jeu de données X en utilisant le meilleur
        hyperparamètres trouvé avec la fonction fit.
        """

        knn = neighbors.KNeighborsClassifier(self.best_params_)
        knn.fit(self.X_train, self.y_train)

        return knn.predict(x)
